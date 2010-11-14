From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
Date: Sun, 14 Nov 2010 09:42:49 +0800
Message-ID: <AANLkTimt+rZ3nTHK01VciYyh-pKMiCmLZYcJjqz6OTY8@mail.gmail.com>
References: <1289322724-20998-1-git-send-email-bryan.wu@canonical.com>
	<1289322724-20998-2-git-send-email-bryan.wu@canonical.com>
	<1289399707.3297.250.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44478 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab0KNBmw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Nov 2010 20:42:52 -0500
Received: by qyk12 with SMTP id 12so2468271qyk.19
        for <linux-omap@vger.kernel.org>; Sat, 13 Nov 2010 17:42:51 -0800 (PST)
In-Reply-To: <1289399707.3297.250.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gadiyar@ti.com" <gadiyar@ti.com>

On Wed, Nov 10, 2010 at 10:35 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Tue, 2010-11-09 at 18:12 +0100, ext Bryan Wu wrote:
>> Generic DPI panel driver includes the driver and 4 similar panel con=
figurations. It
>> will match the panel name which is passed from platform data and set=
up the
>> right configurations.
>>
>> With generic DPI panel driver, we can remove those 4 duplicated pane=
l display
>> drivers. In the future, it is simple for us just add new panel confi=
guration
>> date in panel-generic-dpi.c to support new display panel.
>
> This is looking good, but still a couple of comments inline:
>
>> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>> ---
>> =A0.../arm/plat-omap/include/plat/panel-generic-dpi.h | =A0 37 +++
>> =A0drivers/video/omap2/displays/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A08 +
>> =A0drivers/video/omap2/displays/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 +
>> =A0drivers/video/omap2/displays/panel-generic-dpi.c =A0 | =A0309 +++=
+++++++++++++++++
>> =A04 files changed, 355 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/panel-generic-=
dpi.h
>> =A0create mode 100644 drivers/video/omap2/displays/panel-generic-dpi=
=2Ec
>>
>> diff --git a/arch/arm/plat-omap/include/plat/panel-generic-dpi.h b/a=
rch/arm/plat-omap/include/plat/panel-generic-dpi.h
>> new file mode 100644
>> index 0000000..7906197
>> --- /dev/null
>> +++ b/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
>> @@ -0,0 +1,37 @@
>> +/*
>> + * Header for generic DPI panel driver
>> + *
>> + * Copyright (C) 2010 Canonical Ltd.
>> + * Author: Bryan Wu <bryan.wu@canonical.com>
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
>> +#ifndef __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H
>> +#define __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H
>> +
>> +#include "display.h"
>> +
>> +/**
>> + * struct panel_generic_dpi_data - panel driver configuration data
>> + * @name: panel name
>> + * @platform_enable: platform specific panel enable function
>> + * @platform_disable: platform specific panel disable function
>> + */
>> +struct panel_generic_dpi_data {
>> + =A0 =A0 const char *name;
>> + =A0 =A0 int (*platform_enable)(struct omap_dss_device *dssdev);
>> + =A0 =A0 void (*platform_disable)(struct omap_dss_device *dssdev);
>> +};
>> +
>> +#endif /* __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H */
>> diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/om=
ap2/displays/Kconfig
>> index 12327bb..cb3e339 100644
>> --- a/drivers/video/omap2/displays/Kconfig
>> +++ b/drivers/video/omap2/displays/Kconfig
>> @@ -1,6 +1,14 @@
>> =A0menu "OMAP2/3 Display Device Drivers"
>> =A0 =A0 =A0 =A0 =A0depends on OMAP2_DSS
>>
>> +config PANEL_GENERIC_DPI
>> + =A0 =A0 =A0 =A0tristate "Generic DPI Panel"
>> + =A0 =A0 =A0 =A0help
>> + =A0 =A0 =A0 Generic DPI panel driver.
>> + =A0 =A0 =A0 Supports DVI output for Beagle and OMAP3 SDP.
>> + =A0 =A0 =A0 Supports LCD Panel used in TI SDP3430 and EVM boards,
>> + =A0 =A0 =A0 OMAP3517 EVM boards and CM-T35.
>> +
>> =A0config PANEL_GENERIC
>> =A0 =A0 =A0 =A0 =A0tristate "Generic Panel"
>> =A0 =A0 =A0 =A0 =A0help
>> diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/o=
map2/displays/Makefile
>> index aa38609..022058c 100644
>> --- a/drivers/video/omap2/displays/Makefile
>> +++ b/drivers/video/omap2/displays/Makefile
>> @@ -1,3 +1,4 @@
>> +obj-$(CONFIG_PANEL_GENERIC_DPI) +=3D panel-generic-dpi.o
>> =A0obj-$(CONFIG_PANEL_GENERIC) +=3D panel-generic.o
>> =A0obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) +=3D panel-sharp-ls037v7dw0=
1.o
>> =A0obj-$(CONFIG_PANEL_SHARP_LQ043T1DG01) +=3D panel-sharp-lq043t1dg0=
1.o
>> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/driv=
ers/video/omap2/displays/panel-generic-dpi.c
>> new file mode 100644
>> index 0000000..7ddd631
>> --- /dev/null
>> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
>> @@ -0,0 +1,309 @@
>> +/*
>> + * Generic DPI Panels support
>> + *
>> + * Copyright (C) 2010 Canonical Ltd.
>> + * Author: Bryan Wu <bryan.wu@canonical.com>
>> + *
>> + * Copyright (C) 2008 Nokia Corporation
>> + * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
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
>> +#include <linux/module.h>
>> +#include <linux/delay.h>
>> +
>> +#include <plat/panel-generic-dpi.h>
>> +
>> +struct panel_config {
>> + =A0 =A0 struct omap_video_timings timings;
>> +
>> + =A0 =A0 int acbi; =A0 =A0 =A0 /* ac-bias pin transitions per inter=
rupt */
>> + =A0 =A0 /* Unit: line clocks */
>> + =A0 =A0 int acb; =A0 =A0 =A0 =A0/* ac-bias pin frequency */
>> +
>> + =A0 =A0 enum omap_panel_config config;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Used to match device to panel configuration
>> + =A0 =A0 =A0* when use generic panel driver
>> + =A0 =A0 =A0*/
>> + =A0 =A0 const char *name;
>> +};
>> +
>> +/* Panel configurations */
>> +static struct panel_config generic_dpi_panels[] =3D {
>> + =A0 =A0 /* Generic Panel */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .x_res =A0 =A0 =A0 =A0 =A0=
=3D 640,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_res =A0 =A0 =A0 =A0 =A0=
=3D 480,
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pixel_clock =A0 =A0=3D 23=
500,
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hfp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 48,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hsw =A0 =A0 =A0 =A0 =A0 =A0=
=3D 32,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hbp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 80,
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vfp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vsw =A0 =A0 =A0 =A0 =A0 =A0=
=3D 4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vbp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 7,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 .acbi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 0x0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .acb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D 0x0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .config =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 OMAP_DSS_LCD_TFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D "generic",
>> + =A0 =A0 },
>> +
>> + =A0 =A0 /* Sharp LQ043T1DG01 */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .x_res =A0 =A0 =A0 =A0 =A0=
=3D 480,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_res =A0 =A0 =A0 =A0 =A0=
=3D 272,
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pixel_clock =A0 =A0=3D 90=
00,
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hsw =A0 =A0 =A0 =A0 =A0 =A0=
=3D 42,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hfp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hbp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 2,
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vsw =A0 =A0 =A0 =A0 =A0 =A0=
=3D 11,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vfp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vbp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 .acbi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 0x0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .acb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D 0x0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .config =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D "sharp_lq",
>> + =A0 =A0 },
>> +
>> + =A0 =A0 /* Sharp LS037V7DW01 */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .x_res =A0 =A0 =A0 =A0 =A0=
=3D 480,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_res =A0 =A0 =A0 =A0 =A0=
=3D 640,
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pixel_clock =A0 =A0=3D 19=
200,
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hsw =A0 =A0 =A0 =A0 =A0 =A0=
=3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hfp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hbp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 28,
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vsw =A0 =A0 =A0 =A0 =A0 =A0=
=3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vfp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vbp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 .acbi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 0x0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .acb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D 0x28,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .config =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP_DSS_LCD_IHS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D "sharp_ls",
>> + =A0 =A0 },
>> +
>> + =A0 =A0 /* Toppoly TDO35S */
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .x_res =A0 =A0 =A0 =A0 =A0=
=3D 480,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_res =A0 =A0 =A0 =A0 =A0=
=3D 640,
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pixel_clock =A0 =A0=3D 26=
000,
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hfp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 104,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hsw =A0 =A0 =A0 =A0 =A0 =A0=
=3D 8,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hbp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 8,
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vfp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vsw =A0 =A0 =A0 =A0 =A0 =A0=
=3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vbp =A0 =A0 =A0 =A0 =A0 =A0=
=3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 .acbi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D 0x0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .acb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D 0x0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .config =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP_DSS_LCD_ONOFF,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D "toppoly_tdo35s",
>> + =A0 =A0 },
>> +};
>> +
>> +static inline struct panel_generic_dpi_data
>> +*get_panel_data(const struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 return (struct panel_generic_dpi_data *) dssdev->data;
>> +}
>> +
>> +
>> +static int generic_dpi_panel_power_on(struct omap_dss_device *dssde=
v)
>> +{
>> + =A0 =A0 int r;
>> + =A0 =A0 struct panel_generic_dpi_data *panel_data =3D get_panel_da=
ta(dssdev);
>> +
>> + =A0 =A0 if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_ACTIVE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 r =3D omapdss_dpi_display_enable(dssdev);
>> + =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
>> +
>> + =A0 =A0 if (panel_data->platform_enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 r =3D panel_data->platform_enable(dssdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +err1:
>> + =A0 =A0 omapdss_dpi_display_disable(dssdev);
>> +err0:
>> + =A0 =A0 return r;
>> +}
>> +
>> +static void generic_dpi_panel_power_off(struct omap_dss_device *dss=
dev)
>> +{
>> + =A0 =A0 struct panel_generic_dpi_data *panel_data =3D get_panel_da=
ta(dssdev);
>> +
>> + =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (panel_data->platform_disable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 panel_data->platform_disable(dssdev);
>> +
>> + =A0 =A0 omapdss_dpi_display_disable(dssdev);
>> +}
>
> For both panel power on and off some panels require some sleep times:
> when powering on, the video interface has to be enabled for some time
> before the panel can be enabled, and similarly when powering off the
> video interface needs to be on for some time after the panel has been
> disabled.
>

Actually, in my previous version patches, I introduced .power_on_delay
and .power_off_delay in panel_configs, which contains the sleep value
for msleep(). But Archit told me this is not necessary, so I removed
that.

And I will call this in panel powering on function
+       /* wait couple of vsyncs until enabling the LCD */
+       if (p->power_on_delay)
+               msleep(p->power_on_delay);
+

Is that OK for you?

> See for example sharp_lq driver's power_on/off.
>
> This should be handled similarly that what we have in panel-taal:
> configuration options in the panel_config struct for the sleep times
> (and if it's 0, no sleep done).
>
>> +
>> +static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 struct panel_generic_dpi_data *panel_data =3D get_panel_da=
ta(dssdev);
>> + =A0 =A0 struct panel_config *panel_config =3D NULL;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 dev_dbg(&dssdev->dev, "probe\n");
>> +
>> + =A0 =A0 if (!panel_data || !panel_data->name)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(generic_dpi_panels); i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(panel_data->name, generic_dpi_p=
anels[i].name) =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 panel_config =3D &generic_=
dpi_panels[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!panel_config)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 dssdev->type =3D OMAP_DISPLAY_TYPE_DPI;
>
> Leave this display type also in to the board file. It defines the
> interface (like the data_lines), not the panel.
>

No problem, I will change that back.

> I think otherwise the patches look good. At some point we should add
> backlight support also, so that we can remove a few drivers more (and
> get rid of the extra backlight stuff in omap_dss_device struct).
>

Yeah, I plan to do that. But IMHO, how about just move those backlight
support as backlight drivers and only remain display control in this
directory.

Thanks a lot,
--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
