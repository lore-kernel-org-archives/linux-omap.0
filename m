From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/10] ARM: OMAP2: Remove OMAP_PRM_REGADDR,
 OMAP_CM_REGADDR
Date: Thu, 6 Nov 2008 06:15:44 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811060610160.11718@utopia.booyaka.com>
References: <20081002163508.15385.43247.stgit@localhost.localdomain> <20081002163751.15385.31321.stgit@localhost.localdomain> <20081006161849.GC27466@flint.arm.linux.org.uk> <20081006233954.GD27466@flint.arm.linux.org.uk> <alpine.DEB.2.00.0810070729300.9923@utopia.booyaka.com>
 <20081027205936.GP4283@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38656 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789AbYKFNQG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 08:16:06 -0500
In-Reply-To: <20081027205936.GP4283@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi Russell,

I've been on holiday, hence the delayed E-mail.

On Mon, 27 Oct 2008, Russell King - ARM Linux wrote:

> If I take this further, and detect clocks which result in
> omap2_clk_wait_ready() being called, but we don't have a corresponding
> [if]ck, I see at least these four warnings:
> 
> CLK: omapctrl_ick.0: no other_clk but asked to wait_ready
> CLK: sdrc_ick.0: no other_clk but asked to wait_ready
> CLK: dpll4_m2x2_ck.0: no other_clk but asked to wait_ready
> CLK: omap_32ksync_ick.0: no other_clk but asked to wait_ready
> 
> So, presumably these ick clocks don't have corresponding fck clocks,
> which means checking the fck register for the bit would be wrong?

Yes, that's right.  

> So, here's the question: should any of the above clocks result in
> omap2_wait_clock_ready() being called?  If the answer is no, that's
> great.  If yes, are there missing clk structures for OMAP3?

No, omap2_wait_clock_ready() shouldn't be called for those clocks.  The 
current linux-omap git head does not call omap2_wait_clock_ready() in 
these cases, as far as I know.


- Paul
