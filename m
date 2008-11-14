From: "Shah, Hardik" <hardik.shah@ti.com>
Subject: RE: [REVIEW PATCH] Added OMAP3EVM support on Tomis FBDEV/DSS Patches
Date: Fri, 14 Nov 2008 17:19:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02DF390CE4@dbde02.ent.ti.com>
References: <FEB3AB03-0384-4323-B4AE-D321BE3EFC2A@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35267 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbYKNLtX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 06:49:23 -0500
In-Reply-To: <FEB3AB03-0384-4323-B4AE-D321BE3EFC2A@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Koen Kooi
> Sent: Friday, November 14, 2008 5:09 PM
> To: Hiremath, Vaibhav
> Cc: linux-fbdev-devel@lists.sourceforge.net; linux-omap@vger.kernel.org
> Subject: Re: [REVIEW PATCH] Added OMAP3EVM support on Tomis FBDEV/DSS Patches
> 
> 
> Op 14 nov 2008, om 07:32 heeft hvaibhav@ti.com het volgende geschreven:
> 
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> > omap2/board-omap3evm.c
> >
> > +	if (system_rev > OMAP3430_REV_ES1_0) {
> > +		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> > +			ENABLE_VPLL2_DEDICATED, TWL4030_VPLL2_DEDICATED);
> > +		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> > +			ENABLE_VPLL2_DEV_GRP, TWL4030_VPLL2_DEV_GRP);
> > +	}
> > +	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
> > +	lcd_enabled = 1;
> > +	return 0;
> > +}
> > +
> > +static void panel_disable_lcd(struct omap_display *display)
> > +{
> > +	if (system_rev > OMAP3430_REV_ES1_0) {
> > +		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x0,
> > +				TWL4030_VPLL2_DEDICATED);
> > +		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x0,
> > +				TWL4030_VPLL2_DEV_GRP);
> > +	}
> > +	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);
> > +	lcd_enabled = 0;
> > +}
> 
> system_rev() is now omap_rev(), you'll get a really green picture
> without that change :)
> 
> I can confirm that the panel-sdp3430 works on the evm.
[Shah, Hardik] Hi panel-omap3evm.c is working fine. We tested that.  And we were getting the green picture. Thanks for pointing that out.  We will change this also in our next patch.
> 
> regards,
> 
> Koen
