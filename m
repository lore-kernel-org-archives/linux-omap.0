From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: OMAP3: board-generic: Add missing omap3_init_late
Date: Tue, 19 Feb 2013 18:28:31 +0530
Message-ID: <1361278711-17672-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48114 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757000Ab3BSNAB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Feb 2013 08:00:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>

The .init_late callback for OMAP3 has been missing for DT
builds, which causes a lot of late PM initializations to
be missed in turn.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 53cb380b..9b35329 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -103,6 +103,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
+	.init_late	= omap3_init_late,
 	.timer		= &omap3_timer,
 	.dt_compat	= omap3_boards_compat,
 	.restart	= omap3xxx_restart,
@@ -120,6 +121,7 @@ DT_MACHINE_START(OMAP3_GP_DT, "Generic OMAP3-GP (Flattened Device Tree)")
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
+	.init_late	= omap3_init_late,
 	.timer		= &omap3_secure_timer,
 	.dt_compat	= omap3_gp_boards_compat,
 	.restart	= omap3xxx_restart,
-- 
1.7.9.5

