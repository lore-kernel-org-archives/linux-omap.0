From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 01/11] OMAP: mach-omap2: Fix incorrect assignment warnings
Date: Fri, 27 Aug 2010 02:26:39 +0530
Message-ID: <1282856209-15645-2-git-send-email-manjugk@ti.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58416 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349Ab0HZU5v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Aug 2010 16:57:51 -0400
In-Reply-To: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

From: Manjunatha GK <manjugk@ti.com>

This patch fixes below sparse warnings for incorrect assignments.

arch/arm/mach-omap2/control.c:195:16: warning: incorrect type in assignment (different address spaces)
arch/arm/mach-omap2/control.c:195:16:    expected unsigned int [usertype] *v_addr
arch/arm/mach-omap2/control.c:195:16:    got void [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/control.c:199:25: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/control.c:199:25:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/control.c:199:25:    got unsigned int [usertype] *
arch/arm/mach-omap2/control.c:320:28: warning: incorrect type in assignment (different address spaces)
arch/arm/mach-omap2/control.c:320:28:    expected void *[noderef] <asn:2>scratchpad_address
arch/arm/mach-omap2/control.c:320:28:    got void [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/control.c:321:9: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/control.c:321:9:    expected void volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/control.c:321:9:    got void *[noderef] <asn:2>scratchpad_address
arch/arm/mach-omap2/control.c:324:9: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/control.c:324:9:    expected void volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/control.c:324:9:    got void *
arch/arm/mach-omap2/control.c:327:9: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/control.c:327:9:    expected void volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/control.c:327:9:    got void *
arch/arm/mach-omap2/control.c:334:9: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/control.c:334:9:    expected void volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/control.c:334:9:    got void *
arch/arm/mach-omap2/control.c:321:9: warning: dereference of noderef expression
arch/arm/mach-omap2/control.c:324:9: warning: dereference of noderef expression
arch/arm/mach-omap2/control.c:327:9: warning: dereference of noderef expression
arch/arm/mach-omap2/control.c:334:9: warning: dereference of noderef expression

arch/arm/mach-omap2/pm34xx.c:323:28: warning: incorrect type in assignment (different address spaces)
arch/arm/mach-omap2/pm34xx.c:323:28:    expected unsigned int [usertype] *scratchpad_address
arch/arm/mach-omap2/pm34xx.c:323:28:    got void [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/pm34xx.c:326:26: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/pm34xx.c:326:26:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/pm34xx.c:326:26:    got unsigned int [usertype] *
arch/arm/mach-omap2/pm34xx.c:329:26: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/pm34xx.c:329:26:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/pm34xx.c:329:26:    got unsigned int [usertype] *
arch/arm/mach-omap2/pm34xx.c:334:29: warning: incorrect type in argument 1 (different address spaces)
arch/arm/mach-omap2/pm34xx.c:334:29:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-omap2/pm34xx.c:334:29:    got unsigned int [usertype] *

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/control.c |    4 ++--
 arch/arm/mach-omap2/pm34xx.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index a8d20ee..7405936 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -190,7 +190,7 @@ void omap_ctrl_writel(u32 val, u16 offset)
 void omap3_clear_scratchpad_contents(void)
 {
 	u32 max_offset = OMAP343X_SCRATCHPAD_ROM_OFFSET;
-	u32 *v_addr;
+	void __iomem *v_addr;
 	u32 offset = 0;
 	v_addr = OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD_ROM);
 	if (prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
@@ -206,7 +206,7 @@ void omap3_clear_scratchpad_contents(void)
 /* Populate the scratchpad structure with restore structure */
 void omap3_save_scratchpad_contents(void)
 {
-	void * __iomem scratchpad_address;
+	void  __iomem *scratchpad_address;
 	u32 arm_context_addr;
 	struct omap3_scratchpad scratchpad_contents;
 	struct omap3_scratchpad_prcm_block prcm_block_contents;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7b03426..4af19a6 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -316,7 +316,7 @@ static void restore_control_register(u32 val)
 /* Function to restore the table entry that was modified for enabling MMU */
 static void restore_table_entry(void)
 {
-	u32 *scratchpad_address;
+	void __iomem *scratchpad_address;
 	u32 previous_value, control_reg_value;
 	u32 *address;
 
-- 
1.7.0.4

