From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 22/33] add omap nand drivers
Date: Sat, 30 Aug 2008 20:16:22 +0300
Message-ID: <1220116593-862-23-git-send-email-me@felipebalbi.com>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com>
 <1220116593-862-2-git-send-email-me@felipebalbi.com>
 <1220116593-862-3-git-send-email-me@felipebalbi.com>
 <1220116593-862-4-git-send-email-me@felipebalbi.com>
 <1220116593-862-5-git-send-email-me@felipebalbi.com>
 <1220116593-862-6-git-send-email-me@felipebalbi.com>
 <1220116593-862-7-git-send-email-me@felipebalbi.com>
 <1220116593-862-8-git-send-email-me@felipebalbi.com>
 <1220116593-862-9-git-send-email-me@felipebalbi.com>
 <1220116593-862-10-git-send-email-me@felipebalbi.com>
 <1220116593-862-11-git-send-email-me@felipebalbi.com>
 <1220116593-862-12-git-send-email-me@felipebalbi.com>
 <1220116593-862-13-git-send-email-me@felipebalbi.com>
 <1220116593-862-14-git-send-email-me@felipebalbi.com>
 <1220116593-862-15-git-send-email-me@felipebalbi.com>
 <1220116593-862-16-git-send-email-me@felipebalbi.com>
 <1220116593-862-17-git-send-email-me@felipebalbi.com>
 <1220116593-862-18-git-send-email-me@felipebalbi.com>
 <1220116593-862-19-git-send-email-me@felipebalbi.com>
 <1220116593-862-20-git-send-email-me@felipebalbi.com>
 <1220116593-862-21-git-send-email-me@felipebalbi.com>
 <1220116593-862-22-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36607 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbYH3RWG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Aug 2008 13:22:06 -0400
In-Reply-To: <1220116593-862-22-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

=46rom: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/mtd/nand/Kconfig           |   19 +
 drivers/mtd/nand/Makefile          |    3 +
 drivers/mtd/nand/omap-hw.c         |  860 ++++++++++++++++++++++++++++=
++++++++
 drivers/mtd/nand/omap-nand-flash.c |  186 ++++++++
 drivers/mtd/nand/omap2.c           |  757 ++++++++++++++++++++++++++++=
+++
 5 files changed, 1825 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/nand/omap-hw.c
 create mode 100644 drivers/mtd/nand/omap-nand-flash.c
 create mode 100644 drivers/mtd/nand/omap2.c

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 41f361c..ed1a331 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -68,6 +68,25 @@ config MTD_NAND_AMS_DELTA
 	help
 	  Support for NAND flash on Amstrad E3 (Delta).
=20
+config MTD_NAND_OMAP2
+	tristate "NAND Flash device on OMAP2 and OMAP3"
+	depends on ARM && MTD_NAND && (ARCH_OMAP2 || ARCH_OMAP3)
+	help
+          Support for NAND flash on Texas Instruments OMAP2 and OMAP3 =
platforms.
+
+config MTD_NAND_OMAP
+	tristate "NAND Flash device on OMAP H3/H2/P2 boards"
+	depends on ARM && ARCH_OMAP1 && MTD_NAND && (MACH_OMAP_H2 || MACH_OMA=
P_H3 || MACH_OMAP_PERSEUS2)
+	help
+	  Support for NAND flash on Texas Instruments H3/H2/P2 platforms.
+
+config MTD_NAND_OMAP_HW
+	bool "OMAP HW NAND Flash controller support"
+        depends on ARM && ARCH_OMAP16XX && MTD_NAND
+
+	help
+	  Driver for TI OMAP16xx hardware NAND flash controller.
+
 config MTD_NAND_TOTO
 	tristate "NAND Flash device on TOTO board"
 	depends on ARCH_OMAP && BROKEN
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index b786c5d..ba42584 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -24,6 +24,9 @@ obj-$(CONFIG_MTD_NAND_NANDSIM)		+=3D nandsim.o
 obj-$(CONFIG_MTD_NAND_CS553X)		+=3D cs553x_nand.o
 obj-$(CONFIG_MTD_NAND_NDFC)		+=3D ndfc.o
 obj-$(CONFIG_MTD_NAND_ATMEL)		+=3D atmel_nand.o
+obj-$(CONFIG_MTD_NAND_OMAP) 		+=3D omap-nand-flash.o
+obj-$(CONFIG_MTD_NAND_OMAP2) 		+=3D omap2.o
+obj-$(CONFIG_MTD_NAND_OMAP_HW)		+=3D omap-hw.o
 obj-$(CONFIG_MTD_NAND_CM_X270)		+=3D cmx270_nand.o
 obj-$(CONFIG_MTD_NAND_BASLER_EXCITE)	+=3D excite_nandflash.o
 obj-$(CONFIG_MTD_NAND_PXA3xx)		+=3D pxa3xx_nand.o
