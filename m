From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 7/7] arm: omap: pdata-quirks: Remove unused timer pdata
Date: Thu, 9 Nov 2017 17:29:02 +0100
Message-ID: <20171109162902.gmqcznrvegvkwrrz@earth>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
 <1510144108-29563-8-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vj2xfcwpxwnaujo5"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510144108-29563-8-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, khilman@kernel.org, daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--vj2xfcwpxwnaujo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 08, 2017 at 05:58:28PM +0530, Keerthy wrote:
> Remove unused timer pdata.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>=20
> No code changes in this v2 version. Only enhanced patch
> statistics for renames.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  arch/arm/mach-omap2/pdata-quirks.c | 32 --------------------------------
>  1 file changed, 32 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pda=
ta-quirks.c
> index ad9df86..e7d7fc7 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -24,10 +24,8 @@
>  #include <linux/platform_data/hsmmc-omap.h>
>  #include <linux/platform_data/iommu-omap.h>
>  #include <linux/platform_data/wkup_m3.h>
> -#include <linux/platform_data/pwm_omap_dmtimer.h>
>  #include <linux/platform_data/media/ir-rx51.h>
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
> -#include <clocksource/dmtimer.h>
> =20
>  #include "common.h"
>  #include "common-board-devices.h"
> @@ -477,33 +475,6 @@ void omap_auxdata_legacy_init(struct device *dev)
>  	dev->platform_data =3D &twl_gpio_auxdata;
>  }
> =20
> -/* Dual mode timer PWM callbacks platdata */
> -#if IS_ENABLED(CONFIG_OMAP_DM_TIMER)
> -static struct pwm_omap_dmtimer_pdata pwm_dmtimer_pdata =3D {
> -	.request_by_node =3D omap_dm_timer_request_by_node,
> -	.request_specific =3D omap_dm_timer_request_specific,
> -	.request =3D omap_dm_timer_request,
> -	.set_source =3D omap_dm_timer_set_source,
> -	.get_irq =3D omap_dm_timer_get_irq,
> -	.set_int_enable =3D omap_dm_timer_set_int_enable,
> -	.set_int_disable =3D omap_dm_timer_set_int_disable,
> -	.free =3D omap_dm_timer_free,
> -	.enable =3D omap_dm_timer_enable,
> -	.disable =3D omap_dm_timer_disable,
> -	.get_fclk =3D omap_dm_timer_get_fclk,
> -	.start =3D omap_dm_timer_start,
> -	.stop =3D omap_dm_timer_stop,
> -	.set_load =3D omap_dm_timer_set_load,
> -	.set_match =3D omap_dm_timer_set_match,
> -	.set_pwm =3D omap_dm_timer_set_pwm,
> -	.set_prescaler =3D omap_dm_timer_set_prescaler,
> -	.read_counter =3D omap_dm_timer_read_counter,
> -	.write_counter =3D omap_dm_timer_write_counter,
> -	.read_status =3D omap_dm_timer_read_status,
> -	.write_status =3D omap_dm_timer_write_status,
> -};
> -#endif
> -
>  static struct ir_rx51_platform_data __maybe_unused rx51_ir_data =3D {
>  	.set_max_mpu_wakeup_lat =3D omap_pm_set_max_mpu_wakeup_lat,
>  };
> @@ -572,9 +543,6 @@ static void __init omap3_mcbsp_init(void) {}
>  	OF_DEV_AUXDATA("ti,am4372-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
>  		       &wkup_m3_data),
>  #endif
> -#if IS_ENABLED(CONFIG_OMAP_DM_TIMER)
> -	OF_DEV_AUXDATA("ti,omap-dmtimer-pwm", 0, NULL, &pwm_dmtimer_pdata),
> -#endif
>  #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
>  	OF_DEV_AUXDATA("ti,omap4-iommu", 0x4a066000, "4a066000.mmu",
>  		       &omap4_iommu_pdata),
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--vj2xfcwpxwnaujo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloEgk4ACgkQ2O7X88g7
+poBlg//b119y1WURpxyz7wam4nwY+Zp1BEdqsnexHI8lE0oIgJXfdct/6ZeznvQ
lMl+3AII+WRfhktRG57IhoQMoOIMUuEmSwaombOmQ4gxPdEQBCIyxuHTlytzjcvd
LVl7M1HbXdtPV8cHVrr/eFv7J8yrNW9+I7AjhEjBj1TkqN1K18zNNoopAE/kqIFe
bwwRQzeJhxHE5/hgdz8NEELIadL//NLZGSk/qTEEgg3wuo1s4Xapid1G3gFIUsnt
dgvEqlmNPXt8Pd4D5biNnavi23pHzZbbWbFg6GvNbfOimAwHfZkBkfIkabReWPJW
LAaKpvcg/ID6keMAGbW4qjQ1hNb6WDHZ5yZliruvmw2oq0M8NEC+VCzlcffPGaCo
yugxnqWyV0NQvYsOQZtZjoAZJWPaHAlmWC9S4DVvXyn9tdjWoe8PHwO901hwyrhG
jPBFC3UXKUmGmtMtsMxa9AP+1CotdaC7fVY+f+XhFmzjJ1y2bd4+xDyr2BJ1c34x
4ouEjklxTL7dey0UP1FMdNAMxtVTpYYtLO7Q3FjEuGM0HLMd+oAk7OBUvHGMFowO
QomipTbKg27KSUcrUp8+uschQqET9gBdKbdrcA5ZE8d7mKntMyJr5E+6xNnV/8eu
OxlLuLUYatUfW7bDRUy9Kv/Ts2CEwPXwutY/9YCZQWQKVO+TjbU=
=v/3m
-----END PGP SIGNATURE-----

--vj2xfcwpxwnaujo5--
