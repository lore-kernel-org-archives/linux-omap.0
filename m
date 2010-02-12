From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [RESEND][PATCHv2 4/4] OMAP: DSS2: Add Innolux 7" display for
	DEVKIT8000
Date: Fri, 12 Feb 2010 13:55:57 +0800
Message-ID: <45a44e481002112155u68c806beg9fe0a3a122d09d25@mail.gmail.com>
References: <1265917278-22011-1-git-send-email-swirl@gmx.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f172.google.com ([209.85.222.172]:55030 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab0BLGEL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 01:04:11 -0500
In-Reply-To: <1265917278-22011-1-git-send-email-swirl@gmx.li>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <swirl@gmx.li>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 12, 2010 at 3:41 AM, Thomas Weber <swirl@gmx.li> wrote:
> This patch adds the 7 inch display for the DEVKIT8000.
>
> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
> =A0drivers/video/omap2/displays/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A08 ++-
> =A0drivers/video/omap2/displays/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A01 +
> =A0.../video/omap2/displays/panel-innolux-at070tn83.c | =A0107 ++++++=
++++++++++++++
> =A03 files changed, 115 insertions(+), 1 deletions(-)
> =A0create mode 100644 drivers/video/omap2/displays/panel-innolux-at07=
0tn83.c
>
> diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/oma=
p2/displays/Kconfig
> index b12a59c..ca6b372 100644
> --- a/drivers/video/omap2/displays/Kconfig
> +++ b/drivers/video/omap2/displays/Kconfig
> @@ -5,7 +5,7 @@ config PANEL_GENERIC
> =A0 =A0 =A0 =A0 tristate "Generic Panel"
> =A0 =A0 =A0 =A0 help
> =A0 =A0 =A0 =A0 =A0Generic panel driver.
> - =A0 =A0 =A0 =A0 Used for DVI output for Beagle and OMAP3 SDP.
> + =A0 =A0 =A0 =A0 Used for DVI output for Beagle, Devkit8000 and OMAP=
3 SDP.
>
> =A0config PANEL_SHARP_LS037V7DW01
> =A0 =A0 =A0 =A0 tristate "Sharp LS037V7DW01 LCD Panel"
> @@ -13,6 +13,12 @@ config PANEL_SHARP_LS037V7DW01
> =A0 =A0 =A0 =A0 help
> =A0 =A0 =A0 =A0 =A0 LCD Panel used in TI's SDP3430 and EVM boards
>
> +config PANEL_INNOLUX_AT070TN83
> + =A0 =A0 =A0 tristate "Innolux AT070TN83 LCD Panel"
> + =A0 =A0 =A0 depends on OMAP2_DSS
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0LCD Panel used in TimLL's Devkit8000
> +
> =A0config PANEL_TAAL
> =A0 =A0 =A0 =A0 tristate "Taal DSI Panel"
> =A0 =A0 =A0 =A0 depends on OMAP2_DSS_DSI
> diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/om=
ap2/displays/Makefile
> index 9556464..087b192 100644
> --- a/drivers/video/omap2/displays/Makefile
> +++ b/drivers/video/omap2/displays/Makefile
> @@ -2,3 +2,4 @@ obj-$(CONFIG_PANEL_GENERIC) +=3D panel-generic.o
> =A0obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) +=3D panel-sharp-ls037v7dw01=
=2Eo
>
> =A0obj-$(CONFIG_PANEL_TAAL) +=3D panel-taal.o
> +obj-$(CONFIG_PANEL_INNOLUX_AT070TN83) +=3D panel-innolux-at070tn83.o
> diff --git a/drivers/video/omap2/displays/panel-innolux-at070tn83.c b=
/drivers/video/omap2/displays/panel-innolux-at070tn83.c
> new file mode 100644
> index 0000000..f1d7f69
> --- /dev/null
> +++ b/drivers/video/omap2/displays/panel-innolux-at070tn83.c
> @@ -0,0 +1,107 @@
> +/*
> + * LCD panel driver for Innolux AT70TN83
> + *
> + * Copyright (C) 2010 Thomas Weber <weber@corscience.de>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as pu=
blished by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public L=
icense for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along with
> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/err.h>
> +
> +#include <plat/display.h>
> +
> +static struct omap_video_timings innolux_at_timings =3D {
> + =A0 =A0 =A0 .x_res =A0 =A0 =A0 =A0 =A0=3D 800,
> + =A0 =A0 =A0 .y_res =A0 =A0 =A0 =A0 =A0=3D 480,
> +
> + =A0 =A0 =A0 .pixel_clock =A0 =A0=3D 40000,
> +
> + =A0 =A0 =A0 .hsw =A0 =A0 =A0 =A0 =A0 =A0=3D 48,
> + =A0 =A0 =A0 .hfp =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> + =A0 =A0 =A0 .hbp =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> +
> + =A0 =A0 =A0 .vsw =A0 =A0 =A0 =A0 =A0 =A0=3D 3,
> + =A0 =A0 =A0 .vfp =A0 =A0 =A0 =A0 =A0 =A0=3D 12,
> + =A0 =A0 =A0 .vbp =A0 =A0 =A0 =A0 =A0 =A0=3D 25,
> +};
> +
> +static int innolux_at_panel_probe(struct omap_dss_device *dssdev)
> +{
> + =A0 =A0 =A0 dssdev->panel.config =3D OMAP_DSS_LCD_TFT | OMAP_DSS_LC=
D_IVS |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DSS_LCD_IHS;
> + =A0 =A0 =A0 dssdev->panel.acb =3D 0x28;
> + =A0 =A0 =A0 dssdev->panel.timings =3D innolux_at_timings;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +

Hi Thomas, Tomi,

Just curious, does this patch imply that code like this needs to be
written for every single LCD type and resolution that can be connected
to omap2? Maybe there is a better way, like a common table of timings
and values that can be selected with a module option or even
autodetected.

Thanks,
jaya
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
