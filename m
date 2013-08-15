From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH v2 6/8] usb: phy: omap: get rid of
 omap_get_control_dev()
Date: Thu, 15 Aug 2013 18:51:52 +0200
Message-ID: <20130815165152.GB10982@linutronix.de>
References: <1376572512-9561-1-git-send-email-rogerq@ti.com>
 <1376572512-9561-7-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1376572512-9561-7-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, dmurphy-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros | 2013-08-15 16:15:10 [+0300]:

>diff --git a/drivers/usb/phy/phy-omap-control.c b/drivers/usb/phy/phy-omap-control.c
>index 078c46f..d144c14 100644
>--- a/drivers/usb/phy/phy-omap-control.c
>+++ b/drivers/usb/phy/phy-omap-control.c
>@@ -187,11 +167,19 @@ void omap_control_usb_set_mode(struct device *dev,
> {
> 	struct omap_control_usb	*ctrl_usb;
> 
>-	if (IS_ERR(dev) || control_usb->type != OMAP_CTRL_TYPE_OMAP)
>+	if (IS_ERR(dev) || !dev)
> 		return;
> 
> 	ctrl_usb = dev_get_drvdata(dev);
> 
>+	if (!ctrl_usb) {
>+		dev_err(dev, "Invalid control usb device\n");
>+		return;
>+	}
>+
>+	if (ctrl_usb->type != OMAP_CTRL_TYPE_OMAP)
>+		return;
>+

I don't like that part where you can call this function even before the
driver probed the device. This shouldn't happen since you have hard module
dependency and the proper compatible string in your device. But this
kind of thing won't happen in the am335x reset driver.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
