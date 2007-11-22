From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH RESEND] OMAP: DMA: Cleanup of DMA Request Lines
Date: Thu, 22 Nov 2007 10:25:56 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804DC1218@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar@ti.com>

Added support for TI OMAP3430 and cleanup of DMA request lines.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 include/asm-arm/arch-omap/dma.h |  152 =
+++++++++++++++++++++++++++++++---------
 1 files changed, 120 insertions(+), 32 deletions(-)

Index: linux-git-19NOV/include/asm-arm/arch-omap/dma.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-git-19NOV.orig/include/asm-arm/arch-omap/dma.h	2007-11-18 =
23:31:52.000000000 -0500
+++ linux-git-19NOV/include/asm-arm/arch-omap/dma.h	2007-11-22 =
01:13:23.109046296 -0500
@@ -190,19 +190,40 @@
=20
 /* DMA channels for 24xx */
 #define OMAP24XX_DMA_NO_DEVICE		0
+
+#ifndef CONFIG_ARCH_OMAP3
 #define OMAP24XX_DMA_XTI_DMA		1	/* S_DMA_0 */
+#endif
+
 #define OMAP24XX_DMA_EXT_DMAREQ0	2	/* S_DMA_1 */
 #define OMAP24XX_DMA_EXT_DMAREQ1	3	/* S_DMA_2 */
 #define OMAP24XX_DMA_GPMC		4	/* S_DMA_3 */
+
+#ifndef CONFIG_ARCH_OMAP3
 #define OMAP24XX_DMA_GFX		5	/* S_DMA_4 */
+#endif
+
 #define OMAP24XX_DMA_DSS		6	/* S_DMA_5 */
+
+#ifdef CONFIG_ARCH_OMAP2420
 #define OMAP24XX_DMA_VLYNQ_TX		7	/* S_DMA_6 */
+#else
+#define OMAP24XX_DMA_EXT_DMAREQ2	7	/* S_DMA_6 */
+#endif
+
+#ifndef CONFIG_ARCH_OMAP3
 #define OMAP24XX_DMA_CWT		8	/* S_DMA_7 */
+#endif
+
 #define OMAP24XX_DMA_AES_TX		9	/* S_DMA_8 */
 #define OMAP24XX_DMA_AES_RX		10	/* S_DMA_9 */
 #define OMAP24XX_DMA_DES_TX		11	/* S_DMA_10 */
 #define OMAP24XX_DMA_DES_RX		12	/* S_DMA_11 */
+
+#define OMAP34XX_DMA_SHA2MD5_RX		13	/* S_DMA_12 */
 #define OMAP24XX_DMA_SHA1MD5_RX		13	/* S_DMA_12 */
+
+#ifdef CONFIG_ARCH_OMAP2420
 #define OMAP24XX_DMA_EXT_DMAREQ2	14	/* S_DMA_13 */
 #define OMAP24XX_DMA_EXT_DMAREQ3	15	/* S_DMA_14 */
 #define OMAP24XX_DMA_EXT_DMAREQ4	16	/* S_DMA_15 */
@@ -216,43 +237,110 @@
 #define OMAP24XX_DMA_EAC_BT_UL_WR	24	/* S_DMA_23 */
 #define OMAP24XX_DMA_EAC_BT_DL_RD	25	/* S_DMA_24 */
 #define OMAP24XX_DMA_EAC_BT_DL_WR	26	/* S_DMA_25 */
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2430
+#define OMAP24XX_DMA_EXT_DMAREQ3	14	/* S_DMA_13 */
+#endif
+
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#define OMAP24XX_DMA_SPI3_TX0		15	/* S_DMA_14 */
+#define OMAP24XX_DMA_SPI3_RX0		16	/* S_DMA_15 */
+#define OMAP24XX_DMA_MCBSP3_TX		17	/* S_DMA_16 */
+#define OMAP24XX_DMA_MCBSP3_RX		18	/* S_DMA_17 */
+#define OMAP24XX_DMA_MCBSP4_TX		19	/* S_DMA_18 */
+#define OMAP24XX_DMA_MCBSP4_RX		20	/* S_DMA_19 */
+#define OMAP24XX_DMA_MCBSP5_TX		21	/* S_DMA_20 */
+#define OMAP24XX_DMA_MCBSP5_RX		22	/* S_DMA_21 */
+#define OMAP24XX_DMA_SPI3_TX1		23	/* S_DMA_22 */
+#define OMAP24XX_DMA_SPI3_RX1		24	/* S_DMA_23 */
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2430
+#define OMAP24XX_DMA_EXT_DMAREQ4	25	/* S_DMA_24 */
+#define OMAP24XX_DMA_EXT_DMAREQ5	26	/* S_DMA_25 */
+#endif
+
+#ifdef CONFIG_ARCH_OMAP3
+#define OMAP34XX_DMA_I2C3_TX		25	/* S_DMA_24 */
+#define OMAP34XX_DMA_I2C3_RX		26	/* S_DMA_25 */
+#endif
+
 #define OMAP24XX_DMA_I2C1_TX		27	/* S_DMA_26 */
 #define OMAP24XX_DMA_I2C1_RX		28	/* S_DMA_27 */
 #define OMAP24XX_DMA_I2C2_TX		29	/* S_DMA_28 */
 #define OMAP24XX_DMA_I2C2_RX		30	/* S_DMA_29 */
