From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHv2 3/7] ARM: OMAP4 PM: Add IO Daisychain support
Date: Fri, 7 Oct 2011 23:17:47 +0530
Message-ID: <1318009671-12813-4-git-send-email-vishwanath.bs@ti.com>
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43418 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754483Ab1JGRzN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Oct 2011 13:55:13 -0400
In-Reply-To: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

patch adds IO Daisychain support for OMAP4 as per section 3.9.4 in OMAP4430
Public TRM.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c |   33 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.h |    1 +
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 0016555..7e19678 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -23,6 +23,8 @@
 
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
+#include "prcm44xx.h"
+#include "prminst44xx.h"
 
 /* PRM low-level functions */
 
@@ -50,3 +52,34 @@ u32 omap4_prm_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 reg)
 
 	return v;
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
+	/* Enable GLOBAL_WUEN */
+	if (!(omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET)
+				& OMAP4430_GLOBAL_WUEN_MASK))
+		omap4_prm_rmw_inst_reg_bits(OMAP4430_GLOBAL_WUEN_MASK,
+				OMAP4430_GLOBAL_WUEN_MASK, OMAP4430_PRM_DEVICE_INST,
+			OMAP4_PRM_IO_PMCTRL_OFFSET);
+
+	/* Trigger WUCLKIN enable */
+	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, OMAP4430_WUCLK_CTRL_MASK,
+			OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET);
+	omap_test_timeout(
+		((omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET)
+		>> OMAP4430_WUCLK_STATUS_SHIFT) == 1), MAX_IOPAD_LATCH_TIME, i);
+	/* Trigger WUCLKIN disable */
+	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, 0x0,
+			OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET);
+	return;
+}
+
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 7dfa379..275b25a 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -750,6 +750,7 @@
 extern u32 omap4_prm_read_inst_reg(s16 inst, u16 idx);
 extern void omap4_prm_write_inst_reg(u32 val, s16 inst, u16 idx);
 extern u32 omap4_prm_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
+extern void omap4_trigger_wuclk_ctrl(void);
 
 # endif
 
-- 
1.7.0.4

