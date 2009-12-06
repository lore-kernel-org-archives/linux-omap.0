From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: [PATCH] arch/arm/plat-omap/devices.c - sort alphabetically
Date: Sun, 6 Dec 2009 19:03:03 +0100
Message-ID: <20091206180303.GA3057@localhost.localdomain>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:42634 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933887AbZLFRDB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 6 Dec 2009 12:03:01 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Comment in omap_init_devices asks to keep init calls and their
implementations in alphabetical order, so let it be that way.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index f866178..30b5db7 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -242,6 +242,39 @@ fail:
 
 /*-------------------------------------------------------------------------*/
 
+#if defined(CONFIG_HW_RANDOM_OMAP) || defined(CONFIG_HW_RANDOM_OMAP_MODULE)
+
+#ifdef CONFIG_ARCH_OMAP24XX
+#define	OMAP_RNG_BASE		0x480A0000
+#else
+#define	OMAP_RNG_BASE		0xfffe5000
+#endif
+
+static struct resource rng_resources[] = {
+	{
+		.start		= OMAP_RNG_BASE,
+		.end		= OMAP_RNG_BASE + 0x4f,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap_rng_device = {
+	.name		= "omap_rng",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(rng_resources),
+	.resource	= rng_resources,
+};
+
+static void omap_init_rng(void)
+{
+	(void) platform_device_register(&omap_rng_device);
+}
+#else
+static inline void omap_init_rng(void) {}
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 /* Numbering for the SPI-capable controllers when used for SPI:
  * spi		= 1
  * uwire	= 2
@@ -324,39 +357,6 @@ static void omap_init_wdt(void)
 static inline void omap_init_wdt(void) {}
 #endif
 
-/*-------------------------------------------------------------------------*/
-
-#if defined(CONFIG_HW_RANDOM_OMAP) || defined(CONFIG_HW_RANDOM_OMAP_MODULE)
-
-#ifdef CONFIG_ARCH_OMAP24XX
-#define	OMAP_RNG_BASE		0x480A0000
-#else
-#define	OMAP_RNG_BASE		0xfffe5000
-#endif
-
-static struct resource rng_resources[] = {
-	{
-		.start		= OMAP_RNG_BASE,
-		.end		= OMAP_RNG_BASE + 0x4f,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap_rng_device = {
-	.name	   = "omap_rng",
-	.id	     = -1,
-	.num_resources	= ARRAY_SIZE(rng_resources),
-	.resource	= rng_resources,
-};
-
-static void omap_init_rng(void)
-{
-	(void) platform_device_register(&omap_rng_device);
-}
-#else
-static inline void omap_init_rng(void) {}
-#endif
-
 /*
  * This gets called after board-specific INIT_MACHINE, and initializes most
  * on-chip peripherals accessible on this board (except for few like USB):
@@ -384,9 +384,9 @@ static int __init omap_init_devices(void)
 	 */
 	omap_init_dsp();
 	omap_init_kp();
+	omap_init_rng();
 	omap_init_uwire();
 	omap_init_wdt();
-	omap_init_rng();
 	return 0;
 }
 arch_initcall(omap_init_devices);
