From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v4 08/11] ARM: OMAP2+: AM33XX: Reserve memory to comply with EMIF spec
Date: Thu, 10 Jul 2014 21:55:46 -0500
Message-ID: <1405047349-15101-9-git-send-email-d-gerlach@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35355 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752283AbaGKC5q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Jul 2014 22:57:46 -0400
In-Reply-To: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Dave Gerlach <d-gerlach@ti.com>

From: Vaibhav Bedia <vaibhav.bedia@ti.com>

SDRAM controller on AM33XX requires that a modification of certain
bit-fields in PWR_MGMT_CTRL register (ref. section 7.3.5.13 in
AM335x-Rev H) is followed by a dummy read access to SDRAM. This
scenario arises when entering a low power state like DeepSleep.
To ensure that the read is not from a cached region we reserve
some memory during bootup using the arm_memblock_steal() API. The
original call to omap_reserve is removed as it is not used in any
way on am335x.

A subsequent patch will pass along the location of the reserved
memory location to the AM335x suspend handler which modifies the
PWR_MGMT_CTRL register in the EMIF.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
v3->v4:
	Left as is because of use in sram code when EMIF is off to avoid
	copying additional code. Also uses hardcoded virtual address now
	to avoid problems with himem
	
 arch/arm/mach-omap2/board-generic.c |  2 +-
 arch/arm/mach-omap2/common.c        | 32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/common.h        |  4 ++++
 arch/arm/mach-omap2/io.c            |  1 +
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 9480997..d2c435e 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -163,7 +163,7 @@ static const char *am33xx_boards_compat[] __initconst = {
 };
 
 DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
-	.reserve	= omap_reserve,
+	.reserve	= am33xx_reserve,
 	.map_io		= am33xx_map_io,
 	.init_early	= am33xx_init_early,
 	.init_irq	= omap_intc_of_init,
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 2dabb9e..df6394e 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -15,10 +15,14 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_data/dsp-omap.h>
+#include <asm/memblock.h>
+#include <asm/mach/map.h>
 
 #include "common.h"
 #include "omap-secure.h"
 
+#define AM33XX_DRAM_SYNC_VA 0xfe600000
+
 /*
  * Stub function for OMAP2 so that common files
  * continue to build when custom builds are used
@@ -34,3 +38,31 @@ void __init omap_reserve(void)
 	omap_secure_ram_reserve_memblock();
 	omap_barrier_reserve_memblock();
 }
+
+static phys_addr_t am33xx_paddr;
+static u32 am33xx_size;
+
+/* Steal one page physical memory for uncached read DeepSleep */
+void __init am33xx_reserve(void)
+{
+	am33xx_size = ALIGN(PAGE_SIZE, SZ_1M);
+	am33xx_paddr = arm_memblock_steal(am33xx_size, SZ_1M);
+
+	omap_reserve();
+}
+
+void __iomem *am33xx_dram_sync;
+
+void __init am33xx_dram_sync_init(void)
+{
+	struct map_desc dram_io_desc[1];
+
+	dram_io_desc[0].virtual = AM33XX_DRAM_SYNC_VA;
+	dram_io_desc[0].pfn = __phys_to_pfn(am33xx_paddr);
+	dram_io_desc[0].length = am33xx_size;
+	dram_io_desc[0].type = MT_MEMORY_RW_SO;
+
+	iotable_init(dram_io_desc, ARRAY_SIZE(dram_io_desc));
+
+	am33xx_dram_sync = (void __iomem *) dram_io_desc[0].virtual;
+}
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index b2d252b..1536338 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -316,6 +316,10 @@ extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 struct omap2_hsmmc_info;
 extern void omap_reserve(void);
 
+extern void am33xx_reserve(void);
+extern void am33xx_dram_sync_init(void);
+extern void __iomem *am33xx_dram_sync;
+
 struct omap_hwmod;
 extern int omap_dss_reset(struct omap_hwmod *);
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 8f55945..4d4d150 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -313,6 +313,7 @@ void __init ti81xx_map_io(void)
 void __init am33xx_map_io(void)
 {
 	iotable_init(omapam33xx_io_desc, ARRAY_SIZE(omapam33xx_io_desc));
+	am33xx_dram_sync_init();
 }
 #endif
 
-- 
1.9.0

