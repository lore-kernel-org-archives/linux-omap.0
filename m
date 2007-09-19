From: <sshahrom@micron.com>
Subject: [PATCH 1/4] OMAP: Resubmitting support for 2K page nand
Date: Wed, 19 Sep 2007 14:21:02 -0700
Message-ID: <809D758398CC1F49AA8E493528AD4A27014DF6D0@ntxsjombx02.micron.com>
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
Cc: sshahrom@micron.com
List-Id: linux-omap@vger.kernel.org


Hello,
Following patches would add support for 2k Page nand with Enabled HW ECC =
on omap2430 v4.0. and v5. It has been Tested with Micron Nand.=20
The Patch is against 2.6.23 linux-omap.git tree. As Always all the =
comments are welcomed.
Regards,
-Shahrom

Signed-off-by: Shahrom Sharif-Kashani <sshahrom <at> micron.com>

:100644 100644 1e8492a... 0000000... M	=
arch/arm/mach-omap2/board-2430sdp-flash.c

diff --git a/arch/arm/mach-omap2/board-2430sdp-flash.c =
b/arch/arm/mach-omap2/board-2430sdp-flash.c
index 1e8492a..b534a07 100644
--- a/arch/arm/mach-omap2/board-2430sdp-flash.c
+++ b/arch/arm/mach-omap2/board-2430sdp-flash.c
@@ -20,10 +20,64 @@
 #include <asm/arch/onenand.h>
 #include <asm/arch/board.h>
 #include <asm/arch/gpmc.h>
+#include <asm/arch/nand.h>
=20
 #define ONENAND_MAP 0x20000000
 #define GPMC_OFF_CONFIG1_0 0x60
=20
+enum fstype {
+	NAND =3D 0,
+	NOR,
+	ONENAND,
+	UNKNOWN =3D -1
+};
+
+static enum fstype flash_type =3D NAND;
+
+static struct mtd_partition nand_partitions[] =3D {
+	{
+		.name		=3D "X-Loader",
+		.offset		=3D 0,
+		.size		=3D 4*(64*2048),  /* 0-3 blks reserved.
+						   Mandated by ROM code */
+		.mask_flags	=3D MTD_WRITEABLE	/* force read-only */
+	},
+	{
+		.name		=3D "U-Boot",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D  4*(64*2048),
+		.mask_flags	=3D MTD_WRITEABLE	/* force read-only */
+	},
+	{
+		.name		=3D "U-Boot Environment",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D 2*(64*2048),
+	},
+	{
+		.name		=3D "Kernel",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D 32*(64*2048),		/* 4*1M */
+	},
+	{
+		.name		=3D "File System",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D MTDPART_SIZ_FULL,
+	},
+};
+static struct omap_nand_platform_data sdp_nand_data =3D {
+	.parts		=3D nand_partitions,
+	.nr_parts	=3D ARRAY_SIZE(nand_partitions),
+	.dma_channel	=3D -1,	/* disable DMA in OMAP OneNAND driver */
+};
+
+static struct platform_device sdp_nand_device =3D {
+	.name		=3D "omap2-nand",
+	.id		=3D -1,
+	.dev =3D {
+		.platform_data =3D &sdp_nand_data,
+	},
+};
+
 static struct mtd_partition onenand_partitions[] =3D {
 	{
 		.name		=3D "(OneNAND)X-Loader",
@@ -72,7 +126,7 @@ static struct platform_device sdp_onenan
 void __init sdp2430_flash_init(void)
 {
 	unsigned long gpmc_base_add, gpmc_cs_base_add;
-	unsigned char cs=3D0;
+	unsigned char cs =3D 0;
=20
 	gpmc_base_add =3D OMAP243X_GPMC_VIRT;
 	while (cs < GPMC_CS_NUM) {
@@ -82,29 +136,50 @@ void __init sdp2430_flash_init(void)
 		gpmc_cs_base_add =3D
 			(gpmc_base_add + GPMC_OFF_CONFIG1_0 + (cs*0x30));
=20
-		/* xloader/Uboot would have programmed the oneNAND
+		/* xloader/Uboot would have programmed the NAND/oneNAND
 		 * base address for us This is a ugly hack. The proper
 		 * way of doing this is to pass the setup of u-boot up
 		 * to kernel using kernel params - something on the
-		 * lines of machineID. Check if oneNAND is
+		 * lines of machineID. Check if Nand/oneNAND is
 		 * configured */
+		ret =3D __raw_readl(gpmc_cs_base_add + GPMC_CS_CONFIG1);
+		if ((ret & 0xC00) =3D=3D (0x800)) {
+			/* Found it!! */
+			printk(KERN_INFO "NAND: Found NAND on CS %d \n", cs);
+			flash_type =3D NAND;
+			break;
+		}
 		ret =3D __raw_readl(gpmc_cs_base_add + GPMC_CS_CONFIG7);
 		if ((ret & 0x3F) =3D=3D (ONENAND_MAP >> 24)) {
 			/* Found it!! */
+			flash_type =3D ONENAND;
 			break;
 		}
 		cs++;
 	}
 	if (cs >=3D GPMC_CS_NUM) {
-		printk("OneNAND: Unable to find oneNAND configuration in GPMC "
-		       " - not registering.\n");
+		printk(KERN_INFO "MTD: Unable to find MTD configuration in "
+				 "GPMC   - not registering.\n");
+		return;
+	}
+
+	if (flash_type =3D=3D NAND) {
+		sdp_nand_data.cs               =3D cs;
+		sdp_nand_data.gpmc_cs_baseaddr =3D (void *) gpmc_cs_base_add;
+		sdp_nand_data.gpmc_baseaddr    =3D (void *) gpmc_base_add;
+
+		if (platform_device_register(&sdp_nand_device) < 0) {
+			printk(KERN_ERR "Unable to register NAND device\n");
 		return;
 	}
+	}
=20
+	if (flash_type =3D=3D ONENAND) {
 	sdp_onenand_data.cs =3D cs;
=20
 	if (platform_device_register(&sdp_onenand_device) < 0) {
 		printk(KERN_ERR "Unable to register OneNAND device\n");
 		return;
 	}
+	}
 }

Signed-off-by: Shahrom Sharif-Kashani <sshahrom@micron.com>
