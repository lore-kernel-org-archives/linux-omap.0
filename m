From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP3 & USB NFS root
Date: Wed, 16 Feb 2011 12:26:53 +0200
Message-ID: <20110216102653.GR2497@legolas.emea.dhcp.ti.com>
References: <1297691206.2951.8.camel@deskari>
 <20110214134842.GH2549@legolas.emea.dhcp.ti.com>
 <1297692039.2951.10.camel@deskari>
 <20110214140216.GJ2549@legolas.emea.dhcp.ti.com>
 <1297838666.2031.8.camel@deskari>
 <20110216080227.GB2497@legolas.emea.dhcp.ti.com>
 <20110216080543.GD2497@legolas.emea.dhcp.ti.com>
 <1297849461.5431.3.camel@deskari>
 <20110216094918.GN2497@legolas.emea.dhcp.ti.com>
 <1297850436.2713.2.camel@deskari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:42705 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755126Ab1BPK07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 05:26:59 -0500
Received: by bwz16 with SMTP id 16so1428843bwz.18
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 02:26:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297850436.2713.2.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Feb 16, 2011 at 12:00:36PM +0200, Tomi Valkeinen wrote:
> On Wed, 2011-02-16 at 03:49 -0600, Balbi, Felipe wrote:
> > Hi,
> > 
> > On Wed, Feb 16, 2011 at 11:44:21AM +0200, Tomi Valkeinen wrote:
> > > Perhaps I'm missing some Kconfig option.
> > 
> > Yes, you have a problem on your Kconfig
> > 
> > <snip>
> > 
> > > CONFIG_USB_MUSB_HDRC=y
> > > CONFIG_USB_MUSB_TUSB6010=y
> > > # CONFIG_USB_MUSB_OMAP2PLUS is not set
> > > # CONFIG_USB_MUSB_AM35X is not set
> > 
> > Since you're running on Overo, you need to use CONFIG_USB_MUSB_OMAP2PLUS
> > instead of CONFIG_USB_MUSB_TUSB6010. We're still working to make those
> > work together. Lots of re-work needs to be done on the DMA part before
> > we can make all of them work together.
> > 
> > Fix that and it should work.
> 
> Ok, thanks, now it works! I set CONFIG_USB_MUSB_OMAP2PLUS, but that
> didn't help alone. I also had to enable host side USB, select
> CONFIG_USB_MUSB_OTG. With plain peripheral support nothing happened.

you need the other patch I sent before. Here it is:

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 54a8bd1..bc29655 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1949,31 +1949,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		goto fail0;
 	}
 
-	switch (plat->mode) {
-	case MUSB_HOST:
-#ifdef CONFIG_USB_MUSB_HDRC_HCD
-		break;
-#else
-		goto bad_config;
-#endif
-	case MUSB_PERIPHERAL:
-#ifdef CONFIG_USB_GADGET_MUSB_HDRC
-		break;
-#else
-		goto bad_config;
-#endif
-	case MUSB_OTG:
-#ifdef CONFIG_USB_MUSB_OTG
-		break;
-#else
-bad_config:
-#endif
-	default:
-		dev_err(dev, "incompatible Kconfig role setting\n");
-		status = -EINVAL;
-		goto fail0;
-	}
-
 	/* allocate */
 	musb = allocate_instance(dev, plat->config, ctrl);
 	if (!musb) {

-- 
balbi
