From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH-V2 1/2] OMAP: LCD LS037V7DW01: Add Backlight driver
 support
Date: Fri, 16 Apr 2010 12:41:37 +0300
Message-ID: <1271410897.2690.293.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1271073027-2628-1-git-send-email-hvaibhav@ti.com>
	 <1271410776.2690.291.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19282 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756762Ab0DPJmE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 05:42:04 -0400
In-Reply-To: <1271410776.2690.291.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext hvaibhav@ti.com" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Oops, my emailer decided to send the email a bit too soon =).

On Fri, 2010-04-16 at 11:39 +0200, Tomi Valkeinen wrote:
> On Mon, 2010-04-12 at 13:50 +0200, ext hvaibhav@ti.com wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > 
> > Tested on OMAP3EVM for OMAP3530 and AM/DM 3730.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> This patch causes omap_3430sdp_defconfig not to compile:
> 

drivers/built-in.o: In function `sharp_ls_panel_remove':
/home/valkeine/work/linux/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c:129: undefined reference to `backlight_device_unregister'
drivers/built-in.o: In function `sharp_ls_panel_probe':
/home/valkeine/work/linux/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c:103: undefined reference to `backlight_device_register'

This is caused by the defconfig not having backlight enabled. I'm not
sure if the ls037v7dw01 driver should depend on the backlight config
option, or if there should first be a defconfig change, enabling the
backlight support.

 Tomi

> 
> > ---
> >  .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   77 ++++++++++++++++++++
> >  1 files changed, 77 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> > index 8d51a5e..d84feb0 100644
> > --- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> > +++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> > @@ -20,10 +20,16 @@
> >  #include <linux/module.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> > +#include <linux/backlight.h>
> > +#include <linux/fb.h>
> >  #include <linux/err.h>
> > 
> >  #include <plat/display.h>
> > 
> > +struct sharp_data {
> > +	struct backlight_device *bl;
> > +};
> > +
> >  static struct omap_video_timings sharp_ls_timings = {
> >  	.x_res = 480,
> >  	.y_res = 640,
> > @@ -39,18 +45,89 @@ static struct omap_video_timings sharp_ls_timings = {
> >  	.vbp		= 1,
> >  };
> > 
> > +static int sharp_ls_bl_update_status(struct backlight_device *bl)
> > +{
> > +	struct omap_dss_device *dssdev = dev_get_drvdata(&bl->dev);
> > +	int level;
> > +
> > +	if (!dssdev->set_backlight)
> > +		return -EINVAL;
> > +
> > +	if (bl->props.fb_blank == FB_BLANK_UNBLANK &&
> > +			bl->props.power == FB_BLANK_UNBLANK)
> > +		level = bl->props.brightness;
> > +	else
> > +		level = 0;
> > +
> > +	return dssdev->set_backlight(dssdev, level);
> > +}
> > +
> > +static int sharp_ls_bl_get_brightness(struct backlight_device *bl)
> > +{
> > +	if (bl->props.fb_blank == FB_BLANK_UNBLANK &&
> > +			bl->props.power == FB_BLANK_UNBLANK)
> > +		return bl->props.brightness;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct backlight_ops sharp_ls_bl_ops = {
> > +	.get_brightness = sharp_ls_bl_get_brightness,
> > +	.update_status  = sharp_ls_bl_update_status,
> > +};
> > +
> > +
> > +
> >  static int sharp_ls_panel_probe(struct omap_dss_device *dssdev)
> >  {
> > +	struct backlight_properties props;
> > +	struct backlight_device *bl;
> > +	struct sharp_data *sd;
> > +	int r;
> > +
> >  	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> >  		OMAP_DSS_LCD_IHS;
> >  	dssdev->panel.acb = 0x28;
> >  	dssdev->panel.timings = sharp_ls_timings;
> > 
> > +	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
> > +	if (!sd)
> > +		return -ENOMEM;
> > +
> > +	dev_set_drvdata(&dssdev->dev, sd);
> > +
> > +	memset(&props, 0, sizeof(struct backlight_properties));
> > +	props.max_brightness = dssdev->max_backlight_level;
> > +
> > +	bl = backlight_device_register("sharp-ls", &dssdev->dev, dssdev,
> > +			&sharp_ls_bl_ops, &props);
> > +	if (IS_ERR(bl)) {
> > +		r = PTR_ERR(bl);
> > +		kfree(sd);
> > +		return r;
> > +	}
> > +	sd->bl = bl;
> > +
> > +	bl->props.fb_blank = FB_BLANK_UNBLANK;
> > +	bl->props.power = FB_BLANK_UNBLANK;
> > +	bl->props.brightness = dssdev->max_backlight_level;
> > +	r = sharp_ls_bl_update_status(bl);
> > +	if (r < 0)
> > +		dev_err(&dssdev->dev, "failed to set lcd brightness\n");
> > +
> >  	return 0;
> >  }
> > 
> >  static void sharp_ls_panel_remove(struct omap_dss_device *dssdev)
> >  {
> > +	struct sharp_data *sd = dev_get_drvdata(&dssdev->dev);
> > +	struct backlight_device *bl = sd->bl;
> > +
> > +	bl->props.power = FB_BLANK_POWERDOWN;
> > +	sharp_ls_bl_update_status(bl);
> > +	backlight_device_unregister(bl);
> > +
> > +	kfree(sd);
> >  }
> > 
> >  static int sharp_ls_power_on(struct omap_dss_device *dssdev)
> > --
> > 1.6.2.4
> > 
> 


