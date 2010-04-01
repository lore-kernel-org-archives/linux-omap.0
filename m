From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
Date: Thu, 1 Apr 2010 05:50:13 -0700
Message-ID: <20100401125012.GR31200@atomide.com>
References: <20100329.120856.59654379.Hiroshi.DOYU@nokia.com>
 <20100401095203.GL31200@atomide.com>
 <20100401.132336.193692763.Hiroshi.DOYU@nokia.com>
 <20100401.142629.226796472.Hiroshi.DOYU@nokia.com>
 <alpine.DEB.2.00.1004010629380.27004@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61280 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab0DAMs1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 08:48:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1004010629380.27004@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, khilman@deeprootsystems.com, felipe.balbi@nokia.com, x0095840@ti.com, linux-omap@vger.kernel.org, ameya.palande@nokia.com, felipe.contreras@nokia.com

* Paul Walmsley <paul@pwsan.com> [100401 05:29]:
> Hi Hiroshi,
> 
> On Thu, 1 Apr 2010, Hiroshi DOYU wrote:
> 
> > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
> > Date: Thu, 01 Apr 2010 13:23:36 +0300 (EEST)
> > 
> > > From: ext Tony Lindgren <tony@atomide.com>
> > > Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
> > > Date: Thu, 1 Apr 2010 11:52:04 +0200
> > > 
> > >> * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [100329 02:05]:
> > >>> From: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
> > >>> Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
> > >>> Date: Mon, 29 Mar 2010 09:01:45 +0200
> > >>> > 
> > >>> > in that case, wouldn't it be better to split that into 
> > >>> > arch/arm/omap1/mbox.c arch/arm/omap2/mbox24xx.c 
> > >>> > arch/arm/omap2/mbox34xx.c arch/arm/omap2/mbox44xx.c ??
> > >>> > 
> > >>> > that way we don't need ifdefs on the code and we will only compile what 
> > >>> > we really need.
> > >>> 
> > >>> This is feasible.
> > >>> But I'm not so sure whether adding 4 new files with around only 10
> > >>> lines code is acceptable or not.
> > >>> 
> > >>> Tony, any comment on the above?
> > >>> 
> > >>> Basically there could be the case we need all resources if we want to
> > >>> support omap1, 2, 3 and 4 at the same time, and the appropriate one
> > >>> will be chosen at run time by CPUID. I'm not sure how mature "omap
> > >>> multi arch" support is practically, but it's better to keep it as much
> > >>> as possbile.
> > >> 
> > >> I like Felipe's suggestion of adding devices2420.c, devices34xx.c,
> > >> devices44xx.c or similar. Then do the device init from those with
> > >> a arch_initcall that returns immediately if not running on the right
> > >> soc.
> > > 
> > > Ok, let's procced with this. I'll post something later.
> > > 
> > 
> > Something like the following?
> 
> Is it possible to try a hwmod conversion of this?  Similar to the UART, 
> HSMMC, etc. work that Kevin has queued in his pm-wip/hwmods branch:
> 
> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=shortlog;h=refs/heads/pm-wip/hwmods
> 
> Otherwise this will all have to be redone when the mailbox is converted to 
> use hwmod.

Sounds like a plan to me.

Tony
