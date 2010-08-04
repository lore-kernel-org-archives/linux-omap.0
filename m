From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/3] OMAP4: prcm: Add temporarily helper functions for rmw and read inside the PRM
Date: Thu,  5 Aug 2010 00:12:46 +0200
Message-ID: <1280959968-23933-2-git-send-email-b-cousson@ti.com>
References: <1280959968-23933-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45450 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047Ab0HDWM5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Aug 2010 18:12:57 -0400
In-Reply-To: <1280959968-23933-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, Benoit Cousson <b-cousson@ti.com>

Since OMAP4 is using an absolute address, the current PRM accessors
are not useable.
OMAP4 adaptation for these API are currently ongoing, so define temp
version until the proper ones are defined.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/prcm.c             |   24 ++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/prcm.h |    2 ++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 96f4616..d4388d3 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -216,6 +216,30 @@ u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
 	return v;
 }
 
+/* Read a PRM register, AND it, and shift the result down to bit 0 */
+u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask)
+{
+	u32 v;
+
+	v = __raw_readl(reg);
+	v &= mask;
+	v >>= __ffs(mask);
+
+	return v;
+}
+
+/* Read-modify-write a register in a PRM module. Caller must lock */
+u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg)
+{
+	u32 v;
+
+	v = __raw_readl(reg);
+	v &= ~mask;
+	v |= bits;
+	__raw_writel(v, reg);
+
+	return v;
+}
 /* Read a register in a CM module */
 u32 cm_read_mod_reg(s16 module, u16 idx)
 {
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index 9fbd914..ab77442 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -38,6 +38,8 @@ u32 prm_read_mod_reg(s16 module, u16 idx);
 void prm_write_mod_reg(u32 val, s16 module, u16 idx);
 u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
 u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
+u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask);
+u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg);
 u32 cm_read_mod_reg(s16 module, u16 idx);
 void cm_write_mod_reg(u32 val, s16 module, u16 idx);
 u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
-- 
1.6.1.3

