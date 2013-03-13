From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RFC 1/2] ARM: OMAP1: Remove unused DMA channel definitions
Date: Wed, 13 Mar 2013 22:15:48 +0200
Message-ID: <1363205749-9905-2-git-send-email-jarkko.nikula@bitmer.com>
References: <1363205749-9905-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:55523 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932456Ab3CMUQF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 16:16:05 -0400
In-Reply-To: <1363205749-9905-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

Many of these channel definitions have became unused or were never used
so remove unused definitions from arch/arm/mach-omap1/dma.h using a script
below. See also notes in commit 8c4cc00
("ARM: OMAP1: DMA: Moving OMAP1 DMA channel definitions to mach-omap1")
for removing remaining ones.

egrep '#define OMAP.*DMA' arch/arm/mach-omap1/dma.h \
        |cut -f 1 |cut -d ' ' -f 2 | while read -r i; do \
                if [ `git grep -c $i | wc -l` -eq 1 ]; then \
                        echo "removing" $i; \
                        sed -i "/${i}/d" arch/arm/mach-omap1/dma.h; \
                fi; \
        done

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap1/dma.h |   41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.h b/arch/arm/mach-omap1/dma.h
index da6345d..d05909c 100644
--- a/arch/arm/mach-omap1/dma.h
+++ b/arch/arm/mach-omap1/dma.h
@@ -21,21 +21,10 @@
 
 /* DMA channels for omap1 */
 #define OMAP_DMA_NO_DEVICE		0
-#define OMAP_DMA_MCSI1_TX		1
-#define OMAP_DMA_MCSI1_RX		2
-#define OMAP_DMA_I2C_RX			3
-#define OMAP_DMA_I2C_TX			4
-#define OMAP_DMA_EXT_NDMA_REQ		5
-#define OMAP_DMA_EXT_NDMA_REQ2		6
-#define OMAP_DMA_UWIRE_TX		7
 #define OMAP_DMA_MCBSP1_TX		8
 #define OMAP_DMA_MCBSP1_RX		9
 #define OMAP_DMA_MCBSP3_TX		10
 #define OMAP_DMA_MCBSP3_RX		11
-#define OMAP_DMA_UART1_TX		12
-#define OMAP_DMA_UART1_RX		13
-#define OMAP_DMA_UART2_TX		14
-#define OMAP_DMA_UART2_RX		15
 #define OMAP_DMA_MCBSP2_TX		16
 #define OMAP_DMA_MCBSP2_RX		17
 #define OMAP_DMA_UART3_TX		18
@@ -43,41 +32,11 @@
 #define OMAP_DMA_CAMERA_IF_RX		20
 #define OMAP_DMA_MMC_TX			21
 #define OMAP_DMA_MMC_RX			22
-#define OMAP_DMA_NAND			23
-#define OMAP_DMA_IRQ_LCD_LINE		24
-#define OMAP_DMA_MEMORY_STICK		25
 #define OMAP_DMA_USB_W2FC_RX0		26
-#define OMAP_DMA_USB_W2FC_RX1		27
-#define OMAP_DMA_USB_W2FC_RX2		28
 #define OMAP_DMA_USB_W2FC_TX0		29
-#define OMAP_DMA_USB_W2FC_TX1		30
-#define OMAP_DMA_USB_W2FC_TX2		31
 
 /* These are only for 1610 */
-#define OMAP_DMA_CRYPTO_DES_IN		32
-#define OMAP_DMA_SPI_TX			33
-#define OMAP_DMA_SPI_RX			34
-#define OMAP_DMA_CRYPTO_HASH		35
-#define OMAP_DMA_CCP_ATTN		36
-#define OMAP_DMA_CCP_FIFO_NOT_EMPTY	37
-#define OMAP_DMA_CMT_APE_TX_CHAN_0	38
-#define OMAP_DMA_CMT_APE_RV_CHAN_0	39
-#define OMAP_DMA_CMT_APE_TX_CHAN_1	40
-#define OMAP_DMA_CMT_APE_RV_CHAN_1	41
-#define OMAP_DMA_CMT_APE_TX_CHAN_2	42
-#define OMAP_DMA_CMT_APE_RV_CHAN_2	43
-#define OMAP_DMA_CMT_APE_TX_CHAN_3	44
-#define OMAP_DMA_CMT_APE_RV_CHAN_3	45
-#define OMAP_DMA_CMT_APE_TX_CHAN_4	46
-#define OMAP_DMA_CMT_APE_RV_CHAN_4	47
-#define OMAP_DMA_CMT_APE_TX_CHAN_5	48
-#define OMAP_DMA_CMT_APE_RV_CHAN_5	49
-#define OMAP_DMA_CMT_APE_TX_CHAN_6	50
-#define OMAP_DMA_CMT_APE_RV_CHAN_6	51
-#define OMAP_DMA_CMT_APE_TX_CHAN_7	52
-#define OMAP_DMA_CMT_APE_RV_CHAN_7	53
 #define OMAP_DMA_MMC2_TX		54
 #define OMAP_DMA_MMC2_RX		55
-#define OMAP_DMA_CRYPTO_DES_OUT		56
 
 #endif /* __OMAP1_DMA_CHANNEL_H */
-- 
1.7.10.4

