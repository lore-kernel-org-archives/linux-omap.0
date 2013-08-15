From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 1/8] usb: phy: omap-control: Get rid of platform data
Date: Thu, 15 Aug 2013 18:22:29 +0200
Message-ID: <20130815162229.GA10982@linutronix.de>
References: <1376572512-9561-1-git-send-email-rogerq@ti.com>
 <1376572512-9561-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35463 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757381Ab3HOQWd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Aug 2013 12:22:33 -0400
Content-Disposition: inline
In-Reply-To: <1376572512-9561-2-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, bcousson@baylibre.com, tony@atomide.com, kishon@ti.com, george.cherian@ti.com, dmurphy@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Roger Quadros | 2013-08-15 16:15:05 [+0300]:

>diff --git a/drivers/usb/phy/phy-omap-control.c b/drivers/usb/phy/phy-omap-control.c
>index a4dda8e..3b9ee83 100644
>--- a/drivers/usb/phy/phy-omap-control.c
>+++ b/drivers/usb/phy/phy-omap-control.c
>@@ -197,8 +197,13 @@ static int omap_control_usb_probe(struct platform_device *pdev)
> {
> 	struct resource	*res;
> 	struct device_node *np = pdev->dev.of_node;
>-	struct omap_control_usb_platform_data *pdata =
>-			dev_get_platdata(&pdev->dev);
>+
>+	if (np) {
>+		of_property_read_u32(np, "ti,type", &control_usb->type);
>+	} else {
>+		/* We only support DT boot */
>+		return -ENODEV;
>+	}

what about
    if (!nop)
        return -EINVAL;

> 	control_usb = devm_kzalloc(&pdev->dev, sizeof(*control_usb),
> 		GFP_KERNEL);
>@@ -207,15 +212,6 @@ static int omap_control_usb_probe(struct platform_device *pdev)
> 		return -ENOMEM;
> 	}
> 
>-	if (np) {
>-		of_property_read_u32(np, "ti,type", &control_usb->type);

and here you shift the property to the left and remove the other lines.
But then you wanted to remove that ti,type thingy but I guess this will
be part of another patch then. Since you can't do everything in one
patch, it is okay.

>-	} else if (pdata) {
>-		control_usb->type = pdata->type;
>-	} else {
>-		dev_err(&pdev->dev, "no pdata present\n");
>-		return -EINVAL;
>-	}
>-
> 	control_usb->dev	= &pdev->dev;
> 
> 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,

Sebastian
