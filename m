From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [RESUBMIT][PATCH 6/7] OMAP4: Clock stubs since clock management framework not in.
Date: Thu,  7 May 2009 11:59:15 +0530
Message-ID: <1241677756-28756-6-git-send-email-santosh.shilimkar@ti.com>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-5-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54387 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232AbZEGG3m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 May 2009 02:29:42 -0400
In-Reply-To: <1241677756-28756-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch update the cooomon clock.c file for OMAP4. The clk_get() and
clk_put() sunctions are moved to  common place in arch/arm/common/clkdev.c
Since on current OMAP4 platform clk management is still not supported, the
platform file is stubbed with those functions.

Once the framework is ready, this WILL be replaced with a full
clkdev implementation.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/clock.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 2e06145..f7c3b0a 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -36,10 +36,34 @@ static struct clk_functions *arch_clock;
  * Standard clock functions defined in include/linux/clk.h
  *-------------------------------------------------------------------------*/
 
+/* This functions is moved to arch/arm/common/clkdev.c. For OMAP4 since
+ * clock framework is not up , it is defined here to avoid rework in
+ * every driver */
+
+/* Dummy hooks only for OMAP4.For rest OMAPs, common clkdev is used */
+#if defined(CONFIG_ARCH_OMAP4)
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	return NULL;
+}
+EXPORT_SYMBOL(clk_get);
+
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_put);
+void omap2_clk_prepare_for_reboot(void)
+{
+}
+EXPORT_SYMBOL(omap2_clk_prepare_for_reboot);
+#endif
 int clk_enable(struct clk *clk)
 {
 	unsigned long flags;
 	int ret = 0;
+	if (cpu_is_omap44xx())
+		/* OMAP4 clk framework not supported yet */
+		return 0;
 
 	if (clk == NULL || IS_ERR(clk))
 		return -EINVAL;
@@ -56,6 +80,9 @@ EXPORT_SYMBOL(clk_enable);
 void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
+	if (cpu_is_omap44xx())
+		/* OMAP4 clk framework not supported yet */
+		return ;
 
 	if (clk == NULL || IS_ERR(clk))
 		return;
@@ -80,6 +107,9 @@ unsigned long clk_get_rate(struct clk *clk)
 {
 	unsigned long flags;
 	unsigned long ret = 0;
+	if (cpu_is_omap44xx())
+		/* OMAP4 clk framework not supported yet */
+		return 0;
 
 	if (clk == NULL || IS_ERR(clk))
 		return 0;
-- 
1.5.4.7

