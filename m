From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap: introduce OMAP MCOP board file
Date: Tue, 5 Apr 2011 12:54:47 +0300
Message-ID: <20110405095446.GF23776@legolas.emea.dhcp.ti.com>
References: <1301995970-23699-1-git-send-email-balbi@ti.com>
 <20110405093656.GS2176@legolas.emea.dhcp.ti.com>
 <20110405095119.GD4699@n2100.arm.linux.org.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:38907 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750920Ab1DEJyw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 05:54:52 -0400
Received: by eyg24 with SMTP id 24so53927eyg.25
        for <linux-omap@vger.kernel.org>; Tue, 05 Apr 2011 02:54:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110405095119.GD4699@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Michael Fillinger <m-fillinger@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi,

On Tue, Apr 05, 2011 at 10:51:19AM +0100, Russell King - ARM Linux wrote:
> > I don't think Linus will like if we add yet another hwmod + clk data
> > file just for MCOP, so we need to re-use what's in tree.
> 
> I'd suggest holding fire on new stuff.
> 
> We *absolutely* *must* show that we're taking Linus' complaint seriously
> and make headway towards consolidating some of the code.  I don't see that
> activity as optional.
> 
> I've now made the decision (as I mentioned I may do in the thread) that
> for the next merge window I'm only taking consolidations and bug fixes
> through my tree, and I encourage everyone else to do the same.  At the
> moment, I'm planning for this up until the next merge window, but if
> sufficient progress hasn't been done, I'll extend it thereafter.
> 
> In other words, no new platform code and no new platform class code.
> 
> The longer it takes to get the consolidation effort producing results, the
> longer we will have to keep the restriction in place, and the more painful
> it'll be for people who want to have their platforms merged.
> 
> So I hope *no* one is thinking "this isn't my problem, someone else will
> solve it" - if you're thinking that then we're doomed.

Ok Russell, we will hold on to this patch and try to help as we can on
the code consolidation effort.

Let's hope to get this sorted out soon as it would be really great for
us to start pre-silicon validation with mainline kernel with little to
no effort needed :-D

-- 
balbi
