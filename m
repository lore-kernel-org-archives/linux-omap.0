From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] ARM: OMAP2+: Fix the machine entry for am3517
Date: Tue,  3 Dec 2013 15:23:16 -0800
Message-ID: <1386112999-17271-3-git-send-email-tony@atomide.com>
References: <1386112999-17271-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51145 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab3LCXXX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Dec 2013 18:23:23 -0500
In-Reply-To: <1386112999-17271-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>

From: Nishanth Menon <nm@ti.com>

The am3517 is wrongly booting as omap3 which means that the am3517
specific devices like Ethernet won't work when booted with device
tree. Now with the new devices defined in am3517.dtsi, let's use
that instead of the omap3.dtsi, and add a separate machine entry
for am3517 so am3517-evm can use it.

Signed-off-by: Nishanth Menon <nm@ti.com>
[tony@atomide.com: updated comments]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am3517-evm.dts    |  6 +++---
 arch/arm/mach-omap2/board-generic.c | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index e99dfaf..03fcbf0 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -7,11 +7,11 @@
  */
 /dts-v1/;
 
-#include "omap34xx.dtsi"
+#include "am3517.dtsi"
 
 / {
-	model = "TI AM3517 EVM (AM3517/05)";
-	compatible = "ti,am3517-evm", "ti,omap3";
+	model = "TI AM3517 EVM (AM3517/05 TMDSEVM3517)";
+	compatible = "ti,am3517-evm", "ti,am3517", "ti,omap3";
 
 	memory {
 		device_type = "memory";
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 19f1652..e94a215 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -139,6 +139,24 @@ static const char *am33xx_boards_compat[] __initdata = {
 	NULL,
 };
 
+static const char *am3517_boards_compat[] __initdata = {
+	"ti,am3517",
+	NULL,
+};
+
+DT_MACHINE_START(AM3517_DT, "Generic AM3517 (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= am35xx_init_early,
+	.init_irq	= omap_intc_of_init,
+	.handle_irq	= omap3_intc_handle_irq,
+	.init_machine	= omap_generic_init,
+	.init_late	= omap3_init_late,
+	.init_time	= omap3_gptimer_timer_init,
+	.dt_compat	= am3517_boards_compat,
+	.restart	= omap3xxx_restart,
+MACHINE_END
+
 DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= am33xx_map_io,
-- 
1.8.1.1

