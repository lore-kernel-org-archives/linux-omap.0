From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 2/4] PM: Workaround for taking care of gpio clocks
Date: Fri, 15 Aug 2008 10:47:19 +0300
Message-ID: <1218786439-28070-1-git-send-email-jouni.hogander@nokia.com>
References: <87iqu2rac0.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:44321 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbYHOHri (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 03:47:38 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7F7lQ9C027509
	for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 10:47:36 +0300
In-Reply-To: <87iqu2rac0.fsf@trdhcp146196.ntc.nokia.com>
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
 arch/arm/mach-omap2/pm34xx.c |   54 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index f30fa9e..7d5d461 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -53,6 +53,36 @@ static void (*saved_idle)(void);
 
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
@@ -169,8 +199,18 @@ static void omap_sram_idle(void)
 
 	omap2_gpio_prepare_for_retention();
 
+	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+	 * handles fcks correctly */
+	if (clocks_off_while_idle)
+		per_gpio_clk_disable();
+
 	_omap_sram_idle(NULL, save_state);
 
+	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+	 * handles fcks correctly */
+	if (clocks_off_while_idle)
+		per_gpio_clk_enable();
+
 	omap2_gpio_resume_after_retention();
 }
 
@@ -200,6 +240,10 @@ static int omap3_fclks_active(void)
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
@@ -418,7 +462,8 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst;
-	int ret;
+	char clk_name[11];
+	int ret, i;
 
 	printk(KERN_ERR "Power Management for TI OMAP3.\n");
 
@@ -454,6 +499,13 @@ int __init omap3_pm_init(void)
 
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

