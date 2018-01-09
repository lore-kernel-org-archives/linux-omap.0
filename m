From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v7 2/9] arm: omap: timer: Wrap the inline functions under
 OMAP2PLUS define
Date: Tue, 9 Jan 2018 10:19:19 +0100
Message-ID: <20180109091919.m4xx6kgs6ad32nvz@earth.universe>
References: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
 <1515478987-5786-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nt6qf6agbrchd7hc"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515478987-5786-3-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: daniel.lezcano@linaro.org, thierry.reding@gmail.com, tony@atomide.com, aaro.koskinen@iki.fi, Claudiu.Beznea@microchip.com, narmstrong@baylibre.com, linux-pwm@vger.kernel.org, ladis@linux-mips.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org


--nt6qf6agbrchd7hc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 09, 2018 at 11:53:00AM +0530, Keerthy wrote:
> Wrap the inline functions under OMAP2PLUS/OMAP1 defines.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Tested-by: Ladislav Michl <ladis@linux-mips.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  arch/arm/plat-omap/include/plat/dmtimer.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-om=
ap/include/plat/dmtimer.h
> index dd79f30..862ad62 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -276,6 +276,12 @@ struct omap_dm_timer {
>  #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
>  		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
> =20
> +/*
> + * The below are inlined to optimize code size for system timers. Other =
code
> + * should not need these at all, see
> + * include/linux/platform_data/pwm_omap_dmtimer.h
> + */
> +#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2PLUS)
>  static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 =
reg,
>  						int posted)
>  {
> @@ -414,5 +420,5 @@ static inline void __omap_dm_timer_write_status(struc=
t omap_dm_timer *timer,
>  {
>  	writel_relaxed(value, timer->irq_stat);
>  }
> -
> +#endif /* CONFIG_ARCH_OMAP1 || CONFIG_ARCH_OMAP2PLUS */
>  #endif /* __ASM_ARCH_DMTIMER_H */
> --=20
> 1.9.1
>=20

--nt6qf6agbrchd7hc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpUiRMACgkQ2O7X88g7
+ppgsA/9EDlAx3bEYAy7jDSRgNUdKShddd7WUPxLVUECWJHFhxMVEfV42cWaK0sF
nNXdsbmQkvMhyVCaxUw06R/e8A0/SaHJZqrTGm4/taD/FQvGsvHvdm5NvzY7CjTD
fhgt42lU+NHyYXPm/3nnhNnuh+JldnblwWP1sf8n7/15KSo0gS2MQep6Ei9imv1S
cIjMHxj6AMR5+3HPUClQVtjMBqPqAY0mASi8Rlb6c6rX5QHi0LGAGmM4WI0XwfSG
PbF6mV+ox4X5/9/eW33BHTOz1O/Z1c9fF7fqpNYhOk8Jzqpqpu5CePryasga/oks
gtgd2ctcouHS36m1omiQWqDvC/6uCjHXaOpuUxBPvh4tiSa2jzG6fSmluQfZelpV
/pV6CbRc7AAfLpHRX6WIc9C6iSnuQl+u69ly6PFplhWj6sF2nzj/SC0zfVdWrs3R
74cbG+e7YXJwfz2tqM1YQaqesvm3ZK8F1xXyjYdDHwNUOE/ZzhUBVFNeQ6yidqCD
yX/5l4rfBjOLpDgHjQnmS1mJh8laIvfGgQyocRoDcYGIdMEi+NwHArZ4xxMFY4rB
VY/iqxN6vkeia7o8YlKKsrXQy6Qadkjp6M0BTSWyIB61y0GHGCZ9fczrUrrs1mPo
I1HEMjNzaHBjnr2faW41ZiDz9mLPPk8fL72m9EnyEg7qC5xU9RE=
=4iT4
-----END PGP SIGNATURE-----

--nt6qf6agbrchd7hc--
