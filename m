From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: OMAP3530 USB host problems
Date: Fri, 20 Feb 2009 20:54:26 +0200
Message-ID: <20090220185426.GR20723@frodo>
References: <499EF348.6020302@mlbassoc.com> <20090220182904.GP20723@frodo> <499EFB84.1020201@mlbassoc.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38600 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbZBTSyb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 13:54:31 -0500
Content-Disposition: inline
In-Reply-To: <499EFB84.1020201@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: me@felipebalbi.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Feb 20, 2009 at 11:50:44AM -0700, Gary Thomas wrote:
> Felipe Balbi wrote:
> > On Fri, Feb 20, 2009 at 11:15:36AM -0700, Gary Thomas wrote:
> >> I have a 3530 board (similar to the OMAP3EVM) and I'm trying
> >> to get the USB host working.  Sadly, this is failing, but I
> >> don't quite see why.  From drivers/usb/host/echi-omap.c:
> >> 	/* Wait for TLL to be Active */
> >>         timeout = 1000;
> >> 	while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3)
> >> 			& (1 << OMAP3430ES2_ST_USBTLL_SHIFT)))
> >>         {
> >>             if (--timeout <= 0) {
> >>                 printk(KERN_ERR "USB TLL is unavailable\n");
> >>                 return -ENODEV;
> >>             }
> >> 		cpu_relax();
> >>         }
> >>
> >> Any clues on why this might be?  How do I solve it?
> > 
> > could you enable CONFIG_DEBUG_LL and post the seria console output ?
> > 
> > do you really use TLL ?? I don't really know omap3evm, but I guess it
> > uses PHY mode (correct me if I'm wrong).
> > 
> 
> It's not that I _need_ TLL, the driver function omap_start_ehci()
> tries to reset the part of the USB controller and fails.  I'm just
> trying to understand why this part of the code falls over.

you have OMAP_EHCI_TLL_MODE set, you should probably use
OMAP_EHCI_PHY_MODE instead.

You can fix it via "make menuconfig"

-- 
balbi
