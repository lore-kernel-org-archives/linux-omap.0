From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 7/8] ARM: DRA7: board-generic: Add basic DT support
Date: Tue, 9 Jul 2013 12:57:52 +0530
Message-ID: <1373354873-12359-8-git-send-email-rnayak@ti.com>
References: <1373354873-12359-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51017 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074Ab3GIH2x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Jul 2013 03:28:53 -0400
In-Reply-To: <1373354873-12359-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, Rajendra Nayak <rnayak@ti.com>

From: R Sricharan <r.sricharan@ti.com>

Describe minimal DT boot machine details for DRA7xx based SoC's. DRA7xx
family is based on dual core ARM CORTEX A15 using GIC as the interrupt controller.
The PRCM and timer infrastructure is reused from OMAP5 and so are the io
descriptor tables.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../devicetree/bindings/arm/omap/omap.txt          |    3 +++
 arch/arm/mach-omap2/board-generic.c                |   18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 6d498c7..91b7049 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -59,3 +59,6 @@ Boards:
 
 - AM43x EPOS EVM
   compatible = "ti,am43x-epos-evm", "ti,am4372", "ti,am43"
+
+- DRA7 EVM:  Software Developement Board for DRA7XX
+  compatible = "ti,dra7-evm", "ti,dra7"
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index e5fbfed..92f8dd3 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -201,3 +201,21 @@ DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
 	.dt_compat	= am43_boards_compat,
 MACHINE_END
 #endif
+
+#ifdef CONFIG_SOC_DRA7XX
+static const char *dra7xx_boards_compat[] __initdata = {
+	"ti,dra7",
+	NULL,
+};
+
+DT_MACHINE_START(DRA7XX_DT, "Generic DRA7XX (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.smp		= smp_ops(omap4_smp_ops),
+	.map_io		= omap5_map_io,
+	.init_early	= dra7xx_init_early,
+	.init_irq	= omap_gic_of_init,
+	.init_machine	= omap_generic_init,
+	.init_time	= omap5_realtime_timer_init,
+	.dt_compat	= dra7xx_boards_compat,
+MACHINE_END
+#endif
-- 
1.7.9.5

