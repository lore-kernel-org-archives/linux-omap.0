From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] 24xx NAND - Please Test
Date: Tue, 10 Jan 2006 03:12:03 -0800 (PST)
Message-ID: <20060110111203.26135.qmail@web32907.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1610980556-1136891523=:21913"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kyungmin.park@samsung.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-1610980556-1136891523=:21913
Content-Type: text/plain; charset=iso-8859-1
Content-Id: 
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by reloaded.ext.ti.com id k0ABJCvd018496

Kyungmin Park,

As you have already worked on h4 x-loader, I had cooked up NAND patch
for H4, but was not able to test it on EVM, as I got stuck in x-loader
and u-boot flashing itself.

You may want to test it and submit it to linux-omap list, as I will not
able to work on this anymore. Thanx.

---Komal Shah
http://komalshah.blogspot.com/


	=09
__________________________________________=20
Yahoo! DSL =96 Something to write home about.=20
Just $16.99/mo. or less.=20
dsl.yahoo.com=20

--0-1610980556-1136891523=:21913
Content-Type: text/plain; name="mtd-h4-nand.patch"
Content-Description: 3438099749-mtd-h4-nand.patch
Content-Disposition: inline; filename="mtd-h4-nand.patch"

MTD: H4 NAND support.
Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---
commit e638d8a390e39926af0ef430c1bada246be47980
tree 266103817e2358b243f8c22a08fed4023fdadd43
parent 165e0bcd61404f0418fc70f07a6a23124fa0d206
author Komal Shah <komal_shah802003@yahoo.com> Tue, 10 Jan 2006 16:36:35 +0530
committer Komal Shah <komal_shah802003@yahoo.com> Tue, 10 Jan 2006 16:36:35 +0530

 arch/arm/mach-omap2/board-h4.c     |   76 ++++++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/prcm-regs.h    |    2 +
 drivers/mtd/nand/Kconfig           |    8 ++--
 drivers/mtd/nand/omap-nand-flash.c |   47 ++++++++++++++++++----
 4 files changed, 111 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 19b498d..3b16517 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
 
@@ -34,7 +35,7 @@
 #include <asm/io.h>
 #include <asm/delay.h>
 
-static struct mtd_partition h4_partitions[] = {
+static struct mtd_partition h4_nor_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
 	      .name		= "bootloader",
@@ -65,27 +66,79 @@ static struct mtd_partition h4_partition
 	}
 };
 
