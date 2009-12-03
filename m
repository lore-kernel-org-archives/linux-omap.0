From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/8] OMAP1 clock: convert test in disable_unused() to use
	ENABLE_ON_INIT
Date: Thu, 03 Dec 2009 03:07:07 -0700
Message-ID: <20091203100706.1203.7214.stgit@localhost.localdomain>
References: <20091203095830.1203.76290.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35927 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856AbZLCKLt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 05:11:49 -0500
In-Reply-To: <20091203095830.1203.76290.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

mach-omap1/clock.c:omap1_clk_disable_unused() contains a test that
assumes that the clock structures are available in the file's
namespace.  After a following patch, this will no longer be the case.
So we need to reimplement that test.  It turns out that we already
have a facility in the clock framework to handle this case - the
ENABLE_ON_INIT flag - used on OMAP2/3.  Remove the offending test and
mark the clocks that it was intended to catch as ENABLE_ON_INIT.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/clock.c |   11 -----------
 arch/arm/mach-omap1/clock.h |   17 ++++++++++++++++-
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index e006493..26a887c 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -718,17 +718,6 @@ static void __init omap1_clk_disable_unused(struct clk *clk)
 	if ((regval32 & (1 << clk->enable_bit)) == 0)
 		return;
 
-	/* FIXME: This clock seems to be necessary but no-one
-	 * has asked for its activation. */
-	if (clk == &tc2_ck		/* FIX: pm.c (SRAM), CCP, Camera */
-	    || clk == &ck_dpll1out.clk	/* FIX: SoSSI, SSR */
-	    || clk == &arm_gpio_ck	/* FIX: GPIO code for 1510 */
-		) {
-		printk(KERN_INFO "FIXME: Clock \"%s\" seems unused\n",
-		       clk->name);
-		return;
-	}
-
 	printk(KERN_INFO "Disabling unused clock \"%s\"... ", clk->name);
 	clk->ops->disable(clk);
 	printk(" done\n");
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 29ffa97..70195ca 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -157,12 +157,17 @@ static struct clk ck_dpll1 = {
 	.parent		= &ck_ref,
 };
 
+/*
+ * FIXME: This clock seems to be necessary but no-one has asked for its
+ * activation.  [ FIX: SoSSI, SSR ]
+ */
 static struct arm_idlect1_clk ck_dpll1out = {
 	.clk = {
 		.name		= "ck_dpll1out",
 		.ops		= &clkops_generic,
 		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IDLE_CONTROL | ENABLE_REG_32BIT,
+		.flags		= CLOCK_IDLE_CONTROL | ENABLE_REG_32BIT |
+				  ENABLE_ON_INIT,
 		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_CKOUT_ARM,
 		.recalc		= &followparent_recalc,
@@ -207,10 +212,15 @@ static struct arm_idlect1_clk armper_ck = {
 	.idlect_shift	= 2,
 };
 
+/*
+ * FIXME: This clock seems to be necessary but no-one has asked for its
+ * activation.  [ GPIO code for 1510 ]
+ */
 static struct clk arm_gpio_ck = {
 	.name		= "arm_gpio_ck",
 	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
+	.flags		= ENABLE_ON_INIT,
 	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 	.enable_bit	= EN_GPIOCK,
 	.recalc		= &followparent_recalc,
@@ -372,10 +382,15 @@ static struct clk tc1_ck = {
 	.recalc		= &followparent_recalc,
 };
 
+/*
+ * FIXME: This clock seems to be necessary but no-one has asked for its
+ * activation.  [ pm.c (SRAM), CCP, Camera ]
+ */
 static struct clk tc2_ck = {
 	.name		= "tc2_ck",
 	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
+	.flags		= ENABLE_ON_INIT,
 	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
 	.enable_bit	= EN_TC2_CK,
 	.recalc		= &followparent_recalc,


