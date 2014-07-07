From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power
	control setting
Date: Mon, 7 Jul 2014 13:15:13 +0100
Message-ID: <20140707121512.GT3705@n2100.arm.linux.org.uk>
References: <3c3a7a4861df01d0163787a9c18f7b7ac821c5b9.1403000372.git.nsekhar@ti.com> <20140617131935.GB9070@saruman.home> <20140701194704.GG13396@saruman.home> <20140702081142.GU28884@atomide.com> <20140707104727.GM28884@atomide.com> <20140707104944.GS3705@n2100.arm.linux.org.uk> <20140707110249.GO28884@atomide.com> <53BA8983.3030803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:57420 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752984AbaGGMPW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 08:15:22 -0400
Content-Disposition: inline
In-Reply-To: <53BA8983.3030803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Mon, Jul 07, 2014 at 05:20:27PM +0530, Sekhar Nori wrote:
> OMAP4430 had L2 cache controller version r2p0 (per the public TRM) which
> does not have this register. So unless there is a ROM API that was
> introduced after OMAP4430, this would not be there even for other
> OMAP4s. Public TRM of OMAP4470 does not indicate an API for this.
> 
> Before creating the patch, I checked with ROM team handling AM437x and
> they denied an API to write to this register was present in AM437x ROM.

Okay, so why are we trying to write to this register then...

Ah, we have a bug in cache-l2x0.c:

#define L2X0_CACHE_ID_PART_MASK         (0xf << 6)
#define L2X0_CACHE_ID_RTL_MASK          0x3f
#define L310_CACHE_ID_RTL_R3P0          0x05

        unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_PART_MASK;

        if (rev >= L310_CACHE_ID_RTL_R2P0) {
...
        if (rev >= L310_CACHE_ID_RTL_R3P0) {
                l2c_write_sec(L310_DYNAMIC_CLK_GATING_EN | L310_STNDBY_MODE_EN,
                              base, L310_POWER_CTRL);

So, because we're masking the wrong bits, we end up with these tests
always succeeding.

So that's a NACK for the original patch, it's the wrong fix.  The
right fix is to avoid writing this register by fixing the RTL masking.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
