From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHv3 3/7] ARM: OMAP4 PM: Add IO Daisychain support
Date: Thu, 15 Dec 2011 20:47:19 +0530
Message-ID: <1323962239-6030-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59202 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab1LOP0u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 10:26:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

patch adds IO Daisychain support for OMAP4 as per section 3.9.4 in OMAP4430
Public TRM.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Tested-by: Govindraj.R <govindraj.raja@ti.com>
---
Changes done in V3:
1. Moved enablement of Global WUEN which is a onetime setting to pm_init
   so that there is no check inside omap4_trigger_wuclk_ctrl
2. Fixed an issue while reading WUCLK_STATUS inside omap4_trigger_wuclk_ctrl

Updated branch is available at:
git://gitorious.org/omap-pm/linux.git for_3.3/io_daisy_chain_rebased

 arch/arm/mach-omap2/pm44xx.c  |    8 ++++++++
 arch/arm/mach-omap2/prm44xx.c |   25 +++++++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.h |    1 +
 3 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 8edb015..a7cd8db
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -18,6 +18,8 @@
 
 #include "common.h"
 #include "powerdomain.h"
+#include "prm44xx.h"
+#include "prm-regbits-44xx.h"
 
 struct power_state {
 	struct powerdomain *pwrdm;
@@ -111,6 +113,12 @@ static int __init omap4_pm_init(void)
 		goto err2;
 	}
 
+	/* Enable GLOBAL_WUEN */
+	omap4_prm_rmw_inst_reg_bits(OMAP4430_GLOBAL_WUEN_MASK,
+			OMAP4430_GLOBAL_WUEN_MASK, OMAP4430_PRM_DEVICE_INST,
+			OMAP4_PRM_IO_PMCTRL_OFFSET);
+
+
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 67d8d74..da97851
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -142,3 +142,28 @@ static int __init omap4xxx_prcm_init(void)
 		return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
 	return 0;
 }
+
+/**
+ * Maximum time(us) it takes to output the signal WUCLKOUT of the last pad of
+ * the I/O ring after asserting WUCLKIN high
+ */
+#define MAX_IOPAD_LATCH_TIME 1000
+
+/* OMAP4 IO Daisychain trigger sequence */
+void omap4_trigger_wuclk_ctrl(void)
+{
+	int i = 0;
+
+	/* Trigger WUCLKIN enable */
+	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, OMAP4430_WUCLK_CTRL_MASK,
+			OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET);
+	omap_test_timeout(
+		(((omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET) &
+		OMAP4430_WUCLK_STATUS_MASK) >> OMAP4430_WUCLK_STATUS_SHIFT) == 1),
+		MAX_IOPAD_LATCH_TIME, i);
+
+	/* Trigger WUCLKIN disable */
+	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, 0x0,
+			OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET);
+	return;
+}
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 3d66ccd..a8678db 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -750,6 +750,7 @@
 extern u32 omap4_prm_read_inst_reg(s16 inst, u16 idx);
 extern void omap4_prm_write_inst_reg(u32 val, s16 inst, u16 idx);
 extern u32 omap4_prm_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
+extern void omap4_trigger_wuclk_ctrl(void);
 
 /* OMAP4-specific VP functions */
 u32 omap4_prm_vp_check_txdone(u8 vp_id);
-- 
1.7.0.4

