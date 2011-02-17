From: Felipe Balbi <balbi@ti.com>
Subject: [patch v2.6.39 0/3] Patches for next merge window
Date: Thu, 17 Feb 2011 13:30:18 +0200
Message-ID: <1297942221-22995-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58982 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755445Ab1BQLa2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 06:30:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Anand Gadiyar <gadiyar@ti.com>, Hema Kalliguddi <hemahk@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

Hi all,

This is what I have for next merge window. If you have
patches that should go in, please re-send them now as I
don't have anything in my queue.

I dropped Ming's DMA rework because I'm not sure that's
the best approach. IMO, it's better to simplify DMA
programming by having "one programming model fits all"
rather than have all these flags floating around. So
that'll have to wait another cycle.

I'm also looking into Hema's HWMOD + pm_runtime patches.

I guess those will have to go through Tony's tree since
most of the changes are in arch/arm/mach-omap2/.

Felipe Balbi (3):
  usb: musb: do not error out if Kconfig doesn't match board mode
  usb: musb: gadget: beautify
    usb_gadget_probe_driver()/usb_gadget_unregister_driver
  usb: musb: gadget: do not poke with gadget's list_head

 drivers/usb/musb/musb_core.c       |   25 -----
 drivers/usb/musb/musb_core.h       |    4 +-
 drivers/usb/musb/musb_gadget.c     |  187 +++++++++++++++++++-----------------
 drivers/usb/musb/musb_gadget.h     |    7 +-
 drivers/usb/musb/musb_gadget_ep0.c |   24 +++--
 5 files changed, 120 insertions(+), 127 deletions(-)

-- 
1.7.4.rc2

