From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 04/20] omapfb: Add support for the Amstrad Delta LCD
Date: Fri, 05 Jun 2009 13:39:51 +0200
Message-ID: <4A290407.90402@tis.icnet.pl>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com> <e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com> <833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com> <200906051238.23755.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:59187 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbZFELkh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Jun 2009 07:40:37 -0400
In-Reply-To: <200906051238.23755.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>
Cc: Antonino Daplas <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, Jonathan McDowell <noodles@earth.li>

TIS - Janusz Krzysztofik napisa=C5=82(a):
> Thursday 04 June 2009 19:52:29 Imre Deak napisa=C5=82(a):
>> From: Jonathan McDowell <noodles@earth.li>
>>
>> This is an updated version of the LCD driver for the Amstrad Delta t=
o
>> take into account the recent changes to the omapfb infrastructure. T=
he
>> Delta features a 480x320 12 bit DSTN panel.
>=20
> Hi,
>=20
> I'd really love to see the lcd_ams_delta support included in the main=
line=20
> kernel, but I am not sure if it is ready for submission, as I still h=
ave=20
> issues with it. It does work perfectly unless power management is tur=
ned on.
> With CONFIG_PM=3Dy, the omapfb device, after initially starting corre=
ctly,=20
> breaks with the following error messages:
>=20
> omapfb omapfb: resetting (status 0xffffff96,reset count 1)
> ...
> omapfb omapfb: resetting (status 0xffffff96,reset count 100)
> omapfb omapfb: too many reset attempts, giving up.
>=20
> Tested with linux-2.6.30-rc5 and linux-omap revision=20
> 90e758af52ba803cba233fabee81176d99589f09. Error messages do not appea=
r when=20
> CONFIG_PM=3Dn or lcd_ams_delta.o is removed from omapfb-objs.

One idea for a temporary workaround: maybe we could just force PM=3Dn i=
n=20
case of MACH_AMS_DELTA && FB_OMAP? PM already depends on !IA64_HP_SIM.

Janusz