-#define OMAP24XX_DMA_MCBSP1_TX		31	/* SDMA_30 */
-#define OMAP24XX_DMA_MCBSP1_RX		32	/* SDMA_31 */
-#define OMAP24XX_DMA_MCBSP2_TX		33	/* SDMA_32 */
-#define OMAP24XX_DMA_MCBSP2_RX		34	/* SDMA_33 */
-#define OMAP24XX_DMA_SPI1_TX0		35	/* SDMA_34 */
-#define OMAP24XX_DMA_SPI1_RX0		36	/* SDMA_35 */
-#define OMAP24XX_DMA_SPI1_TX1		37	/* SDMA_36 */
-#define OMAP24XX_DMA_SPI1_RX1		38	/* SDMA_37 */
-#define OMAP24XX_DMA_SPI1_TX2		39	/* SDMA_38 */
-#define OMAP24XX_DMA_SPI1_RX2		40	/* SDMA_39 */
-#define OMAP24XX_DMA_SPI1_TX3		41	/* SDMA_40 */
-#define OMAP24XX_DMA_SPI1_RX3		42	/* SDMA_41 */
-#define OMAP24XX_DMA_SPI2_TX0		43	/* SDMA_42 */
-#define OMAP24XX_DMA_SPI2_RX0		44	/* SDMA_43 */
-#define OMAP24XX_DMA_SPI2_TX1		45	/* SDMA_44 */
-#define OMAP24XX_DMA_SPI2_RX1		46	/* SDMA_45 */
-
-#define OMAP24XX_DMA_UART1_TX		49	/* SDMA_48 */
-#define OMAP24XX_DMA_UART1_RX		50	/* SDMA_49 */
-#define OMAP24XX_DMA_UART2_TX		51	/* SDMA_50 */
-#define OMAP24XX_DMA_UART2_RX		52	/* SDMA_51 */
-#define OMAP24XX_DMA_UART3_TX		53	/* SDMA_52 */
-#define OMAP24XX_DMA_UART3_RX		54	/* SDMA_53 */
-#define OMAP24XX_DMA_USB_W2FC_TX0	55	/* SDMA_54 */
-#define OMAP24XX_DMA_USB_W2FC_RX0	56	/* SDMA_55 */
-#define OMAP24XX_DMA_USB_W2FC_TX1	57	/* SDMA_56 */
-#define OMAP24XX_DMA_USB_W2FC_RX1	58	/* SDMA_57 */
-#define OMAP24XX_DMA_USB_W2FC_TX2	59	/* SDMA_58 */
-#define OMAP24XX_DMA_USB_W2FC_RX2	60	/* SDMA_59 */
-#define OMAP24XX_DMA_MMC1_TX		61	/* SDMA_60 */
-#define OMAP24XX_DMA_MMC1_RX		62	/* SDMA_61 */
-#define OMAP24XX_DMA_MS			63	/* SDMA_62 */
+#define OMAP24XX_DMA_MCBSP1_TX		31	/* S_DMA_30 */
+#define OMAP24XX_DMA_MCBSP1_RX		32	/* S_DMA_31 */
+#define OMAP24XX_DMA_MCBSP2_TX		33	/* S_DMA_32 */
+#define OMAP24XX_DMA_MCBSP2_RX		34	/* S_DMA_33 */
+#define OMAP24XX_DMA_SPI1_TX0		35	/* S_DMA_34 */
+#define OMAP24XX_DMA_SPI1_RX0		36	/* S_DMA_35 */
+#define OMAP24XX_DMA_SPI1_TX1		37	/* S_DMA_36 */
+#define OMAP24XX_DMA_SPI1_RX1		38	/* S_DMA_37 */
+#define OMAP24XX_DMA_SPI1_TX2		39	/* S_DMA_38 */
+#define OMAP24XX_DMA_SPI1_RX2		40	/* S_DMA_39 */
+#define OMAP24XX_DMA_SPI1_TX3		41	/* S_DMA_40 */
+#define OMAP24XX_DMA_SPI1_RX3		42	/* S_DMA_41 */
+#define OMAP24XX_DMA_SPI2_TX0		43	/* S_DMA_42 */
+#define OMAP24XX_DMA_SPI2_RX0		44	/* S_DMA_43 */
+#define OMAP24XX_DMA_SPI2_TX1		45	/* S_DMA_44 */
+#define OMAP24XX_DMA_SPI2_RX1		46	/* S_DMA_45 */
+
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#define OMAP24XX_DMA_MMC2_TX		47	/* S_DMA_46 */
+#define OMAP24XX_DMA_MMC2_RX		48	/* S_DMA_47 */
+#endif
+
+#define OMAP24XX_DMA_UART1_TX		49	/* S_DMA_48 */
+#define OMAP24XX_DMA_UART1_RX		50	/* S_DMA_49 */
+#define OMAP24XX_DMA_UART2_TX		51	/* S_DMA_50 */
+#define OMAP24XX_DMA_UART2_RX		52	/* S_DMA_51 */
+#define OMAP24XX_DMA_UART3_TX		53	/* S_DMA_52 */
+#define OMAP24XX_DMA_UART3_RX		54	/* S_DMA_53 */
+
+#ifndef CONFIG_ARCH_OMAP3
+#define OMAP24XX_DMA_USB_W2FC_TX0	55	/* S_DMA_54 */
+#define OMAP24XX_DMA_USB_W2FC_RX0	56	/* S_DMA_55 */
+#define OMAP24XX_DMA_USB_W2FC_TX1	57	/* S_DMA_56 */
+#define OMAP24XX_DMA_USB_W2FC_RX1	58	/* S_DMA_57 */
+#define OMAP24XX_DMA_USB_W2FC_TX2	59	/* S_DMA_58 */
+#define OMAP24XX_DMA_USB_W2FC_RX2	60	/* S_DMA_59 */
+#endif
+
+#define OMAP24XX_DMA_MMC1_TX		61	/* S_DMA_60 */
+#define OMAP24XX_DMA_MMC1_RX		62	/* S_DMA_61 */
+#define OMAP24XX_DMA_MS			63	/* S_DMA_62 */
+
+#ifdef CONFIG_ARCH_OMAP2420
 #define OMAP24XX_DMA_EXT_DMAREQ5	64	/* S_DMA_63 */
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2430
+#define OMAP24XX_DMA_EXT_DMAREQ6	64	/* S_DMA_63 */
+#endif
+
+#ifdef CONFIG_ARCH_OMAP3
+#define OMAP24XX_DMA_EXT_DMAREQ3	64	/* S_DMA_63 */
+#endif
+
+#ifdef CONFIG_ARCH_OMAP3
+#define OMAP34XX_DMA_AES2_TX		65	/* S_DMA_64 */
+#define OMAP34XX_DMA_AES2_RX		66	/* S_DMA_65 */
+#define OMAP34XX_DMA_DES2_TX		67	/* S_DMA_66 */
+#define OMAP34XX_DMA_DES2_RX		68	/* S_DMA_67 */
+#define OMAP34XX_DMA_SHA1MD5_RX		69	/* S_DMA_68 */
+#define OMAP34XX_DMA_SPI4_TX0		70	/* S_DMA_69 */
+#define OMAP34XX_DMA_SPI4_RX0		71	/* S_DMA_70 */
+#define OMAP34XX_DSS_DMA0		72	/* S_DMA_71 */
+#define OMAP34XX_DSS_DMA1		73	/* S_DMA_72 */
+#define OMAP34XX_DSS_DMA2		74	/* S_DMA_73 */
+#define OMAP34XX_DSS_DMA3		75	/* S_DMA_74 */
+#define OMAP34XX_DMA_MMC3_TX		77	/* S_DMA_76 */
+#define OMAP34XX_DMA_MMC3_RX		78	/* S_DMA_77 */
+#define OMAP34XX_DMA_USIM_TX		79	/* S_DMA_78 */
+#define OMAP34XX_DMA_USIM_RX		80	/* S_DMA_79 */
+#endif
=20
 =
/*-----------------------------------------------------------------------=
-----*/
