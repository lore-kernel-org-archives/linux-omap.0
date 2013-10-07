From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] Documentation: dt: OMAP: standardize SoC naming definition
Date: Mon, 7 Oct 2013 11:49:42 -0500
Message-ID: <1381164584-4008-2-git-send-email-nm@ti.com>
References: <523C9D8B.2000701@ti.com>
 <1381164584-4008-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381164584-4008-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Felipe <balbi@ti.com>, Olof Johansson <olof@lixom.net>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

SoC family definitions at the moment are reactive to board needs
as a result, beagle-xm would matchup with ti,omap3 which invokes
omap3430_init_early instead of omap3630_init_early. Obviously, this is
the wrong behavior.

Eventually, we will have descriptors match only with SoC types and
should not contain anything specific to board handling.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../devicetree/bindings/arm/omap/omap.txt          |   45 ++++++++++++++++++++
 arch/arm/mach-omap2/board-generic.c                |   23 ++++++++++
 2 files changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 91b7049..28b20a2 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -30,6 +30,51 @@ spinlock@1 {
     ti,hwmods = "spinlock";
 };
 
+SoC Type(optional):
+- ti,gp	- General Purpose devices
+- ti,hs	- High Security devices
+
+SoC Families:
+
+- OMAP2 generic - defaults to OMAP2420
+  compatible = "ti,omap2"
+- OMAP3 generic - defaults to OMAP3430
+  compatible = "ti,omap3"
+- OMAP4 generic - defaults to OMAP4430
+  compatible = "ti,omap4"
+- OMAP5 generic - defaults to OMAP5430
+  compatible = "ti,omap5"
+- DRA7 generic - defaults to DRA742
+  compatible = "ti,dra7"
+- AM43x generic - defaults to AM437x
+  compatible = "ti,am43"
+
+SoCs:
+
+- OMAP2420
+  compatible = "ti,omap2420", "ti,omap2"
+- OMAP2430
+  compatible = "ti,omap2430", "ti,omap2"
+
+- OMAP3430
+  compatible = "ti,omap343x", "ti,omap3"
+- OMAP3630
+  compatible = "ti,omap363x", "ti,omap3"
+- AM33xx
+  compatible = "ti,am33xx", "ti,omap3"
+
+- OMAP4430
+  compatible = "ti,omap443x", "ti,omap4"
+- OMAP4460
+  compatible = "ti,omap446x", "ti,omap4"
+
+- OMAP5430
+  compatible = "ti,omap5430", "ti,omap5"
+- OMAP5432
+  compatible = "ti,omap5432", "ti,omap5"
+
+- DRA742
+  compatible = "ti,dra7xx", "ti,dra7"
 
 Boards:
 
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 39c7838..c78b070 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -113,6 +113,7 @@ MACHINE_END
 #ifdef CONFIG_ARCH_OMAP3
 static const char *omap3_boards_compat[] __initdata = {
 	"ti,omap3",
+	"ti,omap343x",
 	NULL,
 };
 
@@ -129,6 +130,24 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.restart	= omap3xxx_restart,
 MACHINE_END
 
+static const char *omap36xx_boards_compat[] __initdata = {
+	"ti,omap363x",
+	NULL,
+};
+
+DT_MACHINE_START(OMAP36xx_DT, "Generic OMAP363x (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= omap3630_init_early,
+	.init_irq	= omap_intc_of_init,
+	.handle_irq	= omap3_intc_handle_irq,
+	.init_machine	= omap_generic_init,
+	.init_late	= omap3_init_late,
+	.init_time	= omap3_sync32k_timer_init,
+	.dt_compat	= omap36xx_boards_compat,
+	.restart	= omap3xxx_restart,
+MACHINE_END
+
 static const char *omap3_gp_boards_compat[] __initdata = {
 	"ti,omap3-beagle",
 	"timll,omap3-devkit8000",
@@ -171,6 +190,8 @@ MACHINE_END
 #ifdef CONFIG_ARCH_OMAP4
 static const char *omap4_boards_compat[] __initdata = {
 	"ti,omap4",
+	"ti,omap4430",
+	"ti,omap4460",
 	NULL,
 };
 
@@ -191,6 +212,8 @@ MACHINE_END
 #ifdef CONFIG_SOC_OMAP5
 static const char *omap5_boards_compat[] __initdata = {
 	"ti,omap5",
+	"ti,omap5430",
+	"ti,omap5432",
 	NULL,
 };
 
-- 
1.7.9.5
