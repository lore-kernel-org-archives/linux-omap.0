From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 6/8] ARM: OMAP1: Remove duplicated DMA channel definitions
Date: Sat, 15 Jun 2013 11:31:07 +0300
Message-ID: <1371285069-6834-7-git-send-email-jarkko.nikula@bitmer.com>
References: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:33802 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753057Ab3FOIb5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Jun 2013 04:31:57 -0400
In-Reply-To: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

Similarly than with OMAP2 there are many DMA channel definitions that have
been moved or redefined in drivers using them and we can remove them from
dma.h.

There is exception with MMC that arch/arm/mach-omap1/devices.c is using
MMC DMA channel definitions for setting platform data but those can be well
replaced with numeric values.

Remove dma.h include from arch/arm/mach-omap1/devices.c and use a script
below for dropping duplicated definitions and for replacing definitions
with DMA channel numbers.

grep '#define OMAP_DMA' arch/arm/mach-omap1/dma.h | while read -r i; do \
		DDEF=`echo $i |cut -d ' ' -f 1-2`; \
		DEF=`echo $DDEF |cut -d ' ' -f 2`; \
		CH=`echo $i |cut -d ' ' -f 3`; \
		if [ `git grep -c "$DDEF" |wc -l` -gt 1 ]; then \
			echo "removing" $DEF; \
			sed -i "s/${DEF}/${CH}/" arch/arm/mach-omap1/devices.c; \
			sed -i "/${DDEF}/d" arch/arm/mach-omap1/dma.h; \
		fi; \
	done

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap1/devices.c |    9 ++++-----
 arch/arm/mach-omap1/dma.h     |    8 --------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 0af635205..325e603 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -30,7 +30,6 @@
 
 #include "common.h"
 #include "clock.h"
-#include "dma.h"
 #include "mmc.h"
 #include "sram.h"
 
@@ -223,16 +222,16 @@ void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 		case 0:
 			base = OMAP1_MMC1_BASE;
 			irq = INT_MMC;
-			rx_req = OMAP_DMA_MMC_RX;
-			tx_req = OMAP_DMA_MMC_TX;
+			rx_req = 22;
+			tx_req = 21;
 			break;
 		case 1:
 			if (!cpu_is_omap16xx())
 				return;
 			base = OMAP1_MMC2_BASE;
 			irq = INT_1610_MMC2;
-			rx_req = OMAP_DMA_MMC2_RX;
-			tx_req = OMAP_DMA_MMC2_TX;
+			rx_req = 55;
+			tx_req = 54;
 			break;
 		default:
 			continue;
diff --git a/arch/arm/mach-omap1/dma.h b/arch/arm/mach-omap1/dma.h
index 1932e9a..dc33cd9 100644
--- a/arch/arm/mach-omap1/dma.h
+++ b/arch/arm/mach-omap1/dma.h
@@ -20,17 +20,9 @@
 #define __OMAP1_DMA_CHANNEL_H
 
 /* DMA channels for omap1 */
-#define OMAP_DMA_NO_DEVICE		0
 #define OMAP_DMA_UART3_TX		18
 #define OMAP_DMA_UART3_RX		19
-#define OMAP_DMA_CAMERA_IF_RX		20
-#define OMAP_DMA_MMC_TX			21
-#define OMAP_DMA_MMC_RX			22
-#define OMAP_DMA_USB_W2FC_RX0		26
-#define OMAP_DMA_USB_W2FC_TX0		29
 
 /* These are only for 1610 */
-#define OMAP_DMA_MMC2_TX		54
-#define OMAP_DMA_MMC2_RX		55
 
 #endif /* __OMAP1_DMA_CHANNEL_H */
-- 
1.7.10.4

