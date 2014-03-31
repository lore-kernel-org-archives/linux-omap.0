From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 01/55] ARM: OMAP4: CM: use cm_base* in register address calculations
Date: Mon, 31 Mar 2014 18:15:40 +0300
Message-ID: <1396278994-12624-2-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49771 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbaCaPRS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:17:18 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

OMAP44XX_CM*_REGADDR macros should be avoided, instead use the cm_base*
iomaps.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm44xx.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cm44xx.c b/arch/arm/mach-omap2/cm44xx.c
index 535d66e..5627072 100644
--- a/arch/arm/mach-omap2/cm44xx.c
+++ b/arch/arm/mach-omap2/cm44xx.c
@@ -30,23 +30,23 @@
 /* Read a register in CM1 */
 u32 omap4_cm1_read_inst_reg(s16 inst, u16 reg)
 {
-	return __raw_readl(OMAP44XX_CM1_REGADDR(inst, reg));
+	return __raw_readl(cm_base + inst + reg);
 }
 
 /* Write into a register in CM1 */
 void omap4_cm1_write_inst_reg(u32 val, s16 inst, u16 reg)
 {
-	__raw_writel(val, OMAP44XX_CM1_REGADDR(inst, reg));
+	__raw_writel(val, cm_base + inst + reg);
 }
 
 /* Read a register in CM2 */
 u32 omap4_cm2_read_inst_reg(s16 inst, u16 reg)
 {
-	return __raw_readl(OMAP44XX_CM2_REGADDR(inst, reg));
+	return __raw_readl(cm2_base + inst + reg);
 }
 
 /* Write into a register in CM2 */
 void omap4_cm2_write_inst_reg(u32 val, s16 inst, u16 reg)
 {
-	__raw_writel(val, OMAP44XX_CM2_REGADDR(inst, reg));
+	__raw_writel(val, cm2_base + inst + reg);
 }
-- 
1.7.9.5

