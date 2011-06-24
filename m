From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 08/14] OMAP4: prm: Remove deprecated functions
Date: Fri, 24 Jun 2011 13:05:54 +0200
Message-ID: <1308913560-333-9-git-send-email-b-cousson@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44210 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab1FXLG0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 07:06:26 -0400
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

The new prminst_xxx accessors based on partition and offset
is now used, so removed all the previous prcm_xxx accessors.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c |   37 -------------------------------------
 1 files changed, 0 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index f815329..0016555 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -50,40 +50,3 @@ u32 omap4_prm_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 reg)
 
 	return v;
 }
-
-/* Read a PRM register, AND it, and shift the result down to bit 0 */
-/* XXX deprecated */
-u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask)
-{
-	u32 v;
-
-	v = __raw_readl(reg);
-	v &= mask;
-	v >>= __ffs(mask);
-
-	return v;
-}
-
-/* Read-modify-write a register in a PRM module. Caller must lock */
-/* XXX deprecated */
-u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg)
-{
-	u32 v;
-
-	v = __raw_readl(reg);
-	v &= ~mask;
-	v |= bits;
-	__raw_writel(v, reg);
-
-	return v;
-}
-
-u32 omap4_prm_set_inst_reg_bits(u32 bits, s16 inst, s16 reg)
-{
-	return omap4_prm_rmw_inst_reg_bits(bits, bits, inst, reg);
-}
-
-u32 omap4_prm_clear_inst_reg_bits(u32 bits, s16 inst, s16 reg)
-{
-	return omap4_prm_rmw_inst_reg_bits(bits, 0x0, inst, reg);
-}
-- 
1.7.0.4

