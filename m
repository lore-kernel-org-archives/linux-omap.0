From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: Add __arm_ioremap_exec for mapping external
 memory as MT_MEMORY
Date: Fri, 7 Oct 2011 07:43:49 -0700
Message-ID: <20111007144349.GE6324@atomide.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
 <20111005004539.26980.52409.stgit@kaulin.local>
 <alpine.LFD.2.02.1110042059110.9106@xanadu.home>
 <20111005220619.GC6324@atomide.com>
 <4E8E9EE8.8010106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34163 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752672Ab1JGOn4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 10:43:56 -0400
Content-Disposition: inline
In-Reply-To: <4E8E9EE8.8010106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111006 23:06]:
> On Thursday 06 October 2011 03:36 AM, Tony Lindgren wrote:
> > * Nicolas Pitre <nico@fluxnic.net> [111004 17:26]:
> >> On Tue, 4 Oct 2011, Tony Lindgren wrote:
> > +void __iomem *
> > +__arm_ioremap_exec(unsigned long phys_addr, size_t size, int cached)
> > +{
> > +	unsigned int mtype;
> > +
> > +	if (cached)
> > +		mtype = MT_MEMORY;
> > +	else
> > +		mtype = MT_MEMORY_NONCACHED;
> > +
> Why don't we allow user to pass the mtype here ?

Well we want to keep the MT_MEMORY types out of asm/io.h.

> We do have a need also to map a page of DDR and SRAM as
> strongly ordered for errata fix and this interface can be
> used for that.

Yeah..

> Ofcourse, SO memory type is not executable memories, so the
> API name might be miss-leading.

..so I think we should just have a separate static mapping for
the omap4 errata fix SO page, and just limit the memory available
for SRAM code to ioremap.

How does that sounds to you?

Tony
