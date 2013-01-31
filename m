From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP4 PM bootloader dependency problems
Date: Thu, 31 Jan 2013 16:32:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301311630090.32145@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>  <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com> <1359622829.10415.40.camel@sokoban> <510A54F8.4090609@ti.com> <alpine.DEB.2.00.1301311537530.23099@utopia.booyaka.com>
 <510A9BFB.5070802@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52873 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab3AaQc5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 11:32:57 -0500
In-Reply-To: <510A9BFB.5070802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com

Hi,

On Thu, 31 Jan 2013, Santosh Shilimkar wrote:

> On Thursday 31 January 2013 09:10 PM, Paul Walmsley wrote:
> > On Thu, 31 Jan 2013, Rajendra Nayak wrote:
> > 
> > > Throw a pr_warn() at boot only when CONFIG_CPU_IDLE is enabled. Note
> > > that it isn't enabled by default in omap2plus_defconfig. Also
> > > throw one when a suspend fails, saying bootloader *could be* a possible
> > > cause specifying the right version to be used.
> > 
> > In my view, these steps aren't sufficient, for the reasons described in
> > 
> > http://marc.info/?l=linux-omap&m=135964568904053&w=2
> > 
> > Even with CONFIG_CPU_IDLE=n, it's still possible to attempt to enter
> > full-chip retention idle on OMAP4 via 'echo mem > /sys/power/state', so it
> > doesn't seem right to restrict a solution to that case.
> > 
> 
> I think rajendra also mentioned adding one in suspend path too
> when it fails.
> " Also throw one when a suspend fails, saying bootloader
> *could be* a possible cause specifying the right version to be used."
> 
> I find Rajendra's suggestion reasonable because some one might
> just miss the boot message but getting the message on failure
> case cant' be missed.

Right.  I don't have any problem with adding a message to the suspend path 
also.  But I'd like to see a boot-time message added even if 
CONFIG_CPU_IDLE=n, since it's still possible to enter full-chip retention 
idle with dynamic idle.  In other words, not everyone might use 'echo mem 
> /sys/power/state'.


- Paul
