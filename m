From: rafiuddin.syed@ti.com
Subject: [PATCH 1/4 v2] ARM: OMAP4: sDMA: Update the request lines
Date: Wed,  8 Jul 2009 09:50:24 +0530
Message-ID: <1247026824-26787-1-git-send-email-rafiuddin.syed@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53582 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbZGHEUw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Jul 2009 00:20:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch updates the platform dma.h with new dma request lines
for OMAP4 peripherals. Also additional hardware register of OMAP4
sDMA module are included.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/mach/dma.h |   88 +++++++++++++++++++++++++++++++++
 1 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/dma.h b/arch/arm/plat-omap/include/mach/dma.h
index 8c1eae8..01ea54a 100644
--- a/arch/arm/plat-omap/include/mach/dma.h
+++ b/arch/arm/plat-omap/include/mach/dma.h
@@ -122,6 +122,11 @@
 #define OMAP_DMA4_CCFN(n)		(0x60 * (n) + 0xc0)
 #define OMAP_DMA4_COLOR(n)		(0x60 * (n) + 0xc4)
 
+/* Additional registers available on OMAP4 */
+#define OMAP_DMA4_CDP(n)		(0x60 * (n) + 0xd0)
+#define OMAP_DMA4_CNDP(n)		(0x60 * (n) + 0xd4)
+#define OMAP_DMA4_CCDN(n)		(0x60 * (n) + 0xd8)
+
 /* Dummy defines to keep multi-omap compiles happy */
 #define OMAP1_DMA_REVISION		0
 #define OMAP1_DMA_IRQSTATUS_L0		0
@@ -311,6 +316,89 @@
 #define OMAP34XX_DMA_USIM_TX		79	/* S_DMA_78 */
 #define OMAP34XX_DMA_USIM_RX		80	/* S_DMA_79 */
 
