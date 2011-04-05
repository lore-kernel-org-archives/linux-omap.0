From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: introduce OMAP MCOP board file
Date: Tue, 5 Apr 2011 08:46:32 -0700
Message-ID: <20110405154632.GC17376@atomide.com>
References: <1301995970-23699-1-git-send-email-balbi@ti.com>
 <20110405093656.GS2176@legolas.emea.dhcp.ti.com>
 <20110405095119.GD4699@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58357 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab1DEPqh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 11:46:37 -0400
Content-Disposition: inline
In-Reply-To: <20110405095119.GD4699@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>, Michael Fillinger <m-fillinger@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110405 02:48]:
> 
> I'd suggest holding fire on new stuff.
> 
> We *absolutely* *must* show that we're taking Linus' complaint seriously
> and make headway towards consolidating some of the code.  I don't see that
> activity as optional.

I agree.
 
> I've now made the decision (as I mentioned I may do in the thread) that
> for the next merge window I'm only taking consolidations and bug fixes
> through my tree, and I encourage everyone else to do the same.  At the
> moment, I'm planning for this up until the next merge window, but if
> sufficient progress hasn't been done, I'll extend it thereafter.

OK
 
> In other words, no new platform code and no new platform class code.
> 
> The longer it takes to get the consolidation effort producing results, the
> longer we will have to keep the restriction in place, and the more painful
> it'll be for people who want to have their platforms merged.
> 
> So I hope *no* one is thinking "this isn't my problem, someone else will
> solve it" - if you're thinking that then we're doomed.

Yes we need more people to pitch in to the consolidation process,
so everybody please help where possible.

Regards,

Tony

