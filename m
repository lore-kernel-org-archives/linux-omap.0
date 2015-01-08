From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 15/21] ARM: exynos4/5: convert pmu wakeup to stacked
 domains
Date: Thu, 8 Jan 2015 10:58:31 -0600
Message-ID: <20150108165831.GB19124@kahuna>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-16-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38192 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757094AbbAHQ70 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jan 2015 11:59:26 -0500
Content-Disposition: inline
In-Reply-To: <1420652576-22309-16-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

On 17:42-20150107, Marc Zyngier wrote:
> Exynos has been (ab)using the gic_arch_extn to provide
> wakeup from suspend, and it makes a lot of sense to convert
> this code to use stacked domains instead.
> 
> This patch does just this, updating the DT files to actually
> reflect what the HW provides.
> 
> BIG FAT WARNING: because the DTs were so far lying by not
> exposing the fact that the PMU block is actually the first
> interrupt controller in the chain for RTC, kernels with this patch
> applied wont have any suspend-resume facility when booted
> with old DTs, and old kernels with updated DTs may not even boot.
> 
> Also, I stronly suspect that there is more than two wake-up
> interrupts on these platforms, but I leave it to the maintainers
> to fix their mess.
> 

minor checkpatch warnings:

+WARNING: line over 80 characters
+#230: FILE: arch/arm/mach-exynos/suspend.c:208:
++	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
+WARNING: line over 80 characters
+#274: FILE: arch/arm/mach-exynos/suspend.c:252:
++#define EXYNOS_PMU_IRQ(symbol,name)	OF_DECLARE_2(irqchip, symbol, name, exynos_pmu_irq_init)
+ERROR: space required after that ',' (ctx:VxV)
+#274: FILE: arch/arm/mach-exynos/suspend.c:252:
++#define EXYNOS_PMU_IRQ(symbol,name)	OF_DECLARE_2(irqchip, symbol, name, exynos_pmu_irq_init)
+                              ^
-- 
Regards,
Nishanth Menon
