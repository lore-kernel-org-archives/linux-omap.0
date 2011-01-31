From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 13/13] OMAP: hwmod: Removal of macros for data that is obtained from hwmod database
Date: Mon, 31 Jan 2011 20:20:37 +0530
Message-ID: <1296485437-12806-14-git-send-email-kishon@ti.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48533 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755922Ab1AaO4i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 09:56:38 -0500
In-Reply-To: <1296485437-12806-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com, Kishon Vijay Abraham I <kishon@ti.com>

Information like base address and DMA channel nubers should no longer
be obtained using macros. These information should be obtained from
hwmod database. Hence the macros that define the base address are removed.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/mcbsp.c             |   64 +++++++++++++++---------------
 arch/arm/plat-omap/include/plat/mcbsp.h |   50 +-----------------------
 2 files changed, 33 insertions(+), 81 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 2b89ebd..d90f649 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -83,14 +83,14 @@ struct resource omap7xx_mcbsp_res[][6] = {
 	{
 		{
 			.name  = "mpu",
-			.start = OMAP7XX_MCBSP1_BASE,
-			.end   = OMAP7XX_MCBSP1_BASE + SZ_256,
+			.start = 0xfffb1000,
+			.end   = 0xfffb10ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
 			.name  = "dma",
-			.start = OMAP7XX_MCBSP1_BASE,
-			.end   = OMAP7XX_MCBSP1_BASE + SZ_256,
+			.start = 0xfffb1000,
+			.end   = 0xfffb10ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
@@ -117,14 +117,14 @@ struct resource omap7xx_mcbsp_res[][6] = {
 	{
 		{
 			.name  = "mpu",
-			.start = OMAP7XX_MCBSP2_BASE,
-			.end   = OMAP7XX_MCBSP2_BASE + SZ_256,
+			.start = 0xfffb1800,
+			.end   = 0xfffb18ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
 			.name  = "dma",
-			.start = OMAP7XX_MCBSP2_BASE,
-			.end   = OMAP7XX_MCBSP2_BASE + SZ_256,
+			.start = 0xfffb1800,
+			.end   = 0xfffb18ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
@@ -172,14 +172,14 @@ struct resource omap15xx_mcbsp_res[][6] = {
 	{
 		{
 			.name  = "mpu",
-			.start = OMAP1510_MCBSP1_BASE,
-			.end   = OMAP1510_MCBSP1_BASE + SZ_256,
+			.start = 0xe1011800,
+			.end   = 0xe10118ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
 			.name  = "dma",
-			.start = OMAP1510_MCBSP1_BASE,
-			.end   = OMAP1510_MCBSP1_BASE + SZ_256,
+			.start = 0xe1011800,
+			.end   = 0xe10118ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
@@ -206,14 +206,14 @@ struct resource omap15xx_mcbsp_res[][6] = {
 	{
 		{
 			.name  = "mpu",
-			.start = OMAP1510_MCBSP2_BASE,
-			.end   = OMAP1510_MCBSP2_BASE + SZ_256,
+			.start = 0xfffb1000,
+			.end   = 0xfffb10ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
 			.name  = "dma",
-			.start = OMAP1510_MCBSP2_BASE,
-			.end   = OMAP1510_MCBSP2_BASE + SZ_256,
+			.start = 0xfffb1000,
+			.end   = 0xfffb10ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
@@ -240,14 +240,14 @@ struct resource omap15xx_mcbsp_res[][6] = {
 	{
 		{
 			.name  = "mpu",
-			.start = OMAP1510_MCBSP3_BASE,
-			.end   = OMAP1510_MCBSP3_BASE + SZ_256,
+			.start = 0xe1017000,
+			.end   = 0xe10170ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
 			.name  = "dma",
-			.start = OMAP1510_MCBSP3_BASE,
-			.end   = OMAP1510_MCBSP3_BASE + SZ_256,
+			.start = 0xe1017000,
+			.end   = 0xe10170ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
@@ -298,14 +298,14 @@ struct resource omap16xx_mcbsp_res[][6] = {
 	{
 		{
 			.name  = "mpu",
-			.start = OMAP1610_MCBSP1_BASE,
-			.end   = OMAP1610_MCBSP1_BASE + SZ_256,
+			.start = 0xe1011800,
+			.end   = 0xe10118ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
 			.name  = "dma",
-			.start = OMAP1610_MCBSP1_BASE,
-			.end   = OMAP1610_MCBSP1_BASE + SZ_256,
+			.start = 0xe1011800,
+			.end   = 0xe10118ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
@@ -332,14 +332,14 @@ struct resource omap16xx_mcbsp_res[][6] = {
 	{
 		{
 			.name  = "mpu",
-			.start = OMAP1610_MCBSP2_BASE,
-			.end   = OMAP1610_MCBSP2_BASE + SZ_256,
+			.start = 0xfffb1000,
+			.end   = 0xfffb10ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
 			.name  = "dma",
-			.start = OMAP1610_MCBSP2_BASE,
-			.end   = OMAP1610_MCBSP2_BASE + SZ_256,
+			.start = 0xfffb1000,
+			.end   = 0xfffb10ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
@@ -366,14 +366,14 @@ struct resource omap16xx_mcbsp_res[][6] = {
 	{
 		{
 			.name  = "mpu",
-			.start = OMAP1610_MCBSP3_BASE,
-			.end   = OMAP1610_MCBSP3_BASE + SZ_256,
+			.start = 0xe1017000,
+			.end   = 0xe10170ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
 			.name  = "dma",
-			.start = OMAP1610_MCBSP3_BASE,
-			.end   = OMAP1610_MCBSP3_BASE + SZ_256,
+			.start = 0xe1017000,
+			.end   = 0xe10170ff,
 			.flags = IORESOURCE_MEM,
 		},
 		{
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 54058a3..2c827ef 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -41,41 +41,7 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define MCBSP_CONFIG_TYPE3	0x3
 #define MCBSP_CONFIG_TYPE4	0x4
 
-#define OMAP7XX_MCBSP1_BASE	0xfffb1000
-#define OMAP7XX_MCBSP2_BASE	0xfffb1800
-
-#define OMAP1510_MCBSP1_BASE	0xe1011800
-#define OMAP1510_MCBSP2_BASE	0xfffb1000
-#define OMAP1510_MCBSP3_BASE	0xe1017000
-
-#define OMAP1610_MCBSP1_BASE	0xe1011800
-#define OMAP1610_MCBSP2_BASE	0xfffb1000
-#define OMAP1610_MCBSP3_BASE	0xe1017000
-
-#define OMAP24XX_MCBSP1_BASE	0x48074000
-#define OMAP24XX_MCBSP2_BASE	0x48076000
-#define OMAP2430_MCBSP3_BASE	0x4808c000
-#define OMAP2430_MCBSP4_BASE	0x4808e000
-#define OMAP2430_MCBSP5_BASE	0x48096000
-
-#define OMAP34XX_MCBSP1_BASE	0x48074000
-#define OMAP34XX_MCBSP2_BASE	0x49022000
-#define OMAP34XX_MCBSP2_ST_BASE	0x49028000
-#define OMAP34XX_MCBSP3_BASE	0x49024000
-#define OMAP34XX_MCBSP3_ST_BASE	0x4902A000
-#define OMAP34XX_MCBSP3_BASE	0x49024000
-#define OMAP34XX_MCBSP4_BASE	0x49026000
-#define OMAP34XX_MCBSP5_BASE	0x48096000
-
-#define OMAP44XX_MCBSP1_BASE	0x40122000
-#define OMAP44XX_MCBSP1_DMA_BASE	0x49022000
-#define OMAP44XX_MCBSP2_BASE	0x40124000
-#define OMAP44XX_MCBSP2_DMA_BASE	0x49024000
-#define OMAP44XX_MCBSP3_BASE	0x40126000
-#define OMAP44XX_MCBSP3_DMA_BASE	0x49026000
-#define OMAP44XX_MCBSP4_BASE	0x48096000
-
-#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
+#ifdef CONFIG_ARCH_OMAP1
 
 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x02
@@ -115,13 +81,6 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define OMAP_MCBSP_REG_XCCR	0x00
 #define OMAP_MCBSP_REG_RCCR	0x00
 
-#define AUDIO_MCBSP_DATAWRITE	(OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1)
-#define AUDIO_MCBSP_DATAREAD	(OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1)
-
-#define AUDIO_MCBSP		OMAP_MCBSP1
-#define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
-#define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
-
 #else
 
 #define OMAP_MCBSP_REG_DRR2	0x00
@@ -177,13 +136,6 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define OMAP_ST_REG_SFIRCR	0x28
 #define OMAP_ST_REG_SSELCR	0x2C
 
-#define AUDIO_MCBSP_DATAWRITE	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
-#define AUDIO_MCBSP_DATAREAD	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1)
-
-#define AUDIO_MCBSP		OMAP_MCBSP2
-#define AUDIO_DMA_TX		OMAP24XX_DMA_MCBSP2_TX
-#define AUDIO_DMA_RX		OMAP24XX_DMA_MCBSP2_RX
-
 #endif
 
 /************************** McBSP SPCR1 bit definitions ***********************/
-- 
1.7.0.4

