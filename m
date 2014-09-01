From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 22/26] ARM: OMAP4: PRM: make omap4_prm_read/write_inst_reg calls static
Date: Mon, 1 Sep 2014 21:09:11 +0300
Message-ID: <1409594955-1476-23-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44856 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754717AbaIASKa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:30 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

These are not (and should not be) used by anybody outside the PRM
driver itself.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c      |    6 +++---
 arch/arm/mach-omap2/prm44xx_54xx.h |    4 ----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index d357ca9..15b4646 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -80,19 +80,19 @@ static struct prm_reset_src_map omap44xx_prm_reset_src_map[] = {
 /* PRM low-level functions */
 
 /* Read a register in a CM/PRM instance in the PRM module */
-u32 omap4_prm_read_inst_reg(s16 inst, u16 reg)
+static u32 omap4_prm_read_inst_reg(s16 inst, u16 reg)
 {
 	return readl_relaxed(prm_base + inst + reg);
 }
 
 /* Write into a register in a CM/PRM instance in the PRM module */
-void omap4_prm_write_inst_reg(u32 val, s16 inst, u16 reg)
+static void omap4_prm_write_inst_reg(u32 val, s16 inst, u16 reg)
 {
 	writel_relaxed(val, prm_base + inst + reg);
 }
 
 /* Read-modify-write a register in a PRM module. Caller must lock */
-u32 omap4_prm_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 reg)
+static u32 omap4_prm_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 reg)
 {
 	u32 v;
 
diff --git a/arch/arm/mach-omap2/prm44xx_54xx.h b/arch/arm/mach-omap2/prm44xx_54xx.h
index 8d95aa5..96477e7 100644
--- a/arch/arm/mach-omap2/prm44xx_54xx.h
+++ b/arch/arm/mach-omap2/prm44xx_54xx.h
@@ -26,10 +26,6 @@
 /* Function prototypes */
 #ifndef __ASSEMBLER__
 
-extern u32 omap4_prm_read_inst_reg(s16 inst, u16 idx);
-extern void omap4_prm_write_inst_reg(u32 val, s16 inst, u16 idx);
-extern u32 omap4_prm_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
-
 /* OMAP4/OMAP5-specific VP functions */
 u32 omap4_prm_vp_check_txdone(u8 vp_id);
 void omap4_prm_vp_clear_txdone(u8 vp_id);
-- 
1.7.9.5

