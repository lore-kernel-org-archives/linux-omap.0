From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 01/10] 34XX: PM: Workaround for taking care of gpio clocks
Date: Fri, 16 May 2008 14:04:52 +0300
Message-ID: <1210935892-27918-1-git-send-email-jouni.hogander@nokia.com>
References: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37426 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894AbYEPLFI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 07:05:08 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GB523i032536
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 06:05:06 -0500
In-Reply-To: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

In omap3 gpios 2-6 are in per domain. Clocks for these should be
disabled. This patch is needed until gpio driver disables gpio clocks
when they are not needed.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   48 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a1bfb30..1826dcd 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -52,6 +52,34 @@ static void (*saved_idle)(void);
 
 static struct powerdomain *mpu_pwrdm;
 
+/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+ * handles fcks correctly */
+#define NUM_OF_PERGPIOS 5
+static struct clk *gpio_fcks[NUM_OF_PERGPIOS];
+static struct clk *gpio_icks[NUM_OF_PERGPIOS];
+
+/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+ * handles fcks correctly */
+static void per_gpio_clk_enable(void)
+{
+	int i;
+	for (i = 1; i < NUM_OF_PERGPIOS + 1; i++) {
+		clk_enable(gpio_icks[i-1]);
+		clk_enable(gpio_fcks[i-1]);
+	}
+}
+
+/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+ * handles fcks correctly */
+static void per_gpio_clk_disable(void)
+{
+	int i;
+	for (i = 1; i < NUM_OF_PERGPIOS + 1; i++) {
+		clk_disable(gpio_fcks[i-1]);
+		clk_disable(gpio_icks[i-1]);
+	}
+}
+
 /* PRCM Interrupt Handler for wakeups */
 static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 {
@@ -165,8 +193,16 @@ static void omap_sram_idle(void)
 
 	omap2_gpio_prepare_for_retention();
 
+	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+	 * handles fcks correctly */
+	per_gpio_clk_disable();
+
 	_omap_sram_idle(NULL, save_state);
 
+	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+	 * handles fcks correctly */
+	per_gpio_clk_enable();
+
 	omap2_gpio_resume_after_retention();
 }
 
@@ -340,7 +376,8 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst;
-	int ret;
+	char clk_name[11];
+	int ret, i;
 
 	printk(KERN_ERR "Power Management for TI OMAP3.\n");
 
@@ -374,6 +411,15 @@ int __init omap3_pm_init(void)
 
 	pm_idle = omap3_pm_idle;
 
+	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+	 * handles fcks correctly */
+	for (i = 1; i < NUM_OF_PERGPIOS + 1; i++) {
+		sprintf(clk_name, "gpio%d_fck", i + 1);
+		gpio_fcks[i-1] = clk_get(NULL, clk_name);
+		sprintf(clk_name, "gpio%d_ick", i + 1);
+		gpio_icks[i-1] = clk_get(NULL, clk_name);
+	}
+
 err1:
 	return ret;
 err2:
-- 
1.5.5

