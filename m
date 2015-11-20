From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH] clocksource: ti-32k: convert to platform device
Date: Fri, 20 Nov 2015 12:21:11 -0600
Message-ID: <87h9kgcz1k.fsf@saruman.tx.rr.com>
References: <1448040129-23869-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448040129-23869-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

Grygorii Strashko <grygorii.strashko@ti.com> writes:
> Since system clocksource is finally selected by Clocksource core at
> fs_initcall stage during boot there are no reasons to initialize
> ti_32k_timer at early boot stages. Hence, ti_32k_timer can be
> converted to use platform device/driver model and its PM can be
> implemented using PM runtime which is common for OMAP devices.
>
> Platform specific initialization code has to be disabled once as
> ti_32k_timer is converted to platform device - otherwise OMAP platform
> code will generate boot warnings.
>
> After this change, all counter_32k's platform code can be removed
> once all OMAP boards will be converted to DT.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  arch/arm/mach-omap2/timer.c        | 16 +++--------
>  drivers/clocksource/timer-ti-32k.c | 58 ++++++++++++++++++++++++++++++++=
------
>  2 files changed, 53 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index b18ebbe..3bfde44 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -393,23 +393,15 @@ static const struct of_device_id omap_counter_match=
[] __initconst =3D {
>  static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
>  {
>  	int ret;
> -	struct device_node *np =3D NULL;
>  	struct omap_hwmod *oh;
>  	const char *oh_name =3D "counter_32k";
>=20=20
>  	/*
> -	 * If device-tree is present, then search the DT blob
> -	 * to see if the 32kHz counter is supported.
> +	 * If device-tree is present, then just exit -
> +	 * 32kHz clocksource driver will handle it.
>  	 */
> -	if (of_have_populated_dt()) {
> -		np =3D omap_get_timer_dt(omap_counter_match, NULL);
> -		if (!np)
> -			return -ENODEV;
> -
> -		of_property_read_string_index(np, "ti,hwmods", 0, &oh_name);
> -		if (!oh_name)
> -			return -ENODEV;
> -	}
> +	if (of_have_populated_dt())
> +		return 0;
>=20=20
>  	/*
>  	 * First check hwmod data is available for sync32k counter
> diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/tim=
er-ti-32k.c
> index 8518d9d..e71496f 100644
> --- a/drivers/clocksource/timer-ti-32k.c
> +++ b/drivers/clocksource/timer-ti-32k.c
> @@ -39,8 +39,11 @@
>  #include <linux/time.h>
>  #include <linux/sched_clock.h>
>  #include <linux/clocksource.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>=20=20
>  /*
>   * 32KHz clocksource ... always available, on pretty most chips except
> @@ -88,15 +91,28 @@ static u64 notrace omap_32k_read_sched_clock(void)
>  	return ti_32k_read_cycles(&ti_32k_timer.cs);
>  }
>=20=20
> -static void __init ti_32k_timer_init(struct device_node *np)
> +static const struct of_device_id ti_32k_of_table[] =3D {
> +	{ .compatible =3D "ti,omap-counter32k" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ti_32k_of_table);
> +
> +static int __init ti_32k_probe(struct platform_device *pdev)
>  {
> +	struct device *dev =3D &pdev->dev;
> +	struct resource *res;
>  	int ret;
>=20=20
> -	ti_32k_timer.base =3D of_iomap(np, 0);
> -	if (!ti_32k_timer.base) {
> -		pr_err("Can't ioremap 32k timer base\n");
> -		return;
> -	}
> +	/* Static mapping, never released */
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ti_32k_timer.base =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ti_32k_timer.base))
> +		return PTR_ERR(ti_32k_timer.base);
> +
> +	pm_runtime_enable(dev);
> +	ret =3D pm_runtime_get_sync(dev);
> +	if (ret < 0)
> +		goto probe_err;
>=20=20
>  	ti_32k_timer.counter =3D ti_32k_timer.base;
>=20=20
> @@ -116,11 +132,35 @@ static void __init ti_32k_timer_init(struct device_=
node *np)
>  	ret =3D clocksource_register_hz(&ti_32k_timer.cs, 32768);
>  	if (ret) {
>  		pr_err("32k_counter: can't register clocksource\n");
> -		return;
> +		goto probe_err;
>  	}
>=20=20
>  	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
>  	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
> +	return 0;
> +
> +probe_err:
> +	pm_runtime_put_noidle(dev);
> +	return ret;
> +};
> +
> +static struct platform_driver ti_32k_driver __initdata =3D {
> +	.probe		=3D ti_32k_probe,
> +	.driver		=3D {
> +		.name	=3D "ti_32k_timer",
> +		.of_match_table =3D of_match_ptr(ti_32k_of_table),
> +	}
> +};
> +
> +static int __init ti_32k_init(void)
> +{
> +	return platform_driver_register(&ti_32k_driver);
>  }
> -CLOCKSOURCE_OF_DECLARE(ti_32k_timer, "ti,omap-counter32k",
> -		ti_32k_timer_init);
> +
> +subsys_initcall(ti_32k_init);
> +
> +MODULE_AUTHOR("Paul Mundt");
> +MODULE_AUTHOR("Juha Yrj=C3=B6l=C3=A4");
> +MODULE_DESCRIPTION("OMAP2 32k Timer");
> +MODULE_ALIAS("platform:ti_32k_timer");
> +MODULE_LICENSE("GPL v2");

this will break clksource_of_init(), right ? Eventually, we want that to
be the only thing called by our .init_time method. I'll leave it to Tony
to decide, but IMO this is not a good path forward for timers.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWT2SZAAoJEIaOsuA1yqREoZYP/1I8BqIejJaCncT5UWgXT/W6
5JG0P6x5YIToeqC8W9E6hJji0Dd8O7/oiFsaDTwMxFPCIs176DF2Ao1IPoJ0leTS
Q60q8Y2VpLRdnKeviTawDeAGs43RoX5/71ixaOKhTfs1/f+DAc5sQK7rVqaNWI9o
mRFfybsVUfYvr3F2E72oVreQnhYlIfiwxbJJJLreITigsO/ek2Dw1oi/BhgmrW7m
ipeOmjx1Qxpk5wwfNflxXy6kpsYSDYMUW+bT1ufoIGkvmZtYVSlRhRx2m4AvMZVY
SpqMyrMgTojvv7IDLr6ayawdO58aXI/DYPRE4yeny/0MC1HYzMFU3crJMchJXBoz
T0dgOlTptXFcuRuSuzRT0cTIm54JAIrPWKlvA6xH40MMjwwVgGw6YHn94ptHEnPN
FPSxJ7qy6BxntJW3Di4OQ4GG+uJFOBf+8/6gcq4rBX487Vr9oVAq2y5BQ69JbbdS
CwhvKX9ZOfamuayUPOp5t8aLK1uPen1AfsYv9YQBaOF9+PhOPTJDjV3mfvoIR3hp
dFHAk+f6WJBhoxAVYgV2+Qu7pk2XFFBkdzmS5qvXKa3YO/JJoM5bUG9UB8+EHKf6
gLoUU+PJJ9s8yqHDRy6IAOcpSDd7DcTuj1RvFCXT9tiQiGbehuOL3mRaJJcDwvd5
Bfu1esNwQxCWEb5xeXlW
=OGG7
-----END PGP SIGNATURE-----
--=-=-=--
