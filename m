From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/10] ARM: OMAP2: Remove OMAP_PRM_REGADDR, OMAP_CM_REGADDR
Date: Tue, 7 Oct 2008 00:39:54 +0100
Message-ID: <20081006233954.GD27466@flint.arm.linux.org.uk>
References: <20081002163508.15385.43247.stgit@localhost.localdomain> <20081002163751.15385.31321.stgit@localhost.localdomain> <20081006161849.GC27466@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43558 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbYJFXkJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 19:40:09 -0400
Content-Disposition: inline
In-Reply-To: <20081006161849.GC27466@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Mon, Oct 06, 2008 at 05:18:49PM +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 02, 2008 at 10:37:52AM -0600, Paul Walmsley wrote:
> > From: Tony Lindgren <tony@atomide.com>
> > 
> > Remove OMAP_PRM_REGADDR and OMAP_CM_REGADDR.  Use
> > prm_read/write_mod_reg() or cm_read/write_mod_reg() instead.  For
> > assembly, use OMAPXXXX_PRM_REGADDR or OMAPXXXX_CM_REGADDR macros.
> 
> I do have concerns about this patch as well - hating those casts
> that are required to store an offset in 'enable_reg', which then
> have to be un-casted to add the correct base address.
> 
> I've been trying to work out if there's a better way to do this
> using the existing structures.  How about:

I've modified this idea slightly, since using a mask instead of bit
numbers makes it possible to remove more special casing... and I also
have a perl script to convert the clock definitions.

One thing I've noticed, however, is that there seem to be clocks which
result in omap2_clk_wait_ready() being called, which checks the "other"
F or I clock register, but there's no corresponding clock defined in
the source for that bit.  Eg, iva1_ifck in clock24xx.h.  What does it
mean?
