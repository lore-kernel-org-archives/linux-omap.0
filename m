From: Tony Lindgren <tony@atomide.com>
Subject: Re: Open issues after 2.6.38 merge window
Date: Fri, 14 Jan 2011 15:59:43 -0800
Message-ID: <20110114235942.GS4957@atomide.com>
References: <20110114194758.GM4957@atomide.com>
 <4D30B8BB.90804@ti.com>
 <20110114233838.GR4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27656 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab1ANX7u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 18:59:50 -0500
Content-Disposition: inline
In-Reply-To: <20110114233838.GR4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Anders <x0132446@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [110114 15:38]:
> * David Anders <x0132446@ti.com> [110114 12:56]:
> > Tony,
> > 
> > i've been testing the 2.6.37 kernel on ES2.0, ES2.1, ES2.2 using the
> > following:
> > 
> > x-loader:
> > git://gitorious.org/x-loader/x-loader.git
> > branch: master
> >  6f3a261 omap1: remove support for 1710 and 1510
> > defconfig: omap4430panda_config
> > 
> > U-boot:
> > git://git.denx.de/u-boot.git
> > tag: v2010.12
> > defconfig: omap4_panda_config
> 
> That's what I'm using too.
>  
> > kernel:
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> > tag: v2.6.37
> > defconfig: omap2plus_defconfig
> > 
> > i've not seen the power off issue you have described.
> 
> Hmm well it happens also with v2.6.37, so sounds like it's
> a u-boot or hardware issue. I'll debug a bit further.

Weird. While debugging the problem, I left just the u-boot console
running for a few minutes to see if panda shuts down on it's own.

It did not, but instead it now stays running with the kernel
booted also.. No idea why. Did not touch anything with u-boot..

Tony
