From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 5/8] ARM: OMAP1: Remove McBSP DMA channel definitions
Date: Sat, 15 Jun 2013 11:31:06 +0300
Message-ID: <1371285069-6834-6-git-send-email-jarkko.nikula@bitmer.com>
References: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:33804 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239Ab3FOIb7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Jun 2013 04:31:59 -0400
In-Reply-To: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

arch/arm/mach-omap1/mcbsp.c is only place where OMAP1 McBSP DMA channel
definitions are set. We may well use numerical values there and get rid
of their definitions in arch/arm/mach-omap1/dma.h.

Remove dma.h include from arch/arm/mach-omap1/mcbsp.c and use following
script for replacing definitions with DMA channel number:

egrep '#define OMAP_DMA_MCBSP' arch/arm/mach-omap1/dma.h | cut -f 1,3 \
	| while read i; do \
		DEF=`echo $i |cut -d ' ' -f 2`; \
		CH=`echo $i |cut -d ' ' -f 3`; \
		echo "removing" $DEF; \
		sed -i "s/${DEF}/${CH}/" arch/arm/mach-omap1/mcbsp.c; \
		sed -i "/${DEF}/d" arch/arm/mach-omap1/dma.h; \
	done

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap1/dma.h   |    6 ------
 arch/arm/mach-omap1/mcbsp.c |   33 ++++++++++++++++-----------------
 2 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.h b/arch/arm/mach-omap1/dma.h
index d05909c..1932e9a 100644
--- a/arch/arm/mach-omap1/dma.h
+++ b/arch/arm/mach-omap1/dma.h
@@ -21,12 +21,6 @@
 
 /* DMA channels for omap1 */
 #define OMAP_DMA_NO_DEVICE		0
-#define OMAP_DMA_MCBSP1_TX		8
-#define OMAP_DMA_MCBSP1_RX		9
-#define OMAP_DMA_MCBSP3_TX		10
-#define OMAP_DMA_MCBSP3_RX		11
-#define OMAP_DMA_MCBSP2_TX		16
-#define OMAP_DMA_MCBSP2_RX		17
 #define OMAP_DMA_UART3_TX		18
 #define OMAP_DMA_UART3_RX		19
 #define OMAP_DMA_CAMERA_IF_RX		20
diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index b0d4723..8ed67f8 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -27,7 +27,6 @@
 #include <mach/irqs.h>
 
 #include "iomap.h"
-#include "dma.h"
 
 #define DPS_RSTCT2_PER_EN	(1 << 0)
 #define DSP_RSTCT2_WD_PER_EN	(1 << 1)
@@ -114,12 +113,12 @@ struct resource omap7xx_mcbsp_res[][6] = {
 		},
 		{
 			.name  = "rx",
-			.start = OMAP_DMA_MCBSP1_RX,
+			.start = 9,
 			.flags = IORESOURCE_DMA,
 		},
 		{
 			.name  = "tx",
-			.start = OMAP_DMA_MCBSP1_TX,
+			.start = 8,
 			.flags = IORESOURCE_DMA,
 		},
 	},
@@ -141,12 +140,12 @@ struct resource omap7xx_mcbsp_res[][6] = {
 		},
 		{
 			.name  = "rx",
-			.start = OMAP_DMA_MCBSP3_RX,
+			.start = 11,
 			.flags = IORESOURCE_DMA,
 		},
 		{
 			.name  = "tx",
-			.start = OMAP_DMA_MCBSP3_TX,
+			.start = 10,
 			.flags = IORESOURCE_DMA,
 		},
 	},
@@ -191,12 +190,12 @@ struct resource omap15xx_mcbsp_res[][6] = {
 		},
 		{
 			.name  = "rx",
-			.start = OMAP_DMA_MCBSP1_RX,
+			.start = 9,
 			.flags = IORESOURCE_DMA,
 		},
 		{
 			.name  = "tx",
-			.start = OMAP_DMA_MCBSP1_TX,
+			.start = 8,
 			.flags = IORESOURCE_DMA,
 		},
 	},
@@ -218,12 +217,12 @@ struct resource omap15xx_mcbsp_res[][6] = {
 		},
 		{
 			.name  = "rx",
-			.start = OMAP_DMA_MCBSP2_RX,
+			.start = 17,
 			.flags = IORESOURCE_DMA,
 		},
 		{
 			.name  = "tx",
-			.start = OMAP_DMA_MCBSP2_TX,
+			.start = 16,
 			.flags = IORESOURCE_DMA,
 		},
 	},
@@ -245,12 +244,12 @@ struct resource omap15xx_mcbsp_res[][6] = {
 		},
 		{
 			.name  = "rx",
-			.start = OMAP_DMA_MCBSP3_RX,
+			.start = 11,
 			.flags = IORESOURCE_DMA,
 		},
 		{
 			.name  = "tx",
-			.start = OMAP_DMA_MCBSP3_TX,
+			.start = 10,
 			.flags = IORESOURCE_DMA,
 		},
 	},
@@ -298,12 +297,12 @@ struct resource omap16xx_mcbsp_res[][6] = {
 		},
 		{
 			.name  = "rx",
-			.start = OMAP_DMA_MCBSP1_RX,
+			.start = 9,
 			.flags = IORESOURCE_DMA,
 		},
 		{
 			.name  = "tx",
-			.start = OMAP_DMA_MCBSP1_TX,
+			.start = 8,
 			.flags = IORESOURCE_DMA,
 		},
 	},
@@ -325,12 +324,12 @@ struct resource omap16xx_mcbsp_res[][6] = {
 		},
 		{
 			.name  = "rx",
-			.start = OMAP_DMA_MCBSP2_RX,
+			.start = 17,
 			.flags = IORESOURCE_DMA,
 		},
 		{
 			.name  = "tx",
-			.start = OMAP_DMA_MCBSP2_TX,
+			.start = 16,
 			.flags = IORESOURCE_DMA,
 		},
 	},
@@ -352,12 +351,12 @@ struct resource omap16xx_mcbsp_res[][6] = {
 		},
 		{
 			.name  = "rx",
-			.start = OMAP_DMA_MCBSP3_RX,
+			.start = 11,
 			.flags = IORESOURCE_DMA,
 		},
 		{
 			.name  = "tx",
-			.start = OMAP_DMA_MCBSP3_TX,
+			.start = 10,
 			.flags = IORESOURCE_DMA,
 		},
 	},
-- 
1.7.10.4

