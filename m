From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 3/3] ARM: OMAP4+: Remove static iotable mappings for SRAM
Date: Thu, 29 Aug 2013 16:53:11 +0530
Message-ID: <1377775391-13103-4-git-send-email-rnayak@ti.com>
References: <1377775391-13103-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40715 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755991Ab3H2LXz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 07:23:55 -0400
In-Reply-To: <1377775391-13103-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com, nsekhar@ti.com, santosh.shilimkar@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>

In order to handle errata I688, a page of sram was reserved by doing a
static iotable map. Now that we use gen_pool to manage sram, we can
completely remove all of these static mappings and use gen_pool_alloc()
to get the one page of sram space needed to implement errata I688.

Suggested-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/mpu.txt |    5 ++++-
 arch/arm/boot/dts/omap4.dtsi                       |    1 +
 arch/arm/boot/dts/omap5.dtsi                       |    3 ++-
 arch/arm/mach-omap2/io.c                           |   17 -----------------
 arch/arm/mach-omap2/omap4-common.c                 |   17 ++++++++++++++++-
 arch/arm/mach-omap2/sram.c                         |    6 ------
 arch/arm/mach-omap2/sram.h                         |    6 ------
 7 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/mpu.txt b/Documentation/devicetree/bindings/arm/omap/mpu.txt
index 1a5a42c..8915ba3 100644
--- a/Documentation/devicetree/bindings/arm/omap/mpu.txt
+++ b/Documentation/devicetree/bindings/arm/omap/mpu.txt
@@ -6,9 +6,12 @@ The MPU contain CPUs, GIC, L2 cache and a local PRCM.
 
 Required properties:
 - compatible : Should be "ti,omap3-mpu" for OMAP3
-               Should be "ti,omap4-mpu" for OMAP4
+               Should be "ti,omap4-mpu" for OMAP4 and OMAP5
 - ti,hwmods: "mpu"
 
+Optional properties:
+- sram:	Phandle to the ocmcram node
+
 Examples:
 
 - For an OMAP4 SMP system:
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 1ba6a77..9114241 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -71,6 +71,7 @@
 		mpu {
 			compatible = "ti,omap4-mpu";
 			ti,hwmods = "mpu";
+			sram = <&ocmcram>;
 		};
 
 		dsp {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 461ffd8..e9b735b 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -72,8 +72,9 @@
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
index 4a3f06f..8b2334e 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -239,15 +239,6 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
 		.length		= L4_PER_44XX_SIZE,
 		.type		= MT_DEVICE,
 	},
-#ifdef CONFIG_OMAP4_ERRATA_I688
-	{
-		.virtual	= OMAP4_SRAM_VA,
-		.pfn		= __phys_to_pfn(OMAP4_SRAM_PA),
-		.length		= PAGE_SIZE,
-		.type		= MT_MEMORY_SO,
-	},
-#endif
-
 };
 #endif
 
@@ -277,14 +268,6 @@ static struct map_desc omap54xx_io_desc[] __initdata = {
 		.length		= L4_PER_54XX_SIZE,
 		.type		= MT_DEVICE,
 	},
-#ifdef CONFIG_OMAP4_ERRATA_I688
-	{
-		.virtual	= OMAP4_SRAM_VA,
-		.pfn		= __phys_to_pfn(OMAP4_SRAM_PA),
-		.length		= PAGE_SIZE,
-		.type		= MT_MEMORY_SO,
-	},
-#endif
 };
 #endif
 
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 5791143..6b5ffb3 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -24,6 +24,7 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/of_address.h>
 #include <linux/reboot.h>
+#include <linux/genalloc.h>
 
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
@@ -71,6 +72,21 @@ void omap_bus_sync(void)
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
+			 __func__);
+	sram_pool = of_get_named_gen_pool(np, "sram", 0);
+	sram_sync = (void *)gen_pool_alloc(sram_pool, PAGE_SIZE);
+	return 0;
+}
+omap_arch_initcall(omap4_sram_init);
+
 /* Steal one page physical memory for barrier implementation */
 int __init omap_barrier_reserve_memblock(void)
 {
@@ -91,7 +107,6 @@ void __init omap_barriers_init(void)
 	dram_io_desc[0].type = MT_MEMORY_SO;
 	iotable_init(dram_io_desc, ARRAY_SIZE(dram_io_desc));
 	dram_sync = (void __iomem *) dram_io_desc[0].virtual;
-	sram_sync = (void __iomem *) OMAP4_SRAM_VA;
 
 	pr_info("OMAP4: Map 0x%08llx to 0x%08lx for dram barrier\n",
 		(long long) paddr, dram_io_desc[0].virtual);
diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index d5ecb75..8591044 100644
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
1.7.9.5

