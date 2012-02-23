From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 3/5] ARM: OMAP2+: wakeupgen: Fix wrong array size for irq_target_cpu
Date: Thu, 23 Feb 2012 23:23:19 +0100
Message-ID: <1330035801-14937-4-git-send-email-b-cousson@ti.com>
References: <1330035801-14937-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54066 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756067Ab2BWWXt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 17:23:49 -0500
In-Reply-To: <1330035801-14937-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

The wakeupgen was wrongly allocating an array based on the
NR_IRQS value (410 on OMAP4) whereas it is just capable of handling 128
entries.
Moreover with SPARSE_IRQ, the NR_IRQS number might be 16, and thus
cannot handle the proper number of entries. It will generate an oops as
soon a driver will request an IRQ > 16.

Allocate the array using the fixed MAX_IRQS value (128).

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index d3d8971..bec55e1 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -45,7 +45,7 @@ static void __iomem *wakeupgen_base;
 static void __iomem *sar_base;
 static DEFINE_PER_CPU(u32 [NR_REG_BANKS], irqmasks);
 static DEFINE_SPINLOCK(wakeupgen_lock);
-static unsigned int irq_target_cpu[NR_IRQS];
+static unsigned int irq_target_cpu[MAX_IRQS];
 
 /*
  * Static helper functions.
@@ -379,7 +379,7 @@ int __init omap_wakeupgen_init(void)
 	 */
 
 	/* Associate all the IRQs to boot CPU like GIC init does. */
-	for (i = 0; i < NR_IRQS; i++)
+	for (i = 0; i < MAX_IRQS; i++)
 		irq_target_cpu[i] = boot_cpu;
 
 	irq_hotplug_init();
-- 
1.7.0.4

