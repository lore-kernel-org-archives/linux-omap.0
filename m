From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP3 & USB NFS root
Date: Wed, 16 Feb 2011 10:05:43 +0200
Message-ID: <20110216080543.GD2497@legolas.emea.dhcp.ti.com>
References: <1297691206.2951.8.camel@deskari>
 <20110214134842.GH2549@legolas.emea.dhcp.ti.com>
 <1297692039.2951.10.camel@deskari>
 <20110214140216.GJ2549@legolas.emea.dhcp.ti.com>
 <1297838666.2031.8.camel@deskari>
 <20110216080227.GB2497@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54733 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753078Ab1BPIFr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 03:05:47 -0500
Received: by mail-bw0-f42.google.com with SMTP id 13so1970834bwz.15
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 00:05:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110216080227.GB2497@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Feb 16, 2011 at 10:02:27AM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Feb 16, 2011 at 08:44:26AM +0200, Tomi Valkeinen wrote:
> > > ah, ok. So it's another problem. I don't have beagle, but I have an old
> > > overo here. Will try tomorrow to see what's going on. Thanks for the
> > > report.
> > 
> > Did you get a chance to try this? Or any suggestions what I could try? I
> > could of course try to bisect it, but that's quite laborious as I have
> > to store the kernel into an mmc to be able to use it.
> 
> I'm trying to get my overo to work. MMC doesn't seem to be working on
> u-boot again:
> 
> Overo # mmc rescan 0
> Overo # fatload mmc 0 82000000 uImage
> reading uImage
> mmc_send_cmd: timedout waiting for cmddis!
> mmc fail to send stop cmd
> mmc_send_cmd: timedout waiting for cmddis!
> Invalid FAT entry
> 
> 952320 bytes read
> Overo # 
> 
> u-boot's HEAD is efb063390d2d1e712c2c8110911616244d562c4b

case I can't get it working, would you care to try the below patch ?

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 54a8bd1..bc29655 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1949,31 +1949,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
                goto fail0;
        }
 
-       switch (plat->mode) {
-       case MUSB_HOST:
-#ifdef CONFIG_USB_MUSB_HDRC_HCD
-               break;
-#else
-               goto bad_config;
-#endif
-       case MUSB_PERIPHERAL:
-#ifdef CONFIG_USB_GADGET_MUSB_HDRC
-               break;
-#else
-               goto bad_config;
-#endif
-       case MUSB_OTG:
-#ifdef CONFIG_USB_MUSB_OTG
-               break;
-#else
-bad_config:
-#endif
-       default:
-               dev_err(dev, "incompatible Kconfig role setting\n");
-               status = -EINVAL;
-               goto fail0;
-       }
-
        /* allocate */
        musb = allocate_instance(dev, plat->config, ctrl);
        if (!musb) {


-- 
balbi
