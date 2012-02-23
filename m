From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 5/5] ARM: OMAP: irqs: Set NR_IRQS to NR_IRQS_LEGACY for CONFIG_SPARSE_IRQ
Date: Thu, 23 Feb 2012 23:23:21 +0100
Message-ID: <1330035801-14937-6-git-send-email-b-cousson@ti.com>
References: <1330035801-14937-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57865 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756089Ab2BWWXu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 17:23:50 -0500
In-Reply-To: <1330035801-14937-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

If CONFIG_SPARSE_IRQ is set, the irqdescs will be allocated with
NR_IRQS entries at boot time and thus will shift all the entries
allocated dynamically by irq_alloc_descs for nothing.

Set NR_IRQS to NR_IRQS_LEGACY if CONFIG_SPARSE_IRQ is set.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/plat-omap/include/plat/irqs.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 3d41a65..acc1ac8 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -438,7 +438,11 @@
 #define OMAP_GPMC_IRQ_END	(OMAP_GPMC_IRQ_BASE + OMAP_GPMC_NR_IRQS)
 
 
+#ifdef CONFIG_SPARSE_IRQ
+#define NR_IRQS			NR_IRQS_LEGACY
+#else
 #define NR_IRQS			OMAP_GPMC_IRQ_END
+#endif
 
 #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
 
-- 
1.7.0.4

