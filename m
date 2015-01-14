From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 6/7] ARM: OMAP2+: Fix reboot for 81xx
Date: Tue, 13 Jan 2015 19:24:47 -0600
Message-ID: <20150114012447.GF18523@saruman>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
 <1421190837-4692-7-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33181 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbbANBZx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2015 20:25:53 -0500
Content-Disposition: inline
In-Reply-To: <1421190837-4692-7-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2015 at 03:13:56PM -0800, Tony Lindgren wrote:
> We are missing proper hooks for 81xx for reboot to work.
>=20
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Makefile         |  1 +
>  arch/arm/mach-omap2/common.h         |  8 ++++++++
>  arch/arm/mach-omap2/ti81xx-restart.c | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
>  create mode 100644 arch/arm/mach-omap2/ti81xx-restart.c
>=20
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 5d27dfd..3a6463f 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -58,6 +58,7 @@ AFLAGS_sram34xx.o			:=3D-Wa,-march=3Darmv7-a
>  # Restart code (OMAP4/5 currently in omap4-common.c)
>  obj-$(CONFIG_SOC_OMAP2420)		+=3D omap2-restart.o
>  obj-$(CONFIG_SOC_OMAP2430)		+=3D omap2-restart.o
> +obj-$(CONFIG_SOC_TI81XX)		+=3D ti81xx-restart.o
>  obj-$(CONFIG_SOC_AM33XX)		+=3D am33xx-restart.o
>  obj-$(CONFIG_SOC_AM43XX)		+=3D omap4-restart.o
>  obj-$(CONFIG_ARCH_OMAP3)		+=3D omap3-restart.o
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 900ebdd..65b4371 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -164,6 +164,14 @@ static inline void omap3xxx_restart(enum reboot_mode=
 mode, const char *cmd)
>  }
>  #endif
> =20
> +#ifdef CONFIG_SOC_TI81XX
> +void ti81xx_restart(enum reboot_mode mode, const char *cmd);
> +#else
> +static inline void ti81xx_restart(enum reboot_mode mode, const char *cmd)
> +{
> +}
> +#endif
> +
>  #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
>  	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
>  void omap44xx_restart(enum reboot_mode mode, const char *cmd);
> diff --git a/arch/arm/mach-omap2/ti81xx-restart.c b/arch/arm/mach-omap2/t=
i81xx-restart.c
> new file mode 100644
> index 0000000..68b29be
> --- /dev/null
> +++ b/arch/arm/mach-omap2/ti81xx-restart.c
> @@ -0,0 +1,31 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/reboot.h>
> +
> +#include "iomap.h"
> +#include "common.h"
> +#include "control.h"
> +#include "prm3xxx.h"
> +
> +#define TI81XX_PRM_DEVICE_RSTCTRL	0x00a0
> +#define TI81XX_GLOBAL_RST_COLD		BIT(1)
> +
> +/**
> + * ti81xx_restart - trigger a software restart of the SoC
> + * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
> + * @cmd: passed from the userspace program rebooting the system (if prov=
ided)
> + *
> + * Resets the SoC.  For @cmd, see the 'reboot' syscall in
> + * kernel/sys.c.  No return value.
> + */
> +void ti81xx_restart(enum reboot_mode mode, const char *cmd)
> +{
> +	omap2_prm_set_mod_reg_bits(TI81XX_GLOBAL_RST_COLD, 0,
> +				   TI81XX_PRM_DEVICE_RSTCTRL);

do you need to check that mode =3D=3D REBOOT_COLD here ?

--=20
balbi

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtcVfAAoJEIaOsuA1yqREi7wP/A/Oh0FpWL97wO+7V6WsxSdw
NwPO4ogap5RjFc34O+BcbWzbrEHdgJe05hUnslTHYbMdw3r8LrpVE8zVE3P3r2Vt
UBjfzQf/oodIAYVp7UnTecEUxpPg+8Ey/4NK0lqL0dr+UW38PhG5rx6FKDDywhhA
S8gubxJw5oqpqLPslrwob7lxCQ+FLHzu0TFFvc4BUX538RRZl6jhHpW5Jn+bxdkn
aN+6PflLDTVpthWwzxBlEoQ2Qtk0McPs+n6s1X3HElxsWRmCQONJhDtXih6toAye
NmJUgxydFHep9qzG0CFNA0tqIhkhCFGDjcqw+B92pCdHIQptB7knlEEEarEkD72T
C5sGci5YfA+qGKzDG3qPjkee9dyhhETV+Ao6b8tC46Eh2ns8iymGDkgg9cJAfS/V
oxUCGvLpuxcujzewDzMok5/uRf0VumGamWmOKFn9AcKQNenipHgiL/jBVXwiGCU1
PobVddOmNzRNkjWGA9tQr8rwMrzec2sqhSZJA4rytbzeGz777x9TGA1iCKkCb5YP
dH8PzsQBGSHPg2qzC/QrH7C4f+STL7r7Vx5a5ybmrqbsnvf7GlIf4HJbVI5Vha9k
E5hjmZ4YN16uqygT/56topSIzUNJ+J8/r447JZ3yMpNYw1a+yW2+s5gfncv5Icil
cXYe3250yJwXSPODSMY8
=igwz
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--
