From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC 7/9] ARM: OMAP4: Generalize reset handling API
Date: Tue, 2 Jul 2013 16:58:16 +0530
Message-ID: <1372764498-32503-8-git-send-email-vaibhav.bedia@ti.com>
References: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34369 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197Ab3GBL3X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jul 2013 07:29:23 -0400
In-Reply-To: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, rnayak@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

Reset status bits on AM335x have different masks and register
is not consistent across powerdomains. Generalize the OMAP4
reset handling code to take care of these.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c  |  7 +++----
 arch/arm/mach-omap2/prminst44xx.c | 27 +++++++++++++++++++--------
 arch/arm/mach-omap2/prminst44xx.h |  5 +++--
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 7341eff..0f756b4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3011,13 +3011,12 @@ static int _omap4_deassert_hardreset(struct omap_hwmod *oh,
 	if (!oh->clkdm)
 		return -EINVAL;
 
-	if (ohri->st_shift)
-		pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does not support st_shift\n",
-		       oh->name, ohri->name);
 	return omap4_prminst_deassert_hardreset(ohri->rst_shift,
+				ohri->st_shift,
 				oh->clkdm->pwrdm.ptr->prcm_partition,
 				oh->clkdm->pwrdm.ptr->prcm_offs,
-				oh->prcm.omap4.rstctrl_offs);
+				oh->prcm.omap4.rstctrl_offs,
+				oh->prcm.omap4.rstst_offs);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index c12320c..5e165ea 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -136,26 +136,37 @@ int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
  * -EINVAL upon an argument error, -EEXIST if the submodule was already out
  * of reset, or -EBUSY if the submodule did not exit reset promptly.
  */
-int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
-				     u16 rstctrl_offs)
+int omap4_prminst_deassert_hardreset(u8 shift, u8 st_shift, u8 part, s16 inst,
+				     u16 rstctrl_offs, u16 rstst_offs)
 {
 	int c;
-	u32 mask = 1 << shift;
-	u16 rstst_offs = rstctrl_offs + OMAP4_RST_CTRL_ST_OFFSET;
+	u32 ctrl_mask = 1 << shift;
+	u32 st_mask;
+
+	if (!rstst_offs)
+		rstst_offs = rstctrl_offs + OMAP4_RST_CTRL_ST_OFFSET;
+
+	if (!st_shift) {
+		st_mask = 1 << shift;
+		st_shift = shift;
+	} else {
+		st_mask = 1 << st_shift;
+	}
 
 	/* Check the current status to avoid de-asserting the line twice */
 	if (omap4_prminst_is_hardreset_asserted(shift, part, inst,
 						rstctrl_offs) == 0)
 		return -EEXIST;
 
+
 	/* Clear the reset status by writing 1 to the status bit */
-	omap4_prminst_rmw_inst_reg_bits(0xffffffff, mask, part, inst,
+	omap4_prminst_rmw_inst_reg_bits(0xffffffff, st_mask, part, inst,
 					rstst_offs);
 	/* de-assert the reset control line */
-	omap4_prminst_rmw_inst_reg_bits(mask, 0, part, inst, rstctrl_offs);
+	omap4_prminst_rmw_inst_reg_bits(ctrl_mask, 0, part, inst, rstctrl_offs);
 	/* wait the status to be set */
-	omap_test_timeout(omap4_prminst_is_hardreset_asserted(shift, part, inst,
-							      rstst_offs),
+	omap_test_timeout(omap4_prminst_is_hardreset_asserted(st_shift, part,
+							inst, rstst_offs),
 			  MAX_MODULE_HARDRESET_WAIT, c);
 
 	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
diff --git a/arch/arm/mach-omap2/prminst44xx.h b/arch/arm/mach-omap2/prminst44xx.h
index a2ede2d..3973212 100644
--- a/arch/arm/mach-omap2/prminst44xx.h
+++ b/arch/arm/mach-omap2/prminst44xx.h
@@ -27,8 +27,9 @@ extern int omap4_prminst_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
 					       u16 rstctrl_offs);
 extern int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
 					  u16 rstctrl_offs);
-extern int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
-					    u16 rstctrl_offs);
+extern int omap4_prminst_deassert_hardreset(u8 shift, u8 st_shift, u8 part,
+					    s16 inst, u16 rstctrl_offs,
+					    u16 rstst_offs);
 
 extern void omap_prm_base_init(void);
 
-- 
1.8.1

