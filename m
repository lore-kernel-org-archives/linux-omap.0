From: David Brownell <david-b@pacbell.net>
Subject: [patch] twl4030-regulator: expose VPLL2
Date: Fri, 13 Mar 2009 17:54:54 -0700
Message-ID: <200903131754.54997.david-b@pacbell.net>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761566AbZCNAzl@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@sirena.org.uk>, OMAP <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Add VPLL2 to the set of twl4030-family regulators exposed for
use by various drivers.  It's commonly used to power the digital
video outputs (e.g. LCD or DVI displays) on OMAP3 systems.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Please apply to regulator-next and linux-omap ... I'll send
some patches configuring various OMAP boards to use this.

 drivers/mfd/twl4030-core.c            |    2 --
 drivers/regulator/twl4030-regulator.c |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -613,11 +613,9 @@ add_children(struct twl4030_platform_dat
 
 	/* maybe add LDOs that are omitted on cost-reduced parts */
 	if (twl_has_regulator() && !(features & TPS_SUBSET)) {
-		/*
 		child = add_regulator(TWL4030_REG_VPLL2, pdata->vpll2);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
-		*/
 
 		child = add_regulator(TWL4030_REG_VMMC2, pdata->vmmc2);
 		if (IS_ERR(child))
--- a/drivers/regulator/twl4030-regulator.c
+++ b/drivers/regulator/twl4030-regulator.c
@@ -404,8 +404,8 @@ static struct twlreg_info twl4030_regs[]
 	TWL_ADJUSTABLE_LDO(VMMC2, 0x2b, 6),
 	/*
 	TWL_ADJUSTABLE_LDO(VPLL1, 0x2f, 7),
-	TWL_ADJUSTABLE_LDO(VPLL2, 0x33, 8),
 	*/
+	TWL_ADJUSTABLE_LDO(VPLL2, 0x33, 8),
 	TWL_ADJUSTABLE_LDO(VSIM, 0x37, 9),
 	TWL_ADJUSTABLE_LDO(VDAC, 0x3b, 10),
 	/*
