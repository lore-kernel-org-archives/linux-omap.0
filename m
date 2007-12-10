From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH RFC Option 3] OMAP: DMA: Cleanup of DMA Request Lines
Date: Mon, 10 Dec 2007 10:27:28 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804FE68FA@dbde01.ent.ti.com>
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
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar@ti.com>

Added support for TI OMAP3430 and cleanup of DMA request lines.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Index: dma_cleanup_patch/include/asm-arm/arch-omap/dma.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
This is Option 3. More complicated and kind of roundabout.
This is only a sample patch and needs more work.
But it ought to make it easier to add support for future OMAPs
with only minimal changes to the drivers.

--- dma_cleanup_patch.orig/include/asm-arm/arch-omap/dma.h	2007-12-10 =
10:11:23.000000000 +0530
+++ dma_cleanup_patch/include/asm-arm/arch-omap/dma.h	2007-12-10 =
10:18:12.269821374 +0530
@@ -21,6 +21,8 @@
 #ifndef __ASM_ARCH_DMA_H
 #define __ASM_ARCH_DMA_H
=20
+#include "dmareq.h"
+
 /* Hardware registers for omap1 */
 #define OMAP_DMA_BASE			(0xfffed800)
 #define OMAP_DMA_GCR			(OMAP_DMA_BASE + 0x400)
