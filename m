From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/14] omap: arch/arm/plat-omap/devices.c - sort alphabetically
Date: Fri, 11 Dec 2009 15:53:04 -0800
Message-ID: <20091211235304.3189.31824.stgit@localhost>
References: <20091211234919.3189.95607.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57659 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762837AbZLKXw7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 18:52:59 -0500
In-Reply-To: <20091211234919.3189.95607.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>

From: Ladislav Michl <ladis@linux-mips.org>

Comment in omap_init_devices asks to keep init calls and their
implementations in alphabetical order, so let it be that way.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/devices.c |   68 +++++++++++++++++++++---------------------
 1 files changed, 34 insertions(+), 34 deletions(-)

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

