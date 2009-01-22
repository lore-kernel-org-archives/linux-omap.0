From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP1: mcbsp clocks
Date: Thu, 22 Jan 2009 23:55:43 +0000
Message-ID: <20090122235543.GC8137@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51538 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758763AbZAVXzv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 18:55:51 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1LQ9Oj-0008Iz-Ut
	for linux-omap@vger.kernel.org; Thu, 22 Jan 2009 23:55:46 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1LQ9Oi-0004GS-0V
	for linux-omap@vger.kernel.org; Thu, 22 Jan 2009 23:55:44 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

A question about OMAP1 mcbsp clocks.  From what I understand from the
OMAP5912 clock architecture documentation, mcbsp1 and mcbsp3 have two
clocks:

1. interface clock switchable between DSPPER_CK and DSPXOR_CK.
2. a function clock which could be DSPXOR_CK (mcbsp3), and
   CK_DPLL1OUT or MCBS1_CLKS (mcbsp1).

However, the code in mach-omap1/mcbsp.c associates both mcbsp1 and 3
unconditionally with all of: DSP_CK, API_CK and DSPXOR_CK.  As far as
I can see, DSP_CK (for the DSP processor) and API_CK (for system dma)
have nothing to do with mcbsp1,3.

So, the question is why is it this way, and what would be the effect
of correcting this so that both of these mcbsp units are associated
with their proper interface and function clocks?

On a related note, mcbsp2 has its own interface and function clocks,
both tied to ARMPER_CK, which it doesn't even claim.  Again - why
not?

And on that note, can someone explain to me the weird way idle stuff
is handled?  It seems that idle modes are only controlled in one
situation:

1. a clock has CLOCK_NO_IDLE_PARENT set
2. the parent has CLOCK_IDLE_CONTROL set

In other words, to invoke the idle state of a clock, it's _child_ needs
to be manipulated - manipulating the clock itself, even if it has
CLOCK_IDLE_CONTROL, has no effect on the idle states.  Why is this?

(There's also a bunch of clocks which have CLOCK_IDLE_CONTROL set
but which don't have any children, making the idle state for those
clocks effectively unreachable - bug?)
