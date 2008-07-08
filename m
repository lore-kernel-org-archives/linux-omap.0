From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 8/9] OMAP3 clock/SRAM: fix CORE DPLL M2 divider mask
Date: Mon, 07 Jul 2008 20:55:11 -0600
Message-ID: <20080708025510.11646.80186.stgit@localhost.localdomain>
References: <20080708025225.11646.55912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40864 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841AbYGHC4i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2008 22:56:38 -0400
In-Reply-To: <20080708025225.11646.55912.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

3430ES2+ CORE DPLL M2 divider can divide by 1 to 31, unlike ES1, which
was more limited.  The SRAM code currently only supports dividing by 1
or 2, but we should mask off the full range of bits to guard against
the event that the previous contents of CM_CLKSEL_PLL1 included an M2
divider > 2.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/sram34xx.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 63db781..1acdbe8 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -173,7 +173,7 @@ omap3_sdrc_dlla_status:
 omap3_sdrc_dlla_ctrl:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
 core_m2_mask_val:
-	.word 0xE7FFFFFF
+	.word 0x07FFFFFF
 
 ENTRY(omap3_sram_configure_core_dpll_sz)
 	.word	. - omap3_sram_configure_core_dpll


