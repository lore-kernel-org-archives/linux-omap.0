From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RFC 2/2] ARM: OMAP2+: Remove unused DMA channel definitions
Date: Wed, 13 Mar 2013 22:15:49 +0200
Message-ID: <1363205749-9905-3-git-send-email-jarkko.nikula@bitmer.com>
References: <1363205749-9905-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:55526 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932456Ab3CMUQN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 16:16:13 -0400
In-Reply-To: <1363205749-9905-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

Many of these channel definitions have became unused or were never used
so remove unused definitions from arch/arm/mach-omap2/dma.h using a script
below. See also notes in commit d5e7c86
("ARM: OMAP2+: DMA: Moving OMAP2+ DMA channel definitions to mach-omap2")
for removing remaining ones.

egrep '#define OMAP.*DMA' arch/arm/mach-omap2/dma.h \
	|cut -f 1 |cut -d ' ' -f 2 | while read -r i; do \
		if [ `git grep -c $i | wc -l` -eq 1 ]; then \
			echo "removing" $i; \
			sed -i "/${i}/d" arch/arm/mach-omap2/dma.h; \
		fi; \
	done

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap2/dma.h |   70 ---------------------------------------------
 1 file changed, 70 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.h b/arch/arm/mach-omap2/dma.h
index eba80db..65f80ca 100644
--- a/arch/arm/mach-omap2/dma.h
+++ b/arch/arm/mach-omap2/dma.h
@@ -22,69 +22,20 @@
 
 /* DMA channels for 24xx */
 #define OMAP24XX_DMA_NO_DEVICE		0
-#define OMAP24XX_DMA_XTI_DMA		1	/* S_DMA_0 */
 #define OMAP24XX_DMA_EXT_DMAREQ0	2	/* S_DMA_1 */
 #define OMAP24XX_DMA_EXT_DMAREQ1	3	/* S_DMA_2 */
 #define OMAP24XX_DMA_GPMC		4	/* S_DMA_3 */
-#define OMAP24XX_DMA_GFX		5	/* S_DMA_4 */
-#define OMAP24XX_DMA_DSS		6	/* S_DMA_5 */
-#define OMAP242X_DMA_VLYNQ_TX		7	/* S_DMA_6 */
-#define OMAP24XX_DMA_EXT_DMAREQ2	7	/* S_DMA_6 */
-#define OMAP24XX_DMA_CWT		8	/* S_DMA_7 */
 #define OMAP24XX_DMA_AES_TX		9	/* S_DMA_8 */
 #define OMAP24XX_DMA_AES_RX		10	/* S_DMA_9 */
-#define OMAP24XX_DMA_DES_TX		11	/* S_DMA_10 */
-#define OMAP24XX_DMA_DES_RX		12	/* S_DMA_11 */
-#define OMAP24XX_DMA_SHA1MD5_RX		13	/* S_DMA_12 */
-#define OMAP34XX_DMA_SHA2MD5_RX		13	/* S_DMA_12 */
 #define OMAP242X_DMA_EXT_DMAREQ2	14	/* S_DMA_13 */
 #define OMAP242X_DMA_EXT_DMAREQ3	15	/* S_DMA_14 */
 #define OMAP242X_DMA_EXT_DMAREQ4	16	/* S_DMA_15 */
-#define OMAP242X_DMA_EAC_AC_RD		17	/* S_DMA_16 */
-#define OMAP242X_DMA_EAC_AC_WR		18	/* S_DMA_17 */
-#define OMAP242X_DMA_EAC_MD_UL_RD	19	/* S_DMA_18 */
-#define OMAP242X_DMA_EAC_MD_UL_WR	20	/* S_DMA_19 */
-#define OMAP242X_DMA_EAC_MD_DL_RD	21	/* S_DMA_20 */
-#define OMAP242X_DMA_EAC_MD_DL_WR	22	/* S_DMA_21 */
-#define OMAP242X_DMA_EAC_BT_UL_RD	23	/* S_DMA_22 */
-#define OMAP242X_DMA_EAC_BT_UL_WR	24	/* S_DMA_23 */
-#define OMAP242X_DMA_EAC_BT_DL_RD	25	/* S_DMA_24 */
-#define OMAP242X_DMA_EAC_BT_DL_WR	26	/* S_DMA_25 */
-#define OMAP243X_DMA_EXT_DMAREQ3	14	/* S_DMA_13 */
-#define OMAP24XX_DMA_SPI3_TX0		15	/* S_DMA_14 */
-#define OMAP24XX_DMA_SPI3_RX0		16	/* S_DMA_15 */
-#define OMAP24XX_DMA_MCBSP3_TX		17	/* S_DMA_16 */
-#define OMAP24XX_DMA_MCBSP3_RX		18	/* S_DMA_17 */
-#define OMAP24XX_DMA_MCBSP4_TX		19	/* S_DMA_18 */
-#define OMAP24XX_DMA_MCBSP4_RX		20	/* S_DMA_19 */
-#define OMAP24XX_DMA_MCBSP5_TX		21	/* S_DMA_20 */
-#define OMAP24XX_DMA_MCBSP5_RX		22	/* S_DMA_21 */
-#define OMAP24XX_DMA_SPI3_TX1		23	/* S_DMA_22 */
-#define OMAP24XX_DMA_SPI3_RX1		24	/* S_DMA_23 */
-#define OMAP243X_DMA_EXT_DMAREQ4	25	/* S_DMA_24 */
-#define OMAP243X_DMA_EXT_DMAREQ5	26	/* S_DMA_25 */
 #define OMAP34XX_DMA_I2C3_TX		25	/* S_DMA_24 */
 #define OMAP34XX_DMA_I2C3_RX		26	/* S_DMA_25 */
 #define OMAP24XX_DMA_I2C1_TX		27	/* S_DMA_26 */
 #define OMAP24XX_DMA_I2C1_RX		28	/* S_DMA_27 */
 #define OMAP24XX_DMA_I2C2_TX		29	/* S_DMA_28 */
 #define OMAP24XX_DMA_I2C2_RX		30	/* S_DMA_29 */
