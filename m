From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap3beagle: init musb default role by Kconfig
Date: Wed, 16 Feb 2011 10:05:06 +0200
Message-ID: <20110216080506.GC2497@legolas.emea.dhcp.ti.com>
References: <1297760100-7200-1-git-send-email-lliubbo@gmail.com>
 <20110215112350.GM2570@legolas.emea.dhcp.ti.com>
 <AANLkTik-tZKZ-0G1RBXD0rz1O4=wLXtHd2wTD-61dLm0@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54306 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752234Ab1BPIFL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 03:05:11 -0500
Received: by mail-bw0-f42.google.com with SMTP id 13so1970834bwz.15
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 00:05:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik-tZKZ-0G1RBXD0rz1O4=wLXtHd2wTD-61dLm0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bob Liu <lliubbo@gmail.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, archit@ti.com, tony@atomide.com, adrian.hunter@nokia.com

On Wed, Feb 16, 2011 at 10:07:26AM +0800, Bob Liu wrote:
> On Tue, Feb 15, 2011 at 7:23 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Tue, Feb 15, 2011 at 04:55:00PM +0800, Bob Liu wrote:
> >> Currently musb is initialized to OTG mode by default in musb_board_data, it's
> >> better to init it depending on Kconfig.
> >
> > what's the problem in always keeping OTG ? that board is wired for OTG
> > anyway.
> >
> 
> Yeah, but it's better if user can make their choices by themselves.
> Or mask the other choices in Kconfig if keeping OTG.
> Currently user can select HOST-only mode in Kconfig, but will receive
> compiler error.
> In my opinion, this should be consist.

compile error ?? Would you share that ? All I see is a dev_err() when
Kconfig doesn't match board-file.

> Another problem is if keeping in OTG mode, my board can't recognize usb device.
> HOST-only mode works fine, I am still debugging on it.
> But I think it's not related with current topic.

I can be related. Try this:

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
