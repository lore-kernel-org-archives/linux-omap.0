From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP4: Fix array size for irq_target_cpu
Date: Tue, 4 Sep 2012 17:03:09 -0700
Message-ID: <20120905000309.GW1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55858 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab2IEADM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 20:03:12 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

If NR_IRQS is less than MAX_IRQS, we end up writing past the
irq_target_cpu array in omap_wakeupgen_init():

/* Associate all the IRQs to boot CPU like GIC init does. */
for (i = 0; i < max_irqs; i++)
	irq_target_cpu[i] = boot_cpu;

This can happen if SPARSE_IRQ is enabled as by default NR_IRQS is
set to 16. Without this patch we're overwriting other data during
the boot.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -47,7 +47,7 @@
 static void __iomem *wakeupgen_base;
 static void __iomem *sar_base;
 static DEFINE_SPINLOCK(wakeupgen_lock);
-static unsigned int irq_target_cpu[NR_IRQS];
+static unsigned int irq_target_cpu[MAX_IRQS];
 static unsigned int irq_banks = MAX_NR_REG_BANKS;
 static unsigned int max_irqs = MAX_IRQS;
 static unsigned int omap_secure_apis;
