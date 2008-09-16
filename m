From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/6] OMAP3 clock: add idlest_reg, idlest_mask for DPLL3
Date: Tue, 16 Sep 2008 06:16:20 -0600
Message-ID: <20080916121618.4666.46424.stgit@localhost.localdomain>
References: <20080916121521.4666.61245.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58332 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbYIPMRj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 08:17:39 -0400
In-Reply-To: <20080916121521.4666.61245.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

DPLL3 dpll_data was missing idlest_* fields - add them.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 044a3ff..19c3881 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -441,6 +441,8 @@ static struct dpll_data dpll3_dd = {
 	.recal_st_bit	= OMAP3430_CORE_DPLL_ST_SHIFT,
 	.autoidle_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
 	.autoidle_mask	= OMAP3430_AUTO_CORE_DPLL_MASK,
+	.idlest_reg	= _OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.idlest_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.max_multiplier = OMAP3_MAX_DPLL_MULT,
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE


