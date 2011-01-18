From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 01/14] ARM: bitops: ensure set/clear/change bitops take a
 word-aligned pointer
Date: Tue, 18 Jan 2011 13:20:52 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101181312360.8580@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1Peudk-0003SJ-Aj@rmk-PC.arm.linux.org.uk>
 <alpine.LFD.2.00.1101180043140.8580@xanadu.home>
 <20110118143033.GD10997@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:52813 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab1ARSVV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 13:21:21 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LF800FJ7DM8FWE0@vl-mh-mrz21.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 18 Jan 2011 13:20:32 -0500 (EST)
In-reply-to: <20110118143033.GD10997@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, 18 Jan 2011, Russell King - ARM Linux wrote:

> On Tue, Jan 18, 2011 at 01:00:21AM -0500, Nicolas Pitre wrote:
> > I also wonder what happens with a misaligned ldrex/strex... Does the 
> > alignment trap get invoked?  If so, the assertion could be put there 
> > instead if that's not done already, removing this overhead from bitops 
> > calls.  In the pre-ARMv6 case the alignment trap fixup would be applied 
> > as usual since the ldr/str are not special, but the previous code 
> > allowed for misaligned pointer so result would be no worse than before 
> > in that case.  Testing appears to indicate those misaligned bitops are 
> > rather nonexistent so far.
> 
> Well, whether LDREX/STREX always fault for misalignment is well open to
> debate.  The ARM ARM for ARMv7 seems to imply they will always fault for
> misaligned accesses.  For ARMv6, the situation is less clear - the way
> the manual is arranged, it suggests that they will if SCTLR.U is set.
> When it's clear, the ARM ARM doesn't specify what the outcome is.

Probably we should make sure they always fault on both ARMv6 and ARMv7 
regardless of this particular issue.

> I also don't know how our unaligned fixup will behave with an unaligned
> LDREX/STREX without checking the bit patterns.

Making ldrex/strex always fault means that we also need to make the 
alignment fixup code produce a SIGBUS, or panic the kernel if in atomic 
context.

> So... I think that's too many unknowns to rely on it, especially when
> filesystem data is at stake.
> 
> Maybe changing it to:
> 
> 	ands	ip, r1, #3
> 	strneb	r1, [ip]
> 
> instead?

Sure.  That would solve the T2 issue.  Eventually we could revisit the 
need for this assertion here once the above is done.


Nicolas
