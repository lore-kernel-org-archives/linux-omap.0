From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: [RESUBMIT][PATCH][RFC] OMAP4: McSPI Support for OMAP_4430
Date: Thu, 25 Jun 2009 11:54:49 +0530 (IST)
Message-ID: <51412.192.168.10.89.1245911089.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44689 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934AbZFYGYw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Jun 2009 02:24:52 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5P6OosM026941
	for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 01:24:55 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n5P6OlTK014185
	for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 01:24:48 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds McSPI support for OMAP4430 SDP platform. All the base addresses
are changed between OMAP1/2/3 and OMAP4.The fields of the resource structures
are filled at runtime to have McSPI support on OMAP4.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
---
 arch/arm/mach-omap2/devices.c |   25 +++++++++++++++++++++----
 drivers/spi/omap2_mcspi.c     |   10 ++++++----
 2 files changed, 27 insertions(+), 8 deletions(-)

Index: omap4_dev/arch/arm/mach-omap2/devices.c
===================================================================
--- omap4_dev.orig/arch/arm/mach-omap2/devices.c	2009-06-24 19:22:04.000000000
+0530
+++ omap4_dev/arch/arm/mach-omap2/devices.c	2009-06-25 10:05:39.000000000 +0530
@@ -257,6 +257,11 @@
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
@@ -301,7 +306,8 @@
 	},
 };

-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4)
 static struct omap2_mcspi_platform_config omap2_mcspi3_config = {
 	.num_cs		= 2,
 };
@@ -325,7 +331,7 @@
 };
 #endif

-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct omap2_mcspi_platform_config omap2_mcspi4_config = {
 	.num_cs		= 1,
 };
@@ -351,12 +357,23 @@

 static void omap_init_mcspi(void)
 {
+	if (cpu_is_omap44xx()) {
+		omap2_mcspi1_resources[0].start = OMAP4_MCSPI1_BASE;
+		omap2_mcspi1_resources[0].end 	= OMAP4_MCSPI1_BASE + 0xff;
+		omap2_mcspi2_resources[0].start = OMAP4_MCSPI2_BASE;
+		omap2_mcspi2_resources[0].end 	= OMAP4_MCSPI2_BASE + 0xff;
+		omap2_mcspi3_resources[0].start = OMAP4_MCSPI3_BASE;
+		omap2_mcspi3_resources[0].end 	= OMAP4_MCSPI3_BASE + 0xff;
+		omap2_mcspi4_resources[0].start = OMAP4_MCSPI4_BASE;
+		omap2_mcspi4_resources[0].end 	= OMAP4_MCSPI4_BASE + 0xff;
+	}
 	platform_device_register(&omap2_mcspi1);
 	platform_device_register(&omap2_mcspi2);
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4)
 	platform_device_register(&omap2_mcspi3);
 #endif
-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	platform_device_register(&omap2_mcspi4);
 #endif
 }
Index: omap4_dev/drivers/spi/omap2_mcspi.c
===================================================================
--- omap4_dev.orig/drivers/spi/omap2_mcspi.c	2009-06-24 19:22:23.000000000 +0530
+++ omap4_dev/drivers/spi/omap2_mcspi.c	2009-06-24 19:22:46.000000000 +0530
@@ -918,7 +918,8 @@
 	OMAP24XX_DMA_SPI2_TX1,
 };

-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX) || \
+	 defined(CONFIG_ARCH_OMAP4)
 static u8 __initdata spi3_rxdma_id[] = {
 	OMAP24XX_DMA_SPI3_RX0,
 	OMAP24XX_DMA_SPI3_RX1,
@@ -930,7 +931,7 @@
 };
 #endif

-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static u8 __initdata spi4_rxdma_id[] = {
 	OMAP34XX_DMA_SPI4_RX0,
 };
@@ -960,14 +961,15 @@
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


