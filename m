From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: [PATCH] ARM: OMAP: irqs: Fix NR_IRQS value to handle PRCM interrupts
Date: Tue, 28 Feb 2012 14:10:09 +0100
Message-ID: <4F4CD231.4030709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43701 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755950Ab2B1NKX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 08:10:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>

The following commit: 2f31b51659c2d8315ea2888ba5b93076febe672b
Author: Tero Kristo <t-kristo@ti.com>
Date:   Fri Dec 16 14:37:00 2011 -0700

    ARM: OMAP4: PRM: use PRCM interrupt handler

introduced the PRCM interrupt handler and thus the need
for 64 more interrupts. Since SPARSE_IRQ is still not fully
functional on OMAP, the NR_IRQS needs to be updated to avoid
the failure that happen during irq_alloc_descs call inside
the PRCM driver:

[    0.208221] PRCM: failed to allocate irq descs: -12

Later the mux framework is then unable to request an IRQ from
the PRCM interrupt handler.

[    1.802795] mux: Failed to setup hwmod io irq -22

Fix that by adding 64 more interrupts for OMAP2PLUS config.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
---
Tony,

This patch should probably go for the next -rc if possible.

Thanks,
Benoit

 arch/arm/plat-omap/include/plat/irqs.h |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 2efd645..37bbbbb 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -428,8 +428,16 @@
 #define OMAP_GPMC_NR_IRQS	8
 #define OMAP_GPMC_IRQ_END	(OMAP_GPMC_IRQ_BASE + OMAP_GPMC_NR_IRQS)
 
+/* PRCM IRQ handler */
+#ifdef CONFIG_ARCH_OMAP2PLUS
+#define OMAP_PRCM_IRQ_BASE	(OMAP_GPMC_IRQ_END)
+#define OMAP_PRCM_NR_IRQS	64
+#define OMAP_PRCM_IRQ_END	(OMAP_PRCM_IRQ_BASE + OMAP_PRCM_NR_IRQS)
+#else
+#define OMAP_PRCM_IRQ_END	OMAP_GPMC_IRQ_END
+#endif
 
-#define NR_IRQS			OMAP_GPMC_IRQ_END
+#define NR_IRQS			OMAP_PRCM_IRQ_END
 
 #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
 
-- 
1.7.0.4