Index: test_option1_1/include/asm-arm/arch-omap/dmareq.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dma_cleanup_patch/include/asm-arm/arch-omap/dmareq.h	2007-12-10 =
10:17:24.143370584 +0530
@@ -0,0 +1,120 @@
+/*
+ *
+ *  Copyright (C) 2007 Texas Instruments
+ *  Author: Anand Gadiyar <gadiyar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 =
USA
+ */
+
+ enum request_lines {
+ OMAP_DMAREQ_NO_DEVICE,
+ OMAP_DMAREQ_XTI_DMA,
+ OMAP_DMAREQ_EXT_DMAREQ0,
+ OMAP_DMAREQ_EXT_DMAREQ1,
+ OMAP_DMAREQ_GPMC,
+ OMAP_DMAREQ_GFX,
+ OMAP_DMAREQ_DSS,
+ OMAP_DMAREQ_EXT_DMAREQ2,
+ OMAP_DMAREQ_CWT,
+ OMAP_DMAREQ_AES_TX,
+ OMAP_DMAREQ_AES_RX,
+ OMAP_DMAREQ_DES_TX,
+ OMAP_DMAREQ_DES_RX,
+ OMAP_DMAREQ_SHA2MD5_RX,
+ OMAP_DMAREQ_SPI3_TX0,
+ OMAP_DMAREQ_SPI3_RX0,
+ OMAP_DMAREQ_MCBSP3_TX,
+ OMAP_DMAREQ_MCBSP3_RX,
+ OMAP_DMAREQ_MCBSP4_TX,
+ OMAP_DMAREQ_MCBSP4_RX,
+ OMAP_DMAREQ_MCBSP5_TX,
+ OMAP_DMAREQ_MCBSP5_RX,
+ OMAP_DMAREQ_SPI3_TX1,
+ OMAP_DMAREQ_SPI3_RX1,
+ OMAP_DMAREQ_I2C3_TX,
+ OMAP_DMAREQ_I2C3_RX,
+ OMAP_DMAREQ_I2C1_TX,
+ OMAP_DMAREQ_I2C1_RX,
+ OMAP_DMAREQ_I2C2_TX,
+ OMAP_DMAREQ_I2C2_RX,
+ OMAP_DMAREQ_MCBSP1_TX,
+ OMAP_DMAREQ_MCBSP1_RX,
+ OMAP_DMAREQ_MCBSP2_TX,
+ OMAP_DMAREQ_MCBSP2_RX,
+ OMAP_DMAREQ_SPI1_TX0,
+ OMAP_DMAREQ_SPI1_RX0,
+ OMAP_DMAREQ_SPI1_TX1,
+ OMAP_DMAREQ_SPI1_RX1,
+ OMAP_DMAREQ_SPI1_TX2,
+ OMAP_DMAREQ_SPI1_RX2,
+ OMAP_DMAREQ_SPI1_TX3,
+ OMAP_DMAREQ_SPI1_RX3,
+ OMAP_DMAREQ_SPI2_TX0,
+ OMAP_DMAREQ_SPI2_RX0,
+ OMAP_DMAREQ_SPI2_TX1,
+ OMAP_DMAREQ_SPI2_RX1,
+ OMAP_DMAREQ_MMC2_TX,
+ OMAP_DMAREQ_MMC2_RX,
+ OMAP_DMAREQ_UART1_TX,
+ OMAP_DMAREQ_UART1_RX,
+ OMAP_DMAREQ_UART2_TX,
+ OMAP_DMAREQ_UART2_RX,
+ OMAP_DMAREQ_UART3_TX,
+ OMAP_DMAREQ_UART3_RX,
+ OMAP_DMAREQ_USB_W2FC_TX0,
+ OMAP_DMAREQ_USB_W2FC_RX0,
+ OMAP_DMAREQ_USB_W2FC_TX1,
+ OMAP_DMAREQ_USB_W2FC_RX1,
+ OMAP_DMAREQ_USB_W2FC_TX2,
+ OMAP_DMAREQ_USB_W2FC_RX2,
+ OMAP_DMAREQ_MMC1_TX,
+ OMAP_DMAREQ_MMC1_RX,
+ OMAP_DMAREQ_MS,
+ OMAP_DMAREQ_EXT_DMAREQ3,
+ OMAP_DMAREQ_AES2_TX,
+ OMAP_DMAREQ_AES2_RX,
+ OMAP_DMAREQ_DES2_TX,
+ OMAP_DMAREQ_DES2_RX,
+ OMAP_DMAREQ_SHA1MD5_RX,
+ OMAP_DMAREQ_SPI4_TX0,
+ OMAP_DMAREQ_SPI4_RX0,
+ OMAP_DSS_DMAREQ0,
+ OMAP_DSS_DMAREQ1,
+ OMAP_DSS_DMAREQ2,
+ OMAP_DSS_DMAREQ3,
+ OMAP_DMAREQ_MMC3_TX,
+ OMAP_DMAREQ_MMC3_RX,
+ OMAP_DMAREQ_USIM_TX,
+ OMAP_DMAREQ_USIM_RX,
+ OMAP_DMAREQ_EXT_DMAREQ4,
+ OMAP_DMAREQ_EXT_DMAREQ5,
+ OMAP_DMAREQ_EXT_DMAREQ6,
+ OMAP_DMAREQ_VLYNQ_TX,
+ OMAP_DMAREQ_EAC_AC_RD,
+ OMAP_DMAREQ_EAC_AC_WR,
+ OMAP_DMAREQ_EAC_MD_UL_RD,
+ OMAP_DMAREQ_EAC_MD_UL_WR,
+ OMAP_DMAREQ_EAC_MD_DL_RD,
+ OMAP_DMAREQ_EAC_MD_DL_WR,
+ OMAP_DMAREQ_EAC_BT_UL_RD,
+ OMAP_DMAREQ_EAC_BT_UL_WR,
+ OMAP_DMAREQ_EAC_BT_DL_RD,
+ OMAP_DMAREQ_EAC_BT_DL_WR,
+ };
+
+extern int dma_omap_cpu;
+extern const int sdma_req_line[][3];
+#define get_sdma_request_line(request_line)	\
+				sdma_req_line[request_line][dma_omap_cpu]
Index: dma_cleanup_patch/arch/arm/plat-omap/dma.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- dma_cleanup_patch.orig/arch/arm/plat-omap/dma.c	2007-12-10 =
10:19:54.000000000 +0530
+++ dma_cleanup_patch/arch/arm/plat-omap/dma.c	2007-12-10 =
10:20:55.000585152 +0530
@@ -55,8 +55,115 @@
=20
 #define OMAP_FUNC_MUX_ARM_BASE	(0xfffe1000 + 0xec)
