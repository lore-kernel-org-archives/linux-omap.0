From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/10] ARM: OMAP2: Remove OMAP_PRM_REGADDR, OMAP_CM_REGADDR
Date: Mon, 27 Oct 2008 20:59:36 +0000
Message-ID: <20081027205936.GP4283@flint.arm.linux.org.uk>
References: <20081002163508.15385.43247.stgit@localhost.localdomain> <20081002163751.15385.31321.stgit@localhost.localdomain> <20081006161849.GC27466@flint.arm.linux.org.uk> <20081006233954.GD27466@flint.arm.linux.org.uk> <alpine.DEB.2.00.0810070729300.9923@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56292 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbYJ0VA1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Oct 2008 17:00:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0810070729300.9923@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Tue, Oct 07, 2008 at 08:12:11AM -0600, Paul Walmsley wrote:
> Hello Russell,
> 
> On Tue, 7 Oct 2008, Russell King - ARM Linux wrote:
> 
> > One thing I've noticed, however, is that there seem to be clocks which
> > result in omap2_clk_wait_ready() being called, which checks the "other"
> > F or I clock register, but there's no corresponding clock defined in
> > the source for that bit.  Eg, iva1_ifck in clock24xx.h.  What does it
> > mean?
> 
> Bug.  (Harmless, but a bug nonetheless.)  It's fixed in the current 
> linux-omap head.  Those patches are scheduled for a future merge window, 
> but would be pleased to send those sooner if you like.

Right, now that I have one of my OMAP3 platforms sort-of up and running,
I can start checking out some ideas.

I've taken the easy way out of modifying all the struct clk structures for
the time being, and thrown some code at initialization time to take the
information already there and manipulate it to the new structure.  This
includes working out the associations between the 'ick' and 'fck' clocks.

On OMAP3430 ES2.2, 2.6.28-rc2, I tripped over these:

CLK: no clock to associate dpll3_m3x2_ck.0 with
CLK: no clock to associate dpll4_m2x2_ck.0 with
CLK: no clock to associate dpll4_m3x2_ck.0 with
CLK: no clock to associate dpll4_m4x2_ck.0 with
CLK: no clock to associate dpll4_m5x2_ck.0 with
CLK: no clock to associate dpll4_m6x2_ck.0 with
CLK: no clock to associate iva2_ck.0 with
CLK: no clock to associate hsotgusb_ick.0 with
CLK: no clock to associate sdrc_ick.0 with
CLK: no clock to associate pka_ick.0 with
CLK: no clock to associate icr_ick.0 with
CLK: no clock to associate aes2_ick.0 with
CLK: no clock to associate sha12_ick.0 with
CLK: no clock to associate des2_ick.0 with
CLK: no clock to associate mailboxes_ick.0 with
CLK: no clock to associate omapctrl_ick.0 with
CLK: no clock to associate aes1_ick.0 with
CLK: no clock to associate rng_ick.0 with
CLK: no clock to associate sha11_ick.0 with
CLK: no clock to associate usbhost_120m_fck.0 with
CLK: no clock to associate wdt1_ick.0 with
CLK: no clock to associate omap_32ksync_ick.0 with
CLK: no clock to associate gpt12_ick.0 with
CLK: no clock to associate sr1_fck.0 with
CLK: no clock to associate sr2_fck.0 with

which all don't have a corresponding clock for their "other" [if]ck.

If I take this further, and detect clocks which result in
omap2_clk_wait_ready() being called, but we don't have a corresponding
[if]ck, I see at least these four warnings:

CLK: omapctrl_ick.0: no other_clk but asked to wait_ready
CLK: sdrc_ick.0: no other_clk but asked to wait_ready
CLK: dpll4_m2x2_ck.0: no other_clk but asked to wait_ready
CLK: omap_32ksync_ick.0: no other_clk but asked to wait_ready

So, presumably these ick clocks don't have corresponding fck clocks,
which means checking the fck register for the bit would be wrong?

So, here's the question: should any of the above clocks result in
omap2_wait_clock_ready() being called?  If the answer is no, that's
great.  If yes, are there missing clk structures for OMAP3?
