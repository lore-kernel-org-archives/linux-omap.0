From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH v4 02/21] irqchip: tegra: add DT-based support for legacy
 interrupt controller
Date: Tue, 20 Jan 2015 09:51:26 +0200
Message-ID: <20150120075126.GA31060@tbergstrom-lnx.Nvidia.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
 <1421660655-21394-3-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2646 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbbATHv5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2015 02:51:57 -0500
Content-Disposition: inline
In-Reply-To: <1421660655-21394-3-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stefan Agner <stefan@agner.ch>

On Mon, Jan 19, 2015 at 09:43:56AM +0000, Marc Zyngier wrote:
> Tegra's LIC (Legacy Interrupt Controller) has been so far only
> supported as a weird extension of the GIC, which is not exactly
> pretty.
> 
> The stacked IRQ domain framework fits this pretty well, and allows
> the LIC code to be turned into a standalone irqchip. In the process,
> make the driver DT aware, something that was sorely missing from
> the mach-tegra implementation.
> 

Note that the GIC isn't really stacked on top of the LIC. Each IRQ is
presented to both the LIC and the GIC (as an SPI). The LIC is only used
to wakeup the CPU in case the GIC is not powered. The LIC can also
generate interrupts towards the AVP/ARM7, but that's outside the scope
of Linux ofcourse. The LIC can also be used to force an IRQ and that
forced IRQ will be propagated to the GIC. (see also figure 2, page 36
of the Tegra K1 TRM)

Cheers,

Peter.

