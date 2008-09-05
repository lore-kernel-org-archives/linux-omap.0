From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP3 clock: camera module has no target IDLEST bit
Date: Fri, 5 Sep 2008 23:37:26 +0100
Message-ID: <20080905223725.GD17156@flint.arm.linux.org.uk>
References: <alpine.DEB.1.00.0809051332380.32223@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33125 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbYIEWhh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 18:37:37 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0809051332380.32223@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, saaguirre@ti.com

On Fri, Sep 05, 2008 at 01:34:03PM -0600, Paul Walmsley wrote:
> We must not attempt to wait for the CAM module to become ready after
> clock enable, since it has no target IDLEST bit.

Grrr.  These things seem to be collecting here, and in need of a
more generic and elegant solution.  (Please always do that rather
than extending an already existing hack.)

In mainline, I see a bunch of exclusions in omap2_clk_wait_ready()
for OMAP24xx and OMAP34xx.

Your struct clk has a 'flags' field.  Currently, bits 13 to 20 are
free.  Enough room to fit into it two extra bits - a "don't wait for
OMAP24xx" and "don't wait for OMAP34xx" bits.

They can then be used thusly:

	if (cpu_is_omap24xx() && clk->flags & CLK_NOWAIT_24XX)
		return;
	if (cpu_is_omap34xx() && clk->flags & CLK_NOWAIT_34XX)
		return;

rather than throwing individual exceptions into clock.c.  Such a
solution is far more elegant, easier to review, and likely to be
far smaller in the long run - both in terms of lines of change and
code size.
