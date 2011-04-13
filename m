From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 1/2] OMAP2+: PM: Fix the saving of CM_AUTOIDLE_PLL register on scratchpad area
Date: Wed, 13 Apr 2011 18:21:06 +0300
Message-ID: <1302708067-8226-2-git-send-email-eduardo.valentin@ti.com>
References: <1302708067-8226-1-git-send-email-eduardo.valentin@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54907 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756961Ab1DMPV3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Apr 2011 11:21:29 -0400
In-Reply-To: <1302708067-8226-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Linux-ARM <linux-arm-kernel@lists.infradead.org>, Eduardo Valentin <eduardo.valentin@ti.com>

The saving of CCR.CM_AUTOIDLE_PLL is done in scratchpad area.

However, in current code, the saving is done for CM_AUTOIDLE2_PLL
(offset 0x34) instead of CM_AUTOIDLE_PLL (offset 0x30).

This patch changes the code to save the correct register.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/mach-omap2/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 6952794..df0c75c 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -317,7 +317,7 @@ void omap3_save_scratchpad_contents(void)
 	prcm_block_contents.cm_clken_pll =
 			omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 	prcm_block_contents.cm_autoidle_pll =
-			omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_AUTOIDLE_PLL);
+			omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
 	prcm_block_contents.cm_clksel1_pll =
 			omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL1_PLL);
 	prcm_block_contents.cm_clksel2_pll =
-- 
1.7.5-rc1

