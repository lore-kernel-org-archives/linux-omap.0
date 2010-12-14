From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP3: PM: Fix CLK_SRC mask for IVA2 and MPU
Date: Tue, 14 Dec 2010 19:01:39 +0530
Message-ID: <1292333499-11352-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48210 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305Ab0LNNbs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 08:31:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

The IVA2_CLK_SRC and MPU_CLK_SRC for OMAP3
are 3 bit fields and hence the mask should
be defined as (0x7 << n).

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 4f959a7..d5c8fb6 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -81,7 +81,7 @@
 
 /* CM_CLKSEL1_PLL_IVA2 */
 #define OMAP3430_IVA2_CLK_SRC_SHIFT			19
-#define OMAP3430_IVA2_CLK_SRC_MASK			(0x3 << 19)
+#define OMAP3430_IVA2_CLK_SRC_MASK			(0x7 << 19)
 #define OMAP3430_IVA2_DPLL_MULT_SHIFT			8
 #define OMAP3430_IVA2_DPLL_MULT_MASK			(0x7ff << 8)
 #define OMAP3430_IVA2_DPLL_DIV_SHIFT			0
@@ -126,7 +126,7 @@
 
 /* CM_CLKSEL1_PLL_MPU */
 #define OMAP3430_MPU_CLK_SRC_SHIFT			19
-#define OMAP3430_MPU_CLK_SRC_MASK			(0x3 << 19)
+#define OMAP3430_MPU_CLK_SRC_MASK			(0x7 << 19)
 #define OMAP3430_MPU_DPLL_MULT_SHIFT			8
 #define OMAP3430_MPU_DPLL_MULT_MASK			(0x7ff << 8)
 #define OMAP3430_MPU_DPLL_DIV_SHIFT			0
-- 
1.7.0.4

