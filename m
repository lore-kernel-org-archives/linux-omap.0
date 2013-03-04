From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: Fix build related to kgdb.h no longer
 including serial_8250.h
Date: Mon, 4 Mar 2013 11:02:39 -0800
Message-ID: <20130304190238.GU11806@atomide.com>
References: <20130211224600.GB4801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41015 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758718Ab3CDTCo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 14:02:44 -0500
Content-Disposition: inline
In-Reply-To: <20130211224600.GB4801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [130211 14:49]:
> Commit 16559ae4 (kgdb: remove #include <linux/serial_8250.h> from kgd=
b.h)
> had a side effect of breaking omap1_defconfig build as some headers
> were included indirectly:
>=20
> arch/arm/mach-omap1/board-h2.c:249: error: =E2=80=98INT_KEYBOARD=E2=80=
=99 undeclared here (not in a function)
> ...
>=20
> This worked earlier as linux/serial_8250.h included linux/serial_core=
=2Eh,
> via linux/serial_8250.h from linux/kgdb.h. Fix this by including the
> necessary headers directly.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> ---
>=20
> Arnd & Olof, can you please apply this to your non-critical fixes
> or some other branch that gets merged early on during the merge
> window?

I'll apply this into omap-for-v3.9-rc1/fixes.

Tony
=20
> --- a/arch/arm/mach-omap1/common.h
> +++ b/arch/arm/mach-omap1/common.h
> @@ -31,6 +31,8 @@
> =20
>  #include <plat/i2c.h>
> =20
> +#include <mach/irqs.h>
> +
>  #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
>  void omap7xx_map_io(void);
>  #else
> --- a/drivers/video/omap/lcd_ams_delta.c
> +++ b/drivers/video/omap/lcd_ams_delta.c
> @@ -27,6 +27,7 @@
>  #include <linux/lcd.h>
>  #include <linux/gpio.h>
> =20
> +#include <mach/hardware.h>
>  #include <mach/board-ams-delta.h>
> =20
>  #include "omapfb.h"
> --- a/drivers/video/omap/lcd_osk.c
> +++ b/drivers/video/omap/lcd_osk.c
> @@ -24,7 +24,10 @@
>  #include <linux/platform_device.h>
> =20
>  #include <asm/gpio.h>
> +
> +#include <mach/hardware.h>
>  #include <mach/mux.h>
> +
>  #include "omapfb.h"
> =20
>  static int osk_panel_init(struct lcd_panel *panel, struct omapfb_dev=
ice *fbdev)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
