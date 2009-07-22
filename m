From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: [PATCH]OMAP4: McSPI Support for OMAP4430
Date: Wed, 22 Jul 2009 19:24:26 +0530 (IST)
Message-ID: <58614.192.168.10.89.1248270866.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37373 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbZGVNys (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jul 2009 09:54:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: david-b@pacbell.net
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Patch updated as it was line wrapped in previous submission.

-Rafiuddin.Syed

This patch adds McSPI support for OMAP4430 SDP platform. All the base addresses
are changed between OMAP1/2/3 and OMAP4.The fields of the resource structures
are filled at runtime to have McSPI support on OMAP4.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: David Brownell <david-b@pacbell.net>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/devices.c |   29 +++++++++++++++++++++++------
 drivers/spi/omap2_mcspi.c     |   10 ++++++----
 2 files changed, 29 insertions(+), 10 deletions(-)

Index: kernel-omap4-base/arch/arm/mach-omap2/devices.c
===================================================================
--- kernel-omap4-base.orig/arch/arm/mach-omap2/devices.c
+++ kernel-omap4-base/arch/arm/mach-omap2/devices.c
@@ -257,6 +257,11 @@ static inline void omap_init_sti(void) {
 #define OMAP2_MCSPI3_BASE		0x480b8000
 #define OMAP2_MCSPI4_BASE		0x480ba000

+#define OMAP4_MCSPI1_BASE		0x48098100
+#define OMAP4_MCSPI2_BASE		0x4809a100
+#define OMAP4_MCSPI3_BASE		0x480b8100
+#define OMAP4_MCSPI4_BASE		0x480ba100
+
 static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
 	.num_cs		= 4,
 };
@@ -301,7 +306,8 @@ static struct platform_device omap2_mcsp
 	},
 };

-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4)
 static struct omap2_mcspi_platform_config omap2_mcspi3_config = {
 	.num_cs		= 2,
 };
@@ -325,7 +331,7 @@ static struct platform_device omap2_mcsp
 };
 #endif

-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct omap2_mcspi_platform_config omap2_mcspi4_config = {
 	.num_cs		= 1,
 };
@@ -351,14 +357,25 @@ static struct platform_device omap2_mcsp

 static void omap_init_mcspi(void)
 {
+	if (cpu_is_omap44xx()) {
+		omap2_mcspi1_resources[0].start	= OMAP4_MCSPI1_BASE;
+		omap2_mcspi1_resources[0].end	= OMAP4_MCSPI1_BASE + 0xff;
+		omap2_mcspi2_resources[0].start	= OMAP4_MCSPI2_BASE;
+		omap2_mcspi2_resources[0].end	= OMAP4_MCSPI2_BASE + 0xff;
+		omap2_mcspi3_resources[0].start	= OMAP4_MCSPI3_BASE;
+		omap2_mcspi3_resources[0].end	= OMAP4_MCSPI3_BASE + 0xff;
+		omap2_mcspi4_resources[0].start	= OMAP4_MCSPI4_BASE;
+		omap2_mcspi4_resources[0].end	= OMAP4_MCSPI4_BASE + 0xff;
+	}
 	platform_device_register(&omap2_mcspi1);
 	platform_device_register(&omap2_mcspi2);
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
-	if (cpu_is_omap2430() || cpu_is_omap343x())
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4)
+	if (cpu_is_omap2430() || cpu_is_omap343x() || cpu_is_omap44xx())
 		platform_device_register(&omap2_mcspi3);
 #endif
-#ifdef CONFIG_ARCH_OMAP3
-	if (cpu_is_omap343x())
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+	if (cpu_is_omap343x() || cpu_is_omap44xx())
 		platform_device_register(&omap2_mcspi4);
 #endif
 }
Index: kernel-omap4-base/drivers/spi/omap2_mcspi.c
===================================================================
--- kernel-omap4-base.orig/drivers/spi/omap2_mcspi.c
+++ kernel-omap4-base/drivers/spi/omap2_mcspi.c
@@ -907,7 +907,8 @@ static u8 __initdata spi2_txdma_id[] = {
 	OMAP24XX_DMA_SPI2_TX1,
 };

-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX) || \
+	 defined(CONFIG_ARCH_OMAP4)
 static u8 __initdata spi3_rxdma_id[] = {
 	OMAP24XX_DMA_SPI3_RX0,
 	OMAP24XX_DMA_SPI3_RX1,
@@ -919,7 +920,7 @@ static u8 __initdata spi3_txdma_id[] = {
 };
 #endif

-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static u8 __initdata spi4_rxdma_id[] = {
 	OMAP34XX_DMA_SPI4_RX0,
 };
@@ -949,14 +950,15 @@ static int __init omap2_mcspi_probe(stru
 		txdma_id = spi2_txdma_id;
 		num_chipselect = 2;
 		break;
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4)
 	case 3:
 		rxdma_id = spi3_rxdma_id;
 		txdma_id = spi3_txdma_id;
 		num_chipselect = 2;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	case 4:
 		rxdma_id = spi4_rxdma_id;
 		txdma_id = spi4_txdma_id;