-#define OMAP24XX_DMA_MCBSP1_TX		31	/* S_DMA_30 */
-#define OMAP24XX_DMA_MCBSP1_RX		32	/* S_DMA_31 */
-#define OMAP24XX_DMA_MCBSP2_TX		33	/* S_DMA_32 */
-#define OMAP24XX_DMA_MCBSP2_RX		34	/* S_DMA_33 */
-#define OMAP24XX_DMA_SPI1_TX0		35	/* S_DMA_34 */
-#define OMAP24XX_DMA_SPI1_RX0		36	/* S_DMA_35 */
-#define OMAP24XX_DMA_SPI1_TX1		37	/* S_DMA_36 */
-#define OMAP24XX_DMA_SPI1_RX1		38	/* S_DMA_37 */
-#define OMAP24XX_DMA_SPI1_TX2		39	/* S_DMA_38 */
-#define OMAP24XX_DMA_SPI1_RX2		40	/* S_DMA_39 */
-#define OMAP24XX_DMA_SPI1_TX3		41	/* S_DMA_40 */
-#define OMAP24XX_DMA_SPI1_RX3		42	/* S_DMA_41 */
-#define OMAP24XX_DMA_SPI2_TX0		43	/* S_DMA_42 */
-#define OMAP24XX_DMA_SPI2_RX0		44	/* S_DMA_43 */
-#define OMAP24XX_DMA_SPI2_TX1		45	/* S_DMA_44 */
-#define OMAP24XX_DMA_SPI2_RX1		46	/* S_DMA_45 */
 #define OMAP24XX_DMA_MMC2_TX		47	/* S_DMA_46 */
 #define OMAP24XX_DMA_MMC2_RX		48	/* S_DMA_47 */
 #define OMAP24XX_DMA_UART1_TX		49	/* S_DMA_48 */
@@ -93,33 +44,12 @@
 #define OMAP24XX_DMA_UART2_RX		52	/* S_DMA_51 */
 #define OMAP24XX_DMA_UART3_TX		53	/* S_DMA_52 */
 #define OMAP24XX_DMA_UART3_RX		54	/* S_DMA_53 */
-#define OMAP24XX_DMA_USB_W2FC_TX0	55	/* S_DMA_54 */
-#define OMAP24XX_DMA_USB_W2FC_RX0	56	/* S_DMA_55 */
-#define OMAP24XX_DMA_USB_W2FC_TX1	57	/* S_DMA_56 */
-#define OMAP24XX_DMA_USB_W2FC_RX1	58	/* S_DMA_57 */
-#define OMAP24XX_DMA_USB_W2FC_TX2	59	/* S_DMA_58 */
-#define OMAP24XX_DMA_USB_W2FC_RX2	60	/* S_DMA_59 */
 #define OMAP24XX_DMA_MMC1_TX		61	/* S_DMA_60 */
 #define OMAP24XX_DMA_MMC1_RX		62	/* S_DMA_61 */
-#define OMAP24XX_DMA_MS			63	/* S_DMA_62 */
 #define OMAP242X_DMA_EXT_DMAREQ5	64	/* S_DMA_63 */
-#define OMAP243X_DMA_EXT_DMAREQ6	64	/* S_DMA_63 */
-#define OMAP34XX_DMA_EXT_DMAREQ3	64	/* S_DMA_63 */
 #define OMAP34XX_DMA_AES2_TX		65	/* S_DMA_64 */
 #define OMAP34XX_DMA_AES2_RX		66	/* S_DMA_65 */
-#define OMAP34XX_DMA_DES2_TX		67	/* S_DMA_66 */
-#define OMAP34XX_DMA_DES2_RX		68	/* S_DMA_67 */
 #define OMAP34XX_DMA_SHA1MD5_RX		69	/* S_DMA_68 */
-#define OMAP34XX_DMA_SPI4_TX0		70	/* S_DMA_69 */
-#define OMAP34XX_DMA_SPI4_RX0		71	/* S_DMA_70 */
-#define OMAP34XX_DSS_DMA0		72	/* S_DMA_71 */
-#define OMAP34XX_DSS_DMA1		73	/* S_DMA_72 */
-#define OMAP34XX_DSS_DMA2		74	/* S_DMA_73 */
-#define OMAP34XX_DSS_DMA3		75	/* S_DMA_74 */
-#define OMAP34XX_DMA_MMC3_TX		77	/* S_DMA_76 */
-#define OMAP34XX_DMA_MMC3_RX		78	/* S_DMA_77 */
-#define OMAP34XX_DMA_USIM_TX		79	/* S_DMA_78 */
-#define OMAP34XX_DMA_USIM_RX		80	/* S_DMA_79 */
 
 #define OMAP36XX_DMA_UART4_TX		81	/* S_DMA_80 */
 #define OMAP36XX_DMA_UART4_RX		82	/* S_DMA_81 */
-- 
1.7.10.4

