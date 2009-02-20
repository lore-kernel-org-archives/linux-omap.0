From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: OMAP3530 USB host problems
Date: Fri, 20 Feb 2009 21:23:30 +0200
Message-ID: <20090220192330.GN32564@gandalf>
References: <499EF348.6020302@mlbassoc.com> <20090220182904.GP20723@frodo> <499EFB84.1020201@mlbassoc.com> <20090220185426.GR20723@frodo> <499EFF0D.6060602@mlbassoc.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38503 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbZBTTXg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 14:23:36 -0500
Content-Disposition: inline
In-Reply-To: <499EFF0D.6060602@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: me@felipebalbi.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Feb 20, 2009 at 12:05:49PM -0700, Gary Thomas wrote:
> Felipe Balbi wrote:
> > On Fri, Feb 20, 2009 at 11:50:44AM -0700, Gary Thomas wrote:
> >> Felipe Balbi wrote:
> >>> On Fri, Feb 20, 2009 at 11:15:36AM -0700, Gary Thomas wrote:
> >>>> I have a 3530 board (similar to the OMAP3EVM) and I'm trying
> >>>> to get the USB host working.  Sadly, this is failing, but I
> >>>> don't quite see why.  From drivers/usb/host/echi-omap.c:
> >>>> 	/* Wait for TLL to be Active */
> >>>>         timeout = 1000;
> >>>> 	while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3)
> >>>> 			& (1 << OMAP3430ES2_ST_USBTLL_SHIFT)))
> >>>>         {
> >>>>             if (--timeout <= 0) {
> >>>>                 printk(KERN_ERR "USB TLL is unavailable\n");
> >>>>                 return -ENODEV;
> >>>>             }
> >>>> 		cpu_relax();
> >>>>         }
> >>>>
> >>>> Any clues on why this might be?  How do I solve it?
> >>> could you enable CONFIG_DEBUG_LL and post the seria console output ?
> >>>
> >>> do you really use TLL ?? I don't really know omap3evm, but I guess it
> >>> uses PHY mode (correct me if I'm wrong).
> >>>
> >> It's not that I _need_ TLL, the driver function omap_start_ehci()
> >> tries to reset the part of the USB controller and fails.  I'm just
> >> trying to understand why this part of the code falls over.
> > 
> > you have OMAP_EHCI_TLL_MODE set, you should probably use
> > OMAP_EHCI_PHY_MODE instead.
> > 
> > You can fix it via "make menuconfig"
> > 
> 
> I already have that; this code is still being used.
>   # CONFIG_OMAP_EHCI_TLL_MODE is not set
>   CONFIG_OMAP_EHCI_PHY_MODE=y
> 
> This is not used in the function above at all.

hmm.. true, just checked the function.

Weird, TRM says when that bit is 1, we cannot access ST_USBTLL, we
should access it when it's 0, try the following:

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 1b3266c..122e95b 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -250,7 +250,7 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
        /* Wait for TLL to be Active */
        while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3)
-                       & (1 << OMAP3430ES2_ST_USBTLL_SHIFT)))
+                       & (0 << OMAP3430ES2_ST_USBTLL_SHIFT)))
                cpu_relax();
 
        /* perform TLL soft reset, and wait until reset is complete */

and tell us if it worked

-- 
balbi
