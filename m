From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7] 4460sdp/blaze/panda: hwmod: Prevent gpio1 reset
 during hwmod init
Date: Mon, 4 Jul 2011 01:53:35 -0700
Message-ID: <20110704085335.GP23145@atomide.com>
References: <1309486081-8257-1-git-send-email-rnayak@ti.com>
 <1309486081-8257-2-git-send-email-rnayak@ti.com>
 <1309486081-8257-3-git-send-email-rnayak@ti.com>
 <1309486081-8257-4-git-send-email-rnayak@ti.com>
 <1309486081-8257-5-git-send-email-rnayak@ti.com>
 <1309486081-8257-6-git-send-email-rnayak@ti.com>
 <1309486081-8257-7-git-send-email-rnayak@ti.com>
 <1309486081-8257-8-git-send-email-rnayak@ti.com>
 <20110701063241.GX23145@atomide.com>
 <alpine.DEB.2.00.1107022103430.12499@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:29832 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754089Ab1GDIxi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jul 2011 04:53:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107022103430.12499@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, Nishanth Menon <nm@ti.com>, s-sintes@ti.com, Moiz Sonasath <m-sonasath@ti.com>

* Paul Walmsley <paul@pwsan.com> [110702 21:09]:
> Hi Tony
> 
> On Thu, 30 Jun 2011, Tony Lindgren wrote:
> 
> > NAK for this patch. We don't want any of this in init_early.
> > 
> > The problem is with hwmod core code that wrongly assumes it
> > can just reset all devices.
> 
> I don't think the hwmod core code has any way of knowing which devices 
> shouldn't be reset unless the board file specifically tells it.  Even if 
> the reset happens right before the hwmod enable (as called by the device 
> driver), the 4460 boards would still crash when the GPIO driver starts.
> 
> What you suggested below should allow those omap_hwmod_no_setup_reset() 
> calls to live in init_machine, rather than init_early.  Hopefully that is 
> acceptable?  So I did a test implementation of your idea, and learned some 
> good news and bad news.

Yes later on that should be fine, but preferrably not until late_initcall
so we have decent debug output even without DEBUG_LL being enabled.
 
> The good news is that it seems to work for the PM runtime-converted 
> drivers.  omap_hwmod_no_setup_reset() calls can go into init_machine code.  
> We should also be able to get rid of the postsetup code in 
> mach-omap2/io.c.
> 
> The bad news is that the unused IP block reset code will reset IP blocks 
> used by drivers that haven't been converted to use runtime PM.  The hwmod 
> core code doesn't know that those IP blocks are in use, since 
> omap_hwmod_enable() is never called for them.  The unused IP block reset 
> code will then reset those blocks after the drivers have already probed, 
> and the drivers are not expecting this :-)

I guess we should keep it disabled for now :)
 
> GPTIMER and HSMMC drivers are the obvious problems in terms of getting a 
> successful boot, but DSS is another one that may cause some problems here.  
> There are HSMMC and DSS driver PM runtime conversion patches posted, 
> hopefully they will go into mainline soon, but there are probably some 
> other important drivers yet to be converted or yet to be pushed.
> 
> Here are some options that come to mind:
> 
> 1. Wait until the driver runtime PM conversion is finished before doing 
>    anything.  In the meantime, boards with IP blocks that can't be reset 
>    - N810, TI 4460 boards - will have problems.
> 
> 2. Merge the lazy/unused hwmod reset code, but prevent IP blocks 
>    controlled by non-runtime PM drivers from being reset.  We'd have to
>    maintain a list of these somewhere, perhaps in some common code called 
>    by board file init_machine code.  Then we'd need to redact that list as 
>    new driver runtime PM conversions complete.
> 
> 3. Merge the lazy/unused hwmod reset code, but disable the unused hwmod 
>    reset code until the driver runtime PM conversion is finished.  This
>    could cause problems with driverless devices that are left configured
>    by bootloaders or ROM code, and that problem would reoccur for each new
>    OMAP chip.
> 
> Do you have a preference as to which approach to take?

I think #3 above is the safest option. How about make it only happen with
hwmod_reset=1 cmdline with 0 being the default value?

Regards,

Tony 
