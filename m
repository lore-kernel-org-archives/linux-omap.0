From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/14] ARM: bitops: ensure set/clear/change bitops take
	a word-aligned pointer
Date: Tue, 18 Jan 2011 14:30:33 +0000
Message-ID: <20110118143033.GD10997@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1Peudk-0003SJ-Aj@rmk-PC.arm.linux.org.uk> <alpine.LFD.2.00.1101180043140.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36224 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab1AROap (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 09:30:45 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101180043140.8580@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Jan 18, 2011 at 01:00:21AM -0500, Nicolas Pitre wrote:
> I also wonder what happens with a misaligned ldrex/strex... Does the 
> alignment trap get invoked?  If so, the assertion could be put there 
> instead if that's not done already, removing this overhead from bitops 
> calls.  In the pre-ARMv6 case the alignment trap fixup would be applied 
> as usual since the ldr/str are not special, but the previous code 
> allowed for misaligned pointer so result would be no worse than before 
> in that case.  Testing appears to indicate those misaligned bitops are 
> rather nonexistent so far.

Well, whether LDREX/STREX always fault for misalignment is well open to
debate.  The ARM ARM for ARMv7 seems to imply they will always fault for
misaligned accesses.  For ARMv6, the situation is less clear - the way
the manual is arranged, it suggests that they will if SCTLR.U is set.
When it's clear, the ARM ARM doesn't specify what the outcome is.

I also don't know how our unaligned fixup will behave with an unaligned
LDREX/STREX without checking the bit patterns.

So... I think that's too many unknowns to rely on it, especially when
filesystem data is at stake.

Maybe changing it to:

	ands	ip, r1, #3
	strneb	r1, [ip]

instead?
