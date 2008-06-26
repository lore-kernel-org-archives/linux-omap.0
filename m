From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/4] OMAP2 clock: check register address in
	omap2_clk_wait_ready()
Date: Thu, 26 Jun 2008 01:09:21 -0600
Message-ID: <20080626070915.16555.41229.stgit@localhost.localdomain>
References: <20080626070305.16555.96759.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42972 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbYFZHLn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 03:11:43 -0400
In-Reply-To: <20080626070305.16555.96759.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: gadiyar@ti.com, k.kooi@student.utwente.nl, dirk.behme@googlemail.com, igor.stoppa@nokia.com, r-woodruff2@ti.com, jouni.hogander@nokia.com

The test in omap2_clk_wait_ready() for DSS or CAM clocks didn't
verify that the PRCM {F,I}CLKEN1 register was in the CORE powerdomain.
Add this check in.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 59b042f..577be44 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -236,13 +236,17 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	else
 		return;
 
-	/* No check for DSS or CAM clocks on 24xx */
-	/* REVISIT: This should check prcm_mod against CORE_MOD */
-	if (cpu_is_omap24xx() && (reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
+	/* 24xx: DSS and CAM have no idlest bits for their target agents */
+	if (cpu_is_omap24xx() &&
+	    (prcm_mod == OMAP2420_CM_REGADDR(CORE_MOD, 0) ||
+	     prcm_mod == OMAP2430_CM_REGADDR(CORE_MOD, 0)) &&
+	    (reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
+
 		if (clk->enable_bit == OMAP24XX_EN_DSS2_SHIFT ||
 		    clk->enable_bit == OMAP24XX_EN_DSS1_SHIFT ||
 		    clk->enable_bit == OMAP24XX_EN_CAM_SHIFT)
 			return;
+
 	}
 
 	/* REVISIT: What are the appropriate exclusions for 34XX? */


