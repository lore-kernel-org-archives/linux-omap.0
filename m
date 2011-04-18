From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 1/3] OMAP3: l3: fix for "irq 10: nobody cared" message
Date: Mon, 18 Apr 2011 11:39:40 -0500
Message-ID: <1303144782-5591-2-git-send-email-omar.ramirez@ti.com>
References: <1303144782-5591-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38655 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755848Ab1DRQvP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 12:51:15 -0400
In-Reply-To: <1303144782-5591-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>

If an error occurs in the L3 on any other initiator than MPU,
the interrupt goes unhandled given that the 'base' register
was calculated with the initialized err_source value (which
coincidentally points to MPU) and not with the actual source
of the error.

Removed parenthesis that are not needed for the touched lines.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_l3_smx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
index 5f2da75..4321e79 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.c
+++ b/arch/arm/mach-omap2/omap_l3_smx.c
@@ -196,11 +196,11 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 		/* No timeout error for debug sources */
 	}
 
-	base = ((l3->rt) + (*(omap3_l3_bases[int_type] + err_source)));
-
 	/* identify the error source */
 	for (err_source = 0; !(status & (1 << err_source)); err_source++)
 									;
+
+	base = l3->rt + *(omap3_l3_bases[int_type] + err_source);
 	error = omap3_l3_readll(base, L3_ERROR_LOG);
 
 	if (error) {
-- 
1.7.1

