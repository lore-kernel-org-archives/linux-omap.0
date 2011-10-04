From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 2/4] ARM: OMAP4 PM: Add IO Daisychain support
Date: Tue, 4 Oct 2011 23:22:02 +0530
Message-ID: <1317750724-32553-3-git-send-email-vishwanath.bs@ti.com>
References: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58503 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933287Ab1JDR7L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Oct 2011 13:59:11 -0400
In-Reply-To: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

patch adds IO Daisychain support for OMAP4 as per section 3.9.4 in OMAP4430
Public TRM.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/pm.h     |    1 +
 arch/arm/mach-omap2/pm44xx.c |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 9a36a7c..2e09d72 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -22,6 +22,7 @@ extern int omap3_can_sleep(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
 extern void omap3_enable_io_chain(void);
+extern void omap4_trigger_wuclk_ctrl(void);
 
 #if defined(CONFIG_PM_OPP)
 extern int omap3_opp_init(void);
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 59a870b..aa7cff4 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -16,8 +16,17 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
+#include <plat/common.h>
+
 #include "powerdomain.h"
 #include <mach/omap4-common.h>
+#include "pm.h"
+#include "cm-regbits-44xx.h"
+#include "cminst44xx.h"
+#include "prm-regbits-44xx.h"
+#include "prcm44xx.h"
+#include "prm44xx.h"
+#include "prminst44xx.h"
 
 struct power_state {
 	struct powerdomain *pwrdm;
@@ -30,6 +39,33 @@ struct power_state {
 
 static LIST_HEAD(pwrst_list);
 
+#define MAX_IOPAD_LATCH_TIME 1000
+
+void omap4_trigger_wuclk_ctrl(void)
+{
+	int i = 0;
+
+	/* Enable GLOBAL_WUEN */
+	if (!omap4_cminst_read_inst_reg_bits(OMAP4430_PRM_PARTITION,
+			OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET,
+			OMAP4430_GLOBAL_WUEN_MASK))
+		omap4_prminst_rmw_inst_reg_bits(OMAP4430_GLOBAL_WUEN_MASK,
+			OMAP4430_GLOBAL_WUEN_MASK, OMAP4430_PRM_PARTITION,
+			OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET);
+
+	/* Trigger WUCLKIN enable */
+	omap4_prminst_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, OMAP4430_WUCLK_CTRL_MASK,
+		OMAP4430_PRM_PARTITION, OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET);
+	omap_test_timeout(
+		((omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION, OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET)
+		>> OMAP4430_WUCLK_STATUS_SHIFT) == 1),
+		MAX_IOPAD_LATCH_TIME, i);
+	/* Trigger WUCLKIN disable */
+	omap4_prminst_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, 0x0,
+		OMAP4430_PRM_PARTITION, OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET);
+	return;
+}
+
 #ifdef CONFIG_SUSPEND
 static int omap4_pm_suspend(void)
 {
-- 
1.7.0.4

