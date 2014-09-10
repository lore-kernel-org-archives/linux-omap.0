From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 3/3] ARM: OMAP4+: Remove static iotable mappings for SRAM
Date: Wed, 10 Sep 2014 11:04:04 -0500
Message-ID: <3e5c2bcdc4b395d4fa0aa0a1e1273b3188006768.1410362895.git.d-gerlach@ti.com>
References: <cover.1410362895.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59446 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbaIJQE1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Sep 2014 12:04:27 -0400
In-Reply-To: <cover.1410362895.git.d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

In order to handle errata I688, a page of sram was reserved by doing a
static iotable map. Now that we use gen_pool to manage sram, we can
completely remove all of these static mappings and use gen_pool_alloc()
to get the one page of sram space needed to implement errata I688.
omap_bus_sync will be NOP until SRAM initialization happens.

Suggested-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
v2->v3: add check for null sram_pool

 Documentation/devicetree/bindings/arm/omap/mpu.txt |  3 +++
 arch/arm/boot/dts/omap4.dtsi                       |  1 +
 arch/arm/boot/dts/omap5.dtsi                       |  3 ++-
 arch/arm/mach-omap2/io.c                           | 17 -----------------
 arch/arm/mach-omap2/omap4-common.c                 | 22 +++++++++++++++++++++-
 arch/arm/mach-omap2/sram.c                         |  6 ------
 arch/arm/mach-omap2/sram.h                         |  6 ------
 7 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/mpu.txt b/Documentation/devicetree/bindings/arm/omap/mpu.txt
index 83f405b..763695d 100644
--- a/Documentation/devicetree/bindings/arm/omap/mpu.txt
+++ b/Documentation/devicetree/bindings/arm/omap/mpu.txt
@@ -10,6 +10,9 @@ Required properties:
 	       Should be "ti,omap5-mpu" for OMAP5
 - ti,hwmods: "mpu"
 
+Optional properties:
+- sram:	Phandle to the ocmcram node
+
 Examples:
 
 - For an OMAP5 SMP system:
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index f584611..42a2d12 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -81,6 +81,7 @@
 		mpu {
 			compatible = "ti,omap4-mpu";
 			ti,hwmods = "mpu";
+			sram = <&ocmcram>;
 		};
 
 		dsp {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index d4e6976..dff19bd 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -104,8 +104,9 @@
 	soc {
 		compatible = "ti,omap-infra";
 		mpu {
-			compatible = "ti,omap5-mpu";
+			compatible = "ti,omap4-mpu";
 			ti,hwmods = "mpu";
+			sram = <&ocmcram>;
 		};
 	};
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5d0667c..a80ee95 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -231,15 +231,6 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
 		.length		= L4_PER_44XX_SIZE,
 		.type		= MT_DEVICE,
 	},
-#ifdef CONFIG_OMAP4_ERRATA_I688
-	{
-		.virtual	= OMAP4_SRAM_VA,
-		.pfn		= __phys_to_pfn(OMAP4_SRAM_PA),
-		.length		= PAGE_SIZE,
-		.type		= MT_MEMORY_RW_SO,
-	},
-#endif
-
 };
 #endif
 
@@ -269,14 +260,6 @@ static struct map_desc omap54xx_io_desc[] __initdata = {
 		.length		= L4_PER_54XX_SIZE,
 		.type		= MT_DEVICE,
 	},
-#ifdef CONFIG_OMAP4_ERRATA_I688
-	{
-		.virtual	= OMAP4_SRAM_VA,
-		.pfn		= __phys_to_pfn(OMAP4_SRAM_PA),
-		.length		= PAGE_SIZE,
-		.type		= MT_MEMORY_RW_SO,
-	},
-#endif
 };
 #endif
 
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index a0fe747..16b20ce 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -25,6 +25,7 @@
 #include <linux/irqchip/irq-crossbar.h>
 #include <linux/of_address.h>
 #include <linux/reboot.h>
+#include <linux/genalloc.h>
 
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
@@ -71,6 +72,26 @@ void omap_bus_sync(void)
 }
 EXPORT_SYMBOL(omap_bus_sync);
 
+static int __init omap4_sram_init(void)
+{
+	struct device_node *np;
+	struct gen_pool *sram_pool;
+
+	np = of_find_compatible_node(NULL, NULL, "ti,omap4-mpu");
+	if (!np)
+		pr_warn("%s:Unable to allocate sram needed to handle errata I688\n",
+			__func__);
+	sram_pool = of_get_named_gen_pool(np, "sram", 0);
+	if (!sram_pool)
+		pr_warn("%s:Unable to get sram pool needed to handle errata I688\n",
+			__func__);
+	else
+		sram_sync = (void *)gen_pool_alloc(sram_pool, PAGE_SIZE);
+
+	return 0;
+}
+omap_arch_initcall(omap4_sram_init);
+
 /* Steal one page physical memory for barrier implementation */
 int __init omap_barrier_reserve_memblock(void)
 {
@@ -91,7 +112,6 @@ void __init omap_barriers_init(void)
 	dram_io_desc[0].type = MT_MEMORY_RW_SO;
 	iotable_init(dram_io_desc, ARRAY_SIZE(dram_io_desc));
 	dram_sync = (void __iomem *) dram_io_desc[0].virtual;
-	sram_sync = (void __iomem *) OMAP4_SRAM_VA;
 
 	pr_info("OMAP4: Map 0x%08llx to 0x%08lx for dram barrier\n",
 		(long long) paddr, dram_io_desc[0].virtual);
diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index e5ac29d..cd488b8 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -124,12 +124,6 @@ static void __init omap2_map_sram(void)
 {
 	int cached = 1;
 
-#ifdef CONFIG_OMAP4_ERRATA_I688
-	if (cpu_is_omap44xx()) {
-		omap_sram_start += PAGE_SIZE;
-		omap_sram_size -= SZ_16K;
-	}
-#endif
 	if (cpu_is_omap34xx()) {
 		/*
 		 * SRAM must be marked as non-cached on OMAP3 since the
diff --git a/arch/arm/mach-omap2/sram.h b/arch/arm/mach-omap2/sram.h
index 3f83b80..948d3ed 100644
--- a/arch/arm/mach-omap2/sram.h
+++ b/arch/arm/mach-omap2/sram.h
@@ -74,9 +74,3 @@ static inline void omap_push_sram_idle(void) {}
  */
 #define OMAP2_SRAM_PA		0x40200000
 #define OMAP3_SRAM_PA           0x40200000
-#ifdef CONFIG_OMAP4_ERRATA_I688
-#define OMAP4_SRAM_PA		0x40304000
-#define OMAP4_SRAM_VA		0xfe404000
-#else
-#define OMAP4_SRAM_PA		0x40300000
-#endif
-- 
1.9.0

