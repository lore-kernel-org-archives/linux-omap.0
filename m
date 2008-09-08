From: nskamat@ti.com
Subject: [PATCH - Omapzoom][ONENAND] Add synchronous burst support
Date: Mon,  8 Sep 2008 13:07:22 -0500
Message-ID: <1220897242-18640-1-git-send-email-nskamat@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53479 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404AbYIHSHb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Sep 2008 14:07:31 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m88I7PB8011838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 8 Sep 2008 13:07:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vimal Singh <vimalsingh@ti.com>, Nishant Kamat <nskamat@ti.com>

From: Vimal Singh <vimalsingh@ti.com>

Following patch taken over the omapzoom.org tree adds
synchronous burst read support to the OMAP2/3 onenand driver.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
Signed-off-by: Nishant Kamat <nskamat@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp-flash.c |   59 +++++++++++++++++++++++++++---
 drivers/mtd/onenand/Kconfig               |    6 +++
 2 files changed, 60 insertions(+), 5 deletions(-)

Index: omapkernel/drivers/mtd/onenand/Kconfig
===================================================================
--- omapkernel.orig/drivers/mtd/onenand/Kconfig	2008-09-08 12:35:43.000000000 +0530
+++ omapkernel/drivers/mtd/onenand/Kconfig	2008-09-08 13:00:39.000000000 +0530
@@ -70,4 +70,10 @@
 	  The simulator may simulate various OneNAND flash chips for the
 	  OneNAND MTD layer.
 
+config MTD_ONENAND_SYNC_BURST_READ
+	bool "OneNand Synchronous burst read support"
+	help
+	  Support for synchronous burst reads for a OneNand flash
+	  device
+
 endif # MTD_ONENAND
Index: omapkernel/arch/arm/mach-omap2/board-3430sdp-flash.c
===================================================================
--- omapkernel.orig/arch/arm/mach-omap2/board-3430sdp-flash.c	2008-09-08 12:35:43.000000000 +0530
+++ omapkernel/arch/arm/mach-omap2/board-3430sdp-flash.c	2008-09-08 13:00:39.000000000 +0530
@@ -76,8 +76,16 @@
 };
 
 struct gpmc_cs_config pdc_onenand_gpmc_setting[] = {
+#ifdef CONFIG_MTD_ONENAND_SYNC_BURST_READ
+	{0x60801200, 0xF0900, 0x00030200, 0x0F040901, 0x0109100A, 0x1F060000},
+#else
 	{0x1200, 0x000F0F01, 0x00030301, 0x0F040F04, 0x010F1010, 0x1F060000},
+#endif
+#ifdef CONFIG_MTD_ONENAND_SYNC_BURST_READ
+	{0x62801201, 0xF1000, 0x00030200, 0x0F041002, 0x02101013, 0x1F060000}
+#else
 	{0x1200, 0x000F0F01, 0x00030301, 0x0F040F04, 0x010F1010, 0x1F060000}
+#endif
 };
 
 struct gpmc_cs_config fpga_gpmc_setting[] = {
@@ -252,15 +260,56 @@
 	.resource	= &sdp_nand_resource,
 };
 
-/*
- * sdp_onenand_setup - The function configures the onenand flash.
- * @onenand_base: Onenand base address
+static unsigned short omap2_onenand_readw(void __iomem *addr)
+{
+	return readw(addr);
+}
+
+static void omap2_onenand_writew(unsigned short value, void __iomem *addr)
+{
+	writew(value, addr);
+}
+
+static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
+					int freq)
+{
+#ifdef CONFIG_MTD_ONENAND_SYNC_BURST_READ
+	u32 reg;
+
+	/* Configure OneNAND for sync read */
+	reg = omap2_onenand_readw(onenand_base + ONENAND_REG_SYS_CFG1);
+	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
+	reg |=  (0x06 << ONENAND_SYS_CFG1_BRL_SHIFT) |
+		ONENAND_SYS_CFG1_SYNC_READ |
+		ONENAND_SYS_CFG1_BL_8 | 0x04;
+	omap2_onenand_writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
+
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG2, 0xf1000);
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG3, 0x00030200);
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG4, 0x0f041002);
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG5, 0x02101013);
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG6, 0x1f060000);
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, 0x62801201);
+#endif
+	return 0;
+}
+
+/**
+ *      sdp_onenand_setup - Set the onenand sync mode
+ *      @onenand_base:  The onenand base address in GPMC memory map
  *
- * @return int:	Currently always returning zero.
  */
 static int sdp_onenand_setup(void __iomem *onenand_base, int freq)
 {
-	/* Onenand setup does nothing at present */
+	struct omap_onenand_platform_data *datap = &sdp_onenand_data;
+	struct device *dev = &sdp_onenand_device.dev;
+
+	/* Set sync timings in GPMC */
+	if (omap2_onenand_set_sync_mode(datap->cs, onenand_base, freq) < 0) {
+		dev_err(dev, "Unable to set synchronous mode\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
