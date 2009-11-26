From: "Y, Kishore" <kishore.y@ti.com>
Subject: RE: [PATCH 2/5] ZOOM: DSS2: Add nec panel for zoom display
Date: Thu, 26 Nov 2009 18:11:38 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94025446830A@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402543D7CA0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44933 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbZKZMlf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 07:41:35 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAQCfcqC027913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2009 06:41:41 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAQCfb2X024564
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2009 18:11:38 +0530 (IST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402543D7CA0@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: G, Manjunath Kondaiah
> Sent: Tuesday, November 24, 2009 9:44 PM
> To: Y, Kishore; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 2/5] ZOOM: DSS2: Add nec panel for zoom display
> 
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Y, Kishore
> > Sent: Friday, November 20, 2009 7:58 PM
> > To: linux-omap@vger.kernel.org
> > Subject: [PATCH 2/5] ZOOM: DSS2: Add nec panel for zoom display
> >
> > From df64194feedc16c3f3f552dc26bc3050b7245005 Mon Sep 17 00:00:00 2001
> > From: Mukund Mittal <mmittal@ti.com>
> > Date: Fri, 20 Nov 2009 18:35:26 +0530
> > Subject: [PATCH] ZOOM: DSS2: Add nec panel for zoom display
> >
> > Nec panel has been added which is used on both
> > zoom2 and zoom3 boards
> >
> > Signed-off-by: Kishore Y <kishore.y@ti.com>
> > ---
> >  drivers/video/omap2/displays/panel-nec.c |  291
> > ++++++++++++++++++++++++++++++
> >  1 files changed, 291 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/video/omap2/displays/panel-nec.c
> >
> > diff --git a/drivers/video/omap2/displays/panel-nec.c
> > b/drivers/video/omap2/displays/panel-nec.c
> > new file mode 100644
> > index 0000000..c18f3ba
> > --- /dev/null
> > +++ b/drivers/video/omap2/displays/panel-nec.c
> > @@ -0,0 +1,291 @@
> > +/*
> > + * NEC panel support
> > + *
> > + * Copyright (C) 2008 Nokia Corporation
> > + * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > + *
> > + * This program is free software; you can redistribute it
> > and/or modify it
> > + * under the terms of the GNU General Public License version
> > 2 as published by
> > + * the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be
> > useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of
> > MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
> > Public License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public
> > License along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/delay.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/i2c/twl4030.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#include <mach/gpio.h>
> 
> This will break the build since header files are moved to plat-omap.
> 
Comments taken. I will release v2 soon with all comments incorporated
> > +#include <mach/gpio.h>
> 
> Remove this.
> 
> > +#include <plat/mux.h>
> > +#include <asm/mach-types.h>
> > +#include <plat/control.h>
> > +
> 
> Remove extra line.
> 
Comments taken
> > +#include <plat/display.h>
> > +
> > +#define LCD_XRES		800
> > +#define LCD_YRES		480
> > +
> 
> Remove extra line.
> 
> > +#define LCD_PIXCLOCK_MIN      	21800 /* NEC MIN PIX
> > Clock is 21.8MHz */
> > +#define LCD_PIXCLOCK_TYP      	23800 /* Typical PIX
> > clock is 23.8MHz */
> > +#define LCD_PIXCLOCK_MAX      	25700 /* Maximum is 25.7MHz */
> > +
> 
> -Ditto-
> 
> > +/* Current Pixel clock */
> > +#define LCD_PIXEL_CLOCK		LCD_PIXCLOCK_MIN
> > +
> > +
> 
> -Ditto-
> 
> > +/*NEC NL8048HL11-01B  Manual
> > + * defines HFB, HSW, HBP, VFP, VSW, VBP as shown below
> > + */
> > +
> > +static struct omap_video_timings nec_panel_timings = {
> > +	/* 800 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
> > +	.x_res          = LCD_XRES,
> > +	.y_res          = LCD_YRES,
> > +	.pixel_clock    = LCD_PIXEL_CLOCK,
> > +	.hfp            = 6,
> > +	.hsw            = 1,
> > +	.hbp            = 4,
> > +	.vfp            = 3,
> > +	.vsw            = 1,
> > +	.vbp            = 4,
> > +};
> > +
> > +static int nec_panel_probe(struct omap_dss_device *dssdev)
> > +{
> > +	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> > +                                OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_RF |
> > +                                OMAP_DSS_LCD_ONOFF;
> 
> Checkpatch error - ERROR: code indent should use tabs where possible
> 
> > +	dssdev->panel.timings = nec_panel_timings;
> > +	dssdev->panel.recommended_bpp = 16;
> > +
> > +	return 0;
> > +}
> 
> This function will always return zero. Either check for sanity of function
> Parameters or change return value of the API to void.
> 
> > +
> > +static void nec_panel_remove(struct omap_dss_device *dssdev)
> > +{
> > +}
> > +
> > +static int nec_panel_enable(struct omap_dss_device *dssdev)
> > +{
> > +	int r = 0;
> > +
> > +	mdelay(4);
> 
> Add comment to justify the delay values used.
> 
> > +	if (dssdev->platform_enable)
> > +		r = dssdev->platform_enable(dssdev);
> > +
> > +	return r;
> 
> dssdev parameter is never used inside platform_enable.
> 
> I guess platform_enable will always return zero. Please take care
> of error checking conditions.
> 
> > +}
> > +
> > +static void nec_panel_disable(struct omap_dss_device *dssdev)
> > +{
> > +	if (dssdev->platform_disable)
> > +		dssdev->platform_disable(dssdev);
> dssdev parameter is never used inside platform_disable
> 
> > +	mdelay(4);
> Add comment to justify the delay values used.
> 
> > +}
> > +
> > +static int nec_panel_suspend(struct omap_dss_device *dssdev)
> > +{
> > +	nec_panel_disable(dssdev);
> > +	return 0;
> > +}
> 
> No error checking. Always returns zero.

All these functions are callback functions and hence have to fix to the format. We are only filling a structure here and no need for error checking
> 
> > +
> > +static int nec_panel_resume(struct omap_dss_device *dssdev)
> > +{
> > +	return nec_panel_enable(dssdev);
> > +}
> 
> dssdev parameter is never used inside nec_panel_enable(...)
> No error checking. Always returns zero.
> 

Callback function is expected to receive struct dssdev even if not used.
> > +
> > +static struct omap_dss_driver nec_driver = {
> > +	.probe          = nec_panel_probe,
> > +	.remove         = nec_panel_remove,
> > +
> 
> Remove extra line
> 
> > +	.enable         = nec_panel_enable,
> > +	.disable        = nec_panel_disable,
> > +	.suspend        = nec_panel_suspend,
> > +	.resume         = nec_panel_resume,
> > +
> 
> -Ditto-
> 
> > +	.driver		= {
> > +		.name	= "NEC_panel",
> > +		.owner 	= THIS_MODULE,
> > +	},
> > +};
> > +
> > +static int
> > +spi_send(struct spi_device *spi, unsigned char reg_addr,
> > unsigned char reg_data)
> > +{
> > +	int ret = 0;
> > +	unsigned int cmd = 0;
> > +	unsigned int data = 0;
> > +
> > +	cmd = 0x0000 | reg_addr; /* register address write */
> > +	data = 0x0100 | reg_data ; /* register data write */
> > +	data = (cmd << 16) | data;
> > +	if (spi_write(spi, (unsigned char *)&data, 4))
> > +		printk(KERN_WARNING "error in spi_write %x\n", data);
> > +
> > +	udelay(10);
> 
> Why?
Part on init seq mentioned in panel specs. Expected to wait before giving next command.
> 
> > +	return ret;
> 
> Did you find ret getting updated anywhere?
> 
> > +}
> > +
> > +
> > +static int init_nec_wvga_lcd(struct spi_device *spi)
> > +{
> > +	/* Initialization Sequence */
> > +	spi_send(spi, 3, 0x01);    /* R3 = 01h */
> > +	spi_send(spi, 0, 0x00);    /* R0 = 00h */
> > +	spi_send(spi, 1, 0x01);    /* R1 = 0x01 (normal), 0x03
> > (reversed) */
> > +	spi_send(spi, 4, 0x00);    /* R4 = 00h */
> > +	spi_send(spi, 5, 0x14);    /* R5 = 14h */
> > +	spi_send(spi, 6, 0x24);    /* R6 = 24h */
> > +	spi_send(spi, 16, 0xD7);   /* R16 = D7h */
> > +	spi_send(spi, 17, 0x00);   /* R17 = 00h */
> > +	spi_send(spi, 18, 0x00);   /* R18 = 00h */
> > +	spi_send(spi, 19, 0x55);   /* R19 = 55h */
> > +	spi_send(spi, 20, 0x01);   /* R20 = 01h */
> > +	spi_send(spi, 21, 0x70);   /* R21 = 70h */
> > +	spi_send(spi, 22, 0x1E);   /* R22 = 1Eh */
> > +	spi_send(spi, 23, 0x25);   /* R23 = 25h */
> > +	spi_send(spi, 24, 0x25);   /* R24 = 25h */
> > +	spi_send(spi, 25, 0x02);   /* R25 = 02h */
> > +	spi_send(spi, 26, 0x02);   /* R26 = 02h */
> > +	spi_send(spi, 27, 0xA0);   /* R27 = A0h */
> > +	spi_send(spi, 32, 0x2F);   /* R32 = 2Fh */
> > +	spi_send(spi, 33, 0x0F);   /* R33 = 0Fh */
> > +	spi_send(spi, 34, 0x0F);   /* R34 = 0Fh */
> > +	spi_send(spi, 35, 0x0F);   /* R35 = 0Fh */
> > +	spi_send(spi, 36, 0x0F);   /* R36 = 0Fh */
> > +	spi_send(spi, 37, 0x0F);   /* R37 = 0Fh */
> > +	spi_send(spi, 38, 0x0F);   /* R38 = 0Fh */
> > +	spi_send(spi, 39, 0x00);   /* R39 = 00h */
> > +	spi_send(spi, 40, 0x02);   /* R40 = 02h */
> > +	spi_send(spi, 41, 0x02);   /* R41 = 02h */
> > +	spi_send(spi, 42, 0x02);   /* R42 = 02h */
> > +	spi_send(spi, 43, 0x0F);   /* R43 = 0Fh */
> > +	spi_send(spi, 44, 0x0F);   /* R44 = 0Fh */
> > +	spi_send(spi, 45, 0x0F);   /* R45 = 0Fh */
> > +	spi_send(spi, 46, 0x0F);   /* R46 = 0Fh */
> > +	spi_send(spi, 47, 0x0F);   /* R47 = 0Fh */
> > +	spi_send(spi, 48, 0x0F);   /* R48 = 0Fh */
> > +	spi_send(spi, 49, 0x0F);   /* R49 = 0Fh */
> > +	spi_send(spi, 50, 0x00);   /* R50 = 00h */
> > +	spi_send(spi, 51, 0x02);   /* R51 = 02h */
> > +	spi_send(spi, 52, 0x02);   /* R52 = 02h */
> > +	spi_send(spi, 53, 0x02);   /* R53 = 02h */
> > +	spi_send(spi, 80, 0x0C);   /* R80 = 0Ch */
> > +	spi_send(spi, 83, 0x42);   /* R83 = 42h */
> > +	spi_send(spi, 84, 0x42);   /* R84 = 42h */
> > +	spi_send(spi, 85, 0x41);   /* R85 = 41h */
> > +	spi_send(spi, 86, 0x14);   /* R86 = 14h */
> > +	spi_send(spi, 89, 0x88);   /* R89 = 88h */
> > +	spi_send(spi, 90, 0x01);   /* R90 = 01h */
> > +	spi_send(spi, 91, 0x00);   /* R91 = 00h */
> > +	spi_send(spi, 92, 0x02);   /* R92 = 02h */
> > +	spi_send(spi, 93, 0x0C);   /* R93 = 0Ch */
> > +	spi_send(spi, 94, 0x1C);   /* R94 = 1Ch */
> > +	spi_send(spi, 95, 0x27);   /* R95 = 27h */
> > +	spi_send(spi, 98, 0x49);   /* R98 = 49h */
> > +	spi_send(spi, 99, 0x27);   /* R99 = 27h */
> > +	spi_send(spi, 102, 0x76);  /* R102 = 76h */
> > +	spi_send(spi, 103, 0x27);  /* R103 = 27h */
> > +	spi_send(spi, 112, 0x01);  /* R112 = 01h */
> > +	spi_send(spi, 113, 0x0E);  /* R113 = 0Eh */
> > +	spi_send(spi, 114, 0x02);  /* R114 = 02h */
> > +	spi_send(spi, 115, 0x0C);  /* R115 = 0Ch */
> > +	spi_send(spi, 118, 0x0C);  /* R118 = 0Ch */
> > +	spi_send(spi, 121, 0x30); /* R121 = 0x30 (normal), 0x10
> > (reversed) */
> > +	spi_send(spi, 130, 0x00);  /* R130 = 00h */
> > +	spi_send(spi, 131, 0x00);  /* R131 = 00h */
> > +	spi_send(spi, 132, 0xFC);  /* R132 = FCh */
> > +	spi_send(spi, 134, 0x00);  /* R134 = 00h */
> > +	spi_send(spi, 136, 0x00);  /* R136 = 00h */
> > +	spi_send(spi, 138, 0x00);  /* R138 = 00h */
> > +	spi_send(spi, 139, 0x00);  /* R139 = 00h */
> > +	spi_send(spi, 140, 0x00);  /* R140 = 00h */
> > +	spi_send(spi, 141, 0xFC);  /* R141 = FCh */
> > +	spi_send(spi, 143, 0x00);  /* R143 = 00h */
> > +	spi_send(spi, 145, 0x00);  /* R145 = 00h */
> > +	spi_send(spi, 147, 0x00);  /* R147 = 00h */
> > +	spi_send(spi, 148, 0x00);  /* R148 = 00h */
> > +	spi_send(spi, 149, 0x00);  /* R149 = 00h */
> > +	spi_send(spi, 150, 0xFC);  /* R150 = FCh */
> > +	spi_send(spi, 152, 0x00);  /* R152 = 00h */
> > +	spi_send(spi, 154, 0x00);  /* R154 = 00h */
> > +	spi_send(spi, 156, 0x00);  /* R156 = 00h */
> > +	spi_send(spi, 157, 0x00);  /* R157 = 00h */
> > +	udelay(20);
> > +	spi_send(spi, 2, 0x00);    /* R2 = 00h */
> > +	return 0;
> > +}
> > +
> > +static int dss_spi_probe(struct spi_device *spi)
> > +{
> > +	spi->mode = SPI_MODE_0;
> > +	spi->bits_per_word = 32;
> > +	spi_setup(spi);
> 
> Where are the parameters for SPI speed, phase and polarities initialized?

Defined in board file in spi board info

Regards
Kishore Y
> 
> > +
> > +	init_nec_wvga_lcd(spi);
> > +
> > +	omap_dss_register_driver(&nec_driver);
> > +	return 0;
> > +}
> > +
> > +static int dss_spi_remove(struct spi_device *spi)
> > +{
> > +	omap_dss_unregister_driver(&nec_driver);
> > +
> > +	return 0;
> > +}
> > +
> > +static int dss_spi_suspend(struct spi_device *spi, pm_message_t mesg)
> > +{
> > +	spi_send(spi, 2, 0x01);  /* R2 = 01h */
> > +	mdelay(40);
> > +
> > +	return 0;
> > +}
> > +
> > +static int dss_spi_resume(struct spi_device *spi)
> > +{
> > +	/* reinitialize the panel */
> > +	spi_setup(spi);
> > +	spi_send(spi, 2, 0x00);  /* R2 = 00h */
> > +	init_nec_wvga_lcd(spi);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct spi_driver dss_spi_driver = {
> > +	.probe           = dss_spi_probe,
> > +	.remove	= __devexit_p(dss_spi_remove),
> > +	.suspend         = dss_spi_suspend,
> > +	.resume          = dss_spi_resume,
> > +	.driver         = {
> > +		.name   = "disp_spi",
> > +		.bus    = &spi_bus_type,
> > +		.owner  = THIS_MODULE,
> > +	},
> > +};
> > +
> > +static int __init nec_lcd_init(void)
> > +{
> > +	return spi_register_driver(&dss_spi_driver);
> > +}
> > +
> > +static void __exit nec_lcd_exit(void)
> > +{
> > +	return spi_unregister_driver(&dss_spi_driver);
> > +}
> > +
> > +
> > +module_init(nec_lcd_init);
> > +module_exit(nec_lcd_exit);
> > +MODULE_LICENSE("GPL");
> > +
> > --
> > 1.5.4.3
> >
> >
> > Regards,
> > Kishore Y
> > Ph:- +918039813085
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