> Please let me know what else I can do to help in resolving this issue=
=2E
>=20
> Cheers,
> Janusz
>=20
>> Signed-off-by: Jonathan McDowell <noodles@earth.li>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Imre Deak <imre.deak@nokia.com>
>> ---
>>  drivers/video/omap/Makefile        |    1 +
>>  drivers/video/omap/lcd_ams_delta.c |  137
>> ++++++++++++++++++++++++++++++++++++ 2 files changed, 138 insertions=
(+), 0
>> deletions(-)
>>  create mode 100644 drivers/video/omap/lcd_ams_delta.c
>>
>> diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefi=
le
>> index d86d54a..2bf94ad 100644
>> --- a/drivers/video/omap/Makefile
>> +++ b/drivers/video/omap/Makefile
>> @@ -15,6 +15,7 @@ objs-$(CONFIG_ARCH_OMAP2)$(CONFIG_FB_OMAP_LCDC_EXT=
ERNAL)
>> +=3D rfbi.o objs-y$(CONFIG_FB_OMAP_LCDC_HWA742) +=3D hwa742.o
>>  objs-y$(CONFIG_FB_OMAP_LCDC_BLIZZARD) +=3D blizzard.o
>>
>> +objs-y$(CONFIG_MACH_AMS_DELTA) +=3D lcd_ams_delta.o
>>  objs-y$(CONFIG_MACH_OMAP_H4) +=3D lcd_h4.o
>>  objs-y$(CONFIG_MACH_OMAP_H3) +=3D lcd_h3.o
>>  objs-y$(CONFIG_MACH_OMAP_PALMTE) +=3D lcd_palmte.o
>> diff --git a/drivers/video/omap/lcd_ams_delta.c
>> b/drivers/video/omap/lcd_ams_delta.c new file mode 100644
>> index 0000000..1f74399
>> --- /dev/null
>> +++ b/drivers/video/omap/lcd_ams_delta.c
>> @@ -0,0 +1,137 @@
>> +/*
>> + * Based on drivers/video/omap/lcd_inn1510.c
>> + *
>> + * LCD panel support for the Amstrad E3 (Delta) videophone.
>> + *
>> + * Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License as published b=
y the
>> + * Free Software Foundation; either version 2 of the License, or (a=
t your
>> + * option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GN=
U
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e along
>> + * with this program; if not, write to the Free Software Foundation=
, Inc.,
>> + * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +#include <linux/delay.h>
>> +
>> +#include <mach/board-ams-delta.h>
>> +#include <mach/hardware.h>
>> +#include <mach/omapfb.h>
>> +
>> +#define AMS_DELTA_DEFAULT_CONTRAST	112
>> +
>> +static int ams_delta_panel_init(struct lcd_panel *panel,
>> +		struct omapfb_device *fbdev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void ams_delta_panel_cleanup(struct lcd_panel *panel)
>> +{
>> +}
>> +
>> +static int ams_delta_panel_enable(struct lcd_panel *panel)
>> +{
>> +	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_NDISP,
>> +			AMS_DELTA_LATCH2_LCD_NDISP);
>> +	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN,
>> +			AMS_DELTA_LATCH2_LCD_VBLEN);
>> +
>> +	omap_writeb(1, OMAP_PWL_CLK_ENABLE);
>> +	omap_writeb(AMS_DELTA_DEFAULT_CONTRAST, OMAP_PWL_ENABLE);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ams_delta_panel_disable(struct lcd_panel *panel)
>> +{
>> +	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN, 0);
>> +	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_NDISP, 0);
>> +}
>> +
>> +static unsigned long ams_delta_panel_get_caps(struct lcd_panel *pan=
el)
>> +{
>> +	return 0;
>> +}
>> +
>> +static struct lcd_panel ams_delta_panel =3D {
>> +	.name		=3D "ams-delta",
>> +	.config		=3D 0,
>> +
>> +	.bpp		=3D 12,
>> +	.data_lines	=3D 16,
>> +	.x_res		=3D 480,
>> +	.y_res		=3D 320,
>> +	.pixel_clock	=3D 4687,
>> +	.hsw		=3D 3,
>> +	.hfp		=3D 1,
>> +	.hbp		=3D 1,
>> +	.vsw		=3D 1,
>> +	.vfp		=3D 0,
>> +	.vbp		=3D 0,
>> +	.pcd		=3D 0,
>> +	.acb		=3D 37,
>> +
>> +	.init		=3D ams_delta_panel_init,
>> +	.cleanup	=3D ams_delta_panel_cleanup,
>> +	.enable		=3D ams_delta_panel_enable,
>> +	.disable	=3D ams_delta_panel_disable,
>> +	.get_caps	=3D ams_delta_panel_get_caps,
>> +};
>> +
>> +static int ams_delta_panel_probe(struct platform_device *pdev)
>> +{
>> +	omapfb_register_panel(&ams_delta_panel);
>> +	return 0;
>> +}
>> +
>> +static int ams_delta_panel_remove(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int ams_delta_panel_suspend(struct platform_device *pdev,
>> +		pm_message_t mesg)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int ams_delta_panel_resume(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
>> +
>> +struct platform_driver ams_delta_panel_driver =3D {
>> +	.probe		=3D ams_delta_panel_probe,
>> +	.remove		=3D ams_delta_panel_remove,
>> +	.suspend	=3D ams_delta_panel_suspend,
>> +	.resume		=3D ams_delta_panel_resume,
>> +	.driver		=3D {
>> +		.name	=3D "lcd_ams_delta",
>> +		.owner	=3D THIS_MODULE,
>> +	},
>> +};
>> +
>> +static int ams_delta_panel_drv_init(void)
>> +{
>> +	return platform_driver_register(&ams_delta_panel_driver);
>> +}
>> +
>> +static void ams_delta_panel_drv_cleanup(void)
>> +{
>> +	platform_driver_unregister(&ams_delta_panel_driver);
>> +}
>> +
>> +module_init(ams_delta_panel_drv_init);
>> +module_exit(ams_delta_panel_drv_cleanup);
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
