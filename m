From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Mon, 7 May 2012 23:31:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205072321190.9984@utopia.booyaka.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com> <1336029982-31898-3-git-send-email-r.sricharan@ti.com> <20120504223933.GX5613@atomide.com> <alpine.DEB.2.00.1205071259090.9984@utopia.booyaka.com> <20120507191847.GJ5088@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43059 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2EHFbu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 01:31:50 -0400
In-Reply-To: <20120507191847.GJ5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: R Sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

On Mon, 7 May 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [120507 12:11]:
> > On Fri, 4 May 2012, Tony Lindgren wrote:
> > 
> > > How about we add CONFIG_SOC_OMAP3PLUS in the clean-up series?
> > > Then this becomes just:
> > > 
> > > #ifdef CONFIG_SOC_OMAP3PLUS
> > 
> > We might want to consider having separate CONFIG_SOC_* values for each 
> > SoC.  So rather than CONFIG_SOC_OMAP3PLUS, we'd have CONFIG_SOC_OMAP3430, 
> > CONFIG_SOC_OMAP3630, etc.
> 
> Hmm but this would be in addition to the SOC specific options. The goal
> is to cut down the ifdeffery needed all over the place to add new SoCs,
> see the experimental patch I posted:
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67938.html

I see.  Yeah, the problem is that it's hard to figure out which SoCs 
should go into SOC_OMAP3PLUS.  AM33xx?  TI81xx?  etc.  Some of these chips 
draw some aspects from chips that we've historically considered part of 
OMAP3, and other aspects from OMAP4-style chips.

What seems better to me would be to use a more specific, IP block-focused 
macro as needed.  So to pick a random example, in mach-omap2/control.c, we 
currently skip compilation of the scratchpad functions unless 
CONFIG_ARCH_OMAP3 is defined.  Instead of making this 
SOC_OMAP3PLUS-dependent, or dependent on a mess of CONFIG_SOC_* macros, 
maybe something like CONFIG_OMAP3430_SCM_SCRATCHPAD_FORMAT?

Of course, for some of these cases, maybe it makes more sense to move the 
code out into a separate file, control-omap3-scratchpad.c or something, 
and just conditionally compile it to avoid the #ifdefs.

> Just to continue exploring just using the SoC specific options, we would
> currently end up with more of this kind of nastiness:
> 
> #if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) ||      \
> 					defined(CONFIG_ARCH_OMAP3))

Yep, agreed that we don't want that.

> > The other motivation would be to support device manufacturers who only 
> > wish to build a kernel for the single device that they are shipping.  In 
> > terms of kernels shipped, this is probably the most popular use-case. With 
> > something like CONFIG_SOC_OMAPAM33XX, they can avoid building quite a bit 
> > of code and data (and potentially bugs) that are not needed for their 
> > specific device.
> 
> Sure, but I think you're missing the point: This would be in addition
> to the SoC specific options. Do you still see issues with that?

Indeed, I misunderstood your proposal, sorry about that.

Anyway, to me it seems like it would be a little better to have CONFIG_* 
macros that are specific to the IP block in question, only because of the 
SoC grouping problem that I mentioned above.


- Paul