diff --git a/drivers/mtd/nand/omap-hw.c b/drivers/mtd/nand/omap-hw.c
new file mode 100644
index 0000000..c598d9d
--- /dev/null
+++ b/drivers/mtd/nand/omap-hw.c
@@ -0,0 +1,860 @@
+/*
+ *  drivers/mtd/nand/omap-hw.c
+ *
+ *  This is the MTD driver for OMAP1710 internal HW NAND controller.
+ *
+ *  Copyright (C) 2004-2006 Nokia Corporation
+ *
+ *  Author: Jarkko Lavinen <jarkko.lavinen@nokia.com> and
+ *          Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but=
 WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licens=
e for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License a=
long with
+ * this program; see the file COPYING. If not, write to the Free Softw=
are
+ * Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA=
=2E
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/dma-mapping.h>
+#include <linux/clk.h>
+
+#include <asm/io.h>
+
+#include <mach/board.h>
+#include <mach/dma.h>
+
+#define NAND_BASE		0xfffbcc00
+#define NND_REVISION		0x00
+#define NND_ACCESS		0x04
+#define NND_ADDR_SRC		0x08
+#define NND_CTRL		0x10
+#define NND_MASK		0x14
+#define NND_STATUS		0x18
+#define NND_READY		0x1c
+#define NND_COMMAND		0x20
+#define NND_COMMAND_SEC		0x24
+#define NND_ECC_SELECT		0x28
+#define NND_ECC_START		0x2c
+#define NND_ECC_9		0x4c
+#define NND_RESET		0x50
+#define NND_FIFO		0x54
+#define NND_FIFOCTRL		0x58
+#define NND_PSC_CLK		0x5c
+#define NND_SYSTEST		0x60
+#define NND_SYSCFG		0x64
+#define NND_SYSSTATUS		0x68
+#define NND_FIFOTEST1		0x6c
+#define NND_FIFOTEST2		0x70
+#define NND_FIFOTEST3		0x74
+#define NND_FIFOTEST4		0x78
+#define NND_PSC1_CLK		0x8c
+#define NND_PSC2_CLK		0x90
+
+
+#define NND_CMD_READ1_LOWER	0x00
+#define NND_CMD_WRITE1_LOWER	0x00
+#define NND_CMD_READ1_UPPER	0x01
+#define NND_CMD_WRITE1_UPPER	0x01
+#define NND_CMD_PROGRAM_END	0x10
+#define NND_CMD_READ2_SPARE	0x50
+#define NND_CMD_WRITE2_SPARE	0x50
+#define NND_CMD_ERASE		0x60
+#define NND_CMD_STATUS		0x70
+#define NND_CMD_PROGRAM		0x80
+#define NND_CMD_READ_ID		0x90
+#define NND_CMD_ERASE_END	0xD0
+#define NND_CMD_RESET		0xFF
+
+
+#define NAND_Ecc_P1e		(1 << 0)
+#define NAND_Ecc_P2e		(1 << 1)
+#define NAND_Ecc_P4e		(1 << 2)
+#define NAND_Ecc_P8e		(1 << 3)
+#define NAND_Ecc_P16e		(1 << 4)
+#define NAND_Ecc_P32e		(1 << 5)
+#define NAND_Ecc_P64e		(1 << 6)
+#define NAND_Ecc_P128e		(1 << 7)
+#define NAND_Ecc_P256e		(1 << 8)
+#define NAND_Ecc_P512e		(1 << 9)
+#define NAND_Ecc_P1024e		(1 << 10)
+#define NAND_Ecc_P2048e		(1 << 11)
+
+#define NAND_Ecc_P1o		(1 << 16)
+#define NAND_Ecc_P2o		(1 << 17)
+#define NAND_Ecc_P4o		(1 << 18)
+#define NAND_Ecc_P8o		(1 << 19)
+#define NAND_Ecc_P16o		(1 << 20)
+#define NAND_Ecc_P32o		(1 << 21)
+#define NAND_Ecc_P64o		(1 << 22)
+#define NAND_Ecc_P128o		(1 << 23)
+#define NAND_Ecc_P256o		(1 << 24)
+#define NAND_Ecc_P512o		(1 << 25)
+#define NAND_Ecc_P1024o		(1 << 26)
+#define NAND_Ecc_P2048o		(1 << 27)
+
+#define TF(value)	(value ? 1 : 0)
+
+#define P2048e(a)	(TF(a & NAND_Ecc_P2048e)	<< 0 )
+#define P2048o(a)	(TF(a & NAND_Ecc_P2048o)	<< 1 )
+#define P1e(a)		(TF(a & NAND_Ecc_P1e)		<< 2 )
+#define P1o(a)		(TF(a & NAND_Ecc_P1o)		<< 3 )
+#define P2e(a)		(TF(a & NAND_Ecc_P2e)		<< 4 )
+#define P2o(a)		(TF(a & NAND_Ecc_P2o)		<< 5 )
+#define P4e(a)		(TF(a & NAND_Ecc_P4e)		<< 6 )
+#define P4o(a)		(TF(a & NAND_Ecc_P4o)		<< 7 )
+
+#define P8e(a)		(TF(a & NAND_Ecc_P8e)		<< 0 )
+#define P8o(a)		(TF(a & NAND_Ecc_P8o)		<< 1 )
+#define P16e(a)		(TF(a & NAND_Ecc_P16e)		<< 2 )
+#define P16o(a)		(TF(a & NAND_Ecc_P16o)		<< 3 )
+#define P32e(a)		(TF(a & NAND_Ecc_P32e)		<< 4 )
+#define P32o(a)		(TF(a & NAND_Ecc_P32o)		<< 5 )
+#define P64e(a)		(TF(a & NAND_Ecc_P64e)		<< 6 )
+#define P64o(a)		(TF(a & NAND_Ecc_P64o)		<< 7 )
+
+#define P128e(a)	(TF(a & NAND_Ecc_P128e)		<< 0 )
+#define P128o(a)	(TF(a & NAND_Ecc_P128o)		<< 1 )
+#define P256e(a)	(TF(a & NAND_Ecc_P256e)		<< 2 )
+#define P256o(a)	(TF(a & NAND_Ecc_P256o)		<< 3 )
+#define P512e(a)	(TF(a & NAND_Ecc_P512e)		<< 4 )
+#define P512o(a)	(TF(a & NAND_Ecc_P512o)		<< 5 )
+#define P1024e(a)	(TF(a & NAND_Ecc_P1024e)	<< 6 )
+#define P1024o(a)	(TF(a & NAND_Ecc_P1024o)	<< 7 )
+
+#define P8e_s(a)	(TF(a & NAND_Ecc_P8e)		<< 0 )
+#define P8o_s(a)	(TF(a & NAND_Ecc_P8o)		<< 1 )
+#define P16e_s(a)	(TF(a & NAND_Ecc_P16e)		<< 2 )
+#define P16o_s(a)	(TF(a & NAND_Ecc_P16o)		<< 3 )
+#define P1e_s(a)	(TF(a & NAND_Ecc_P1e)		<< 4 )
+#define P1o_s(a)	(TF(a & NAND_Ecc_P1o)		<< 5 )
+#define P2e_s(a)	(TF(a & NAND_Ecc_P2e)		<< 6 )
+#define P2o_s(a)	(TF(a & NAND_Ecc_P2o)		<< 7 )
+
+#define P4e_s(a)	(TF(a & NAND_Ecc_P4e)		<< 0 )
+#define P4o_s(a)	(TF(a & NAND_Ecc_P4o)		<< 1 )
+
+extern struct nand_oobinfo jffs2_oobinfo;
+
+/*
+ * MTD structure for OMAP board
+ */
+static struct mtd_info *omap_mtd;
+static struct clk *omap_nand_clk;
+static int omap_nand_dma_ch;
+static struct completion omap_nand_dma_comp;
+static unsigned long omap_nand_base =3D io_p2v(NAND_BASE);
+
+static inline u32 nand_read_reg(int idx)
+{
+	return __raw_readl(omap_nand_base + idx);
+}
+
+static inline void nand_write_reg(int idx, u32 val)
+{
+	__raw_writel(val, omap_nand_base + idx);
+}
+
+static inline u8 nand_read_reg8(int idx)
+{
+	return __raw_readb(omap_nand_base + idx);
+}
+
+static inline void nand_write_reg8(int idx, u8 val)
+{
+	__raw_writeb(val, omap_nand_base + idx);
+}
+
+static void omap_nand_select_chip(struct mtd_info *mtd, int chip)
+{
+	u32 l;
+
+	switch(chip) {
+	case -1:
+		l =3D nand_read_reg(NND_CTRL);
+		l |=3D (1 << 8) | (1 << 10) | (1 << 12) | (1 << 14);
+		nand_write_reg(NND_CTRL, l);
+		break;
+	case 0:
+		/* Also CS1, CS2, CS4 would be available */
+		l =3D nand_read_reg(NND_CTRL);
+		l &=3D ~(1 << 8);
+		nand_write_reg(NND_CTRL, l);
+		break;
+	default:
+		BUG();
+	}
+}
+
+static void nand_dma_cb(int lch, u16 ch_status, void *data)
+{
+	complete((struct completion *) data);
+}
+
+static void omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
+                                         unsigned int u32_count, int i=
s_write)
+{
+	const int block_size =3D 16;
+	unsigned int block_count, len;
+	int dma_ch;
+	unsigned long fifo_reg, timeout, jiffies_before, jiffies_spent;
+	static unsigned long max_jiffies =3D 0;
+
+	dma_ch =3D omap_nand_dma_ch;
+	block_count =3D u32_count * 4 / block_size;
+	nand_write_reg(NND_STATUS, 0x0f);
+	nand_write_reg(NND_FIFOCTRL, (block_size << 24) | block_count);
+	fifo_reg =3D NAND_BASE + NND_FIFO;
+	if (is_write) {
+		omap_set_dma_dest_params(dma_ch, OMAP_DMA_PORT_TIPB,
+					 OMAP_DMA_AMODE_CONSTANT, fifo_reg,
+					 0, 0);
+		omap_set_dma_src_params(dma_ch, OMAP_DMA_PORT_EMIFF,
+					OMAP_DMA_AMODE_POST_INC,
+					virt_to_phys(addr),
+					0, 0);
+//		omap_set_dma_src_burst_mode(dma_ch, OMAP_DMA_DATA_BURST_4);
+		/* Set POSTWRITE bit */
+		nand_write_reg(NND_CTRL, nand_read_reg(NND_CTRL) | (1 << 16));
+	} else {
+		omap_set_dma_src_params(dma_ch, OMAP_DMA_PORT_TIPB,
+					OMAP_DMA_AMODE_CONSTANT, fifo_reg,
+					0, 0);
+		omap_set_dma_dest_params(dma_ch, OMAP_DMA_PORT_EMIFF,
+					 OMAP_DMA_AMODE_POST_INC,
+					 virt_to_phys(addr),
+					 0, 0);
+//		omap_set_dma_dest_burst_mode(dma_ch, OMAP_DMA_DATA_BURST_8);
+		/* Set PREFETCH bit */
+		nand_write_reg(NND_CTRL, nand_read_reg(NND_CTRL) | (1 << 17));
+	}
+	omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TYPE_S32, block_si=
ze / 4,
+				     block_count, OMAP_DMA_SYNC_FRAME,
+				     0, 0);
+	init_completion(&omap_nand_dma_comp);
+
+	len =3D u32_count << 2;
+	dma_cache_maint(addr, len, DMA_TO_DEVICE);
+	omap_start_dma(dma_ch);
+	jiffies_before =3D jiffies;
+	timeout =3D wait_for_completion_timeout(&omap_nand_dma_comp,
+					      msecs_to_jiffies(1000));
+	jiffies_spent =3D (unsigned long)((long)jiffies - (long)jiffies_befor=
e);
+	if (jiffies_spent > max_jiffies)
+		max_jiffies =3D jiffies_spent;
+
+	if (timeout =3D=3D 0) {
+		printk(KERN_WARNING "omap-hw-nand: DMA timeout after %u ms, max. see=
n latency %u ms\n",
+		       jiffies_to_msecs(jiffies_spent),
+		       jiffies_to_msecs(max_jiffies));
+	}
+	if (!is_write)
+		dma_cache_maint(addr, len, DMA_FROM_DEVICE);
+
+	nand_write_reg(NND_CTRL, nand_read_reg(NND_CTRL) & ~((1 << 16) | (1 <=
< 17)));
+}
+
+static void fifo_read(u32 *out, unsigned int len)
+{
+	const int block_size =3D 16;
+	unsigned long status_reg, fifo_reg;
+	int c;
+
+	status_reg =3D omap_nand_base + NND_STATUS;
+	fifo_reg =3D omap_nand_base + NND_FIFO;
+	len =3D len * 4 / block_size;
+	nand_write_reg(NND_FIFOCTRL, (block_size << 24) | len);
+	nand_write_reg(NND_STATUS, 0x0f);
+	nand_write_reg(NND_CTRL, nand_read_reg(NND_CTRL) | (1 << 17));
+	c =3D block_size / 4;
+	while (len--) {
+		int i;
+
+		while ((__raw_readl(status_reg) & (1 << 2)) =3D=3D 0);
+		__raw_writel(0x0f, status_reg);
+		for (i =3D 0; i < c; i++) {
+			u32 l =3D __raw_readl(fifo_reg);
+			*out++ =3D l;
+		}
+	}
+	nand_write_reg(NND_CTRL, nand_read_reg(NND_CTRL) & ~(1 << 17));
+	nand_write_reg(NND_STATUS, 0x0f);
+}
+
+static void omap_nand_read_buf(struct mtd_info *mtd, u_char *buf, int =
len)
+{
+	unsigned long access_reg;
+
+	if (likely(((unsigned long) buf & 3) =3D=3D 0 && (len & 3) =3D=3D 0))=
 {
+		int u32_count =3D len >> 2;
+		u32 *dest =3D (u32 *) buf;
+		/* If the transfer is big enough and the length divisible by
+		 * 16, we try to use DMA transfer, or FIFO copy in case of
+		 * DMA failure (e.g. all channels busy) */
+		if (u32_count > 64 && (u32_count & 3) =3D=3D 0) {
+			if (omap_nand_dma_ch >=3D 0) {
+				omap_nand_dma_transfer(mtd, buf, u32_count, 0);
+				return;
+			}
+			/* In case of an error, fallback to FIFO copy */
+			fifo_read((u32 *) buf, u32_count);
+			return;
+		}
+		access_reg =3D omap_nand_base + NND_ACCESS;
+		/* Small buffers we just read directly */
+		while (u32_count--)
+			*dest++ =3D __raw_readl(access_reg);
+	} else {
+		/* If we're not word-aligned, we use byte copy */
+		access_reg =3D omap_nand_base + NND_ACCESS;
+		while (len--)
+			*buf++ =3D __raw_readb(access_reg);
+	}
+}
+
+static void omap_nand_write_buf(struct mtd_info *mtd, const u_char *bu=
f, int len)
+{
+	if (likely(((unsigned long) buf & 3) =3D=3D 0 && (len & 3) =3D=3D 0))=
 {
+		const u32 *src =3D (const u32 *) buf;
+
+		len >>=3D 2;
+#if 0
+		/* If the transfer is big enough and length divisible by 16,
+		 * we try to use DMA transfer. */
+		if (len > 256 / 4 && (len & 3) =3D=3D 0) {
+			if (omap_nand_dma_transfer(mtd, (void *) buf, len, 1) =3D=3D 0)
+				return;
+			/* In case of an error, fallback to CPU copy */
+		}
+#endif
+		while (len--)
+			nand_write_reg(NND_ACCESS, *src++);
+	} else {
+		while (len--)
+			nand_write_reg8(NND_ACCESS, *buf++);
+	}
+}
+
+static int omap_nand_verify_buf(struct mtd_info *mtd, const u_char *bu=
f, int len)
+{
+	if (likely(((unsigned long) buf & 3) =3D=3D 0 && (len & 3) =3D=3D 0))=
 {
+		const u32 *dest =3D (const u32 *) buf;
+		len >>=3D 2;
+		while (len--)
+			if (*dest++ !=3D nand_read_reg(NND_ACCESS))
+				return -EFAULT;
+	} else {
+		while (len--)
+			if (*buf++ !=3D nand_read_reg8(NND_ACCESS))
+				return -EFAULT;
+	}
+	return 0;
+}
+
+static u_char omap_nand_read_byte(struct mtd_info *mtd)
+{
+	return nand_read_reg8(NND_ACCESS);
+}
+
+static int omap_nand_dev_ready(struct mtd_info *mtd)
+{
+	u32 l;
+
+	l =3D nand_read_reg(NND_READY);
+	return l & 0x01;
+}
+
+static int nand_write_command(u8 cmd, u32 addr, int addr_valid)
+{
+	if (addr_valid) {
+		nand_write_reg(NND_ADDR_SRC, addr);
+		nand_write_reg8(NND_COMMAND, cmd);
+	} else {
+		nand_write_reg(NND_ADDR_SRC, 0);
+		nand_write_reg8(NND_COMMAND_SEC, cmd);
+	}
+	while (!omap_nand_dev_ready(NULL));
+	return 0;
+}
+
+/*
+ * Send command to NAND device
+ */
+static void omap_nand_command(struct mtd_info *mtd, unsigned command, =
int column, int page_addr)
+{
+	struct nand_chip *this =3D mtd->priv;
+
+	/*
+	 * Write out the command to the device.
+	 */
+	if (command =3D=3D NAND_CMD_SEQIN) {
+		int readcmd;
+
+		if (column >=3D mtd->writesize) {
+			/* OOB area */
+			column -=3D mtd->writesize;
+			readcmd =3D NAND_CMD_READOOB;
+		} else if (column < 256) {
+			/* First 256 bytes --> READ0 */
+			readcmd =3D NAND_CMD_READ0;
+		} else {
+			column -=3D 256;
+			readcmd =3D NAND_CMD_READ1;
+		}
+		nand_write_command(readcmd, 0, 0);
+	}
+	switch (command) {
+	case NAND_CMD_RESET:
+	case NAND_CMD_PAGEPROG:
+	case NAND_CMD_STATUS:
+	case NAND_CMD_ERASE2:
+		nand_write_command(command, 0, 0);
+		break;
+	case NAND_CMD_ERASE1:
+		nand_write_command(command, ((page_addr & 0xFFFFFF00) << 1) | (page_=
addr & 0XFF), 1);
+		break;
+	default:
+		nand_write_command(command, (page_addr << this->page_shift) | column=
, 1);
+	}
+}
+
+static void omap_nand_command_lp(struct mtd_info *mtd, unsigned comman=
d, int column, int page_addr)
+{
+	struct nand_chip *this =3D mtd->priv;
+
+	if (command =3D=3D NAND_CMD_READOOB) {
+		column +=3D mtd->writesize;
+		command =3D NAND_CMD_READ0;
+	}
+	switch (command) {
+	case NAND_CMD_RESET:
+	case NAND_CMD_PAGEPROG:
+	case NAND_CMD_STATUS:
+	case NAND_CMD_ERASE2:	=09
+		nand_write_command(command, 0, 0);
+		break;
+	case NAND_CMD_ERASE1:
+		nand_write_command(command, page_addr << this->page_shift >> 11, 1);
+		break;
+	default:
+		nand_write_command(command, (page_addr << 16) | column, 1);
+	}
+	if (command =3D=3D NAND_CMD_READ0)
+		nand_write_command(NAND_CMD_READSTART, 0, 0);
+}
+
+/*
+ * Generate non-inverted ECC bytes.
+ *
+ * Using noninverted ECC can be considered ugly since writing a blank
+ * page ie. padding will clear the ECC bytes. This is no problem as lo=
ng
+ * nobody is trying to write data on the seemingly unused page.
+ *
+ * Reading an erased page will produce an ECC mismatch between
+ * generated and read ECC bytes that has to be dealt with separately.
+ */
+static int omap_nand_calculate_ecc(struct mtd_info *mtd, const u_char =
*dat, u_char *ecc_code)
+{
+	u32 l;
+	int reg;
+	int n;
+	struct nand_chip *this =3D mtd->priv;
+
+	/* Ex NAND_ECC_HW12_2048 */
+	if ((this->ecc.mode =3D=3D NAND_ECC_HW) && (this->ecc.size  =3D=3D 20=
48))
+		n =3D 4;
+	else
+		n =3D 1;
+	reg =3D NND_ECC_START;
+	while (n--) {
+		l =3D nand_read_reg(reg);
+		*ecc_code++ =3D l;          // P128e, ..., P1e
+		*ecc_code++ =3D l >> 16;    // P128o, ..., P1o
+		// P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e, P256e
+		*ecc_code++ =3D ((l >> 8) & 0x0f) | ((l >> 20) & 0xf0);
+		reg +=3D 4;
+	}
+	return 0;
+}
+
+/*
+ * This function will generate true ECC value, which can be used
+ * when correcting data read from NAND flash memory core
+ */
+static void gen_true_ecc(u8 *ecc_buf)
+{
+	u32 tmp =3D ecc_buf[0] | (ecc_buf[1] << 16) | ((ecc_buf[2] & 0xF0) <<=
 20) | ((ecc_buf[2] & 0x0F) << 8);
+
+	ecc_buf[0] =3D ~(P64o(tmp) | P64e(tmp) | P32o(tmp) | P32e(tmp) | P16o=
(tmp) | P16e(tmp) | P8o(tmp) | P8e(tmp) );
+	ecc_buf[1] =3D ~(P1024o(tmp) | P1024e(tmp) | P512o(tmp) | P512e(tmp) =
| P256o(tmp) | P256e(tmp) | P128o(tmp) | P128e(tmp));
+	ecc_buf[2] =3D ~( P4o(tmp) | P4e(tmp) | P2o(tmp) | P2e(tmp) | P1o(tmp=
) | P1e(tmp) | P2048o(tmp) | P2048e(tmp));
+}
+
+/*
+ * This function compares two ECC's and indicates if there is an error=
=2E
+ * If the error can be corrected it will be corrected to the buffer
+ */
+static int omap_nand_compare_ecc(u8 *ecc_data1,   /* read from NAND me=
mory */
+				 u8 *ecc_data2,   /* read from register */
+				 u8 *page_data)
+{
+	uint   i;
+	u8     tmp0_bit[8], tmp1_bit[8], tmp2_bit[8];
+	u8     comp0_bit[8], comp1_bit[8], comp2_bit[8];
+	u8     ecc_bit[24];
+	u8     ecc_sum =3D 0;
+	u8     find_bit =3D 0;
+	uint   find_byte =3D 0;
+	int    isEccFF;
+
+	isEccFF =3D ((*(u32 *)ecc_data1 & 0xFFFFFF) =3D=3D 0xFFFFFF);
+
+	gen_true_ecc(ecc_data1);
+	gen_true_ecc(ecc_data2);
+
+	for (i =3D 0; i <=3D 2; i++) {
+		*(ecc_data1 + i) =3D ~(*(ecc_data1 + i));
+		*(ecc_data2 + i) =3D ~(*(ecc_data2 + i));
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		tmp0_bit[i]      =3D *ecc_data1 % 2;
+		*ecc_data1       =3D *ecc_data1 / 2;
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		tmp1_bit[i]      =3D *(ecc_data1 + 1) % 2;
+		*(ecc_data1 + 1) =3D *(ecc_data1 + 1) / 2;
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		tmp2_bit[i]      =3D *(ecc_data1 + 2) % 2;
+		*(ecc_data1 + 2) =3D *(ecc_data1 + 2) / 2;
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		comp0_bit[i]     =3D *ecc_data2 % 2;
+		*ecc_data2       =3D *ecc_data2 / 2;
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		comp1_bit[i]     =3D *(ecc_data2 + 1) % 2;
+		*(ecc_data2 + 1) =3D *(ecc_data2 + 1) / 2;
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		comp2_bit[i]     =3D *(ecc_data2 + 2) % 2;
+		*(ecc_data2 + 2) =3D *(ecc_data2 + 2) / 2;
+	}
+
+	for (i =3D 0; i< 6; i++ )
+		ecc_bit[i] =3D tmp2_bit[i + 2] ^ comp2_bit[i + 2];
+
+	for (i =3D 0; i < 8; i++)
+		ecc_bit[i + 6] =3D tmp0_bit[i] ^ comp0_bit[i];
+
+	for (i =3D 0; i < 8; i++)
+		ecc_bit[i + 14] =3D tmp1_bit[i] ^ comp1_bit[i];
+
+	ecc_bit[22] =3D tmp2_bit[0] ^ comp2_bit[0];
+	ecc_bit[23] =3D tmp2_bit[1] ^ comp2_bit[1];
+
+	for (i =3D 0; i < 24; i++)
+		ecc_sum +=3D ecc_bit[i];
+
+	switch (ecc_sum) {
+	case 0:
+		/* Not reached because this function is not called if
+		   ECC values are equal */
+		return 0;
+
+	case 1:
+		/* Uncorrectable error */
+		DEBUG (MTD_DEBUG_LEVEL0, "ECC UNCORRECTED_ERROR 1\n");
+		return -1;
+
+	case 12:
+		/* Correctable error */
+		find_byte =3D (ecc_bit[23] << 8) +=20
+			    (ecc_bit[21] << 7) +=20
+			    (ecc_bit[19] << 6) +
+			    (ecc_bit[17] << 5) +
+			    (ecc_bit[15] << 4) +
+			    (ecc_bit[13] << 3) +
+			    (ecc_bit[11] << 2) +
+			    (ecc_bit[9]  << 1) +
+			    ecc_bit[7];
+
+		find_bit =3D (ecc_bit[5] << 2) + (ecc_bit[3] << 1) + ecc_bit[1];
+
+		DEBUG (MTD_DEBUG_LEVEL0, "Correcting single bit ECC error at offset:=
 %d, bit: %d\n", find_byte, find_bit);
+
+		page_data[find_byte] ^=3D (1 << find_bit);
+
+		return 0;
+	default:
+		if (isEccFF) {
+			if (ecc_data2[0] =3D=3D 0 && ecc_data2[1] =3D=3D 0 && ecc_data2[2] =
=3D=3D 0)
+				return 0;
+		}=20
+		DEBUG (MTD_DEBUG_LEVEL0, "UNCORRECTED_ERROR default\n");
+		return -1;
+	}
+}
+
+static int omap_nand_correct_data(struct mtd_info *mtd, u_char *dat, u=
_char *read_ecc, u_char *calc_ecc)
+{
+	struct nand_chip *this;
+	int block_count =3D 0, i, r;
+
+	this =3D mtd->priv;
+	/* Ex NAND_ECC_HW12_2048 */
+	if ((this->ecc.mode =3D=3D NAND_ECC_HW) && (this->ecc.size  =3D=3D 20=
48))
+		block_count =3D 4;
+	else
+		block_count =3D 1;
+	for (i =3D 0; i < block_count; i++) {
+		if (memcmp(read_ecc, calc_ecc, 3) !=3D 0) {
+			r =3D omap_nand_compare_ecc(read_ecc, calc_ecc, dat);
+			if (r < 0)
+				return r;
+		}
+		read_ecc +=3D 3;
+		calc_ecc +=3D 3;
+		dat +=3D 512;
+	}
+	return 0;
+}
+
+static void omap_nand_enable_hwecc(struct mtd_info *mtd, int mode)
+{
+	nand_write_reg(NND_RESET, 0x01);
+}
+
+#ifdef CONFIG_MTD_CMDLINE_PARTS
+
+extern int mtdpart_setup(char *);
+
+static int __init add_dynamic_parts(struct mtd_info *mtd)
+{
+	static const char *part_parsers[] =3D { "cmdlinepart", NULL };
+	struct mtd_partition *parts;
+	const struct omap_flash_part_str_config *cfg;
+	char *part_str =3D NULL;
+	size_t part_str_len;
+	int c;
+
+	cfg =3D omap_get_var_config(OMAP_TAG_FLASH_PART_STR, &part_str_len);
+	if (cfg !=3D NULL) {
+		part_str =3D kmalloc(part_str_len + 1, GFP_KERNEL);
+		if (part_str =3D=3D NULL)
+			return -ENOMEM;
+		memcpy(part_str, cfg->part_table, part_str_len);
+		part_str[part_str_len] =3D '\0';
+		mtdpart_setup(part_str);
+	}
+	c =3D parse_mtd_partitions(omap_mtd, part_parsers, &parts, 0);
+	if (part_str !=3D NULL) {
+		mtdpart_setup(NULL);
+		kfree(part_str);
+	}
+	if (c <=3D 0)
+		return -1;
+
+	add_mtd_partitions(mtd, parts, c);
+
+	return 0;
+}
+
+#else
+
+static inline int add_dynamic_parts(struct mtd_info *mtd)
+{
+	return -1;
+}
+
+#endif
+
+static inline int calc_psc(int ns, int cycle_ps)
+{
+	return (ns * 1000 + (cycle_ps - 1)) / cycle_ps;
+}
+
+static void set_psc_regs(int psc_ns, int psc1_ns, int psc2_ns)
+{
+	int psc[3], i;
+	unsigned long rate, ps;
+
+	rate =3D clk_get_rate(omap_nand_clk);
+	ps =3D 1000000000 / (rate / 1000);
+	psc[0] =3D calc_psc(psc_ns, ps);
+	psc[1] =3D calc_psc(psc1_ns, ps);
+	psc[2] =3D calc_psc(psc2_ns, ps);
+	for (i =3D 0; i < 3; i++) {
+		if (psc[i] < 2)
+			psc[i] =3D 2;
+		else if (psc[i] > 256)
+			psc[i] =3D 256;
+	}
+	nand_write_reg(NND_PSC_CLK, psc[0] - 1);
+	nand_write_reg(NND_PSC1_CLK, psc[1] - 1);
+	nand_write_reg(NND_PSC2_CLK, psc[2] - 1);
+	printk(KERN_INFO "omap-hw-nand: using PSC values %d, %d, %d\n", psc[0=
], psc[1], psc[2]);
+}
+
+/*
+ * Main initialization routine
+ */
+static int __init omap_nand_init(void)
+{
+	struct nand_chip *this;
+	int err =3D 0;
+	u32 l;
+
+	omap_nand_clk =3D clk_get(NULL, "armper_ck");
+	BUG_ON(omap_nand_clk =3D=3D NULL);
+	clk_enable(omap_nand_clk);
+
+	l =3D nand_read_reg(NND_REVISION);=09
+	printk(KERN_INFO "omap-hw-nand: OMAP NAND Controller rev. %d.%d\n", l=
>>4, l & 0xf);
+
+	/* Reset the NAND Controller */
+	nand_write_reg(NND_SYSCFG, 0x02);
+	while ((nand_read_reg(NND_SYSSTATUS) & 0x01) =3D=3D 0);
+
+	/* No Prefetch, no postwrite, write prot & enable pairs disabled,
+	   addres counter set to send 4 byte addresses to flash,
+	   A8 is set not to be sent to flash (erase addre needs formatting),
+	   choose little endian, enable 512 byte ECC logic,	  =20
+	 */
+	nand_write_reg(NND_CTRL, 0xFF01);
+
+	/* Allocate memory for MTD device structure and private data */
+	omap_mtd =3D kmalloc(sizeof(struct mtd_info) + sizeof(struct nand_chi=
p), GFP_KERNEL);
+	if (!omap_mtd) {
+		printk(KERN_WARNING "omap-hw-nand: Unable to allocate OMAP NAND MTD =
device structure.\n");
+		err =3D -ENOMEM;
+		goto free_clock;
+	}
+#if 1
+	err =3D omap_request_dma(OMAP_DMA_NAND, "NAND", nand_dma_cb,
+			       &omap_nand_dma_comp, &omap_nand_dma_ch);
+	if (err < 0) {
+		printk(KERN_WARNING "omap-hw-nand: Unable to reserve DMA channel\n")=
;
+		omap_nand_dma_ch =3D -1;
+	}
+#else
+	omap_nand_dma_ch =3D -1;
+#endif
+	/* Get pointer to private data */
+	this =3D (struct nand_chip *) (&omap_mtd[1]);
+
+	/* Initialize structures */
+	memset((char *) omap_mtd, 0, sizeof(struct mtd_info));
+	memset((char *) this, 0, sizeof(struct nand_chip));
+
+	/* Link the private data with the MTD structure */
+	omap_mtd->priv =3D this;
+	omap_mtd->name =3D "omap-nand";
+
+	this->options =3D NAND_SKIP_BBTSCAN;
+
+	/* Used from chip select and nand_command() */
+	this->read_byte =3D omap_nand_read_byte;
+
+	this->select_chip   =3D omap_nand_select_chip;
+	this->dev_ready     =3D omap_nand_dev_ready;
+	this->chip_delay    =3D 0;
+	this->ecc.mode      =3D NAND_ECC_HW;
+	this->ecc.bytes     =3D 3;
+	this->ecc.size      =3D 512;
+	this->cmdfunc       =3D omap_nand_command;
+	this->write_buf     =3D omap_nand_write_buf;
+	this->read_buf      =3D omap_nand_read_buf;
+	this->verify_buf    =3D omap_nand_verify_buf;
+	this->ecc.calculate =3D omap_nand_calculate_ecc;
+	this->ecc.correct   =3D omap_nand_correct_data;
+	this->ecc.hwctl     =3D omap_nand_enable_hwecc;
+
+	nand_write_reg(NND_SYSCFG, 0x1); /* Enable auto idle */
+	nand_write_reg(NND_PSC_CLK, 10);
+	/* Scan to find existance of the device */
+	if (nand_scan(omap_mtd, 1)) {
+		err =3D -ENXIO;
+		goto out_mtd;
+	}
+
+	set_psc_regs(25, 15, 35);
+	if (this->page_shift =3D=3D 11) {
+		this->cmdfunc =3D omap_nand_command_lp;
+		l =3D nand_read_reg(NND_CTRL);
+		l |=3D 1 << 4; /* Set the A8 bit in CTRL reg */
+		nand_write_reg(NND_CTRL, l);
+		this->ecc.mode =3D NAND_ECC_HW;
+		this->ecc.steps =3D 1;
+		this->ecc.size =3D 2048;
+		this->ecc.bytes =3D 12;
+		nand_write_reg(NND_ECC_SELECT, 6);
+	}
+
+	/* We have to do bbt scanning ourselves */
+	if (this->scan_bbt (omap_mtd)) {
+		err =3D -ENXIO;
+		goto out_mtd;
+	}
+
+	err =3D add_dynamic_parts(omap_mtd);
+	if (err < 0) {
+		printk(KERN_ERR "omap-hw-nand: no partitions defined\n");
+		err =3D -ENODEV;
+		nand_release(omap_mtd);
+		goto out_mtd;
+	}
+	/* init completed */
+	return 0;
+out_mtd:
+	if (omap_nand_dma_ch >=3D 0)
+		omap_free_dma(omap_nand_dma_ch);
+	kfree(omap_mtd);
+free_clock:
+	clk_put(omap_nand_clk);
+	return err;
+}
+
+module_init(omap_nand_init);
+
+/*
+ * Clean up routine
+ */
+static void __exit omap_nand_cleanup (void)
+{
+	clk_disable(omap_nand_clk);
+	clk_put(omap_nand_clk);
+	nand_release(omap_mtd);
+	kfree(omap_mtd);
+}
+
+module_exit(omap_nand_cleanup);
+
diff --git a/drivers/mtd/nand/omap-nand-flash.c b/drivers/mtd/nand/omap=
-nand-flash.c
new file mode 100644
index 0000000..63a7968
--- /dev/null
+++ b/drivers/mtd/nand/omap-nand-flash.c
@@ -0,0 +1,186 @@
+/*
+ * drivers/mtd/nand/omap-nand-flash.c
+ *
+ * Copyright (c) 2004 Texas Instruments, Jian Zhang <jzhang@ti.com>
+ * Copyright (c) 2004 David Brownell
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/io.h>
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/flash.h>
+#include <mach/tc.h>
+
+#include <asm/io.h>
+#include <mach/hardware.h>
+#include <mach/nand.h>
+
+#define	DRIVER_NAME	"omapnand"
+
+#ifdef CONFIG_MTD_PARTITIONS
+static const char *part_probes[] =3D { "cmdlinepart", NULL };
+#endif
+
+struct omap_nand_info {
+	struct omap_nand_platform_data *pdata;
+	struct mtd_partition	*parts;
+	struct mtd_info		mtd;
+	struct nand_chip	nand;
+};
+
+/*
+ *	hardware specific access to control-lines
+ *	NOTE:  boards may use different bits for these!!
+ *
+ *	ctrl:
+ *	NAND_NCE: bit 0 - don't care
+ *	NAND_CLE: bit 1 -> bit 1  (0x0002)
+ *	NAND_ALE: bit 2 -> bit 2  (0x0004)
+ */
+
+static void omap_nand_hwcontrol(struct mtd_info *mtd, int cmd, unsigne=
d int ctrl)
+{
+	struct nand_chip *chip =3D mtd->priv;
+	unsigned long mask;
+
+	if (cmd =3D=3D NAND_CMD_NONE)
+		return;
+
+	mask =3D (ctrl & NAND_CLE) ? 0x02 : 0;
+	if (ctrl & NAND_ALE)
+		mask |=3D 0x04;
+	writeb(cmd, (unsigned long)chip->IO_ADDR_W | mask);
+}
+
+static int omap_nand_dev_ready(struct mtd_info *mtd)
+{
+	struct omap_nand_info *info =3D container_of(mtd, struct omap_nand_in=
fo, mtd);
+
+	return info->pdata->dev_ready(info->pdata);
+}
+
+static int __devinit omap_nand_probe(struct platform_device *pdev)
+{
+	struct omap_nand_info		*info;
+	struct omap_nand_platform_data	*pdata =3D pdev->dev.platform_data;
+	struct resource			*res =3D pdev->resource;
+	unsigned long			size =3D res->end - res->start + 1;
+	int				err;
+
+	info =3D kzalloc(sizeof(struct omap_nand_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	if (!request_mem_region(res->start, size, pdev->dev.driver->name)) {
+		err =3D -EBUSY;
+		goto out_free_info;
+	}
+
+	info->nand.IO_ADDR_R =3D ioremap(res->start, size);
+	if (!info->nand.IO_ADDR_R) {
+		err =3D -ENOMEM;
+		goto out_release_mem_region;
+	}
+	info->nand.IO_ADDR_W =3D info->nand.IO_ADDR_R;
+	info->nand.cmd_ctrl =3D omap_nand_hwcontrol;
+	info->nand.ecc.mode =3D NAND_ECC_SOFT;
+	info->nand.options =3D pdata->options;
+	if (pdata->dev_ready)
+		info->nand.dev_ready =3D omap_nand_dev_ready;
+	else
+		info->nand.chip_delay =3D 20;
+
+	info->mtd.name =3D pdev->dev.bus_id;
+	info->mtd.priv =3D &info->nand;
+
+	info->pdata =3D pdata;
+
+	/* DIP switches on H2 and some other boards change between 8 and 16 b=
it
+	 * bus widths for flash.  Try the other width if the first try fails.
+	 */
+	if (nand_scan(&info->mtd, 1)) {
+		info->nand.options ^=3D NAND_BUSWIDTH_16;
+		if (nand_scan(&info->mtd, 1)) {
+			err =3D -ENXIO;
+			goto out_iounmap;
+		}
+	}
+	info->mtd.owner =3D THIS_MODULE;
+
+#ifdef CONFIG_MTD_PARTITIONS
+	err =3D parse_mtd_partitions(&info->mtd, part_probes, &info->parts, 0=
);
+	if (err > 0)
+		add_mtd_partitions(&info->mtd, info->parts, err);
+	else if (err < 0 && pdata->parts)
+		add_mtd_partitions(&info->mtd, pdata->parts, pdata->nr_parts);
+	else
+#endif
+		add_mtd_device(&info->mtd);
+
+	platform_set_drvdata(pdev, info);
+
+	return 0;
+
+out_iounmap:
+	iounmap(info->nand.IO_ADDR_R);
+out_release_mem_region:
+	release_mem_region(res->start, size);
+out_free_info:
+	kfree(info);
+
+	return err;
+}
+
+static int omap_nand_remove(struct platform_device *pdev)
+{
+	struct omap_nand_info *info =3D platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+	/* Release NAND device, its internal structures and partitions */
+	nand_release(&info->mtd);
+	iounmap(info->nand.IO_ADDR_R);
+	kfree(info);
+	return 0;
+}
+
+static struct platform_driver omap_nand_driver =3D {
+	.probe		=3D omap_nand_probe,
+	.remove		=3D omap_nand_remove,
+	.driver		=3D {
+		.name	=3D DRIVER_NAME,
+	},
+};
+MODULE_ALIAS(DRIVER_NAME);
+
+static int __init omap_nand_init(void)
+{
+	return platform_driver_register(&omap_nand_driver);
+}
+
+static void __exit omap_nand_exit(void)
+{
+	platform_driver_unregister(&omap_nand_driver);
+}
+
+module_init(omap_nand_init);
+module_exit(omap_nand_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jian Zhang <jzhang@ti.com> (and others)");
+MODULE_DESCRIPTION("Glue layer for NAND flash on TI OMAP boards");
+
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
new file mode 100644
index 0000000..a33944c
--- /dev/null
+++ b/drivers/mtd/nand/omap2.c
@@ -0,0 +1,757 @@
+/*
+ * drivers/mtd/nand/omap2.c
+ *
+ * Copyright (c) 2004 Texas Instruments, Jian Zhang <jzhang@ti.com>
+ * Copyright (c) 2004 Micron Technology Inc.
+ * Copyright (c) 2004 David Brownell
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/io.h>
+
+#include <asm/dma.h>
+
+#include <mach/gpmc.h>
+#include <mach/nand.h>
+
+#define GPMC_IRQ_STATUS		0x18
+#define GPMC_ECC_CONFIG		0x1F4
+#define GPMC_ECC_CONTROL	0x1F8
+#define GPMC_ECC_SIZE_CONFIG	0x1FC
+#define GPMC_ECC1_RESULT	0x200
+
+#define	DRIVER_NAME	"omap2-nand"
+#define	NAND_IO_SIZE	SZ_4K
+
+#define	NAND_WP_ON	1
+#define	NAND_WP_OFF	0
+#define NAND_WP_BIT	0x00000010
+#define WR_RD_PIN_MONITORING	0x00600000
+
+#define	GPMC_BUF_FULL	0x00000001
+#define	GPMC_BUF_EMPTY	0x00000000
+
+#define NAND_Ecc_P1e		(1 << 0)
+#define NAND_Ecc_P2e		(1 << 1)
+#define NAND_Ecc_P4e		(1 << 2)
+#define NAND_Ecc_P8e		(1 << 3)
+#define NAND_Ecc_P16e		(1 << 4)
+#define NAND_Ecc_P32e		(1 << 5)
+#define NAND_Ecc_P64e		(1 << 6)
+#define NAND_Ecc_P128e		(1 << 7)
+#define NAND_Ecc_P256e		(1 << 8)
+#define NAND_Ecc_P512e		(1 << 9)
+#define NAND_Ecc_P1024e		(1 << 10)
+#define NAND_Ecc_P2048e		(1 << 11)
+
+#define NAND_Ecc_P1o		(1 << 16)
+#define NAND_Ecc_P2o		(1 << 17)
+#define NAND_Ecc_P4o		(1 << 18)
+#define NAND_Ecc_P8o		(1 << 19)
+#define NAND_Ecc_P16o		(1 << 20)
+#define NAND_Ecc_P32o		(1 << 21)
+#define NAND_Ecc_P64o		(1 << 22)
+#define NAND_Ecc_P128o		(1 << 23)
+#define NAND_Ecc_P256o		(1 << 24)
+#define NAND_Ecc_P512o		(1 << 25)
+#define NAND_Ecc_P1024o		(1 << 26)
+#define NAND_Ecc_P2048o		(1 << 27)
+
+#define TF(value)	(value ? 1 : 0)
+
+#define P2048e(a)	(TF(a & NAND_Ecc_P2048e)	<< 0)
+#define P2048o(a)	(TF(a & NAND_Ecc_P2048o)	<< 1)
+#define P1e(a)		(TF(a & NAND_Ecc_P1e)		<< 2)
+#define P1o(a)		(TF(a & NAND_Ecc_P1o)		<< 3)
+#define P2e(a)		(TF(a & NAND_Ecc_P2e)		<< 4)
+#define P2o(a)		(TF(a & NAND_Ecc_P2o)		<< 5)
+#define P4e(a)		(TF(a & NAND_Ecc_P4e)		<< 6)
+#define P4o(a)		(TF(a & NAND_Ecc_P4o)		<< 7)
+
+#define P8e(a)		(TF(a & NAND_Ecc_P8e)		<< 0)
+#define P8o(a)		(TF(a & NAND_Ecc_P8o)		<< 1)
+#define P16e(a)		(TF(a & NAND_Ecc_P16e)		<< 2)
+#define P16o(a)		(TF(a & NAND_Ecc_P16o)		<< 3)
+#define P32e(a)		(TF(a & NAND_Ecc_P32e)		<< 4)
+#define P32o(a)		(TF(a & NAND_Ecc_P32o)		<< 5)
+#define P64e(a)		(TF(a & NAND_Ecc_P64e)		<< 6)
+#define P64o(a)		(TF(a & NAND_Ecc_P64o)		<< 7)
+
+#define P128e(a)	(TF(a & NAND_Ecc_P128e)		<< 0)
+#define P128o(a)	(TF(a & NAND_Ecc_P128o)		<< 1)
+#define P256e(a)	(TF(a & NAND_Ecc_P256e)		<< 2)
+#define P256o(a)	(TF(a & NAND_Ecc_P256o)		<< 3)
+#define P512e(a)	(TF(a & NAND_Ecc_P512e)		<< 4)
+#define P512o(a)	(TF(a & NAND_Ecc_P512o)		<< 5)
+#define P1024e(a)	(TF(a & NAND_Ecc_P1024e)	<< 6)
+#define P1024o(a)	(TF(a & NAND_Ecc_P1024o)	<< 7)
+
+#define P8e_s(a)	(TF(a & NAND_Ecc_P8e)		<< 0)
+#define P8o_s(a)	(TF(a & NAND_Ecc_P8o)		<< 1)
+#define P16e_s(a)	(TF(a & NAND_Ecc_P16e)		<< 2)
+#define P16o_s(a)	(TF(a & NAND_Ecc_P16o)		<< 3)
+#define P1e_s(a)	(TF(a & NAND_Ecc_P1e)		<< 4)
+#define P1o_s(a)	(TF(a & NAND_Ecc_P1o)		<< 5)
+#define P2e_s(a)	(TF(a & NAND_Ecc_P2e)		<< 6)
+#define P2o_s(a)	(TF(a & NAND_Ecc_P2o)		<< 7)
+
+#define P4e_s(a)	(TF(a & NAND_Ecc_P4e)		<< 0)
+#define P4o_s(a)	(TF(a & NAND_Ecc_P4o)		<< 1)
+
+#ifdef CONFIG_MTD_PARTITIONS
+static const char *part_probes[] =3D { "cmdlinepart", NULL };
+#endif
+
+struct omap_nand_info {
+	struct nand_hw_control		controller;
+	struct omap_nand_platform_data	*pdata;
+	struct mtd_info			mtd;
+	struct mtd_partition		*parts;
+	struct nand_chip		nand;
+	struct platform_device		*pdev;
+
+	int				gpmc_cs;
+	unsigned long			phys_base;
+	void __iomem			*gpmc_cs_baseaddr;
+	void __iomem			*gpmc_baseaddr;
+};
+
+/*
+ * omap_nand_wp - This function enable or disable the Write Protect fe=
ature on
+ * NAND device
+ * @mtd: MTD device structure
+ * @mode: WP ON/OFF
+ */
+static void omap_nand_wp(struct mtd_info *mtd, int mode)
+{
+	struct omap_nand_info *info =3D container_of(mtd,
+						struct omap_nand_info, mtd);
+
+	unsigned long config =3D __raw_readl(info->gpmc_baseaddr + GPMC_CONFI=
G);
+
+	if (mode)
+		config &=3D ~(NAND_WP_BIT);	/* WP is ON */
+	else
+		config |=3D (NAND_WP_BIT);	/* WP is OFF */
+
+	__raw_writel(config, (info->gpmc_baseaddr + GPMC_CONFIG));
+}
+
+/*
+ * hardware specific access to control-lines
+ * NOTE: boards may use different bits for these!!
+ *
+ * ctrl:
+ * NAND_NCE: bit 0 - don't care
+ * NAND_CLE: bit 1 -> Command Latch
+ * NAND_ALE: bit 2 -> Address Latch
+ */
+static void omap_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int=
 ctrl)
+{
+	struct omap_nand_info *info =3D container_of(mtd,
+					struct omap_nand_info, mtd);
+	switch (ctrl) {
+	case NAND_CTRL_CHANGE | NAND_CTRL_CLE:
+		info->nand.IO_ADDR_W =3D info->gpmc_cs_baseaddr +
+						GPMC_CS_NAND_COMMAND;
+		info->nand.IO_ADDR_R =3D info->gpmc_cs_baseaddr +
+						GPMC_CS_NAND_DATA;
+		break;
+
+	case NAND_CTRL_CHANGE | NAND_CTRL_ALE:
+		info->nand.IO_ADDR_W =3D info->gpmc_cs_baseaddr +
+						GPMC_CS_NAND_ADDRESS;
+		info->nand.IO_ADDR_R =3D info->gpmc_cs_baseaddr +
+						GPMC_CS_NAND_DATA;
+		break;
+
+	case NAND_CTRL_CHANGE | NAND_NCE:
+		info->nand.IO_ADDR_W =3D info->gpmc_cs_baseaddr +
+						GPMC_CS_NAND_DATA;
+		info->nand.IO_ADDR_R =3D info->gpmc_cs_baseaddr +
+						GPMC_CS_NAND_DATA;
+		break;
+	}
+
+	if (cmd !=3D NAND_CMD_NONE)
+		__raw_writeb(cmd, info->nand.IO_ADDR_W);
+}
+
+/*
+ * omap_read_buf - read data from NAND controller into buffer
+ * @mtd: MTD device structure
+ * @buf: buffer to store date
+ * @len: number of bytes to read
+ */
+static void omap_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+{
+	struct omap_nand_info *info =3D container_of(mtd,
+					struct omap_nand_info, mtd);
+	u16 *p =3D (u16 *) buf;
+
+	len >>=3D 1;
+
+	while (len--)
+		*p++ =3D cpu_to_le16(readw(info->nand.IO_ADDR_R));
+}
+
+/*
+ * omap_write_buf - write buffer to NAND controller
+ * @mtd: MTD device structure
+ * @buf: data buffer
+ * @len: number of bytes to write
+ */
+static void omap_write_buf(struct mtd_info *mtd, const u_char * buf, i=
nt len)
+{
+	struct omap_nand_info *info =3D container_of(mtd,
+						struct omap_nand_info, mtd);
+	u16 *p =3D (u16 *) buf;
+
+	len >>=3D 1;
+
+	while (len--) {
+		writew(cpu_to_le16(*p++), info->nand.IO_ADDR_W);
+
+		while (GPMC_BUF_EMPTY =3D=3D (readl(info->gpmc_baseaddr +
+						GPMC_STATUS) & GPMC_BUF_FULL));
+	}
+}
+/*
+ * omap_verify_buf - Verify chip data against buffer
+ * @mtd: MTD device structure
+ * @buf: buffer containing the data to compare
+ * @len: number of bytes to compare
+ */
+static int omap_verify_buf(struct mtd_info *mtd, const u_char * buf, i=
nt len)
+{
+	struct omap_nand_info *info =3D container_of(mtd, struct omap_nand_in=
fo,
+							mtd);
+	u16 *p =3D (u16 *) buf;
+
+	len >>=3D 1;
+
+	while (len--) {
+
+		if (*p++ !=3D cpu_to_le16(readw(info->nand.IO_ADDR_R)))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_MTD_NAND_OMAP_HWECC
+/*
+ * omap_hwecc_init-Initialize the Hardware ECC for NAND flash in GPMC =
controller
+ * @mtd: MTD device structure
+ */
+static void omap_hwecc_init(struct mtd_info *mtd)
+{
+	struct omap_nand_info *info =3D container_of(mtd, struct omap_nand_in=
fo,
+							mtd);
+	register struct nand_chip *chip =3D mtd->priv;
+	unsigned long val =3D 0x0;
+
+	/* Read from ECC Control Register */
+	val =3D __raw_readl(info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+	/* Clear all ECC | Enable Reg1 */
+	val =3D ((0x00000001<<8) | 0x00000001);
+	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+
+	/* Read from ECC Size Config Register */
+	val =3D __raw_readl(info->gpmc_baseaddr + GPMC_ECC_SIZE_CONFIG);
+	/* ECCSIZE1=3D512 | Select eccResultsize[0-3] */
+	val =3D ((((chip->ecc.size >> 1) - 1) << 22) | (0x0000000F));
+	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_SIZE_CONFIG);
+}
+
+/*
+ * gen_true_ecc - This function will generate true ECC value, which ca=
n be used
+ * when correcting data read from NAND flash memory core
+ * @ecc_buf: buffer to store ecc code
+ */
+static void gen_true_ecc(u8 *ecc_buf)
+{
+	u32 tmp =3D ecc_buf[0] | (ecc_buf[1] << 16) |
+		((ecc_buf[2] & 0xF0) << 20) | ((ecc_buf[2] & 0x0F) << 8);
+
+	ecc_buf[0] =3D ~(P64o(tmp) | P64e(tmp) | P32o(tmp) | P32e(tmp) |
+			P16o(tmp) | P16e(tmp) | P8o(tmp) | P8e(tmp));
+	ecc_buf[1] =3D ~(P1024o(tmp) | P1024e(tmp) | P512o(tmp) | P512e(tmp) =
|
+			P256o(tmp) | P256e(tmp) | P128o(tmp) | P128e(tmp));
+	ecc_buf[2] =3D ~(P4o(tmp) | P4e(tmp) | P2o(tmp) | P2e(tmp) | P1o(tmp)=
 |
+			P1e(tmp) | P2048o(tmp) | P2048e(tmp));
+}
+
+/*
+ * omap_compare_ecc - This function compares two ECC's and indicates i=
f there
+ * is an error. If the error can be corrected it will be corrected to =
the
+ * buffer
+ * @ecc_data1:  ecc code from nand spare area
+ * @ecc_data2:  ecc code from hardware register obtained from hardware=
 ecc
+ * @page_data:  page data
+ */
+static int omap_compare_ecc(u8 *ecc_data1,	/* read from NAND memory */
+			    u8 *ecc_data2,	/* read from register */
+			    u8 *page_data)
+{
+	uint	i;
+	u8	tmp0_bit[8], tmp1_bit[8], tmp2_bit[8];
+	u8	comp0_bit[8], comp1_bit[8], comp2_bit[8];
+	u8	ecc_bit[24];
+	u8	ecc_sum =3D 0;
+	u8	find_bit =3D 0;
+	uint	find_byte =3D 0;
+	int	isEccFF;
+
+	isEccFF =3D ((*(u32 *)ecc_data1 & 0xFFFFFF) =3D=3D 0xFFFFFF);
+
+	gen_true_ecc(ecc_data1);
+	gen_true_ecc(ecc_data2);
+
+	for (i =3D 0; i <=3D 2; i++) {
+		*(ecc_data1 + i) =3D ~(*(ecc_data1 + i));
+		*(ecc_data2 + i) =3D ~(*(ecc_data2 + i));
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		tmp0_bit[i]     =3D *ecc_data1 % 2;
+		*ecc_data1	=3D *ecc_data1 / 2;
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		tmp1_bit[i]	 =3D *(ecc_data1 + 1) % 2;
+		*(ecc_data1 + 1) =3D *(ecc_data1 + 1) / 2;
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		tmp2_bit[i]	 =3D *(ecc_data1 + 2) % 2;
+		*(ecc_data1 + 2) =3D *(ecc_data1 + 2) / 2;
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		comp0_bit[i]     =3D *ecc_data2 % 2;
+		*ecc_data2       =3D *ecc_data2 / 2;
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		comp1_bit[i]     =3D *(ecc_data2 + 1) % 2;
+		*(ecc_data2 + 1) =3D *(ecc_data2 + 1) / 2;
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		comp2_bit[i]     =3D *(ecc_data2 + 2) % 2;
+		*(ecc_data2 + 2) =3D *(ecc_data2 + 2) / 2;
+	}
+
+	for (i =3D 0; i < 6; i++)
+		ecc_bit[i] =3D tmp2_bit[i + 2] ^ comp2_bit[i + 2];
+
+	for (i =3D 0; i < 8; i++)
+		ecc_bit[i + 6] =3D tmp0_bit[i] ^ comp0_bit[i];
+
+	for (i =3D 0; i < 8; i++)
+		ecc_bit[i + 14] =3D tmp1_bit[i] ^ comp1_bit[i];
+
+	ecc_bit[22] =3D tmp2_bit[0] ^ comp2_bit[0];
+	ecc_bit[23] =3D tmp2_bit[1] ^ comp2_bit[1];
+
+	for (i =3D 0; i < 24; i++)
+		ecc_sum +=3D ecc_bit[i];
+
+	switch (ecc_sum) {
+	case 0:
+		/* Not reached because this function is not called if
+		 *  ECC values are equal
+		 */
+		return 0;
+
+	case 1:
+		/* Uncorrectable error */
+		DEBUG(MTD_DEBUG_LEVEL0, "ECC UNCORRECTED_ERROR 1\n");
+		return -1;
+
+	case 11:
+		/* UN-Correctable error */
+		DEBUG(MTD_DEBUG_LEVEL0, "ECC UNCORRECTED_ERROR B\n");
+		return -1;
+
+	case 12:
+		/* Correctable error */
+		find_byte =3D (ecc_bit[23] << 8) +
+			    (ecc_bit[21] << 7) +
+			    (ecc_bit[19] << 6) +
+			    (ecc_bit[17] << 5) +
+			    (ecc_bit[15] << 4) +
+			    (ecc_bit[13] << 3) +
+			    (ecc_bit[11] << 2) +
+			    (ecc_bit[9]  << 1) +
+			    ecc_bit[7];
+
+		find_bit =3D (ecc_bit[5] << 2) + (ecc_bit[3] << 1) + ecc_bit[1];
+
+		DEBUG(MTD_DEBUG_LEVEL0, "Correcting single bit ECC error at "
+				"offset: %d, bit: %d\n", find_byte, find_bit);
+
+		page_data[find_byte] ^=3D (1 << find_bit);
+
+		return 0;
+	default:
+		if (isEccFF) {
+			if (ecc_data2[0] =3D=3D 0 &&
+			    ecc_data2[1] =3D=3D 0 &&
+			    ecc_data2[2] =3D=3D 0)
+				return 0;
+		}
+		DEBUG(MTD_DEBUG_LEVEL0, "UNCORRECTED_ERROR default\n");
+		return -1;
+	}
+}
+
+/*
+ * omap_correct_data - Compares the ecc read from nand spare area with=
 ECC
+ * registers values and corrects one bit error if it has occured
+ * @mtd: MTD device structure
+ * @dat: page data
+ * @read_ecc: ecc read from nand flash
+ * @calc_ecc: ecc read from ECC registers
+ */
+static int omap_correct_data(struct mtd_info *mtd, u_char * dat,
+				u_char * read_ecc, u_char * calc_ecc)
+{
+	struct omap_nand_info *info =3D container_of(mtd, struct omap_nand_in=
fo,
+							mtd);
+	int blockCnt =3D 0, i =3D 0, ret =3D 0;
+
+	/* Ex NAND_ECC_HW12_2048 */
+	if ((info->nand.ecc.mode =3D=3D NAND_ECC_HW) &&
+			(info->nand.ecc.size  =3D=3D 2048))
+		blockCnt =3D 4;
+	else
+		blockCnt =3D 1;
+
+	for (i =3D 0; i < blockCnt; i++) {
+		if (memcmp(read_ecc, calc_ecc, 3) !=3D 0) {
+			ret =3D omap_compare_ecc(read_ecc, calc_ecc, dat);
+			if (ret < 0) return ret;
+		}
+		read_ecc +=3D 3;
+		calc_ecc +=3D 3;
+		dat      +=3D 512;
+	}
+	return 0;
+}
+
+/*
+ * omap_calcuate_ecc - Generate non-inverted ECC bytes.
+ * Using noninverted ECC can be considered ugly since writing a blank
+ * page ie. padding will clear the ECC bytes. This is no problem as lo=
ng
+ * nobody is trying to write data on the seemingly unused page. Readin=
g
+ * an erased page will produce an ECC mismatch between generated and r=
ead
+ * ECC bytes that has to be dealt with separately.
+ * @mtd: MTD device structure
+ * @dat: The pointer to data on which ecc is computed
+ * @ecc_code: The ecc_code buffer
+ */
+static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
+				u_char *ecc_code)
+{
+	struct omap_nand_info *info =3D container_of(mtd, struct omap_nand_in=
fo,
+							mtd);
+	unsigned long val =3D 0x0;
+	unsigned long reg;
+
+	/* Start Reading from HW ECC1_Result =3D 0x200 */
+	reg =3D (unsigned long)(info->gpmc_baseaddr + GPMC_ECC1_RESULT);
+	val =3D __raw_readl(reg);
+	*ecc_code++ =3D val;          /* P128e, ..., P1e */
+	*ecc_code++ =3D val >> 16;    /* P128o, ..., P1o */
+	/* P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e, P256e */
+	*ecc_code++ =3D ((val >> 8) & 0x0f) | ((val >> 20) & 0xf0);
+	reg +=3D 4;
+
+	return 0;
+}
+
+/*
+ * omap_enable_hwecc - This function enables the hardware ecc function=
ality
+ * @mtd: MTD device structure
+ * @mode: Read/Write mode
+ */
+static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
+{
+	struct omap_nand_info *info =3D container_of(mtd, struct omap_nand_in=
fo,
+							mtd);
+	register struct nand_chip *chip =3D mtd->priv;
+	unsigned int dev_width =3D (chip->options & NAND_BUSWIDTH_16) ? 1 : 0=
;
+	unsigned long val =3D __raw_readl(info->gpmc_baseaddr + GPMC_ECC_CONF=
IG);
+
+	switch (mode) {
+	case NAND_ECC_READ    :
+		__raw_writel(0x101, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
+		val =3D (dev_width << 7) | (info->gpmc_cs << 1) | (0x1);
+		break;
+	case NAND_ECC_READSYN :
+		 __raw_writel(0x100, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
+		val =3D (dev_width << 7) | (info->gpmc_cs << 1) | (0x1);
+		break;
+	case NAND_ECC_WRITE   :
+		__raw_writel(0x101, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+		/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
+		val =3D (dev_width << 7) | (info->gpmc_cs << 1) | (0x1);
+		break;
+	default:
+		DEBUG(MTD_DEBUG_LEVEL0, "Error: Unrecognized Mode[%d]!\n",
+					mode);
+		break;
+	}
+
+	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_CONFIG);
+}
+#endif
+
+/*
+ * omap_wait - Wait function is called during Program and erase
+ * operations and the way it is called from MTD layer, we should wait
+ * till the NAND chip is ready after the programming/erase operation
+ * has completed.
+ * @mtd: MTD device structure
+ * @chip: NAND Chip structure
+ */
+static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
+{
+	register struct nand_chip *this =3D mtd->priv;
+	struct omap_nand_info *info =3D container_of(mtd, struct omap_nand_in=
fo,
+							mtd);
+	int status =3D 0;
+
+	this->IO_ADDR_W =3D (void *) info->gpmc_cs_baseaddr +
+						GPMC_CS_NAND_COMMAND;
+	this->IO_ADDR_R =3D (void *) info->gpmc_cs_baseaddr + GPMC_CS_NAND_DA=
TA;
+
+	while (!(status & 0x40)) {
+		 __raw_writeb(NAND_CMD_STATUS & 0xFF, this->IO_ADDR_W);
+		status =3D __raw_readb(this->IO_ADDR_R);
+	}
+	return status;
+}
+
+/*
+ * omap_dev_ready - calls the platform specific dev_ready function
+ * @mtd: MTD device structure
+ */
+static int omap_dev_ready(struct mtd_info *mtd)
+{
+	struct omap_nand_info *info =3D container_of(mtd, struct omap_nand_in=
fo,
+							mtd);
+	unsigned int val =3D __raw_readl(info->gpmc_baseaddr + GPMC_IRQ_STATU=
S);
+
+	if ((val & 0x100) =3D=3D 0x100) {
+		/* Clear IRQ Interrupt */
+		val |=3D 0x100;
+		val &=3D ~(0x0);
+		__raw_writel(val, info->gpmc_baseaddr + GPMC_IRQ_STATUS);
+	} else {
+		unsigned int cnt =3D 0;
+		while (cnt++ < 0x1FF) {
+			if  ((val & 0x100) =3D=3D 0x100)
+				return 0;
+			val =3D __raw_readl(info->gpmc_baseaddr +
+							GPMC_IRQ_STATUS);
+		}
+	}
+
+	return 1;
+}
+
+static int __devinit omap_nand_probe(struct platform_device *pdev)
+{
+	struct omap_nand_info		*info;
+	struct omap_nand_platform_data	*pdata;
+	int				err;
+	unsigned long 			val;
+
+
+	pdata =3D pdev->dev.platform_data;
+	if (pdata =3D=3D NULL) {
+		dev_err(&pdev->dev, "platform data missing\n");
+		return -ENODEV;
+	}
+
+	info =3D kzalloc(sizeof(struct omap_nand_info), GFP_KERNEL);
+	if (!info) return -ENOMEM;
+
+	platform_set_drvdata(pdev, info);
+
+	spin_lock_init(&info->controller.lock);
+	init_waitqueue_head(&info->controller.wq);
+
+	info->pdev =3D pdev;
+
+	info->gpmc_cs		=3D pdata->cs;
+	info->gpmc_baseaddr	=3D pdata->gpmc_baseaddr;
+	info->gpmc_cs_baseaddr	=3D pdata->gpmc_cs_baseaddr;
+
+	info->mtd.priv		=3D &info->nand;
+	info->mtd.name		=3D pdev->dev.bus_id;
+	info->mtd.owner		=3D THIS_MODULE;
+
+	err =3D gpmc_cs_request(info->gpmc_cs, NAND_IO_SIZE, &info->phys_base=
);
+	if (err < 0) {
+		dev_err(&pdev->dev, "Cannot request GPMC CS\n");
+		goto out_free_info;
+	}
+
+	/* Enable RD PIN Monitoring Reg */
+	if (pdata->dev_ready) {
+		val  =3D gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG1);
+		val |=3D WR_RD_PIN_MONITORING;
+		gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG1, val);
+	}
+
+	val  =3D gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG7);
+	val &=3D ~(0xf << 8);
+	val |=3D  (0xc & 0xf) << 8;
+	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG7, val);
+
+	/* NAND write protect off */
+	omap_nand_wp(&info->mtd, NAND_WP_OFF);
+
+	if (!request_mem_region(info->phys_base, NAND_IO_SIZE,
+				pdev->dev.driver->name)) {
+		err =3D -EBUSY;
+		goto out_free_cs;
+	}
+
+	info->nand.IO_ADDR_R =3D ioremap(info->phys_base, NAND_IO_SIZE);
+	if (!info->nand.IO_ADDR_R) {
+		err =3D -ENOMEM;
+		goto out_release_mem_region;
+	}
+	info->nand.controller =3D &info->controller;
+
+	info->nand.IO_ADDR_W =3D info->nand.IO_ADDR_R;
+	info->nand.cmd_ctrl  =3D omap_hwcontrol;
+
+	info->nand.read_buf   =3D omap_read_buf;
+	info->nand.write_buf  =3D omap_write_buf;
+	info->nand.verify_buf =3D omap_verify_buf;
+
+	/*
+	* If RDY/BSY line is connected to OMAP then use the omap ready funcrt=
ion
+	* and the generic nand_wait function which reads the status register
+	* after monitoring the RDY/BSY line.Otherwise use a standard chip del=
ay
+	* which is slightly more than tR (AC Timing) of the NAND device and r=
ead
+	* status register until you get a failure or success
+	*/
+	if (pdata->dev_ready) {
+		info->nand.dev_ready =3D omap_dev_ready;
+		info->nand.chip_delay =3D 0;
+	} else {
+		info->nand.waitfunc =3D omap_wait;
+		info->nand.chip_delay =3D 50;
+	}
+
+	info->nand.options  |=3D NAND_SKIP_BBTSCAN;
+	if ((gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG1) & 0x3000)
+								=3D=3D 0x1000)
+		info->nand.options  |=3D NAND_BUSWIDTH_16;
+
+#ifdef CONFIG_MTD_NAND_OMAP_HWECC
+	info->nand.ecc.bytes		=3D 3;
+	info->nand.ecc.size		=3D 512;
+	info->nand.ecc.calculate	=3D omap_calculate_ecc;
+	info->nand.ecc.hwctl		=3D omap_enable_hwecc;
+	info->nand.ecc.correct		=3D omap_correct_data;
+	info->nand.ecc.mode		=3D NAND_ECC_HW;
+
+	/* init HW ECC */
+	omap_hwecc_init(&info->mtd);
+#else
+	info->nand.ecc.mode =3D NAND_ECC_SOFT;
+#endif
+
+	/* DIP switches on some boards change between 8 and 16 bit
+	 * bus widths for flash.  Try the other width if the first try fails.
+	 */
+	if (nand_scan(&info->mtd, 1)) {
+		info->nand.options ^=3D NAND_BUSWIDTH_16;
+		if (nand_scan(&info->mtd, 1)) {
+			err =3D -ENXIO;
+			goto out_release_mem_region;
+		}
+	}
+
+#ifdef CONFIG_MTD_PARTITIONS
+	err =3D parse_mtd_partitions(&info->mtd, part_probes, &info->parts, 0=
);
+	if (err > 0)
+		add_mtd_partitions(&info->mtd, info->parts, err);
+	else if (pdata->parts)
+		add_mtd_partitions(&info->mtd, pdata->parts, pdata->nr_parts);
+	else
+#endif
+		add_mtd_device(&info->mtd);
+
+	platform_set_drvdata(pdev, &info->mtd);
+
+	return 0;
+
+out_release_mem_region:
+	release_mem_region(info->phys_base, NAND_IO_SIZE);
+out_free_cs:
+	gpmc_cs_free(info->gpmc_cs);
+out_free_info:
+	kfree(info);
+
+	return err;
+}
+
+static int omap_nand_remove(struct platform_device *pdev)
+{
+	struct mtd_info *mtd =3D platform_get_drvdata(pdev);
+	struct omap_nand_info *info =3D mtd->priv;
+
+	platform_set_drvdata(pdev, NULL);
+	/* Release NAND device, its internal structures and partitions */
+	nand_release(&info->mtd);
+	iounmap(info->nand.IO_ADDR_R);
+	kfree(&info->mtd);
+	return 0;
+}
+
+static struct platform_driver omap_nand_driver =3D {
+	.probe		=3D omap_nand_probe,
+	.remove		=3D omap_nand_remove,
+	.driver		=3D {
+		.name	=3D DRIVER_NAME,
+		.owner	=3D THIS_MODULE,
+	},
+};
+MODULE_ALIAS(DRIVER_NAME);
+
+static int __init omap_nand_init(void)
+{
+	printk(KERN_INFO "%s driver initializing\n", DRIVER_NAME);
+	return platform_driver_register(&omap_nand_driver);
+}
+
+static void __exit omap_nand_exit(void)
+{
+	platform_driver_unregister(&omap_nand_driver);
+}
+
+module_init(omap_nand_init);
+module_exit(omap_nand_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Glue layer for NAND flash on TI OMAP boards");
--=20
1.6.0.1.141.g445ca

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
