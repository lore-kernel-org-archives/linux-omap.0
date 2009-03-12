From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 75/86] [ARM] OMAP2xxx clock: consolidate DELAYED_APP clock commits; fix barrier
Date: Thu, 12 Mar 2009 11:28:25 -0700
Message-ID: <1236882516-29403-76-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-53-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-54-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-55-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-56-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-57-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-58-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-59-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-60-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-61-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-62-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-63-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-64-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-65-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-66-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-67-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-68-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-69-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-70-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-71-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-72-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-73-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-74-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-75-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863AbZCLSeG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:34:06 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:34:05 -0700 (PDT)
In-Reply-To: <1236882516-29403-75-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Consolidate the commit code for DELAYED_APP clocks into a subroutine,
_omap2xxx_clk_commit().  Also convert the MPU barrier wmb() into an
OCP barrier, since with an MPU barrier, we have no guarantee that the
write actually reached the endpoint device.

linux-omap source commit is 0f5bdb736515801b296125d16937a21ff7b3cfdc.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c |   33 ++++++++++++++++++++++++---------
 1 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 0803c8c..7f12230 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -74,6 +74,28 @@ u8 cpu_mask;
  * OMAP2/3 specific clock functions
  *-------------------------------------------------------------------------*/
 
+/**
+ * _omap2xxx_clk_commit - commit clock parent/rate changes in hardware
+ * @clk: struct clk *
+ *
+ * If @clk has the DELAYED_APP flag set, meaning that parent/rate changes
+ * don't take effect until the VALID_CONFIG bit is written, write the
+ * VALID_CONFIG bit and wait for the write to complete.  No return value.
+ */
+static void _omap2xxx_clk_commit(struct clk *clk)
+{
+	if (!cpu_is_omap24xx())
+		return;
+
+	if (!(clk->flags & DELAYED_APP))
+		return;
+
+	prm_write_mod_reg(OMAP24XX_VALID_CONFIG, OMAP24XX_GR_MOD,
+		OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
+	/* OCP barrier */
+	prm_read_mod_reg(OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
+}
+
 /*
  * _dpll_test_fint - test whether an Fint value is valid for the DPLL
  * @clk: DPLL struct clk to test
@@ -685,11 +707,7 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 
 	clk->rate = clk->parent->rate / new_div;
 
-	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {
-		prm_write_mod_reg(OMAP24XX_VALID_CONFIG,
-			OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
-		wmb();
-	}
+	_omap2xxx_clk_commit(clk);
 
 	return 0;
 }
@@ -772,10 +790,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	__raw_writel(v, clk->clksel_reg);
 	wmb();
 
-	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {
-		__raw_writel(OMAP24XX_VALID_CONFIG, OMAP24XX_PRCM_CLKCFG_CTRL);
-		wmb();
-	}
+	_omap2xxx_clk_commit(clk);
 
 	if (clk->usecount > 0)
 		_omap2_clk_enable(clk);
-- 
1.6.1.2

