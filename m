From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 44/55] ARM: OMAP4: PRM: make omap4_prm_read/write_inst_reg calls static
Date: Mon, 31 Mar 2014 18:16:23 +0300
Message-ID: <1396278994-12624-45-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39216 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753520AbaCaPSu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:18:50 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
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
index a80e8b5..f1f3e78 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -115,19 +115,19 @@ static struct prm_reset_src_map omap44xx_prm_reset_src_map[] = {
 /* PRM low-level functions */
 
 /* Read a register in a CM/PRM instance in the PRM module */
-u32 omap4_prm_read_inst_reg(s16 inst, u16 reg)
+static u32 omap4_prm_read_inst_reg(s16 inst, u16 reg)
 {
 	return __raw_readl(prm_base + inst + reg);
 }
 
 /* Write into a register in a CM/PRM instance in the PRM module */
-void omap4_prm_write_inst_reg(u32 val, s16 inst, u16 reg)
+static void omap4_prm_write_inst_reg(u32 val, s16 inst, u16 reg)
 {
 	__raw_writel(val, prm_base + inst + reg);
 }
 
 /* Read-modify-write a register in a PRM module. Caller must lock */
-u32 omap4_prm_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 reg)
+static u32 omap4_prm_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 reg)
 {
 	u32 v;
 
diff --git a/arch/arm/mach-omap2/prm44xx_54xx.h b/arch/arm/mach-omap2/prm44xx_54xx.h
index 73734b2..4b36d3d 100644
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

