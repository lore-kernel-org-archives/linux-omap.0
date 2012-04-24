From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/7] ARM: OMAP1: Move omap_init_uwire to mach-omap1
Date: Mon, 23 Apr 2012 17:08:27 -0700
Message-ID: <20120424000827.17783.97333.stgit@muffinssi.local>
References: <20120424000607.17783.81686.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64125 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab2DXAIa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 20:08:30 -0400
In-Reply-To: <20120424000607.17783.81686.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This hardware exists on omap1 only and there's no need to keep it
in plat-omap/devices.c. No functional changes.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/devices.c |   44 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/devices.c  |   45 -----------------------------------------
 2 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 51387a4..b853f61 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -258,6 +258,49 @@ void __init omap1_camera_init(void *info)
 
 static inline void omap_init_sti(void) {}
 
+/* Numbering for the SPI-capable controllers when used for SPI:
+ * spi		= 1
+ * uwire	= 2
+ * mmc1..2	= 3..4
+ * mcbsp1..3	= 5..7
+ */
+
+#if defined(CONFIG_SPI_OMAP_UWIRE) || defined(CONFIG_SPI_OMAP_UWIRE_MODULE)
+
+#define	OMAP_UWIRE_BASE		0xfffb3000
+
+static struct resource uwire_resources[] = {
+	{
+		.start		= OMAP_UWIRE_BASE,
+		.end		= OMAP_UWIRE_BASE + 0x20,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap_uwire_device = {
+	.name	   = "omap_uwire",
+	.id	     = -1,
+	.num_resources	= ARRAY_SIZE(uwire_resources),
+	.resource	= uwire_resources,
+};
+
+static void omap_init_uwire(void)
+{
+	/* FIXME define and use a boot tag; not all boards will be hooking
+	 * up devices to the microwire controller, and multi-board configs
+	 * mean that CONFIG_SPI_OMAP_UWIRE may be configured anyway...
+	 */
+
+	/* board-specific code must configure chipselects (only a few
+	 * are normally used) and SCLK/SDI/SDO (each has two choices).
+	 */
+	(void) platform_device_register(&omap_uwire_device);
+}
+#else
+static inline void omap_init_uwire(void) {}
+#endif
+
+
 /*
  * This gets called after board-specific INIT_MACHINE, and initializes most
  * on-chip peripherals accessible on this board (except for few like USB):
@@ -295,6 +338,7 @@ static int __init omap1_init_devices(void)
 	omap_init_rtc();
 	omap_init_spi100k();
 	omap_init_sti();
+	omap_init_uwire();
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 60278f4..a0cfe66 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -109,50 +109,6 @@ static void omap_init_rng(void)
 static inline void omap_init_rng(void) {}
 #endif
 
-/*-------------------------------------------------------------------------*/
-
-/* Numbering for the SPI-capable controllers when used for SPI:
- * spi		= 1
- * uwire	= 2
- * mmc1..2	= 3..4
- * mcbsp1..3	= 5..7
- */
-
-#if defined(CONFIG_SPI_OMAP_UWIRE) || defined(CONFIG_SPI_OMAP_UWIRE_MODULE)
-
-#define	OMAP_UWIRE_BASE		0xfffb3000
-
-static struct resource uwire_resources[] = {
-	{
-		.start		= OMAP_UWIRE_BASE,
-		.end		= OMAP_UWIRE_BASE + 0x20,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap_uwire_device = {
-	.name	   = "omap_uwire",
-	.id	     = -1,
-	.num_resources	= ARRAY_SIZE(uwire_resources),
-	.resource	= uwire_resources,
-};
-
-static void omap_init_uwire(void)
-{
-	/* FIXME define and use a boot tag; not all boards will be hooking
-	 * up devices to the microwire controller, and multi-board configs
-	 * mean that CONFIG_SPI_OMAP_UWIRE may be configured anyway...
-	 */
-
-	/* board-specific code must configure chipselects (only a few
-	 * are normally used) and SCLK/SDI/SDO (each has two choices).
-	 */
-	(void) platform_device_register(&omap_uwire_device);
-}
-#else
-static inline void omap_init_uwire(void) {}
-#endif
-
 #if defined(CONFIG_TIDSPBRIDGE) || defined(CONFIG_TIDSPBRIDGE_MODULE)
 
 static phys_addr_t omap_dsp_phys_mempool_base;
@@ -208,7 +164,6 @@ static int __init omap_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_init_rng();
-	omap_init_uwire();
 	return 0;
 }
 arch_initcall(omap_init_devices);

