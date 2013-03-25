From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 06/18] ARM: OMAP5: PM: Enable Mercury retention mode on CPUx powerdomains
Date: Mon, 25 Mar 2013 15:34:58 +0530
Message-ID: <1364205910-32392-7-git-send-email-santosh.shilimkar@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35755 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab3CYKD4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Mar 2013 06:03:56 -0400
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

In addition to the standard power-management technique, the OMAP5
MPU subsystem also employs an SR3-APG (mercury) power management
technology to reduce leakage.

It allows for full logic and memories retention on MPU_C0 and MPU_C1 and
is controlled by the PRCM_MPU.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index b1441b1..d390d18 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -62,6 +62,10 @@
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
 
+/* Add defines needed for mercury mode. Refer MPU's PRM_PSCON_COUNT */
+#define PRM_PSCON_HG_EN		(1 << 24)
+#define PRM_PSCON_HG_RAMPUP	(1 << 25)
+
 #ifdef CONFIG_SMP
 
 struct omap4_cpu_pm_info {
@@ -337,6 +341,28 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 	return 0;
 }
 
+/**
+ * enable_mercury_retention_mode: Enable OMAP5 mercury retention feature
+ *
+ * OMAP5 devices supports  SR3-APG (mercury) power management technology to
+ * reduce leakage. It allows for full logic and memories retention on
+ * MPU_C0 and MPU_C1 and is controlled by the PRCM_MPU. The function enable
+ * the mercury retention feature.
+ */
+static void enable_mercury_retention_mode(void)
+{
+	u32 reg;
+
+	/*
+	 * To enable mercury mode, both HG_EN and HG_RAMPUP needs to be
+	 * enabled from PRM_PSCON_COUNT register.
+	 */
+	reg = omap4_prcm_mpu_read_inst_reg(OMAP54XX_PRCM_MPU_DEVICE_INST,
+			OMAP54XX_PRCM_MPU_PRM_PSCON_COUNT_OFFSET);
+	reg |= PRM_PSCON_HG_EN | PRM_PSCON_HG_RAMPUP;
+	omap4_prcm_mpu_write_inst_reg(reg, OMAP54XX_PRCM_MPU_DEVICE_INST,
+			OMAP54XX_PRCM_MPU_PRM_PSCON_COUNT_OFFSET);
+}
 
 /*
  * Initialise OMAP4 MPUSS
@@ -415,6 +441,7 @@ int __init omap4_mpuss_init(void)
 		cpu_context_offset = OMAP4_RM_CPU0_CPU0_CONTEXT_OFFSET;
 	} else if (soc_is_omap54xx()) {
 		cpu_context_offset = OMAP54XX_RM_CPU0_CPU0_CONTEXT_OFFSET;
+		enable_mercury_retention_mode();
 	}
 
 	return 0;
-- 
1.7.9.5

