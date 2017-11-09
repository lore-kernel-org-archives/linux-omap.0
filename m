From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 3/7] arm: OMAP: Move dmtimer driver out of plat-omap
 to drivers under clocksource
Date: Thu, 9 Nov 2017 17:17:12 +0100
Message-ID: <20171109161712.4upyx7sypfdctuop@earth>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
 <1510144108-29563-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zodj7mqd3ivtelnj"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510144108-29563-4-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, khilman@kernel.org, daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--zodj7mqd3ivtelnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 08, 2017 at 05:58:24PM +0530, Keerthy wrote:
> Move the dmtimer driver out of plat-omap to clocksource.
> So that non-omap devices also could use this.
>=20
> No Code changes done to the driver file.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>=20
> No code changes in this v2 version. Only enhanced patch
> statistics for renames.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  arch/arm/plat-omap/Kconfig                            | 6 ------
>  arch/arm/plat-omap/Makefile                           | 1 -
>  drivers/clocksource/Kconfig                           | 6 ++++++
>  drivers/clocksource/Makefile                          | 1 +
>  {arch/arm/plat-omap =3D> drivers/clocksource}/dmtimer.c | 0
>  5 files changed, 7 insertions(+), 7 deletions(-)
>  rename {arch/arm/plat-omap =3D> drivers/clocksource}/dmtimer.c (100%)
>=20
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 3e27bff..4b92ac5 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -105,12 +105,6 @@ config OMAP3_L2_AUX_SECURE_SERVICE_SET_ID
>  	help
>  	  PPA routine service ID for setting L2 auxiliary control register.
> =20
> -config OMAP_DM_TIMER
> -	bool "Use dual-mode timer"
> -	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
> -	help
> -	 Select this option if you want to use OMAP Dual-Mode timers.
> -
>  config OMAP_SERIAL_WAKE
>  	bool "Enable wake-up events for serial ports"
>  	depends on ARCH_OMAP1 && OMAP_MUX
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 47e1867..7215ada 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -9,5 +9,4 @@ obj-y :=3D sram.o dma.o counter_32k.o
> =20
>  # omap_device support (OMAP2+ only at the moment)
> =20
> -obj-$(CONFIG_OMAP_DM_TIMER) +=3D dmtimer.o
>  obj-$(CONFIG_OMAP_DEBUG_LEDS) +=3D debug-leds.o
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index c729a88..4da66cf 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -46,6 +46,12 @@ config DIGICOLOR_TIMER
>  	help
>  	  Enables the support for the digicolor timer driver.
> =20
> +config OMAP_DM_TIMER
> +	bool "Use dual-mode timer"
> +	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
> +	help
> +	 Select this option if you want to use Dual-Mode timers.
> +
>  config DW_APB_TIMER
>  	bool "DW APB timer driver" if COMPILE_TEST
>  	help
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index dbc1ad1..a8e51e6 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_EM_TIMER_STI)	+=3D em_sti.o
>  obj-$(CONFIG_CLKBLD_I8253)	+=3D i8253.o
>  obj-$(CONFIG_CLKSRC_MMIO)	+=3D mmio.o
>  obj-$(CONFIG_DIGICOLOR_TIMER)	+=3D timer-digicolor.o
> +obj-$(CONFIG_OMAP_DM_TIMER)	+=3D dmtimer.o
>  obj-$(CONFIG_DW_APB_TIMER)	+=3D dw_apb_timer.o
>  obj-$(CONFIG_DW_APB_TIMER_OF)	+=3D dw_apb_timer_of.o
>  obj-$(CONFIG_FTTMR010_TIMER)	+=3D timer-fttmr010.o
> diff --git a/arch/arm/plat-omap/dmtimer.c b/drivers/clocksource/dmtimer.c
> similarity index 100%
> rename from arch/arm/plat-omap/dmtimer.c
> rename to drivers/clocksource/dmtimer.c
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--zodj7mqd3ivtelnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloEf4gACgkQ2O7X88g7
+po3ThAAkZ9wanvbtsXDeq/va2q2j9hvqZI3gZVakx23FskzmCC/CiN0jbvKE+Sx
CeMtFHG9VIYSqTGjh/0wu+aI7aHFF8LHiH4sZjT5+2awOTIh1StTVQpxKYM1LfdA
suceI4TqlJSBtftzPDKTUPyT5wM7aLMO2AgByOzxPdmmLkWsxigKu+HD8FcwTmM3
RilxUYx1YCiYLK8AvPWBGx6ftvd0LTZHS+AiuRkOSELCqKNmFsoHB7Mb+Ou9/P4P
F7LrMt5TSYkjwM9iABZLsDl2TPIcjCDbIcY9TCQ9kDYYvQ79W2S1qjGBMlW1u/14
zKGQvy6VzBjmC2YBLxisPOhdePh2aEQ6qiTox9fvkxETKPD3JL4BDqzwfVNf4dXf
bb1xjT8PC8ofBJ73RmujofznfpyrtKNLyS1FWM0v2BgorgB38ZyNEG329mVjF+m9
NqtxRGErF2qoGjBhZ56lND+IBSO/AsHbQIujHqP4D9y5G0ggjn6yrEp10sSRmqDr
Ayqt1QRqs3ToXVBbn0npr1sEp5OrB9OUexfkI6NUUU+wUVOItiFfC8ubW4yGf4c7
JvIOgtyHoaN8Qn5dgkz+c1rmDUv/nSf6he9uxt7TFmV0WC9urS3ohW43f1PSbVgf
2GHTwp4Q2QgtJehlsGrvqK9FyKQX01UyEDIY4vzwTSAJp0R4yzA=
=jbzy
-----END PGP SIGNATURE-----

--zodj7mqd3ivtelnj--
