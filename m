From: Tony Lindgren <tony@atomide.com>
Subject: Re: [APPLIED] [PATCH v2] OMAP: Store reboot mode in scratchpad on
	OMAP34xx
Date: Tue, 10 Mar 2009 14:14:10 -0700
Message-ID: <20090310211410.GF19229@atomide.com>
References: <notify-1236713705@atomide.com> <200903101405.46229.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60126 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941AbZCJVOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 17:14:12 -0400
Content-Disposition: inline
In-Reply-To: <200903101405.46229.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, Juha Yrjola <juha.yrjola@solidboot.com>

* David Brownell <david-b@pacbell.net> [090310 14:05]:
> On Tuesday 10 March 2009, Tony Lindgren wrote:
> > This patch has been applied to the linux-omap
> > by youw fwiendly patch wobot.
> 
>   CC      arch/arm/mach-omap2/prcm.o
> arch/arm/mach-omap2/prcm.c: In function 'omap_prcm_arch_reset':
> arch/arm/mach-omap2/prcm.c:56: error: 'OMAP343X_SCRATCHPAD' undeclared (first use in this function)
> arch/arm/mach-omap2/prcm.c:56: error: (Each undeclared identifier is reported only once
> arch/arm/mach-omap2/prcm.c:56: error: for each function it appears in.)
> make[1]: *** [arch/arm/mach-omap2/prcm.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2

I already pushed a fix for that as commit
3388c8ffb612af2c9d4267e0401378c3afb05f5f.

Tony

 
> > 
> > Commit: 73b65cde9647508313b3d686dff0f3d1d92482d1
> > 
> > PatchWorks
> > http://patchwork.kernel.org/patch/10718/
> > 
> > Git
> > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=73b65cde9647508313b3d686dff0f3d1d92482d1
> > 
> > 
> > 
> 
