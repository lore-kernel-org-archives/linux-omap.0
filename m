From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: [PATCH][RFC] OMAP4: McSPI Register Offset Changes For OMAP_4430SDP
Date: Wed, 27 May 2009 22:05:25 +0530 (IST)
Message-ID: <51753.192.168.10.89.1243442125.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33273 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755157AbZE0Qf3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 May 2009 12:35:29 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4RGZQQu005100
	for <linux-omap@vger.kernel.org>; Wed, 27 May 2009 11:35:31 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n4RGZNV9012438
	for <linux-omap@vger.kernel.org>; Wed, 27 May 2009 11:35:24 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch updates McSPI register offset addresses with respect to OMAP4

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
---
 arch/arm/mach-omap2/devices.c |   10 ++++----
 drivers/spi/omap2_mcspi.c     |   51 ++++++++++++++++++++++++++++--------------
 2 files changed, 41 insertions(+), 20 deletions(-)

Index: omap4_dev/arch/arm/mach-omap2/devices.c
===================================================================
--- omap4_dev.orig/arch/arm/mach-omap2/devices.c
+++ omap4_dev/arch/arm/mach-omap2/devices.c
@@ -301,7 +301,8 @@ static struct platform_device omap2_mcsp
 	},
 };

-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+defined(CONFIG_ARCH_OMAP4)
 static struct omap2_mcspi_platform_config omap2_mcspi3_config = {
 	.num_cs		= 2,
 };
@@ -325,7 +326,7 @@ static struct platform_device omap2_mcsp
 };
 #endif

-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct omap2_mcspi_platform_config omap2_mcspi4_config = {
 	.num_cs		= 1,
 };
@@ -353,10 +354,11 @@ static void omap_init_mcspi(void)
 {
 	platform_device_register(&omap2_mcspi1);
 	platform_device_register(&omap2_mcspi2);
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+defined(CONFIG_ARCH_OMAP4)
 	platform_device_register(&omap2_mcspi3);
 #endif
-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	platform_device_register(&omap2_mcspi4);
 #endif
 }
Index: omap4_dev/drivers/spi/omap2_mcspi.c
===================================================================
--- omap4_dev.orig/drivers/spi/omap2_mcspi.c
+++ omap4_dev/drivers/spi/omap2_mcspi.c
@@ -42,21 +42,38 @@
 #define OMAP2_MCSPI_MAX_FREQ		48000000

 #define OMAP2_MCSPI_REVISION		0x00
-#define OMAP2_MCSPI_SYSCONFIG		0x10
-#define OMAP2_MCSPI_SYSSTATUS		0x14
-#define OMAP2_MCSPI_IRQSTATUS		0x18
-#define OMAP2_MCSPI_IRQENABLE		0x1c
-#define OMAP2_MCSPI_WAKEUPENABLE	0x20
-#define OMAP2_MCSPI_SYST		0x24
-#define OMAP2_MCSPI_MODULCTRL		0x28
+#ifdef CONFIG_ARCH_OMAP4
+#define OMAP2_MCSPI_SYSCONFIG		0x110
+#define OMAP2_MCSPI_SYSSTATUS		0x114
+#define OMAP2_MCSPI_IRQSTATUS		0x118
+#define OMAP2_MCSPI_IRQENABLE		0x11c
+#define OMAP2_MCSPI_WAKEUPENABLE	0x120
+#define OMAP2_MCSPI_SYST		0x124
+#define OMAP2_MCSPI_MODULCTRL		0x128

 /* per-channel banks, 0x14 bytes each, first is: */
-#define OMAP2_MCSPI_CHCONF0		0x2c
-#define OMAP2_MCSPI_CHSTAT0		0x30
-#define OMAP2_MCSPI_CHCTRL0		0x34
-#define OMAP2_MCSPI_TX0			0x38
-#define OMAP2_MCSPI_RX0			0x3c
+#define OMAP2_MCSPI_CHCONF0		0x12c
+#define OMAP2_MCSPI_CHSTAT0		0x130
+#define OMAP2_MCSPI_CHCTRL0		0x134
+#define OMAP2_MCSPI_TX0			0x138
+#define OMAP2_MCSPI_RX0			0x13c
+#else
+#define OMAP2_MCSPI_REVISION            0x00
+#define OMAP2_MCSPI_SYSCONFIG           0x10
+#define OMAP2_MCSPI_SYSSTATUS           0x14
+#define OMAP2_MCSPI_IRQSTATUS           0x18
+#define OMAP2_MCSPI_IRQENABLE           0x1c
+#define OMAP2_MCSPI_WAKEUPENABLE        0x20
+#define OMAP2_MCSPI_SYST                0x24
+#define OMAP2_MCSPI_MODULCTRL           0x28

+/* per-channel banks, 0x14 bytes each, first is: */
+#define OMAP2_MCSPI_CHCONF0             0x2c
+#define OMAP2_MCSPI_CHSTAT0             0x30
+#define OMAP2_MCSPI_CHCTRL0             0x34
+#define OMAP2_MCSPI_TX0                 0x38
+#define OMAP2_MCSPI_RX0                 0x3c
+#endif
 /* per-register bitmasks: */

 #define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	(1 << 0)
@@ -918,7 +935,8 @@ static u8 __initdata spi2_txdma_id[] = {
 	OMAP24XX_DMA_SPI2_TX1,
 };

-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX) ||\
+defined(CONFIG_ARCH_OMAP44XX)
 static u8 __initdata spi3_rxdma_id[] = {
 	OMAP24XX_DMA_SPI3_RX0,
 	OMAP24XX_DMA_SPI3_RX1,
@@ -930,7 +948,7 @@ static u8 __initdata spi3_txdma_id[] = {
 };
 #endif

-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static u8 __initdata spi4_rxdma_id[] = {
 	OMAP34XX_DMA_SPI4_RX0,
 };
@@ -960,14 +978,15 @@ static int __init omap2_mcspi_probe(stru
 		txdma_id = spi2_txdma_id;
 		num_chipselect = 2;
 		break;
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) ||\
+defined(CONFIG_ARCH_OMAP4)
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


