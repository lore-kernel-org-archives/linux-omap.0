From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 6/8] 34XX: PM: Workaround to check wether any fck is active before entering sleep
Date: Tue, 17 Jun 2008 10:31:09 +0300
Message-ID: <1213687869-30019-1-git-send-email-jouni.hogander@nokia.com>
References: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63910 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957AbYFQHbO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 03:31:14 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5H7VBPh018660
	for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2008 02:31:12 -0500
Received: from localhost.localdomain (trdhcp146197.ntc.nokia.com [172.22.146.197])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m5H7V9CI019336
	for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2008 10:31:09 +0300
In-Reply-To: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This workaround shouldn't be needed when all drivers are configuring
their sysconfig registers properly and setting their requirements
through omap-pm-srf.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 29ef5a8..0f42de7 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -80,6 +80,13 @@ static void per_gpio_clk_disable(void)
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
@@ -209,10 +216,42 @@ static void omap_sram_idle(void)
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