+/* DMA request lines for 44xx */
+#define OMAP44XX_DMA_DSS_DISPC_REQ	6	/* S_DMA_5 */
+#define OMAP44XX_DMA_SYS_REQ2		7	/* S_DMA_6 */
+#define OMAP44XX_DMA_ISS_REQ1		9	/* S_DMA_8 */
+#define OMAP44XX_DMA_ISS_REQ2		10	/* S_DMA_9 */
+#define OMAP44XX_DMA_ISS_REQ3		12	/* S_DMA_11 */
+#define OMAP44XX_DMA_ISS_REQ4		13	/* S_DMA_12 */
+#define OMAP44XX_DMA_DSS_RFBI_REQ	14	/* S_DMA_13 */
+#define OMAP44XX_DMA_SPI3_TX0		15	/* S_DMA_14 */
+#define OMAP44XX_DMA_SPI3_RX0		16	/* S_DMA_15 */
+#define OMAP44XX_DMA_MCBSP2_TX		17	/* S_DMA_16 */
+#define OMAP44XX_DMA_MCBSP2_RX		18	/* S_DMA_17 */
+#define OMAP44XX_DMA_MCBSP3_TX		19	/* S_DMA_18 */
+#define OMAP44XX_DMA_MCBSP3_RX		20	/* S_DMA_19 */
+#define OMAP44XX_DMA_SPI3_TX1		23	/* S_DMA_22 */
+#define OMAP44XX_DMA_SPI3_RX1		24	/* S_DMA_23 */
+#define OMAP44XX_DMA_I2C3_TX		25	/* S_DMA_24 */
+#define OMAP44XX_DMA_I2C3_RX		26	/* S_DMA_25 */
+#define OMAP44XX_DMA_I2C1_TX		27	/* S_DMA_26 */
+#define OMAP44XX_DMA_I2C1_RX		28	/* S_DMA_27 */
+#define OMAP44XX_DMA_I2C2_TX		29	/* S_DMA_28 */
+#define OMAP44XX_DMA_I2C2_RX		30	/* S_DMA_29 */
+#define OMAP44XX_DMA_MCBSP4_TX		31	/* S_DMA_30 */
+#define OMAP44XX_DMA_MCBSP4_RX		32	/* S_DMA_31 */
+#define OMAP44XX_DMA_MCBSP1_TX		33	/* S_DMA_32 */
+#define OMAP44XX_DMA_MCBSP1_RX		34	/* S_DMA_33 */
+#define OMAP44XX_DMA_SPI1_TX0		35	/* S_DMA_34 */
+#define OMAP44XX_DMA_SPI1_RX0		36	/* S_DMA_35 */
+#define OMAP44XX_DMA_SPI1_TX1		37	/* S_DMA_36 */
+#define OMAP44XX_DMA_SPI1_RX1		38	/* S_DMA_37 */
+#define OMAP44XX_DMA_SPI1_TX2		39	/* S_DMA_38 */
+#define OMAP44XX_DMA_SPI1_RX2		40	/* S_DMA_39 */
+#define OMAP44XX_DMA_SPI1_TX3		41	/* S_DMA_40 */
+#define OMAP44XX_DMA_SPI1_RX3		42	/* S_DMA_41 */
+#define OMAP44XX_DMA_SPI2_TX0		43	/* S_DMA_42 */
+#define OMAP44XX_DMA_SPI2_RX0		44	/* S_DMA_43 */
+#define OMAP44XX_DMA_SPI2_TX1		45	/* S_DMA_44 */
+#define OMAP44XX_DMA_SPI2_RX1		46	/* S_DMA_45 */
+#define OMAP44XX_DMA_MMC2_TX		47	/* S_DMA_46 */
+#define OMAP44XX_DMA_MMC2_RX		48	/* S_DMA_47 */
+#define OMAP44XX_DMA_UART1_TX		49	/* S_DMA_48 */
+#define OMAP44XX_DMA_UART1_RX		50	/* S_DMA_49 */
+#define OMAP44XX_DMA_UART2_TX		51	/* S_DMA_50 */
+#define OMAP44XX_DMA_UART2_RX		52	/* S_DMA_51 */
+#define OMAP44XX_DMA_UART3_TX		53	/* S_DMA_52 */
+#define OMAP44XX_DMA_UART3_RX		54	/* S_DMA_53 */
+#define OMAP44XX_DMA_UART4_TX		55	/* S_DMA_54 */
+#define OMAP44XX_DMA_UART4_RX		56	/* S_DMA_55 */
+#define OMAP44XX_DMA_MMC4_TX		57	/* S_DMA_56 */
+#define OMAP44XX_DMA_MMC4_RX		58	/* S_DMA_57 */
+#define OMAP44XX_DMA_MMC5_TX		59	/* S_DMA_58 */
+#define OMAP44XX_DMA_MMC5_RX		60	/* S_DMA_59 */
+#define OMAP44XX_DMA_MMC1_TX		61	/* S_DMA_60 */
+#define OMAP44XX_DMA_MMC1_RX		62	/* S_DMA_61 */
+#define OMAP44XX_DMA_SYS_REQ3		64	/* S_DMA_63 */
+#define OMAP44XX_DMA_MCPDM_UP		65	/* S_DMA_64 */
+#define OMAP44XX_DMA_MCPDM_DL		66	/* S_DMA_65 */
+#define OMAP44XX_DMA_SPI4_TX0		70	/* S_DMA_69 */
+#define OMAP44XX_DMA_SPI4_RX0		71	/* S_DMA_70 */
+#define OMAP44XX_DMA_DSS_DSI1_REQ0	72	/* S_DMA_71 */
+#define OMAP44XX_DMA_DSS_DSI1_REQ1	73	/* S_DMA_72 */
+#define OMAP44XX_DMA_DSS_DSI1_REQ2	74	/* S_DMA_73 */
+#define OMAP44XX_DMA_DSS_DSI1_REQ3	75	/* S_DMA_74 */
+#define OMAP44XX_DMA_DSS_HDMI_REQ	76	/* S_DMA_75 */
+#define OMAP44XX_DMA_MMC3_TX		77	/* S_DMA_76 */
+#define OMAP44XX_DMA_MMC3_RX		78	/* S_DMA_77 */
+#define OMAP44XX_DMA_USIM_TX		79	/* S_DMA_78 */
+#define OMAP44XX_DMA_USIM_RX		80	/* S_DMA_79 */
+#define OMAP44XX_DMA_DSS_DSI2_REQ0	81	/* S_DMA_80 */
+#define OMAP44XX_DMA_DSS_DSI2_REQ1	82	/* S_DMA_81 */
+#define OMAP44XX_DMA_DSS_DSI2_REQ2	83	/* S_DMA_82 */
+#define OMAP44XX_DMA_DSS_DSI2_REQ3	84	/* S_DMA_83 */
+#define OMAP44XX_DMA_ABE_REQ0		101	/* S_DMA_100 */
+#define OMAP44XX_DMA_ABE_REQ1		102	/* S_DMA_101 */
+#define OMAP44XX_DMA_ABE_REQ2		103	/* S_DMA_102 */
+#define OMAP44XX_DMA_ABE_REQ3		104	/* S_DMA_103 */
+#define OMAP44XX_DMA_ABE_REQ4		105	/* S_DMA_104 */
+#define OMAP44XX_DMA_ABE_REQ5		106	/* S_DMA_105 */
+#define OMAP44XX_DMA_ABE_REQ6		107	/* S_DMA_106 */
+#define OMAP44XX_DMA_ABE_REQ7		108	/* S_DMA_107 */
+#define OMAP44XX_DMA_I2C4_TX		124	/* S_DMA_123 */
+#define OMAP44XX_DMA_I2C4_RX		125	/* S_DMA_124 */
+
 /*----------------------------------------------------------------------------*/
 
 /* Hardware registers for LCD DMA */
-- 
1.5.4.7

