From: <sshahrom@micron.com>
Subject: [PATCH 4/4] [MTD] NAND : Resubmitting support for 2K page nand
Date: Wed, 19 Sep 2007 14:30:12 -0700
Message-ID: <809D758398CC1F49AA8E493528AD4A27014DF6D3@ntxsjombx02.micron.com>
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

Hi,
Continuing with rest of patch series on linux.omap.com

Signed-off-by: Shahrom Sharif-Kashani <sshahrom <at> micron.com>

:000000 100644 0000000... a25426c... A	drivers/mtd/nand/omap2.c

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
new file mode 100644
index 0000000..a25426c
--- /dev/null
+++ b/drivers/mtd/nand/omap2.c
@@ -0,0 +1,636 @@
+/*
+ * drivers/mtd/nand/omap2.c
+ *
+ * Copyright (c) 2004 Texas Instruments, Jian Zhang <jzhang@ti.com>
+ * Copyright (c) 2004 Micron Technology Inc.
+ * Copyright (c) 2004 David Brownell
+ *
+ * This program is free software; you can redistribute it and/or modify
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
+#include <asm/arch/gpmc.h>
+#include <asm/arch/nand.h>
+
+#define GPMC_IRQ_STATUS         0x18
+#define GPMC_ECC_CONFIG         0x1F4
+#define GPMC_ECC_CONTROL        0x1F8
+#define GPMC_ECC_SIZE_CONFIG    0x1FC
+#define GPMC_ECC1_RESULT        0x200
+
+#define	DRIVER_NAME	"omap2-nand"
+#define	NAND_IO_SIZE	SZ_4K
+
+#define	NAND_WP_ON	1
+#define	NAND_WP_OFF	0
+#define NAND_WP_BIT	0x00000010
+#define WR_RD_PIN_MONITORING             0x00600000
+
+#define	GPMC_BUF_FULL	0x00000001
+#define	GPMC_BUF_EMPTY	0x00000000
+
+#ifdef CONFIG_MTD_PARTITIONS
+static const char *part_probes[] =3D { "cmdlinepart", NULL };
+#endif
+
+static int hw_ecc =3D 1;
+
+/* new oob placement block for use with hardware ecc generation */
+static struct nand_ecclayout omap_hw_eccoob =3D {
+	.eccbytes =3D 12,
+	.eccpos =3D {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13},
+	.oobfree =3D {{16, 32}, {33, 63} },
+};
+
+struct omap_nand_info {
+	struct nand_hw_control		controller;
+	struct nand_platform_data	*pdata;
+	struct mtd_info			mtd;
+	struct mtd_partition		*parts;
+	struct nand_chip		nand;
+	struct platform_device		*pdev;
+	/*~~~~~*/
+	int				gpmc_cs;
+	unsigned long 			phys_base;
+	void __iomem            	*gpmc_cs_baseaddr;
+	void __iomem            	*gpmc_baseaddr;
+};
+static void omap_nand_wp(struct mtd_info *mtd, int mode)
+{
+	struct omap_nand_info *info =3D container_of(mtd,
+						struct omap_nand_info, mtd);
+
+	unsigned long config =3D __raw_readl(info->gpmc_baseaddr + =
GPMC_CONFIG);
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
+ *	hardware specific access to control-lines
+ *	NOTE:  boards may use different bits for these!!
+ *
+ *	ctrl:
+ *	NAND_NCE: bit 0 - don't care
+ *	NAND_CLE: bit 1 -> Command Latch
+ *	NAND_ALE: bit 2 -> Address Latch
+ */
+
+static void omap_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int =
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
+* omap_read_buf - read data from NAND controller into buffer
+* @mtd:        MTD device structure
+* @buf:        buffer to store date
+* @len:        number of bytes to read
+*
+*/
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
+* omap_write_buf -  write buffer to NAND controller
+* @mtd:        MTD device structure
+* @buf:        data buffer
+* @len:        number of bytes to write
+*
+*/
+static void omap_write_buf(struct mtd_info *mtd, const u_char * buf, =
int len)
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
+** omap_verify_buf - Verify chip data against buffer
+** @mtd:        MTD device structure
+** @buf:        buffer containing the data to compare
+** @len:        number of bytes to compare
+*/
+static int omap_verify_buf(struct mtd_info *mtd, const u_char * buf, =
int len)
+{
+	struct omap_nand_info *info =3D container_of(mtd, struct =
omap_nand_info,
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
+} /* End omap_verify_buf */
+
+static void omap_hwecc_init(struct mtd_info *mtd)
+{
+	struct omap_nand_info *info =3D container_of(mtd, struct =
omap_nand_info,
+							mtd);
+	unsigned long val =3D 0x0;
+
+	/* Read from ECC Control Register */
+	val =3D __raw_readl(info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+	/*       Clear all ECC  | Enable Reg1 */
+	val =3D ((0x00000001<<8) | 0x00000001);
+	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+
+	/* Read from ECC Size Config Register */
+	val =3D __raw_readl(info->gpmc_baseaddr + GPMC_ECC_SIZE_CONFIG);
+	/*   ECCSIZE1=3D512   |  ECCSIZE0=3D8bytes | Select =
eccResultsize[0123] */
+	val =3D ((0x000000FF<<22) | (0x00000003<<12) | (0x0000000F));
+	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_SIZE_CONFIG);
+
+
+} /* End omap_hwecc_init */
+
+/*
+ * This function will generate true ECC value, which can be used
+ * when correcting data read from NAND flash memory core
+ */
+static void gen_true_ecc(u8 *ecc_buf)
+{
+	u32 tmp =3D ecc_buf[0] | (ecc_buf[1] << 16) |
+		((ecc_buf[2] & 0xF0) << 20) | ((ecc_buf[2] & 0x0F) << 8);
+
+	ecc_buf[0] =3D ~(P64o(tmp) | P64e(tmp) | P32o(tmp) | P32e(tmp) |
+			P16o(tmp) | P16e(tmp) | P8o(tmp) | P8e(tmp));
+	ecc_buf[1] =3D ~(P1024o(tmp) | P1024e(tmp) | P512o(tmp) | P512e(tmp) |
+			P256o(tmp) | P256e(tmp) | P128o(tmp) | P128e(tmp));
+	ecc_buf[2] =3D ~(P4o(tmp) | P4e(tmp) | P2o(tmp) | P2e(tmp) | P1o(tmp) =
|
+			P1e(tmp) | P2048o(tmp) | P2048e(tmp));
+} /* End gen_true_ecc */
+
+/*
+ * This function compares two ECC's and indicates if there is an error.
+ * If the error can be corrected it will be corrected to the buffer
+ */
+static int omap_compare_ecc(u8 *ecc_data1,   /* read from NAND memory =
*/
+			    u8 *ecc_data2,   /* read from register */
+			    u8 *page_data)
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
+		   ECC values are equal */
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
+} /* End omap_compare_ecc */
+
+static int omap_correct_data(struct mtd_info *mtd, u_char * dat,
+				u_char * read_ecc, u_char * calc_ecc)
+{
+	struct omap_nand_info *info =3D container_of(mtd, struct =
omap_nand_info,
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
+} /* End omap_correct_data */
+
+
+/*
+** Generate non-inverted ECC bytes.
+**
+** Using noninverted ECC can be considered ugly since writing a blank
+** page ie. padding will clear the ECC bytes. This is no problem as =
long
+** nobody is trying to write data on the seemingly unused page.
+**
+** Reading an erased page will produce an ECC mismatch between
+** generated and read ECC bytes that has to be dealt with separately.
+*/
+static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
+				u_char *ecc_code)
+{
+	struct omap_nand_info *info =3D container_of(mtd, struct =
omap_nand_info,
+							mtd);
+	unsigned long val =3D 0x0;
+	unsigned long reg, n;
+
+	/* Ex NAND_ECC_HW12_2048 */
+	if ((info->nand.ecc.mode =3D=3D NAND_ECC_HW) &&
+		(info->nand.ecc.size  =3D=3D 2048))
+		n =3D 4;
+	else
+		n =3D 1;
+
+	/* Start Reading from HW ECC1_Result =3D 0x200 */
+	reg =3D (unsigned long)(info->gpmc_baseaddr + GPMC_ECC1_RESULT);
+	while (n--) {
+		val =3D __raw_readl(reg);
+		*ecc_code++ =3D val;          /* P128e, ..., P1e */
+		*ecc_code++ =3D val >> 16;    /* P128o, ..., P1o */
+		/* P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e, P256e */
+		*ecc_code++ =3D ((val >> 8) & 0x0f) | ((val >> 20) & 0xf0);
+		reg +=3D 4;
+	}
+
+	return 0;
+} /* omap_calculate_ecc */
+
+static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
+{
+	struct omap_nand_info *info =3D container_of(mtd, struct =
omap_nand_info,
+							mtd);
+	unsigned long val =3D __raw_readl(info->gpmc_baseaddr + =
GPMC_ECC_CONFIG);
+
+	switch (mode) {
+	case NAND_ECC_READ    :
+		__raw_writel(0x101, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+		/* ECC 16 bit col) | ( CS 0 )  | ECC Enable */
+		val =3D (1 << 7) | (0x0) | (0x1) ;
+		break;
+	case NAND_ECC_READSYN :
+		__raw_writel(0x100, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+		/* ECC 16 bit col) | ( CS 0 )  | ECC Enable */
+		val =3D (1 << 7) | (0x0) | (0x1) ;
+		break;
+	case NAND_ECC_WRITE   :
+		__raw_writel(0x101, info->gpmc_baseaddr + GPMC_ECC_CONTROL);
+		/* ECC 16 bit col) | ( CS 0 )  | ECC Enable */
+		val =3D (1 << 7) | (0x0) | (0x1) ;
+		break;
+	default:
+		DEBUG(MTD_DEBUG_LEVEL0, "Error: Unrecognized Mode[%d]!\n",
+					mode);
+		break;
+	}
+
+	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_CONFIG);
+
+} /* End omap_enable_hwecc */
+
+static int omap_dev_ready(struct mtd_info *mtd)
+{
+	struct omap_nand_info *info =3D container_of(mtd, struct =
omap_nand_info,
+							mtd);
+	unsigned int val =3D __raw_readl(info->gpmc_baseaddr + =
GPMC_IRQ_STATUS);
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
+} /* End omap_dev_ready */
+
+static int __devinit omap_nand_probe(struct platform_device *pdev)
+{
+	struct omap_nand_info		*info;
+	struct omap_nand_platform_data	*pdata;
+	int				err;
+	unsigned long val;
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
+	info->gpmc_cs          =3D pdata->cs;
+	info->gpmc_baseaddr    =3D pdata->gpmc_baseaddr;
+	info->gpmc_cs_baseaddr =3D pdata->gpmc_cs_baseaddr;
+
+	info->mtd.priv  =3D &info->nand;
+	info->mtd.name  =3D pdev->dev.bus_id;
+	info->mtd.owner =3D THIS_MODULE;
+
+	err =3D gpmc_cs_request(info->gpmc_cs, NAND_IO_SIZE, =
&info->phys_base);
+	if (err < 0) {
+		dev_err(&pdev->dev, "Cannot request GPMC CS\n");
+		goto out_free_info;
+	}
+
+	/* Enable RD PIN Monitoring Reg */
+	val  =3D gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG1);
+	val |=3D WR_RD_PIN_MONITORING;
+	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG1, val);
+
+	val  =3D gpmc_cs_read_reg(info->gpmc_cs, GPMC_CS_CONFIG7);
+	val &=3D ~(0xf << 8);
+	val |=3D  (0xc & 0xf) << 8;
+	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG7, val);
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
+	info->nand.dev_ready  =3D omap_dev_ready;
+	info->nand.chip_delay =3D 0;
+
+	/* Options:                            */
+	info->nand.options   =3D NAND_BUSWIDTH_16;
+	info->nand.options  |=3D NAND_SKIP_BBTSCAN;
+
+	if (hw_ecc) {
+		/* init HW ECC */
+		omap_hwecc_init(&info->mtd);
+
+		info->nand.ecc.calculate =3D omap_calculate_ecc;
+		info->nand.ecc.hwctl     =3D omap_enable_hwecc;
+		info->nand.ecc.correct   =3D omap_correct_data;
+		info->nand.ecc.mode      =3D NAND_ECC_HW;
+		info->nand.ecc.bytes     =3D 12;
+		info->nand.ecc.size      =3D 2048;
+		info->nand.ecc.layout    =3D &omap_hw_eccoob;
+
+	} else {
+		info->nand.ecc.mode =3D NAND_ECC_SOFT;
+	}
+
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
+	err =3D parse_mtd_partitions(&info->mtd, part_probes, &info->parts, =
0);
+	if (err > 0)
+		add_mtd_partitions(&info->mtd, info->parts, err);
+	else if (err < 0 && pdata->parts)
+		add_mtd_partitions(&info->mtd, pdata->parts, pdata->nr_parts);
+	else
+#endif
+		add_mtd_device(&info->mtd);
+
+	omap_nand_wp(&info->mtd, NAND_WP_OFF);
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
+} /* End omap_nand_probe */
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

Signed-off-by: Shahrom Sharif-Kashani <sshahrom@micron.com>
