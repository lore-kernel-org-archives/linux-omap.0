From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/3] OMAP_LDP support in linux-git tree
Date: Fri, 5 Dec 2008 10:58:18 -0800
Message-ID: <20081205185816.GG9714@atomide.com>
References: <1227253870-4407-1-git-send-email-stanley.miao@windriver.com> <20081126231240.GM11997@atomide.com> <1227800406.14497.123.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60595 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbYLES6V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 13:58:21 -0500
Content-Disposition: inline
In-Reply-To: <1227800406.14497.123.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

* stanley.miao <stanley.miao@windriver.com> [081127 07:33]:
> On Wed, 2008-11-26 at 15:12 -0800, Tony Lindgren wrote:
> > * Stanley.Miao <stanley.miao@windriver.com> [081120 23:45]:
> > > Changes from v1:
> > > 
> > > 1, change omap_request_gpio() to gpio_request() in gpio.patch.
> > 
> > One request: Since the LDP is in the mainline kernel, can you please
> > provide whatever applies as patches against the mainline board-ldp.c?
> > 
> > Then if some driver is not yet in mainline, provide that in an extra
> > patch.
> > 
> > That way I don't have to rewrite your patches for mainline ;)
> 
> Did I understand you right ? 
> 
> The nand patch modified arch/arm/mach-omap2/Makefile. This Makefile
> changed a lot against mainline. I don't know how to provide the patch
> against mainline.

Sorry for the delay. If you want to use the same patch for the mainline
kernel and linux-omap kernel, you may need to edit the Makefile and Kconfig
manually.

But since you have the ldp board already in the mainline kernel, all you
need to do is to send me patches against the mainline kernel to add
various support bits still missing from the mainline board file. Exactly
what you did with for smc support (Well I had to cut out the smc driver
bits):

ARM: OMAP3: LDP: Add Ethernet device support to make ldp boot succeess

in the current omap3-upstream series:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=omap3-upstream

So just send patches to add the rest of the devices, OK? Make sure it
compiles with the mainline kernel, so exclude the drivers that are not
there yet.

Cheers,

Tony
