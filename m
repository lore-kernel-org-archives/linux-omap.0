From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Date: Mon, 30 Dec 2013 15:19:09 +0200
Message-ID: <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ivaylo Dimitrov <freemangordon@abv.bg>, Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

The omapfb driver uses dma_alloc to reserve memory for the framebuffers.
However, on some use cases, even when CMA is in use, it's quite probable
that omapfb fails to allocate the fb, either due to not enough free dma
memory, fragmented dma memory, or CMA failing to make enough contiguous
space.

This patch adds a kernel cmdline parameter 'omapfb_vram' which can be
used to give the size of a memory area reserved exclusively for omapfb,
and optionally a physical address where the memory area is reserved.

The memory area is reserved with memblock, and assigned to omapfb with
dma_declare_coherent_memory. The dma_alloc function will first try to
allocate the fb from the coherent memory area, and if that fails, it'll
use the normal method of allocation.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ivaylo Dimitrov <freemangordon@abv.bg>
---
 arch/arm/mach-omap2/common.c |  1 +
 arch/arm/mach-omap2/common.h |  2 ++
 arch/arm/mach-omap2/fb.c     | 77 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 2dabb9ecb986..9beecded0380 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -33,4 +33,5 @@ void __init omap_reserve(void)
 	omap_dsp_reserve_sdram_memblock();
 	omap_secure_ram_reserve_memblock();
 	omap_barrier_reserve_memblock();
+	omap_fb_reserve_memblock();
 }
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index e30ef6797c63..21afdc0fe15e 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -304,6 +304,8 @@ extern void omap_reserve(void);
 struct omap_hwmod;
 extern int omap_dss_reset(struct omap_hwmod *);
 
+extern void omap_fb_reserve_memblock(void);
+
 /* SoC specific clock initializer */
 extern int (*omap_clk_init)(void);
 
diff --git a/arch/arm/mach-omap2/fb.c b/arch/arm/mach-omap2/fb.c
index 26e28e94f625..80630329e508 100644
--- a/arch/arm/mach-omap2/fb.c
+++ b/arch/arm/mach-omap2/fb.c
@@ -30,9 +30,11 @@
 #include <linux/dma-mapping.h>
 
 #include <asm/mach/map.h>
+#include <asm/memblock.h>
 
 #include "soc.h"
 #include "display.h"
+#include "common.h"
 
 #ifdef CONFIG_OMAP2_VRFB
 
@@ -106,10 +108,83 @@ static struct platform_device omap_fb_device = {
 	.num_resources = 0,
 };
 
+static phys_addr_t omapfb_mem_base __initdata;
+static phys_addr_t omapfb_mem_size __initdata;
+
+static int __init early_omapfb_vram(char *p)
+{
+	omapfb_mem_size = memparse(p, &p);
+
+	if (!omapfb_mem_size) {
+		pr_err("omapfb: bad size for 'omapfb_vram' param\n");
+		return 0;
+	}
+
+	if (*p == '@') {
+		omapfb_mem_base = memparse(p + 1, NULL);
+
+		if (!omapfb_mem_base) {
+			pr_err("omapfb: bad addr for 'omapfb_vram' param\n");
+			omapfb_mem_size = 0;
+			return 0;
+		}
+	}
+
+	return 0;
+}
+early_param("omapfb_vram", early_omapfb_vram);
+
+void __init omap_fb_reserve_memblock(void)
+{
+	int r;
+
+	if (!omapfb_mem_size)
+		return;
+
+	if (omapfb_mem_base) {
+		r = memblock_reserve(omapfb_mem_base, omapfb_mem_size);
+
+		if (r) {
+			pr_err("omapfb: memblock_reserve failed: %d\n", r);
+			return;
+		}
+	} else {
+		omapfb_mem_base = memblock_alloc(omapfb_mem_size, SZ_1M);
+
+		if (!omapfb_mem_base) {
+			pr_err("omapfb: memblock_alloc failed\n");
+			return;
+		}
+	}
+
+	memblock_free(omapfb_mem_base, omapfb_mem_size);
+	memblock_remove(omapfb_mem_base, omapfb_mem_size);
+
+	pr_info("omapfb: reserved %pa bytes at %pa\n",
+			&omapfb_mem_size, &omapfb_mem_base);
+}
+
 int __init omap_init_fb(void)
 {
-	return platform_device_register(&omap_fb_device);
+	int r;
+
+	r = platform_device_register(&omap_fb_device);
+
+	if (r)
+		return r;
+
+	if (!omapfb_mem_base)
+		return 0;
+
+	r = dma_declare_coherent_memory(&omap_fb_device.dev,
+					  omapfb_mem_base, omapfb_mem_base,
+					  omapfb_mem_size, DMA_MEMORY_MAP);
+	if (!(r & DMA_MEMORY_MAP))
+		pr_err("omapfb: dma_declare_coherent_memory failed\n");
+
+	return 0;
 }
+
 #else
 int __init omap_init_fb(void) { return 0; }
 #endif
-- 
1.8.3.2
