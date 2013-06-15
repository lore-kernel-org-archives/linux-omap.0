From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 3/8] ARM: OMAP2+: hwmod: Remove remaining DMA channel definitions
Date: Sat, 15 Jun 2013 11:31:04 +0300
Message-ID: <1371285069-6834-4-git-send-email-jarkko.nikula@bitmer.com>
References: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:33795 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527Ab3FOIbv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Jun 2013 04:31:51 -0400
In-Reply-To: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Paul Walmsley <paul@pwsan.com>

Last remaining DMA channel definitions in arch/arm/mach-omap2/dma.h
are used only by omap_hwmod_2xxx_3xxx_ipblock_data.c and
omap_hwmod_3xxx_data.c. Remove them by using directly DMA channel number in
hwmod data and drop definitions with a following script:

egrep '#define [OMAP|AM35XX].*DMA' arch/arm/mach-omap2/dma.h | cut -f 1,3 \
	| while read i; do \
		DEF=`echo $i |cut -d ' ' -f 2`; \
		CH=`echo $i |cut -d ' ' -f 3`; \
		echo "removing" $DEF; \
		sed -i "s/${DEF}/${CH}/" arch/arm/mach-omap2/omap_hwmod_*.c; \
		sed -i "/${DEF}/d" arch/arm/mach-omap2/dma.h; \
	done

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/dma.h                          |   19 -------------------
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   20 ++++++++++----------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   18 +++++++++---------
 3 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.h b/arch/arm/mach-omap2/dma.h
index 8a71c7b..aa735a4 100644
--- a/arch/arm/mach-omap2/dma.h
+++ b/arch/arm/mach-omap2/dma.h
@@ -21,27 +21,8 @@
 
 
 /* DMA channels for 24xx */
-#define OMAP34XX_DMA_I2C3_TX		25	/* S_DMA_24 */
-#define OMAP34XX_DMA_I2C3_RX		26	/* S_DMA_25 */
-#define OMAP24XX_DMA_I2C1_TX		27	/* S_DMA_26 */
-#define OMAP24XX_DMA_I2C1_RX		28	/* S_DMA_27 */
-#define OMAP24XX_DMA_I2C2_TX		29	/* S_DMA_28 */
-#define OMAP24XX_DMA_I2C2_RX		30	/* S_DMA_29 */
-#define OMAP24XX_DMA_UART1_TX		49	/* S_DMA_48 */
-#define OMAP24XX_DMA_UART1_RX		50	/* S_DMA_49 */
-#define OMAP24XX_DMA_UART2_TX		51	/* S_DMA_50 */
-#define OMAP24XX_DMA_UART2_RX		52	/* S_DMA_51 */
-#define OMAP24XX_DMA_UART3_TX		53	/* S_DMA_52 */
-#define OMAP24XX_DMA_UART3_RX		54	/* S_DMA_53 */
-#define OMAP34XX_DMA_AES2_TX		65	/* S_DMA_64 */
-#define OMAP34XX_DMA_AES2_RX		66	/* S_DMA_65 */
-#define OMAP34XX_DMA_SHA1MD5_RX		69	/* S_DMA_68 */
 
-#define OMAP36XX_DMA_UART4_TX		81	/* S_DMA_80 */
-#define OMAP36XX_DMA_UART4_RX		82	/* S_DMA_81 */
 
 /* Only for AM35xx */
