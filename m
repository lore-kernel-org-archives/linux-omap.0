From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/10] ARM: OMAP2: Remove OMAP_PRM_REGADDR,
 OMAP_CM_REGADDR
Date: Tue, 7 Oct 2008 08:12:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810070729300.9923@utopia.booyaka.com>
References: <20081002163508.15385.43247.stgit@localhost.localdomain> <20081002163751.15385.31321.stgit@localhost.localdomain> <20081006161849.GC27466@flint.arm.linux.org.uk> <20081006233954.GD27466@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39544 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbYJGOMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 10:12:06 -0400
In-Reply-To: <20081006233954.GD27466@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hello Russell,

On Tue, 7 Oct 2008, Russell King - ARM Linux wrote:

> One thing I've noticed, however, is that there seem to be clocks which
> result in omap2_clk_wait_ready() being called, which checks the "other"
> F or I clock register, but there's no corresponding clock defined in
> the source for that bit.  Eg, iva1_ifck in clock24xx.h.  What does it
> mean?

Bug.  (Harmless, but a bug nonetheless.)  It's fixed in the current 
linux-omap head.  Those patches are scheduled for a future merge window, 
but would be pleased to send those sooner if you like.

The omap2_clk_wait_ready() function is one of the worst legacies of the 
old code.  Code aside, one might reasonably assume that it waits for a 
clock to become ready.  But it actually waits for a device, not a clock, 
to indicate that it is no longer idle.  The practical impact of this is 
that a device will trigger interconnect errors if its registers are 
accessed while it's still idle.  Only a subset of devices can indicate 
readiness.

The plan in the medium term is to move this function to a device layer, 
and call it something like "omap2_device_wait_ready()".  Comments and 
ideas very welcome,


- Paul
