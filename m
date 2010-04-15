From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-RESEND 1/2] OMAP: LCD LS037V7DW01: Add Backlight driver
 support
Date: Thu, 15 Apr 2010 19:44:31 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136F3C@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1271340001-19831-1-git-send-email-hvaibhav@ti.com>
 <1271340761.2690.260.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56675 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091Ab0DOOOj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 10:14:39 -0400
In-Reply-To: <1271340761.2690.260.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Thursday, April 15, 2010 7:43 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH-RESEND 1/2] OMAP: LCD LS037V7DW01: Add Backlight driver
> support
> 
> Hi,
> 
> On Thu, 2010-04-15 at 16:00 +0200, ext hvaibhav@ti.com wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > Tested on OMAP3EVM for OMAP3530 and AM/DM 3730.
> >
> 
> This looks ok to me, I'll add it to my queue.
> 
[Hiremath, Vaibhav] Thanks.

Thanks,
Vaibhav

>  Tomi
> 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   77
> ++++++++++++++++++++
> >  1 files changed, 77 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
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

