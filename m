From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 6/8] OMAP4 : DSS2 : HDMI: HDMI panel driver addition in
 the DSS
Date: Mon, 28 Feb 2011 11:44:53 +0530
Message-ID: <AANLkTi=Kk0QYpzgXUtfxGP=tgvY1xqgVDK+Q0jZv7Ssz@mail.gmail.com>
References: <1298643715-21540-1-git-send-email-mythripk@ti.com>
	<1298643715-21540-7-git-send-email-mythripk@ti.com>
	<1298799839.1977.31.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:60381 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750817Ab1B1GO4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 01:14:56 -0500
Received: by mail-vw0-f53.google.com with SMTP id 8so3965951vws.40
        for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 22:14:55 -0800 (PST)
In-Reply-To: <1298799839.1977.31.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,
I shall add per device lock and make the lock consistent , as audio
can also call these functions.

Thanks and regards,
Mythri.

On Sun, Feb 27, 2011 at 3:13 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2011-02-25 at 08:21 -0600, K, Mythri P wrote:
>> The panel driver(hdmi_omap4_panel.c) in dss file acts as a controlle=
r
>> to manage the enable and disable requests and synchronize audio and =
video.
>> Also the header file to export the hdmi registers is added in the
>> plat-omap , so that it can be accessed by audio driver.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08=
 ++
>> =A0drivers/video/omap2/dss/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/video/omap2/dss/hdmi_omap4_panel.c | =A0190 +++++++++++++=
+++++++++++++++
>> =A03 files changed, 199 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/video/omap2/dss/hdmi_omap4_panel.c
>>
>> diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/d=
ss/Kconfig
>> index fe1ab09..670a55d 100644
>> --- a/drivers/video/omap2/dss/Kconfig
>> +++ b/drivers/video/omap2/dss/Kconfig
>> @@ -125,4 +125,12 @@ config OMAP2_DSS_MIN_FCK_PER_PCK
>> =A0 =A0 =A0 =A0 Max FCK is 173MHz, so this doesn't work if your PCK
>> =A0 =A0 =A0 =A0 is very high.
>>
>> +config OMAP4_PANEL_HDMI
>> + =A0 =A0 bool "HDMI panel support"
>> + =A0 =A0 depends on OMAP2_DSS_HDMI
>> + =A0 =A0 =A0 =A0default n
>> + =A0 =A0 help
>> + =A0 =A0 =A0 HDMI panel. This adds the High Definition Multimedia p=
anel.
>> + =A0 =A0 =A0 See http://www.hdmi.org/ for HDMI specification.
>> +
>> =A0endif
>> diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/=
dss/Makefile
>> index 5998b69..95234d4 100644
>> --- a/drivers/video/omap2/dss/Makefile
>> +++ b/drivers/video/omap2/dss/Makefile
>> @@ -6,3 +6,4 @@ omapdss-$(CONFIG_OMAP2_DSS_VENC) +=3D venc.o
>> =A0omapdss-$(CONFIG_OMAP2_DSS_SDI) +=3D sdi.o
>> =A0omapdss-$(CONFIG_OMAP2_DSS_DSI) +=3D dsi.o
>> =A0omapdss-$(CONFIG_OMAP2_DSS_HDMI) +=3D hdmi.o
>> +obj-$(CONFIG_OMAP4_PANEL_HDMI) +=3D hdmi_omap4_panel.o
>> diff --git a/drivers/video/omap2/dss/hdmi_omap4_panel.c b/drivers/vi=
deo/omap2/dss/hdmi_omap4_panel.c
>> new file mode 100644
>> index 0000000..c28b1f6
>> --- /dev/null
>> +++ b/drivers/video/omap2/dss/hdmi_omap4_panel.c
>> @@ -0,0 +1,190 @@
>> +/*
>> + * hdmi_omap4_panel.c
>> + *
>> + * HDMI library support functions for TI OMAP4 processors.
>> + *
>> + * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://=
www.ti.com/
>> + * Authors: =A0MythriPk <mythripk@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License version 2 as p=
ublished by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public =
License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e along with
>> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#define DSS_SUBSYS_NAME "HDMI"
>
> This is not used.
>
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/mutex.h>
>> +#include <linux/string.h>
>> +#include <linux/delay.h>
>> +#include <linux/module.h>
>> +#include <linux/seq_file.h>
>> +#include <plat/display.h>
>
> Most of these includes are not needed.
>
>> +
>> +#include "dss.h"
>> +
>> +static struct {
>> + =A0 =A0 struct mutex hdmi_lock;
>> +} hdmi;
>
> Static variables in panel drivers are not good, as they won't work if
> there are two devices which use the same driver. In this case that
> cannot happen, as there's only one HDMI module in DSS. However, it's
> worth to mention here in a comment. Or, do it properly and create a p=
er
> device data structure.
>
>> +
>> +
>> +static int hdmi_panel_probe(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 DSSDBG("ENTER hdmi_panel_probe\n");
>> +
>> + =A0 =A0 dssdev->panel.config =3D OMAP_DSS_LCD_TFT |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DSS_LCD_IVS | OMAP_DS=
S_LCD_IHS;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Initialize the timings to 1920 * 1080
>> + =A0 =A0 =A0* This is only for framebuffer update not for TV timing=
 setting
>> + =A0 =A0 =A0* Setting TV timing will be done only on enable
>> + =A0 =A0 =A0*/
>> + =A0 =A0 dssdev->panel.timings.x_res =3D 1920;
>> + =A0 =A0 dssdev->panel.timings.y_res =3D 1080;
>> +
>> + =A0 =A0 DSSDBG("hdmi_panel_probe x_res=3D %d y_res =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 dssdev->panel.timings.x_res,
>> + =A0 =A0 =A0 =A0 =A0 =A0 dssdev->panel.timings.y_res);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void hdmi_panel_remove(struct omap_dss_device *dssdev)
>> +{
>> +
>> +}
>> +
>> +static int hdmi_panel_enable(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 int r =3D 0;
>> + =A0 =A0 DSSDBG("ENTER hdmi_panel_enable\n");
>> +
>> + =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_DISABLED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 mutex_lock(&hdmi.hdmi_lock);
>
> I commented about this in earlier mails already. You need to use the
> locks consistently and have the dssdev->state reads also inside the
> lock.
>
> Think what happens if, say, two threads call hdmi_panel_enable at the
> same time.
>
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
