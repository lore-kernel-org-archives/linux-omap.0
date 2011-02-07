From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/3] OMAP4: CM: Add CM accesor api for bitwise control
Date: Mon,  7 Feb 2011 18:47:10 +0530
Message-ID: <1297084631-27474-3-git-send-email-rnayak@ti.com>
References: <1297084631-27474-1-git-send-email-rnayak@ti.com>
 <1297084631-27474-2-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57909 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396Ab1BGNRY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 08:17:24 -0500
In-Reply-To: <1297084631-27474-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Add new OMAP4 CM accesor apis to set/clear and read
bitfields (based on mask) from CM registers.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c |   21 +++++++++++++++++++++
 arch/arm/mach-omap2/cminst44xx.h |    6 ++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index c04bbbe..a482bfa 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -73,6 +73,27 @@ u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, s16 inst,
 	return v;
 }
 
+u32 omap4_cminst_set_inst_reg_bits(u32 bits, u8 part, s16 inst, s16 idx)
+{
+	return omap4_cminst_rmw_inst_reg_bits(bits, bits, part, inst, idx);
+}
+
+u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, s16 inst, s16 idx)
+{
+	return omap4_cminst_rmw_inst_reg_bits(bits, 0x0, part, inst, idx);
+}
+
+u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx, u32 mask)
+{
+	u32 v;
+
+	v = omap4_cminst_read_inst_reg(part, inst, idx);
+	v &= mask;
+	v >>= __ffs(mask);
+
+	return v;
+}
+
 /*
  *
  */
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index a6abd0a..2b32c18 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -25,6 +25,12 @@ extern u32 omap4_cminst_read_inst_reg(u8 part, s16 inst, u16 idx);
 extern void omap4_cminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx);
 extern u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
 					   s16 inst, s16 idx);
+extern u32 omap4_cminst_set_inst_reg_bits(u32 bits, u8 part, s16 inst,
+					   s16 idx);
+extern u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, s16 inst,
+					   s16 idx);
+extern u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx,
+					   u32 mask);
 
 extern int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg);
 
-- 
1.7.0.4

