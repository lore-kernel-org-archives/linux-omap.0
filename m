From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP3 kernels fail to build
Date: Mon, 8 Aug 2011 12:00:56 +0100
Message-ID: <20110808110056.GA15134@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38472 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab1HHLBL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Aug 2011 07:01:11 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>

With CONFIG_ARCH_OMAP3=y and CONFIG_ARCH_OMAP4=n, I'm getting this:

arch/arm/mach-omap2/built-in.o:(.data+0xf99c): undefined reference to `omap4430_phy_init'
arch/arm/mach-omap2/built-in.o:(.data+0xf9a0): undefined reference to `omap4430_phy_exit'
arch/arm/mach-omap2/built-in.o:(.data+0xf9a4): undefined reference to `omap4430_phy_power'
arch/arm/mach-omap2/built-in.o:(.data+0xf9a8): undefined reference to `omap4430_phy_set_clk'
arch/arm/mach-omap2/built-in.o:(.data+0xf9ac): undefined reference to `omap4430_phy_suspend'

This is probably from twl-common.c, which doesn't really look very
common to me (looks like some is specific to OMAP3 and the rest is
OMAP4 specific.)

As this is always built for all OMAP2+, this will also break OMAP2 as
well.  Why it's even built on OMAP2, I've no idea.

I think the OMAP3 specific bits should be separate from the OMAP4
specific bits, which should be separate from the small amount of
common stuff.

Please either fix ASAP, or revert the five changes for twl-common.c
