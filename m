From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 28/55] ARM: OMAP4: CM: make all omap4_cminst_read/write calls static
Date: Mon, 31 Mar 2014 18:16:07 +0300
Message-ID: <1396278994-12624-29-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58783 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbaCaPSP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2014 11:18:15 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

These are not used outside the cminst44xx.c anymore, thus make them static.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c |   23 +++++++++++------------
 arch/arm/mach-omap2/cminst44xx.h |   14 --------------
 2 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index dfb1a93..20681de 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -80,6 +80,8 @@ void omap_cm_base_init(void)
 
 /* Private functions */
 
+static u32 omap4_cminst_read_inst_reg(u8 part, u16 inst, u16 idx);
+
 /**
  * _clkctrl_idlest - read a CM_*_CLKCTRL register; mask & shift IDLEST bitfield
  * @part: PRCM partition ID that the CM_CLKCTRL register exists in
@@ -118,10 +120,8 @@ static bool _is_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
 		v == CLKCTRL_IDLEST_INTERFACE_IDLE) ? true : false;
 }
 
-/* Public functions */
-
 /* Read a register in a CM instance */
-u32 omap4_cminst_read_inst_reg(u8 part, u16 inst, u16 idx)
+static u32 omap4_cminst_read_inst_reg(u8 part, u16 inst, u16 idx)
 {
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
@@ -130,7 +130,7 @@ u32 omap4_cminst_read_inst_reg(u8 part, u16 inst, u16 idx)
 }
 
 /* Write into a register in a CM instance */
-void omap4_cminst_write_inst_reg(u32 val, u8 part, u16 inst, u16 idx)
+static void omap4_cminst_write_inst_reg(u32 val, u8 part, u16 inst, u16 idx)
 {
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
@@ -139,8 +139,8 @@ void omap4_cminst_write_inst_reg(u32 val, u8 part, u16 inst, u16 idx)
 }
 
 /* Read-modify-write a register in CM1. Caller must lock */
-u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, u16 inst,
-				   s16 idx)
+static u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, u16 inst,
+					  s16 idx)
 {
 	u32 v;
 
@@ -152,17 +152,18 @@ u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, u16 inst,
 	return v;
 }
 
-u32 omap4_cminst_set_inst_reg_bits(u32 bits, u8 part, u16 inst, s16 idx)
+static u32 omap4_cminst_set_inst_reg_bits(u32 bits, u8 part, u16 inst, s16 idx)
 {
 	return omap4_cminst_rmw_inst_reg_bits(bits, bits, part, inst, idx);
 }
 
-u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, u16 inst, s16 idx)
+static u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, u16 inst,
+					    s16 idx)
 {
 	return omap4_cminst_rmw_inst_reg_bits(bits, 0x0, part, inst, idx);
 }
 
-u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx, u32 mask)
+static u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx, u32 mask)
 {
 	u32 v;
 
@@ -173,9 +174,7 @@ u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx, u32 mask)
 	return v;
 }
 
-/*
- *
- */
+/* Public functions */
 
 /**
  * _clktrctrl_write - write @c to a CM_CLKSTCTRL.CLKTRCTRL register bitfield
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index 7f56ea4..ad06525 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -23,20 +23,6 @@ extern void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs,
 				       u16 clkctrl_offs);
 extern void omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
 					u16 clkctrl_offs);
-/*
- * In an ideal world, we would not export these low-level functions,
- * but this will probably take some time to fix properly
- */
-u32 omap4_cminst_read_inst_reg(u8 part, u16 inst, u16 idx);
-void omap4_cminst_write_inst_reg(u32 val, u8 part, u16 inst, u16 idx);
-u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
-				   u16 inst, s16 idx);
-u32 omap4_cminst_set_inst_reg_bits(u32 bits, u8 part, u16 inst,
-				   s16 idx);
-u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, u16 inst,
-				     s16 idx);
-extern u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx,
-					   u32 mask);
 
 extern void omap_cm_base_init(void);
 
-- 
1.7.9.5

