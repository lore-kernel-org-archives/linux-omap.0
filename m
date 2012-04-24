From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/7] ARM: OMAP2+: Move omap_dsp_reserve_sdram_memblock() to
 mach-omap2
Date: Mon, 23 Apr 2012 17:08:30 -0700
Message-ID: <20120424000830.17783.42727.stgit@muffinssi.local>
References: <20120424000607.17783.81686.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40160 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab2DXAIb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 20:08:31 -0400
In-Reply-To: <20120424000607.17783.81686.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This hardware exists only on 2430 and later omaps, so there's no
need to have it in plat-omap/devices.c.

Note that we don't have any users for exported omap_dsp_get_mempool_base(),
so we can make it static.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/dsp.c    |   27 +++++++++++++++++++++++++--
 arch/arm/plat-omap/devices.c |   29 -----------------------------
 2 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
index 74f18f2..0b8dc3f 100644
--- a/arch/arm/mach-omap2/dsp.c
+++ b/arch/arm/mach-omap2/dsp.c
@@ -28,8 +28,6 @@
 
 #include <plat/dsp.h>
 
-extern phys_addr_t omap_dsp_get_mempool_base(void);
-
 static struct platform_device *omap_dsp_pdev;
 
 static struct omap_dsp_platform_data omap_dsp_pdata __initdata = {
@@ -47,6 +45,31 @@ static struct omap_dsp_platform_data omap_dsp_pdata __initdata = {
 	.dsp_cm_rmw_bits = omap2_cm_rmw_mod_reg_bits,
 };
 
+static phys_addr_t omap_dsp_phys_mempool_base;
+
+void __init omap_dsp_reserve_sdram_memblock(void)
+{
+	phys_addr_t size = CONFIG_TIDSPBRIDGE_MEMPOOL_SIZE;
+	phys_addr_t paddr;
+
+	if (!size)
+		return;
+
+	paddr = arm_memblock_steal(size, SZ_1M);
+	if (!paddr) {
+		pr_err("%s: failed to reserve %x bytes\n",
+				__func__, size);
+		return;
+	}
+
+	omap_dsp_phys_mempool_base = paddr;
+}
+
+static phys_addr_t omap_dsp_get_mempool_base(void)
+{
+	return omap_dsp_phys_mempool_base;
+}
+
 static int __init omap_dsp_init(void)
 {
 	struct platform_device *pdev;
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index a0cfe66..1151d0b 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -109,35 +109,6 @@ static void omap_init_rng(void)
 static inline void omap_init_rng(void) {}
 #endif
 
-#if defined(CONFIG_TIDSPBRIDGE) || defined(CONFIG_TIDSPBRIDGE_MODULE)
-
-static phys_addr_t omap_dsp_phys_mempool_base;
-
-void __init omap_dsp_reserve_sdram_memblock(void)
-{
-	phys_addr_t size = CONFIG_TIDSPBRIDGE_MEMPOOL_SIZE;
-	phys_addr_t paddr;
-
-	if (!size)
-		return;
-
-	paddr = arm_memblock_steal(size, SZ_1M);
-	if (!paddr) {
-		pr_err("%s: failed to reserve %x bytes\n",
-				__func__, size);
-		return;
-	}
-
-	omap_dsp_phys_mempool_base = paddr;
-}
-
-phys_addr_t omap_dsp_get_mempool_base(void)
-{
-	return omap_dsp_phys_mempool_base;
-}
-EXPORT_SYMBOL(omap_dsp_get_mempool_base);
-#endif
-
 /*
  * This gets called after board-specific INIT_MACHINE, and initializes most
  * on-chip peripherals accessible on this board (except for few like USB):

