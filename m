From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re:[RESUBMIT][PATCH 6/7 v2] OMAP4: Clock stubs since clock management framework not in.
Date: Tue, 19 May 2009 19:02:39 +0530
Message-ID: <1242739959-12588-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49638 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467AbZESNc5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 09:32:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

(Patches are rebased on 2.6.30-rc6. The older version was based on 2.6.30-rc2)

This patch update the common clock.c file for OMAP4. The clk_get() and
clk_put() sunctions are moved to  common place in arch/arm/common/clkdev.c
Since on current OMAP4 platform clk management is still not supported, the
platform file is stubbed with those functions.

Once the framework is ready, this WILL be replaced with a full
clkdev implementation.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/clock.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 29efc27..0fcfcd6 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -36,10 +36,40 @@ static struct clk_functions *arch_clock;
  * Standard clock functions defined in include/linux/clk.h
  *-------------------------------------------------------------------------*/
 
+/* This functions is moved to arch/arm/common/clkdev.c. For OMAP4 since
+ * clock framework is not up , it is defined here to avoid rework in
+ * every driver. Also dummy prcm reset function is added */
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
+
+void omap2_clk_prepare_for_reboot(void)
+{
+}
+EXPORT_SYMBOL(omap2_clk_prepare_for_reboot);
+
+void omap_prcm_arch_reset(char mode)
+{
+}
+EXPORT_SYMBOL(omap_prcm_arch_reset);
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
@@ -140,6 +170,9 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	unsigned long flags;
 	int ret = -EINVAL;
 
+	if (cpu_is_omap44xx())
+	/* OMAP4 clk framework not supported yet */
+		return 0;
 	if (clk == NULL || IS_ERR(clk) || parent == NULL || IS_ERR(parent))
 		return ret;
 
-- 
1.5.4.7

