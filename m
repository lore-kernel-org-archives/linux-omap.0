From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 14/21] ARM: imx6: convert GPC to stacked domains
Date: Thu, 8 Jan 2015 10:57:17 -0600
Message-ID: <20150108165717.GA19124@kahuna>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-15-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55788 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756934AbbAHQ6I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jan 2015 11:58:08 -0500
Content-Disposition: inline
In-Reply-To: <1420652576-22309-15-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

On 17:42-20150107, Marc Zyngier wrote:
> IMX6 has been (ab)using the gic_arch_extn to provide
> wakeup from suspend, and it makes a lot of sense to convert
> this code to use stacked domains instead.
> 
> This patch does just this, updating the DT files to actually
> reflect what the HW provides.
> 
minor checkpatch warnings below:

@@ -0,0 +1,14 @@
+CHECK: Alignment should match open parenthesis
+#249: FILE: arch/arm/mach-imx/gpc.c:158:
++static int imx_gpc_domain_alloc(struct irq_domain *domain,
++				  unsigned int virq,
+WARNING: line over 80 characters
+#272: FILE: arch/arm/mach-imx/gpc.c:181:
++	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
+ERROR: code indent should use tabs where possible
+#305: FILE: arch/arm/mach-imx/gpc.c:209:
++^I        return -ENOMEM;$
+NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
+      scripts/cleanfile
-- 
Regards,
Nishanth Menon
