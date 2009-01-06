From: Josh Karabin <gkarabin@vocollect.com>
Subject: [PATCH] NAND support for OMAP3 EVM
Date: Tue, 06 Jan 2009 18:17:44 -0500
Message-ID: <4963E698.9070108@vocollect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx4.vocollect.com ([64.212.175.114]:3636 "EHLO
	mx4.vocollect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbZAFXyf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 18:54:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


This patch adds support for detecting NAND flash on OMAP3 EVM boards.
It clones similar code from the 3430 SDP board files.

Signed-off-by: Josh Karabin <gkarabin@vocollect.com>

---
 arch/arm/configs/omap3_evm_defconfig       |   11 +++-
 arch/arm/mach-omap2/board-omap3evm-flash.c |   99 ++++++++++++++++++++++++----
 2 files changed, 96 insertions(+), 14 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index e42fe8c..f276c3a 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -503,7 +503,16 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-# CONFIG_MTD_NAND is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_OMAP2=y
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+# CONFIG_MTD_ALAUDA is not set
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
 # CONFIG_MTD_ONENAND_GENERIC is not set
diff --git a/arch/arm/mach-omap2/board-omap3evm-flash.c b/arch/arm/mach-omap2/board-omap3evm-flash.c
index 5f3663d..b115e48 100644
--- a/arch/arm/mach-omap2/board-omap3evm-flash.c
+++ b/arch/arm/mach-omap2/board-omap3evm-flash.c
@@ -27,29 +27,29 @@ static int omap3evm_onenand_setup(void __iomem *, int freq);
 
 static struct mtd_partition omap3evm_onenand_partitions[] = {
 	{
-		.name           = "xloader",
+		.name           = "xloader-onenand",
 		.offset         = 0,
 		.size           = 4*(64*2048),
 		.mask_flags     = MTD_WRITEABLE
 	},
 	{
-		.name           = "uboot",
+		.name           = "uboot-onenand",
 		.offset         = MTDPART_OFS_APPEND,
 		.size           =  15*(64*2048),
 		.mask_flags     = MTD_WRITEABLE
 	},
 	{
-		.name           = "params",
+		.name           = "params-onenand",
 		.offset         = MTDPART_OFS_APPEND,
 		.size           = 1*(64*2048),
 	},
 	{
-		.name           = "linux",
+		.name           = "linux-onenand",
 		.offset         = MTDPART_OFS_APPEND,
 		.size           = 40*(64*2048),
 	},
 	{
-		.name           = "jffs2",
+		.name           = "jffs2-onenand",
 		.offset         = MTDPART_OFS_APPEND,
 		.size           = MTDPART_SIZ_FULL,
 	},
@@ -70,6 +70,60 @@ static struct platform_device omap3evm_onenand_device = {
 	},
 };
 
+static struct mtd_partition omap3evm_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name		= "xloader-nand",
+		.offset		= 0,
+		.size		= 4*(128 * 1024),
+		.mask_flags	= MTD_WRITEABLE
+	},
+	{
+		.name		= "uboot-nand",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 14*(128 * 1024),
+		.mask_flags	= MTD_WRITEABLE
+	},
+	{
+		.name		= "params-nand",
+
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 2*(128 * 1024)
+	},
+ 	{
+		.name		= "linux-nand",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 40*(128 * 1024)
+	},
+	{
+		.name		= "jffs2-nand",
+		.size		= MTDPART_SIZ_FULL,
+		.offset		= MTDPART_OFS_APPEND,
+	},
+};
+
+static struct omap_nand_platform_data omap3evm_nand_data = {
+	.parts		= omap3evm_nand_partitions,
+	.nr_parts	= ARRAY_SIZE(omap3evm_nand_partitions),
+	.nand_setup	= NULL,
+	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
+	.dev_ready	= NULL,
+};
+
+static struct resource omap3evm_nand_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device omap3evm_nand_device = {
+	.name		= "omap2-nand",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &omap3evm_nand_data,
+	},
+	.num_resources	= 1,
+	.resource	= &omap3evm_nand_resource,
+};
+
 /*
  *      omap3evm_onenand_setup - Set the onenand sync mode
  *      @onenand_base:  The onenand base address in GPMC memory map
@@ -85,29 +139,48 @@ static int omap3evm_onenand_setup(void __iomem *onenand_base, int freq)
 void __init omap3evm_flash_init(void)
 {
 	u8		cs = 0;
-	u8		onenandcs = GPMC_CS_NUM + 1;
+	u8		onenandcs = GPMC_CS_NUM + 1, nandcs = GPMC_CS_NUM + 1;
+	u32		gpmc_base_add = OMAP34XX_GPMC_VIRT;
 
 	while (cs < GPMC_CS_NUM) {
 		u32 ret = 0;
-		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
+		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
 
 		/*
-		* xloader/Uboot would have programmed the oneNAND
+		* xloader/Uboot would have programmed the NAND/oneNAND
 		* base address for us This is a ugly hack. The proper
 		* way of doing this is to pass the setup of u-boot up
 		* to kernel using kernel params - something on the
-		* lines of machineID. Check if oneNAND is configured
+		* lines of machineID. Check if NAND/oneNAND is configured
 		*/
-		if ((ret & 0x3F) == (ONENAND_MAP >> 24))
-			onenandcs = cs;
+		if ((ret & 0xC00) == 0x800) {
+			/* Found it!! */
+			if (nandcs > GPMC_CS_NUM)
+				nandcs = cs;
+		} else {
+			ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
+			if ((ret & 0x3F) == (ONENAND_MAP >> 24))
+				onenandcs = cs;
+		}
 		cs++;
 	}
-	if (onenandcs > GPMC_CS_NUM) {
-		printk(KERN_INFO "OneNAND: Unable to find configuration "
+	if ((nandcs > GPMC_CS_NUM) && (onenandcs > GPMC_CS_NUM)) {
+		printk(KERN_INFO "NAND/OneNAND: Unable to find configuration "
 				" in GPMC\n ");
 		return;
 	}
 
+	if (nandcs < GPMC_CS_NUM) {
+		omap3evm_nand_data.cs	= nandcs;
+		omap3evm_nand_data.gpmc_cs_baseaddr = (void *)(gpmc_base_add +
+					GPMC_CS0_BASE + nandcs*GPMC_CS_SIZE);
+		omap3evm_nand_data.gpmc_baseaddr   = (void *) (gpmc_base_add);
+
+		if (platform_device_register(&omap3evm_nand_device) < 0) {
+			printk(KERN_ERR "Unable to register NAND device\n");
+		}
+	}
+
 	if (onenandcs < GPMC_CS_NUM) {
 		omap3evm_onenand_data.cs = onenandcs;
 		if (platform_device_register(&omap3evm_onenand_device) < 0)
-- 
1.5.6.6