-#define AM35XX_DMA_UART4_TX		54
-#define AM35XX_DMA_UART4_RX		55
 
 #endif /* __OMAP2PLUS_DMA_CHANNEL_H */
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index 534974e..ef56897 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -89,32 +89,32 @@ struct omap_hwmod_class omap2_venc_hwmod_class = {
 
 /* Common DMA request line data */
 struct omap_hwmod_dma_info omap2_uart1_sdma_reqs[] = {
-	{ .name = "rx", .dma_req = OMAP24XX_DMA_UART1_RX, },
-	{ .name = "tx", .dma_req = OMAP24XX_DMA_UART1_TX, },
+	{ .name = "rx", .dma_req = 50, },
+	{ .name = "tx", .dma_req = 49, },
 	{ .dma_req = -1 }
 };
 
 struct omap_hwmod_dma_info omap2_uart2_sdma_reqs[] = {
-	{ .name = "rx", .dma_req = OMAP24XX_DMA_UART2_RX, },
-	{ .name = "tx", .dma_req = OMAP24XX_DMA_UART2_TX, },
+	{ .name = "rx", .dma_req = 52, },
+	{ .name = "tx", .dma_req = 51, },
 	{ .dma_req = -1 }
 };
 
 struct omap_hwmod_dma_info omap2_uart3_sdma_reqs[] = {
-	{ .name = "rx", .dma_req = OMAP24XX_DMA_UART3_RX, },
-	{ .name = "tx", .dma_req = OMAP24XX_DMA_UART3_TX, },
+	{ .name = "rx", .dma_req = 54, },
+	{ .name = "tx", .dma_req = 53, },
 	{ .dma_req = -1 }
 };
 
 struct omap_hwmod_dma_info omap2_i2c1_sdma_reqs[] = {
-	{ .name = "tx", .dma_req = OMAP24XX_DMA_I2C1_TX },
-	{ .name = "rx", .dma_req = OMAP24XX_DMA_I2C1_RX },
+	{ .name = "tx", .dma_req = 27 },
+	{ .name = "rx", .dma_req = 28 },
 	{ .dma_req = -1 }
 };
 
 struct omap_hwmod_dma_info omap2_i2c2_sdma_reqs[] = {
-	{ .name = "tx", .dma_req = OMAP24XX_DMA_I2C2_TX },
-	{ .name = "rx", .dma_req = OMAP24XX_DMA_I2C2_RX },
+	{ .name = "tx", .dma_req = 29 },
+	{ .name = "rx", .dma_req = 30 },
 	{ .dma_req = -1 }
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 31c7126..33d5620 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -548,8 +548,8 @@ static struct omap_hwmod_irq_info uart4_mpu_irqs[] = {
 };
 
 static struct omap_hwmod_dma_info uart4_sdma_reqs[] = {
-	{ .name = "rx",	.dma_req = OMAP36XX_DMA_UART4_RX, },
-	{ .name = "tx",	.dma_req = OMAP36XX_DMA_UART4_TX, },
+	{ .name = "rx",	.dma_req = 82, },
+	{ .name = "tx",	.dma_req = 81, },
 	{ .dma_req = -1 }
 };
 
@@ -577,8 +577,8 @@ static struct omap_hwmod_irq_info am35xx_uart4_mpu_irqs[] = {
 };
 
 static struct omap_hwmod_dma_info am35xx_uart4_sdma_reqs[] = {
-	{ .name = "rx", .dma_req = AM35XX_DMA_UART4_RX, },
-	{ .name = "tx", .dma_req = AM35XX_DMA_UART4_TX, },
+	{ .name = "rx", .dma_req = 55, },
+	{ .name = "tx", .dma_req = 54, },
 	{ .dma_req = -1 }
 };
 
@@ -857,8 +857,8 @@ static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
 };
 
 static struct omap_hwmod_dma_info i2c3_sdma_reqs[] = {
-	{ .name = "tx", .dma_req = OMAP34XX_DMA_I2C3_TX },
-	{ .name = "rx", .dma_req = OMAP34XX_DMA_I2C3_RX },
+	{ .name = "tx", .dma_req = 25 },
+	{ .name = "rx", .dma_req = 26 },
 	{ .dma_req = -1 }
 };
 
@@ -3581,7 +3581,7 @@ static struct omap_hwmod_irq_info omap3_sham_mpu_irqs[] = {
 };
 
 static struct omap_hwmod_dma_info omap3_sham_sdma_reqs[] = {
-	{ .name = "rx", .dma_req = OMAP34XX_DMA_SHA1MD5_RX, },
+	{ .name = "rx", .dma_req = 69, },
 	{ .dma_req = -1 }
 };
 
@@ -3642,8 +3642,8 @@ static struct omap_hwmod_class omap3xxx_aes_class = {
 };
 
 static struct omap_hwmod_dma_info omap3_aes_sdma_reqs[] = {
-	{ .name = "tx", .dma_req = OMAP34XX_DMA_AES2_TX, },
-	{ .name = "rx", .dma_req = OMAP34XX_DMA_AES2_RX, },
+	{ .name = "tx", .dma_req = 65, },
+	{ .name = "rx", .dma_req = 66, },
 	{ .dma_req = -1 }
 };
 
-- 
1.7.10.4

