From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 13/21] ARM: omap: convert wakeupgen to stacked domains
Date: Wed, 14 Jan 2015 14:28:14 -0800
Message-ID: <20150114222814.GU2419@atomide.com>
References: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
 <1421087187-26988-14-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40091 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbbANWcT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2015 17:32:19 -0500
Content-Disposition: inline
In-Reply-To: <1421087187-26988-14-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

* Marc Zyngier <marc.zyngier@arm.com> [150112 10:30]:
> OMAP4/5 has been (ab)using the gic_arch_extn to provide
> wakeup from suspend, and it makes a lot of sense to convert
> this code to use stacked domains instead.
> 
> This patch does just this, updating the DT files to actually
> reflect what the HW provides.
> 
> BIG FAT WARNING: because the DTs were so far lying by not
> exposing the WUGEN HW block, kernels with this patch applied
> won't have any suspend-resume facility when booted with old DTs,
> and old kernels with updated DTs won't even boot.
> 
> On a platform with this patch applied, the system looks like
> this:
> 
> root@bacon-fat:~# cat /proc/interrupts
>             CPU0       CPU1
>  16:          0          0     WUGEN  37  gp_timer
>  19:     233799     155916       GIC  27  arch_timer
>  23:          0          0     WUGEN   9  l3-dbg-irq
>  24:          1          0     WUGEN  10  l3-app-irq
>  27:        282          0     WUGEN  13  omap-dma-engine
>  44:          0          0  4ae10000.gpio  13  DMA

FYI, the legacy irq numbers are now all wrong since commit
9a1091ef0017 ("irqchip: gic: Support hierarchy irq domain.").

Started a separate thread "Regression with legacy IRQ numbers
caused by 9a1091ef0017" on it, will give these a try once
that's sorted out.

Regards,

Tony
