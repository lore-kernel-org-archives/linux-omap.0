From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/3] ARM: OMAP2+: Add machine entry for dra72x devices
Date: Fri, 14 Mar 2014 14:50:41 +0530
Message-ID: <1394788841-15112-4-git-send-email-rnayak@ti.com>
References: <1394788841-15112-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59022 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755893AbaCNJWH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Mar 2014 05:22:07 -0400
In-Reply-To: <1394788841-15112-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, Rajendra Nayak <rnayak@ti.com>

The only difference from the dra75x devices is the missing .smp entry.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 8e3daa1..d803d99 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -253,4 +253,22 @@ DT_MACHINE_START(DRA7XX_DT, "Generic DRA7XX (Flattened Device Tree)")
 	.dt_compat	= dra7xx_boards_compat,
 	.restart	= omap44xx_restart,
 MACHINE_END
+
+static const char *dra72_boards_compat[] __initdata = {
+	"ti,dra72x",
+	"ti,dra7",
+	NULL,
+};
+
+DT_MACHINE_START(DRA72_DT, "Generic DRA72 (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= omap5_map_io,
+	.init_early	= dra7xx_init_early,
+	.init_late	= dra7xx_init_late,
+	.init_irq	= omap_gic_of_init,
+	.init_machine	= omap_generic_init,
+	.init_time	= omap5_realtime_timer_init,
+	.dt_compat	= dra72_boards_compat,
+	.restart	= omap44xx_restart,
+MACHINE_END
 #endif
-- 
1.7.9.5

