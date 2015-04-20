From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Fscking OMAP
Date: Mon, 20 Apr 2015 17:04:00 +0100
Message-ID: <20150420160400.GX4027@n2100.arm.linux.org.uk>
References: <20150420154912.GW4027@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42152 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbbDTQEJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2015 12:04:09 -0400
Content-Disposition: inline
In-Reply-To: <20150420154912.GW4027@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Mon, Apr 20, 2015 at 04:49:13PM +0100, Russell King - ARM Linux wrote:
> Guys,
> 
> If you're going to introduce a dependency on some infrastructure which
> you absolutely require for booting, then _please_ ensure that the
> configuration system is updated such that pre-existing kernel
> configurations continue to work.
> 
> Don't leave it such that the infrastructure ends up returning -ENOSYS,
> which then filters down into your SoC specific code, and aborts the
> initialisation of critical infrastructure, leaving you with a totally
> silent boot failure.
> 
> In this case, it's the addition of syscon to OMAP internals,
> specifically in omap_control_init().
> 
> This is explicitly targetted at OMAP people, who have wasted much of
> my day today investigating why their platforms no longer boot in DT
> mode.

Let's be clear about how this needs to be fixed:

1. OMAP must select MFD_SYSCON in its Kconfig when DT is enabled, since
   OMAP silently fails to boot when this symbol is not enabled.

2. omap_clk_init() really needs to have some diagnostic printk()s in
   it to indicate when something like omap_control_init() fails.

3. omap_clk_init() probably should _not_ return immediately when one
   of the children (such as omap_control_init) fails to initialise, as
   omitting the clocks pretty much ensures that the kernel will BUG()
   a few moments later in the timer code.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
