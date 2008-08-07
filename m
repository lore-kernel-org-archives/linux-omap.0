From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 2/4] 34XX: PM: Workaround for taking care of gpio clocks
Date: Thu,  7 Aug 2008 11:43:54 +0300
Message-ID: <1218098636-4684-2-git-send-email-ext-kalle.jokiniemi@nokia.com>
References: <>
 <1218098636-4684-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53615 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbYHGImI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 04:42:08 -0400
In-Reply-To: <1218098636-4684-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, jouni.hogander@nokia.com

From: ext Rajendra Nayak <rnayak@ti.com>

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
index bca1994..4b6d645 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -47,12 +47,42 @@ struct power_state {
 
 static LIST_HEAD(pwrst_list);
 
-static void (*_omap_sram_idle)(u32 *addr, int save_state);
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
1.5.4.3

