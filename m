From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 3/6] ARM: OMAP3: hwmod data: fix iva2 reset info
Date: Fri, 13 Jul 2012 19:37:36 +0300
Message-ID: <1342197459-7920-4-git-send-email-t-kristo@ti.com>
References: <1342197459-7920-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43921 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030733Ab2GMQjG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 12:39:06 -0400
In-Reply-To: <1342197459-7920-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

IVA2 hwmod resets were missing the status bit offsets. Also, as the
hwmod itself didn't have prcm info at all, resetting iva hwmod was
accessing some bogus memory addresses. Added both infos to fix this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h      |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 8083a8c..90d150c8 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -67,6 +67,7 @@
 #define OMAP3430_EN_IVA2_DPLL_MASK			(0x7 << 0)
 
 /* CM_IDLEST_IVA2 */
+#define OMAP3430_ST_IVA2_SHIFT				0
 #define OMAP3430_ST_IVA2_MASK				(1 << 0)
 
 /* CM_IDLEST_PLL_IVA2 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index f8ac9e7..98bc6f9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -100,9 +100,9 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
 
 /* IVA2 (IVA2) */
 static struct omap_hwmod_rst_info omap3xxx_iva_resets[] = {
-	{ .name = "logic", .rst_shift = 0 },
-	{ .name = "seq0", .rst_shift = 1 },
-	{ .name = "seq1", .rst_shift = 2 },
+	{ .name = "logic", .rst_shift = 0, .st_shift = 8 },
+	{ .name = "seq0", .rst_shift = 1, .st_shift = 9 },
+	{ .name = "seq1", .rst_shift = 2, .st_shift = 10 },
 };
 
 static struct omap_hwmod omap3xxx_iva_hwmod = {
@@ -112,6 +112,15 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.rst_lines	= omap3xxx_iva_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap3xxx_iva_resets),
 	.main_clk	= "iva2_ck",
+	.prcm = {
+		.omap2 = {
+			.module_offs = OMAP3430_IVA2_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_IVA2_SHIFT,
+		}
+	},
 };
 
 /* timer class */
-- 
1.7.4.1

