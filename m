From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 2/7] arm: omap: Move dmtimer.h out of plat-omap
Date: Thu, 9 Nov 2017 17:16:41 +0100
Message-ID: <20171109161641.caehzwiylvsl5gcc@earth>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
 <1510144108-29563-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wtzmmb7ucsxac5vu"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510144108-29563-3-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, khilman@kernel.org, daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--wtzmmb7ucsxac5vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 08, 2017 at 05:58:23PM +0530, Keerthy wrote:
> The header file is currently under plat-omap directory
> under arch/omap. Move this out to an accessible place.
>=20
> No Code changes done to the header file.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>=20
> No code changes in this v2 version. Only enhanced patch
> statistics for renames.

Thanks, this is much easier to review.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  arch/arm/mach-omap1/pm.c                                           | 2 +-
>  arch/arm/mach-omap1/timer.c                                        | 2 +-
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c                         | 2 +-
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c                         | 2 +-
>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c                 | 2 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c                         | 2 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c                         | 2 +-
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c                         | 2 +-
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c                          | 2 +-
>  arch/arm/mach-omap2/omap_hwmod_81xx_data.c                         | 2 +-
>  arch/arm/mach-omap2/pdata-quirks.c                                 | 2 +-
>  arch/arm/mach-omap2/timer.c                                        | 2 +-
>  arch/arm/plat-omap/dmtimer.c                                       | 2 +-
>  {arch/arm/plat-omap/include/plat =3D> include/clocksource}/dmtimer.h | 0
>  14 files changed, 13 insertions(+), 13 deletions(-)
>  rename {arch/arm/plat-omap/include/plat =3D> include/clocksource}/dmtime=
r.h (100%)
>=20
> diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
> index f1135bf..a07d47cf 100644
> --- a/arch/arm/mach-omap1/pm.c
> +++ b/arch/arm/mach-omap1/pm.c
> @@ -55,7 +55,7 @@
>  #include <mach/tc.h>
>  #include <mach/mux.h>
>  #include <linux/omap-dma.h>
> -#include <plat/dmtimer.h>
> +#include <clocksource/dmtimer.h>
> =20
>  #include <mach/irqs.h>
> =20
> diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
> index 8fb1ec6..7c057ab 100644
> --- a/arch/arm/mach-omap1/timer.c
> +++ b/arch/arm/mach-omap1/timer.c
> @@ -27,7 +27,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/dmtimer-omap.h>
> =20
> -#include <plat/dmtimer.h>
> +#include <clocksource/dmtimer.h>
> =20
>  #include "soc.h"
> =20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-o=
map2/omap_hwmod_2420_data.c
> index 1a15a34..45c1043 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -16,7 +16,7 @@
>  #include <linux/i2c-omap.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
>  #include <linux/omap-dma.h>
> -#include <plat/dmtimer.h>
> +#include <clocksource/dmtimer.h>
> =20
>  #include "omap_hwmod.h"
>  #include "l3_2xxx.h"
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-o=
map2/omap_hwmod_2430_data.c
> index 3801850..892ca58 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -18,7 +18,7 @@
>  #include <linux/platform_data/hsmmc-omap.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
>  #include <linux/omap-dma.h>
> -#include <plat/dmtimer.h>
> +#include <clocksource/dmtimer.h>
> =20
>  #include "omap_hwmod.h"
>  #include "l3_2xxx.h"
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/ar=
m/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
> index beec4cd..82b51c0 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
> @@ -11,7 +11,7 @@
> =20
>  #include <linux/platform_data/gpio-omap.h>
>  #include <linux/omap-dma.h>
> -#include <plat/dmtimer.h>
> +#include <clocksource/dmtimer.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
> =20
>  #include "omap_hwmod.h"
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_3xxx_data.c
> index 9cfba41..2423c51 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -25,7 +25,7 @@
>  #include "l4_3xxx.h"
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
> -#include <plat/dmtimer.h>
> +#include <clocksource/dmtimer.h>
> =20
>  #include "soc.h"
>  #include "omap_hwmod.h"
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_44xx_data.c
> index c477096..22e0e38 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -30,7 +30,7 @@
> =20
>  #include <linux/platform_data/spi-omap2-mcspi.h>
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
> -#include <plat/dmtimer.h>
> +#include <clocksource/dmtimer.h>
> =20
>  #include "omap_hwmod.h"
>  #include "omap_hwmod_common_data.h"
> diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_54xx_data.c
> index 988e7ea..530334e 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> @@ -26,7 +26,7 @@
>  #include <linux/omap-dma.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
> -#include <plat/dmtimer.h>
> +#include <clocksource/dmtimer.h>
> =20
>  #include "omap_hwmod.h"
>  #include "omap_hwmod_common_data.h"
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-om=
ap2/omap_hwmod_7xx_data.c
> index d05e553d..adabdef 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -26,7 +26,7 @@
>  #include <linux/omap-dma.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
> -#include <plat/dmtimer.h>
> +#include <clocksource/dmtimer.h>
> =20
>  #include "omap_hwmod.h"
>  #include "omap_hwmod_common_data.h"
> diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_81xx_data.c
> index 77a515b..d05dd2d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> @@ -18,7 +18,7 @@
>  #include <linux/platform_data/gpio-omap.h>
>  #include <linux/platform_data/hsmmc-omap.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
> -#include <plat/dmtimer.h>
> +#include <clocksource/dmtimer.h>
> =20
>  #include "omap_hwmod_common_data.h"
>  #include "cm81xx.h"
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pda=
ta-quirks.c
> index 6b433fc..ad9df86 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -27,7 +27,7 @@
>  #include <linux/platform_data/pwm_omap_dmtimer.h>
>  #include <linux/platform_data/media/ir-rx51.h>
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
> -#include <plat/dmtimer.h>
> +#include <clocksource/dmtimer.h>
> =20
>  #include "common.h"
>  #include "common-board-devices.h"
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index ece09c9..31c1b01 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -26,6 +26,7 @@
>   * License. See the file "COPYING" in the main directory of this archive
>   * for more details.
>   */
> +#include <clocksource/dmtimer.h>
>  #include <linux/init.h>
>  #include <linux/time.h>
>  #include <linux/interrupt.h>
> @@ -49,7 +50,6 @@
>  #include "omap_hwmod.h"
>  #include "omap_device.h"
>  #include <plat/counter-32k.h>
> -#include <plat/dmtimer.h>
>  #include "omap-pm.h"
> =20
>  #include "soc.h"
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 72565fc..afe1dc9 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -47,7 +47,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/dmtimer-omap.h>
> =20
> -#include <plat/dmtimer.h>
> +#include <clocksource/dmtimer.h>
> =20
>  static u32 omap_reserved_systimers;
>  static LIST_HEAD(omap_timer_list);
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/include/clocksou=
rce/dmtimer.h
> similarity index 100%
> rename from arch/arm/plat-omap/include/plat/dmtimer.h
> rename to include/clocksource/dmtimer.h
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--wtzmmb7ucsxac5vu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloEf2kACgkQ2O7X88g7
+prNqg/+JWGt/pipy0+EF/9ybPRdC6Jzlgkn2TMPfffHrZE7JyZjReH2KJncdQAo
Q7F1/lkV3mNbdL/O7pMBih4xfPpTBMSAIYQ4+g6Yke2UqbYUUuuaP+/RbzoekWe3
HxROF2BTx/vc9i29NFDguvs27kQfqcvKSJnRrCsbp6Ojx5hqi74HY8GYDeImojv/
4kG25wEUtziOX8BapjRsa+d4CHwCPzT/vqrrAfuGEke8uWsIJIHLDxjnzHOMUprN
m7uwlk5OH4Q6SxIuhtVUvEuZ3Wn4PUMHXSVYroGH3lhEJmy0ZytqM9j4Oi+TtK7g
l4jb23i0aQrvVQ4mczm8vRDmx1Ug4O3cEVh0K89TBDVjohCzDsY8rj2bCZAbm17K
FJ4PIPFFaV/zw12eqeLwg/ud44Ia+lk2wTf/C9aH6+eCsz/bkOwNqbVRkC9QKoFo
7I8VoeuxKzj8mOf7gLlkdVC7mpGIicpIYPZuPQX3wr66UQeMm0VO2NcUnYe++KeH
JGXObnb0ew61RuURqmzMJc9X1N9uDF9RKLV3nQX35y9ewa+UJZNJ9CrJjM54QEU7
yZ4XxoBenMi9fAspk8nNCYvZur8tr+S59BA6Mih17CMIDw50TXI73pdJ6zjjVZa4
tzQ4iI8/JdTgpMvYwK1zem6XiGBMfNlAxzjC9ze24Vrq0dppGaU=
=vWzW
-----END PGP SIGNATURE-----

--wtzmmb7ucsxac5vu--
