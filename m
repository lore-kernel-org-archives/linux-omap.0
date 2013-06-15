From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 2/8] ARM: OMAP2+: Remove duplicated DMA channel definitions
Date: Sat, 15 Jun 2013 11:31:03 +0300
Message-ID: <1371285069-6834-3-git-send-email-jarkko.nikula@bitmer.com>
References: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:33790 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135Ab3FOIbn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Jun 2013 04:31:43 -0400
In-Reply-To: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

Many DMA channel definitions in arch/arm/mach-omap2/dma.h have been moved or
redefined in drivers without removing them from dma.h. Remove those with a
script below:

egrep '#define OMAP.*DMA' arch/arm/mach-omap2/dma.h \
	|cut -f 1 |cut -d ' ' -f 1-2 | while read -r i; do \
		if [ `git grep -c "$i" |wc -l` -gt 1 ]; then \
			echo "removing" $i; \
			sed -i "/${i}/d" arch/arm/mach-omap2/dma.h; \
		fi; \
	done

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap2/dma.h |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.h b/arch/arm/mach-omap2/dma.h
index 4141ef0..8a71c7b 100644
--- a/arch/arm/mach-omap2/dma.h
+++ b/arch/arm/mach-omap2/dma.h
@@ -21,30 +21,18 @@
 
 
 /* DMA channels for 24xx */
-#define OMAP24XX_DMA_NO_DEVICE		0
-#define OMAP24XX_DMA_EXT_DMAREQ0	2	/* S_DMA_1 */
-#define OMAP24XX_DMA_EXT_DMAREQ1	3	/* S_DMA_2 */
-#define OMAP24XX_DMA_GPMC		4	/* S_DMA_3 */
-#define OMAP242X_DMA_EXT_DMAREQ2	14	/* S_DMA_13 */
-#define OMAP242X_DMA_EXT_DMAREQ3	15	/* S_DMA_14 */
-#define OMAP242X_DMA_EXT_DMAREQ4	16	/* S_DMA_15 */
 #define OMAP34XX_DMA_I2C3_TX		25	/* S_DMA_24 */
 #define OMAP34XX_DMA_I2C3_RX		26	/* S_DMA_25 */
 #define OMAP24XX_DMA_I2C1_TX		27	/* S_DMA_26 */
 #define OMAP24XX_DMA_I2C1_RX		28	/* S_DMA_27 */
 #define OMAP24XX_DMA_I2C2_TX		29	/* S_DMA_28 */
 #define OMAP24XX_DMA_I2C2_RX		30	/* S_DMA_29 */
-#define OMAP24XX_DMA_MMC2_TX		47	/* S_DMA_46 */
-#define OMAP24XX_DMA_MMC2_RX		48	/* S_DMA_47 */
 #define OMAP24XX_DMA_UART1_TX		49	/* S_DMA_48 */
 #define OMAP24XX_DMA_UART1_RX		50	/* S_DMA_49 */
 #define OMAP24XX_DMA_UART2_TX		51	/* S_DMA_50 */
 #define OMAP24XX_DMA_UART2_RX		52	/* S_DMA_51 */
 #define OMAP24XX_DMA_UART3_TX		53	/* S_DMA_52 */
 #define OMAP24XX_DMA_UART3_RX		54	/* S_DMA_53 */
-#define OMAP24XX_DMA_MMC1_TX		61	/* S_DMA_60 */
-#define OMAP24XX_DMA_MMC1_RX		62	/* S_DMA_61 */
-#define OMAP242X_DMA_EXT_DMAREQ5	64	/* S_DMA_63 */
 #define OMAP34XX_DMA_AES2_TX		65	/* S_DMA_64 */
 #define OMAP34XX_DMA_AES2_RX		66	/* S_DMA_65 */
 #define OMAP34XX_DMA_SHA1MD5_RX		69	/* S_DMA_68 */
-- 
1.7.10.4

