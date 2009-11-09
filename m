From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 4/4] OMAP3: PM: Extend T2 wakeup support to 3430SDP
Date: Mon,  9 Nov 2009 22:10:21 +0530
Message-ID: <1257784821-20838-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36173 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065AbZKIQkU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Nov 2009 11:40:20 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA9GeM32013584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 9 Nov 2009 10:40:25 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This extends the wakeup support to the 3430 SDP platform.

Only compile tested.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   89 +++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 11f0dc5..b22fd26 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -46,6 +46,7 @@
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"
 #include "pm.h"
+#include "prm-regbits-34xx.h"
 #include "omap3-opp.h"
 
 #define SDP3430_TS_GPIO_IRQ_SDPV1	3
@@ -91,6 +92,85 @@ static struct cpuidle_params omap3_cpuidle_params_table[] = {
 	{10000, 30000, 300000},
 };
 
+#ifdef CONFIG_PM
+/*
+ * Save the state of keypad
+ *
+ * TODO: This definition should ideally be in a header file, but
+ *       matrix_keypad.h is not the right one. Also, plat/keypad.h
+ *       is no longer used.
+ */
+struct omap_keypad_pm_state {
+	void __iomem *wk_st;
+	void __iomem *wk_en;
+	u32 wk_mask;
+	u32 padconf;
+};
+
+/*
+ * Board specific hook for keypad suspend
+ */
+void sdp3430_kp_suspend(void *ptr)
+{
+	struct omap_keypad_pm_state *pstate =
+			(struct omap_keypad_pm_state *)ptr;
+
+	if (pstate) {
+		/*
+		 * Set wake-enable bit
+		 */
+		if (pstate->wk_en && pstate->wk_mask) {
+			u32 v = __raw_readl(pstate->wk_en);
+			v |= pstate->wk_mask;
+			__raw_writel(v, pstate->wk_en);
+		}
+		/*
+		 * Set corresponding IOPAD wakeup-enable
+		 */
+		if (cpu_is_omap34xx() && pstate->padconf) {
+			u16 v = omap_ctrl_readw(pstate->padconf);
+			v |= OMAP3_PADCONF_WAKEUPENABLE0;
+			omap_ctrl_writew(v, pstate->padconf);
+		}
+	}
+}
+
+/*
+ * Board specific hook for keypad resume
+ */
+void sdp3430_kp_resume(void *ptr)
+{
+	struct omap_keypad_pm_state *pstate =
+			(struct omap_keypad_pm_state *)ptr;
+
+	if (pstate) {
+		/*
+		 * Clear wake-enable bit
+		 */
+		if (pstate->wk_en && pstate->wk_mask) {
+			u32 v = __raw_readl(pstate->wk_en);
+			v &= ~pstate->wk_mask;
+			__raw_writel(v, pstate->wk_en);
+		}
+		/*
+		 * Clear corresponding IOPAD wakeup-enable
+		 */
+		if (cpu_is_omap34xx() && pstate->padconf) {
+			u16 v = omap_ctrl_readw(pstate->padconf);
+			v &= ~OMAP3_PADCONF_WAKEUPENABLE0;
+			omap_ctrl_writew(v, pstate->padconf);
+		}
+	}
+}
+
+static struct omap_keypad_pm_state omap3evm_kp_pm_state = {
+	.wk_st		= OMAP34XX_PRM_REGADDR(WKUP_MOD, PM_WKEN1),
+	.wk_en		= OMAP34XX_PRM_REGADDR(WKUP_MOD, PM_WKST1),
+	.wk_mask	= OMAP3430_EN_GPIO1,
+	.padconf	= 0x1e0,
+};
+#endif	/* CONFIG_PM */
+
 static int board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -135,6 +215,15 @@ static struct twl4030_keypad_data sdp3430_kp_data = {
 	.rows		= 5,
 	.cols		= 6,
 	.rep		= 1,
+#ifdef CONFIG_PM
+	.pm_state	= (void *)&omap3evm_kp_pm_state,
+	.on_suspend	= sdp3430_kp_suspend,
+	.on_resume	= sdp3430_kp_resume,
+#else
+	.pm_state	= NULL,
+	.on_suspend	= NULL,
+	.on_resume	= NULL,
+#endif	/* CONFIG_PM */
 };
 
 static int ts_gpio;	/* Needed for ads7846_get_pendown_state */
-- 
1.6.2.2