=20
+int dma_omap_cpu;
+
+const int sdma_req_line[][3] =3D {
+/* OMAP2420, OMAP2430, OMAP34XX */
+{0, 0, 0},	/* OMAP_DMAREQ_NO_DEVICE */
+{1, 1, -1},	/* OMAP_DMAREQ_XTI_DMA */
+{2, 2, 2},	/* OMAP_DMAREQ_EXT_DMAREQ0 */
+{3, 3, 3},	/* OMAP_DMAREQ_EXT_DMAREQ1 */
+{4, 4, 4},	/* OMAP_DMAREQ_GPMC */
+{5, 5, -1},	/* OMAP_DMAREQ_GFX */
+{6, 6, -1},	/* OMAP_DMAREQ_DSS */
+{14, 7, 7},	/* OMAP_DMAREQ_EXT_DMAREQ2 */
+{8, 8, -1},	/* OMAP_DMAREQ_CWT */
+{9, 9, 9},	/* OMAP_DMAREQ_AES_TX */
+{10, 10, 10},	/* OMAP_DMAREQ_AES_RX */
+{11, 11, 11},	/* OMAP_DMAREQ_DES_TX */
+{12, 12, 12},	/* OMAP_DMAREQ_DES_RX */
+{-1, -1, 13},	/* OMAP_DMAREQ_SHA2MD5_RX */
+{-1, 15, 15},	/* OMAP_DMAREQ_SPI3_TX0 */
+{-1, 16, 16},	/* OMAP_DMAREQ_SPI3_RX0 */
+{-1, 17, 17},	/* OMAP_DMAREQ_MCBSP3_TX */
+{-1, 18, 18},	/* OMAP_DMAREQ_MCBSP3_RX */
+{-1, 19, 19},	/* OMAP_DMAREQ_MCBSP4_TX */
+{-1, 20, 20},	/* OMAP_DMAREQ_MCBSP4_RX */
+{-1, 21, 21},	/* OMAP_DMAREQ_MCBSP5_TX */
+{-1, 22, 22},	/* OMAP_DMAREQ_MCBSP5_RX */
+{-1, 23, 23},	/* OMAP_DMAREQ_SPI3_TX1 */
+{-1, 24, 24},	/* OMAP_DMAREQ_SPI3_RX1 */
+{-1, -1, 25},	/* OMAP_DMAREQ_I2C3_TX */
+{-1, -1, 26},	/* OMAP_DMAREQ_I2C3_RX */
+{27, 27, 27},	/* OMAP_DMAREQ_I2C1_TX */
+{28, 28, 28},	/* OMAP_DMAREQ_I2C1_RX */
+{29, 29, 29},	/* OMAP_DMAREQ_I2C2_TX */
+{30, 30, 30},	/* OMAP_DMAREQ_I2C2_RX */
+{31, 31, 31},	/* OMAP_DMAREQ_MCBSP1_TX */
+{32, 32, 32},	/* OMAP_DMAREQ_MCBSP1_RX */
+{33, 33, 33},	/* OMAP_DMAREQ_MCBSP2_TX */
+{34, 34, 34},	/* OMAP_DMAREQ_MCBSP2_RX */
+{35, 35, 35},	/* OMAP_DMAREQ_SPI1_TX0 */
+{36, 36, 36},	/* OMAP_DMAREQ_SPI1_RX0 */
+{37, 37, 37},	/* OMAP_DMAREQ_SPI1_TX1 */
+{38, 38, 38},	/* OMAP_DMAREQ_SPI1_RX1 */
+{39, 39, 39},	/* OMAP_DMAREQ_SPI1_TX2 */
+{40, 40, 40},	/* OMAP_DMAREQ_SPI1_RX2 */
+{41, 41, 41},	/* OMAP_DMAREQ_SPI1_TX3 */
+{42, 42, 42},	/* OMAP_DMAREQ_SPI1_RX3 */
+{43, 43, 43},	/* OMAP_DMAREQ_SPI2_TX0 */
+{44, 44, 44},	/* OMAP_DMAREQ_SPI2_RX0 */
+{45, 45, 45},	/* OMAP_DMAREQ_SPI2_TX1 */
+{46, 46, 46},	/* OMAP_DMAREQ_SPI2_RX1 */
+{-1, 47, 47},	/* OMAP_DMAREQ_MMC2_TX */
+{-1, 48, 48},	/* OMAP_DMAREQ_MMC2_RX */
+{49, 49, 49},	/* OMAP_DMAREQ_UART1_TX */
+{50, 50, 50},	/* OMAP_DMAREQ_UART1_RX */
+{51, 51, 51},	/* OMAP_DMAREQ_UART2_TX */
+{52, 52, 52},	/* OMAP_DMAREQ_UART2_RX */
+{53, 53, 53},	/* OMAP_DMAREQ_UART3_TX */
+{54, 54, 54},	/* OMAP_DMAREQ_UART3_RX */
+{55, 55, -1},	/* OMAP_DMAREQ_USB_W2FC_TX0 */
+{56, 56, -1},	/* OMAP_DMAREQ_USB_W2FC_RX0 */
+{57, 57, -1},	/* OMAP_DMAREQ_USB_W2FC_TX1 */
+{58, 58, -1},	/* OMAP_DMAREQ_USB_W2FC_RX1 */
+{59, 59, -1},	/* OMAP_DMAREQ_USB_W2FC_TX2 */
+{60, 60, -1},	/* OMAP_DMAREQ_USB_W2FC_RX2 */
+{61, 61, 61},	/* OMAP_DMAREQ_MMC1_TX */
+{62, 62, 62},	/* OMAP_DMAREQ_MMC1_RX */
+{63, 63, 63},	/* OMAP_DMAREQ_MS */
+{15, 14, 64},	/* OMAP_DMAREQ_EXT_DMAREQ3 */
+{-1, -1, 65},	/* OMAP_DMAREQ_AES2_TX */
+{-1, -1, 66},	/* OMAP_DMAREQ_AES2_RX */
+{-1, -1, 67},	/* OMAP_DMAREQ_DES2_TX */
+{-1, -1, 68},	/* OMAP_DMAREQ_DES2_RX */
+{13, 13, 69},	/* OMAP_DMAREQ_SHA1MD5_RX */
+{-1, -1, 70},	/* OMAP_DMAREQ_SPI4_TX0 */
+{-1, -1, 71},	/* OMAP_DMAREQ_SPI4_RX0 */
+{-1, -1, 72},	/* OMAP_DSS_DMAREQ0 */
+{-1, -1, 73},	/* OMAP_DSS_DMAREQ1 */
+{-1, -1, 74},	/* OMAP_DSS_DMAREQ2 */
+{-1, -1, 75},	/* OMAP_DSS_DMAREQ3 */
+{-1, -1, 77},	/* OMAP_DMAREQ_MMC3_TX */
+{-1, -1, 78},	/* OMAP_DMAREQ_MMC3_RX */
+{-1, -1, 79},	/* OMAP_DMAREQ_USIM_TX */
+{-1, -1, 80},	/* OMAP_DMAREQ_USIM_RX */
+{16, 25, -1},	/* OMAP_DMAREQ_EXT_DMAREQ4 */
+{64, 26, -1},	/* OMAP_DMAREQ_EXT_DMAREQ5 */
+{-1, 64, -1},	/* OMAP_DMAREQ_EXT_DMAREQ6 */
+{7, -1, -1},	/* OMAP_DMAREQ_VLYNQ_TX */
+{17, -1, -1},	/* OMAP_DMAREQ_EAC_AC_RD */
+{18, -1, -1},	/* OMAP_DMAREQ_EAC_AC_WR */
+{19, -1, -1},	/* OMAP_DMAREQ_EAC_MD_UL_RD */
+{20, -1, -1},	/* OMAP_DMAREQ_EAC_MD_UL_WR */
+{21, -1, -1},	/* OMAP_DMAREQ_EAC_MD_DL_RD */
+{22, -1, -1},	/* OMAP_DMAREQ_EAC_MD_DL_WR */
+{23, -1, -1},	/* OMAP_DMAREQ_EAC_BT_UL_RD */
+{24, -1, -1},	/* OMAP_DMAREQ_EAC_BT_UL_WR */
+{25, -1, -1},	/* OMAP_DMAREQ_EAC_BT_DL_RD */
+{26, -1, -1},	/* OMAP_DMAREQ_EAC_BT_DL_WR */
+
+};
+
 static int enable_1510_mode =3D 0;
=20
 struct omap_dma_lch {