-static struct flash_platform_data h4_flash_data = {
+static struct flash_platform_data h4_nor_data = {
 	.map_name	= "cfi_probe",
 	.width		= 2,
-	.parts		= h4_partitions,
-	.nr_parts	= ARRAY_SIZE(h4_partitions),
+	.parts		= h4_nor_partitions,
+	.nr_parts	= ARRAY_SIZE(h4_nor_partitions),
 };
 
-static struct resource h4_flash_resource = {
+static struct resource h4_nor_resource = {
 	.start		= H4_CS0_BASE,
 	.end		= H4_CS0_BASE + SZ_64M - 1,
 	.flags		= IORESOURCE_MEM,
 };
 
-static struct platform_device h4_flash_device = {
+static struct platform_device h4_nor_device = {
 	.name		= "omapflash",
 	.id		= 0,
 	.dev		= {
-		.platform_data	= &h4_flash_data,
+		.platform_data	= &h4_nor_data,
 	},
 	.num_resources	= 1,
-	.resource	= &h4_flash_resource,
+	.resource	= &h4_nor_resource,
+};
+
+static struct mtd_partition h4_nand_partitions[] = {
+	{
+		.name		= "xloader",
+		.offset		= 0,
+		.size		= 256 * 1024,
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "bootloader",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 256 * 1024,
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "params",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 192 * 1024,
+	},
+	{
+		.name		= "kernel",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 2 * SZ_1M,
+	},
+	{
+	      .name		= "filesystem",
+	      .offset		= MTDPART_OFS_APPEND,
+	      .size		= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct nand_platform_data h4_nand_data = {
+	.options	= NAND_SAMSUNG_LP_OPTIONS,
+	.parts		= h4_nand_partitions,
+	.nr_parts	= ARRAY_SIZE(h4_nand_partitions),
+};
+
+static struct resource h4_nand_resource = {
+	.start		= H4_CS0_BASE,
+	.end		= H4_CS0_BASE + SZ_64M - 1,
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device h4_nand_device = {
+	.name		= "omapnand",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &h4_nand_data,
+	},
+	.num_resources	= 1,
+	.resource	= &h4_nand_resource,
 };
 
 static struct resource h4_smc91x_resources[] = {
@@ -110,7 +163,8 @@ static struct platform_device h4_smc91x_
 
 static struct platform_device *h4_devices[] __initdata = {
 	&h4_smc91x_device,
-	&h4_flash_device,
+	&h4_nor_device,
+	&h4_nand_device,
 };
 
 static inline void __init h4_init_smc91x(void)
@@ -174,6 +228,10 @@ static void __init omap_h4_init(void)
 	 * You have to mux them off in device drivers later on
 	 * if not needed.
 	 */
+#if defined(CONFIG_MTD_OMAP_NOR) || defined(CONFIG_MTD_OMAP_NOR_MODULE)
+	GPMC_CONFIG1_0	= 0x00060000;	/* rw wait0 pin monitoring */
+	GPMC_CONFIG	= 0x00000010;	/* write protect off */
+#endif
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
diff --git a/arch/arm/mach-omap2/prcm-regs.h b/arch/arm/mach-omap2/prcm-regs.h
index 72337ca..fb6e12a 100644
--- a/arch/arm/mach-omap2/prcm-regs.h
+++ b/arch/arm/mach-omap2/prcm-regs.h
@@ -366,6 +366,8 @@
 
 /* GPMC CS1 FPGA ON USER INTERFACE MODULE */
 //#define DEBUG_BOARD_LED_REGISTER 0x04000014
+/* GPMC */
+#define GPMC_CONFIG		GPMC_REG32(0x050)
 
 /* GPMC CS0 */
 #define GPMC_CONFIG1_0		GPMC_REG32(0x060)
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index f4c4e8e..68f6d87 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -50,10 +50,10 @@ config MTD_NAND_SPIA
 	  If you had to ask, you don't have one. Say 'N'.
 
 config MTD_NAND_OMAP
-	tristate "NAND Flash device on OMAP H3/H2/P2 boards"
-	depends on ARM && ARCH_OMAP1 && MTD_NAND && (MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_PERSEUS2)
-	help
-	  Support for NAND flash on Texas Instruments H3/H2/P2 platforms.
+	tristate "NAND Flash device on OMAP H4/H3/H2/P2/NETSTAR boards"
+	depends on ARM && (ARCH_OMAP1 || ARCH_OMAP2) && MTD_NAND && (MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_NETSTAR || MACH_OMAP_PERSEUS2 || MACH_OMAP_H4)
+        help
+          Support for NAND flash on Texas Instruments H4/H3/H2/P2/NETSTAR platforms.
 
 config MTD_NAND_TOTO
 	tristate "NAND Flash device on TOTO board"
diff --git a/drivers/mtd/nand/omap-nand-flash.c b/drivers/mtd/nand/omap-nand-flash.c
index 35a3408..283dc7b 100644
--- a/drivers/mtd/nand/omap-nand-flash.c
+++ b/drivers/mtd/nand/omap-nand-flash.c
@@ -47,18 +47,49 @@ struct omap_nand_info {
  */
 #define	MASK_CLE	0x02
 #define	MASK_ALE	0x04
+
+/* omap24xx */
+#define NAND_DATA_0	0x84
+#define NAND_COMMAND_0	0x7C
+#define NAND_ADDRESS_0	0x80
+
 static void omap_nand_hwcontrol(struct mtd_info *mtd, int cmd)
 {
 	struct nand_chip *this = mtd->priv;
 	unsigned long IO_ADDR_W = (unsigned long) this->IO_ADDR_W;
-
-	switch (cmd) {
-		case NAND_CTL_SETCLE: IO_ADDR_W |= MASK_CLE; break;
-		case NAND_CTL_CLRCLE: IO_ADDR_W &= ~MASK_CLE; break;
-		case NAND_CTL_SETALE: IO_ADDR_W |= MASK_ALE; break;
-		case NAND_CTL_CLRALE: IO_ADDR_W &= ~MASK_ALE; break;
+	unsigned long IO_ADDR_R = (unsigned long) this->IO_ADDR_R;
+	
+	if(cpu_class_is_omap1()) {
+		switch (cmd) {
+			case NAND_CTL_SETCLE: IO_ADDR_W |= MASK_CLE; break;
+			case NAND_CTL_CLRCLE: IO_ADDR_W &= ~MASK_CLE; break;
+			case NAND_CTL_SETALE: IO_ADDR_W |= MASK_ALE; break;
+			case NAND_CTL_CLRALE: IO_ADDR_W &= ~MASK_ALE; break;
+		}
+	}
+	
+	if(cpu_class_is_omap2()) {
+		switch (cmd) {
+			case NAND_CTL_SETCLE:
+				IO_ADDR_W |= NAND_COMMAND_0;
+				IO_ADDR_R |= NAND_DATA_0;
+			break;
+			case NAND_CTL_CLRCLE:
+				IO_ADDR_W |= NAND_DATA_0;
+				IO_ADDR_R = IO_ADDR_W;
+			break;
+			case NAND_CTL_SETALE:
+				IO_ADDR_W |= NAND_ADDRESS_0;
+				IO_ADDR_R = NAND_DATA_0;
+			break;
+			case NAND_CTL_CLRALE:
+				IO_ADDR_W |= NAND_DATA_0;
+				IO_ADDR_R = IO_ADDR_W;
+			break;
+		}
 	}
 	this->IO_ADDR_W = (void __iomem *) IO_ADDR_W;
+	this->IO_ADDR_R = (void __iomem *) IO_ADDR_R;
 }
 
 static int omap_nand_dev_ready(struct mtd_info *mtd)
@@ -76,12 +107,10 @@ static int __devinit omap_nand_probe(str
 	unsigned long			size = res->end - res->start + 1;
 	int				err;
 
-	info = kmalloc(sizeof(struct omap_nand_info), GFP_KERNEL);
+	info = kzalloc(sizeof(struct omap_nand_info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	memset(info, 0, sizeof(struct omap_nand_info));
-
 	if (!request_mem_region(res->start, size, pdev->dev.driver->name)) {
 		err = -EBUSY;
 		goto out_free_info;

--0-1610980556-1136891523=:21913
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--0-1610980556-1136891523=:21913--
