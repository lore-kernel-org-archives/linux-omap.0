From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/5 v4] OMAP2+: musb: HWMOD adaptation for musb.
Date: Fri, 10 Dec 2010 15:02:33 +0200
Message-ID: <20101210130232.GL6027@legolas.emea.dhcp.ti.com>
References: <1291985590-27126-1-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:55796 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756216Ab0LJNCh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 08:02:37 -0500
Content-Disposition: inline
In-Reply-To: <1291985590-27126-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Fri, Dec 10, 2010 at 06:23:10PM +0530, Hema HK wrote:
>@@ -212,8 +228,28 @@ void __init usb_musb_init(struct omap_mu
> 	musb_plat.mode = board_data->mode;
> 	musb_plat.extvbus = board_data->extvbus;
>
>-	if (platform_device_register(&musb_device) < 0)
>-		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
>+	if (cpu_is_omap3517() || cpu_is_omap3505()) {
>+
>+		if (platform_device_register(&musb_device) < 0)
>+			printk(KERN_ERR "Unable to register HS-USB \
>+					(MUSB) device\n");
>+	} else {

you can amend these two branches to the previous one. move the
platform_device_register() to the previous if (cpu_is_omap3517() ||
cpu_is_omap3505()) check. similarly with the code below.

>+		pdata = &musb_plat;
>+		od = omap_device_build(name, bus_id, oh, pdata,
>+				       sizeof(*pdata), omap_musb_latency,
>+				       ARRAY_SIZE(omap_musb_latency), false);
>+		if (IS_ERR(od)) {
>+			pr_err("Could not build omap_device for %s %s\n",
>+							name, oh_name);
>+			return;
>+		}
>+		pdev = &od->pdev;
>+		dev = &pdev->dev;
>+		get_device(dev);
>+		dev->dma_mask = &musb_dmamask;
>+		dev->coherent_dma_mask = musb_dmamask;
>+		put_device(dev);
>+	}
> }
>
> #else

-- 
balbi
