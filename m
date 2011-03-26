From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] OMAP3: l3: fix for "irq 10: nobody cared" message
Date: Fri, 25 Mar 2011 18:29:56 -0600
Message-ID: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49152 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932136Ab1CZAlZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 20:41:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

If an error occurs in the L3 on any other initiator than MPU,
the interrupt goes unhandled given that the 'base' register
was calculated with the initialized err_base value (which
coincidentally points to MPU) and not with the actual source
of the error.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_l3_smx.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
index 5f2da75..da917c2 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.c
+++ b/arch/arm/mach-omap2/omap_l3_smx.c
@@ -196,11 +196,12 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 		/* No timeout error for debug sources */
 	}
 
-	base = ((l3->rt) + (*(omap3_l3_bases[int_type] + err_source)));
-
 	/* identify the error source */
 	for (err_source = 0; !(status & (1 << err_source)); err_source++)
 									;
+
+	base = ((l3->rt) + (*(omap3_l3_bases[int_type] + err_source)));
+
 	error = omap3_l3_readll(base, L3_ERROR_LOG);
 
 	if (error) {
-- 
1.7.1

