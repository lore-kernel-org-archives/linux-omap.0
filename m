From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/5] ARM: gic: Add distributor and interface enable/disable accessory api
Date: Mon, 24 Jan 2011 14:21:16 +0530
Message-ID: <1295859080-15259-3-git-send-email-santosh.shilimkar@ti.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38256 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350Ab1AXIvu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 03:51:50 -0500
In-Reply-To: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, ccross@android.com, catalin.marinas@arm.com, linux@arm.linux.org.uk, linus.ml.walleij@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

The power management code needs to have access to enable/disable the
gic cpu interface and distributor based on targetted low power
states.

This patch adds and exports one API each for distributor and cpu
interface enable/disable.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/gic.c               |   24 ++++++++++++++++++++++++
 arch/arm/include/asm/hardware/gic.h |    2 ++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index b4a9ea7..6384bb7 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -369,6 +369,30 @@ void __cpuinit gic_enable_ppi(unsigned int irq)
 	local_irq_restore(flags);
 }
 
+/* Used in power management paths */
+void gic_secondary_set(unsigned int gic_nr, unsigned int on)
+{
+	BUG_ON(gic_nr >= MAX_GIC_NR);
+
+	if (on) {
+		__raw_writel(0xf0, gic_data[gic_nr].cpu_base + GIC_CPU_PRIMASK);
+		__raw_writel(1, gic_data[gic_nr].cpu_base + GIC_CPU_CTRL);
+
+	} else {
+		__raw_writel(0, gic_data[gic_nr].cpu_base + GIC_CPU_CTRL);
+	}
+}
+
+void gic_dist_set(unsigned int gic_nr, unsigned int on)
+{
+	BUG_ON(gic_nr >= MAX_GIC_NR);
+
+	if (on)
+		__raw_writel(0x1, gic_data[gic_nr].dist_base + GIC_DIST_CTRL);
+	else
+		__raw_writel(0, gic_data[gic_nr].cpu_base + GIC_CPU_CTRL);
+}
+
 #ifdef CONFIG_SMP
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 0691f9d..638d9dc 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -41,6 +41,8 @@ void gic_secondary_init(unsigned int);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
 void gic_enable_ppi(unsigned int);
+void gic_secondary_set(unsigned int gic_nr, unsigned int on);
+void gic_dist_set(unsigned int gic_nr, unsigned int on);
 #endif
 
 #endif
-- 
1.6.0.4

