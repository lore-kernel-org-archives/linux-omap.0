From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 07/10] 34XX: PM: Workaround to check wether any fck is active before entering sleep
Date: Fri, 16 May 2008 14:05:10 +0300
Message-ID: <1210935910-28038-1-git-send-email-jouni.hogander@nokia.com>
References: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59239 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbYEPLFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 07:05:23 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GB55TQ003718
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 14:05:21 +0300
In-Reply-To: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

This workaround shouldn't be needed when all drivers are configuring
their sysconfig registers properly and setting their requirements
through omap-pm-srf.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a5504b7..43240d3 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -81,6 +81,13 @@ static void per_gpio_clk_disable(void)
 	}
 }
 
+/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+ * handles fcks correctly */
+static void gpio_fclk_mask(u32 *fclk)
+{
+	*fclk &= ~(0x1f << 13);
+}
+
 /* PRCM Interrupt Handler for wakeups */
 static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 {
@@ -211,10 +218,42 @@ static void omap_sram_idle(void)
 	omap2_gpio_resume_after_retention();
 }
 
+static int omap3_fclks_active(void)
+{
+	u32 fck_core1 = 0, fck_core3 = 0, fck_sgx = 0, fck_dss = 0,
+		fck_cam = 0, fck_per = 0, fck_usbhost = 0;
+
+	fck_core1 = cm_read_mod_reg(CORE_MOD,
+				    CM_FCLKEN1);
+	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+		fck_core3 = cm_read_mod_reg(CORE_MOD,
+					    OMAP3430ES2_CM_FCLKEN3);
+		fck_sgx = cm_read_mod_reg(OMAP3430ES2_SGX_MOD,
+					  CM_FCLKEN);
+		fck_usbhost = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+					      CM_FCLKEN);
+	} else
+		fck_sgx = cm_read_mod_reg(GFX_MOD,
+					  OMAP3430ES2_CM_FCLKEN3);
+	fck_dss = cm_read_mod_reg(OMAP3430_DSS_MOD,
+				  CM_FCLKEN);
+	fck_cam = cm_read_mod_reg(OMAP3430_CAM_MOD,
+				  CM_FCLKEN);
+	fck_per = cm_read_mod_reg(OMAP3430_PER_MOD,
+				  CM_FCLKEN);
+	gpio_fclk_mask(&fck_per);
+	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
+	    fck_cam | fck_per | fck_usbhost)
+		return 1;
+	return 0;
+}
+
 static int omap3_can_sleep(void)
 {
 	if (!enable_dyn_sleep)
 		return 0;
+	if (omap3_fclks_active())
+		return 0;
 	if (atomic_read(&sleep_block) > 0)
 		return 0;
 	return 1;
-- 
1.5.5

