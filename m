From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 4/6] 34XX: PM: Workaround for taking care of gpio clocks
Date: Mon, 30 Jun 2008 11:52:50 +0300
Message-ID: <1214815970-23176-1-git-send-email-jouni.hogander@nokia.com>
References: <87tzfb9uhs.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62457 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbYF3IxH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 04:53:07 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5U8r0Gv015430
	for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 03:53:06 -0500
Received: from localhost.localdomain (trdhcp146197.ntc.nokia.com [172.22.146.197])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m5U8qoMR002778
	for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 11:52:50 +0300
In-Reply-To: <87tzfb9uhs.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

In omap3 gpios 2-6 are in per domain. Functional clocks for these
should be disabled. This patch is needed until gpio driver disables
gpio clocks.

GPIO modules in PER domain are not able to act as a wake up source if
PER domain is in retention. PER domain sleep transition before MPU is
prevented by leaving icks active. PER domain still enters retention
together with MPU. When this happens IOPAD wake up mechanism is used
for gpios.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   58 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 92e56cd..2b7ca5f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -47,12 +47,42 @@ struct power_state {
 
 static LIST_HEAD(pwrst_list);
 
-void (*_omap_sram_idle)(u32 *addr, int save_state);
+void (*_omap_sram_idle)(u32 *addr, int save_state, int disable_clocks);
 
 static void (*saved_idle)(void);
 
 static struct powerdomain *mpu_pwrdm;
 
+/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+ * handles fcks correctly */
+#define NUM_OF_PERGPIOS 5
+static struct clk *gpio_fcks[NUM_OF_PERGPIOS];
+
+/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+ * handles fcks correctly */
+static void per_gpio_clk_enable(void)
+{
+	int i;
+	for (i = 1; i < NUM_OF_PERGPIOS + 1; i++)
+		clk_enable(gpio_fcks[i-1]);
+}
+
+/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+ * handles fcks correctly */
+static void per_gpio_clk_disable(void)
+{
+	int i;
+	for (i = 1; i < NUM_OF_PERGPIOS + 1; i++)
+		clk_disable(gpio_fcks[i-1]);
+}
+
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
@@ -169,7 +199,17 @@ static void omap_sram_idle(void)
 
 	omap2_gpio_prepare_for_retention();
 
-	_omap_sram_idle(NULL, save_state);
+	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+	 * handles fcks correctly */
+	if (clocks_off_while_idle)
+		per_gpio_clk_disable();
+
+	_omap_sram_idle(NULL, save_state, clocks_off_while_idle);
+
+	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+	 * handles fcks correctly */
+	if (clocks_off_while_idle)
+		per_gpio_clk_enable();
 
 	omap2_gpio_resume_after_retention();
 }
@@ -197,6 +237,10 @@ static int omap3_fclks_active(void)
 				  CM_FCLKEN);
 	fck_per = cm_read_mod_reg(OMAP3430_PER_MOD,
 				  CM_FCLKEN);
+
+	if (clocks_off_while_idle)
+		gpio_fclk_mask(&fck_per);
+
 	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
 	    fck_cam | fck_per | fck_usbhost)
 		return 1;
@@ -412,7 +456,8 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst;
-	int ret;
+	char clk_name[11];
+	int ret, i;
 
 	printk(KERN_ERR "Power Management for TI OMAP3.\n");
 
@@ -448,6 +493,13 @@ int __init omap3_pm_init(void)
 
 	pm_idle = omap3_pm_idle;
 
+	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+	 * handles fcks correctly */
+	for (i = 1; i < NUM_OF_PERGPIOS + 1; i++) {
+		sprintf(clk_name, "gpio%d_fck", i + 1);
+		gpio_fcks[i-1] = clk_get(NULL, clk_name);
+	}
+
 err1:
 	return ret;
 err2:
-- 
1.5.5

