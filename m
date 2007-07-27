From: <sshahrom@micron.com>
Subject: [PATCH 1/3] [ARM] OMAP: Adding Support for 2K nand page support for
	omap2430
Date: Fri, 27 Jul 2007 10:10:20 -0700
Message-ID: <809D758398CC1F49AA8E493528AD4A27014DF6AD@ntxsjombx02.micron.com>
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


Hello,
Following patches would add support for 2k Page nand with Enabled HW ECC =
on omap2430 v4.0. It has been Tested with Micron Nand. The Patch is =
against 2.6.22 linux-omap.git tree. As Always all the comments are =
welcomed.

Signed-off-by: Shahrom Sharif-Kashani <sshahrom@micron.com>


:100644 100644 1e8492a... 0000000... M	=
arch/arm/mach-omap2/board-2430sdp-flash.c

diff --git a/arch/arm/mach-omap2/board-2430sdp-flash.c =
b/arch/arm/mach-omap2/board-2430sdp-flash.c
index 1e8492a..a8c9340 100644
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
+enum fsType {
+	NAND =3D 0,
+	NOR,
+	ONENAND,
+	UNKNOWN=3D-1
+};
+
+static enum fsType flashType =3D NAND;
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
+			printk("NAND: Found NAND on CS %d \n",cs);
+			flashType =3D NAND;=20
+			break;
+		}
 		ret =3D __raw_readl(gpmc_cs_base_add + GPMC_CS_CONFIG7);
 		if ((ret & 0x3F) =3D=3D (ONENAND_MAP >> 24)) {
 			/* Found it!! */
+			flashType =3D ONENAND;
 			break;
 		}
 		cs++;
 	}
 	if (cs >=3D GPMC_CS_NUM) {
-		printk("OneNAND: Unable to find oneNAND configuration in GPMC "
+		printk("MTD: Unable to find MTD configuration in GPMC "
 		       " - not registering.\n");
 		return;
 	}
=20
+	if (flashType =3D=3D NAND) {
+		sdp_nand_data.cs             =3D cs;
+		sdp_nand_data.gpmcCsBaseAddr =3D gpmc_cs_base_add;
+		sdp_nand_data.gpmcBaseAddr   =3D gpmc_base_add;
+
+		if (platform_device_register(&sdp_nand_device) < 0) {
+			printk(KERN_ERR "Unable to register NAND device\n");
+			return;
+		}
+	}
+
+	if (flashType =3D=3D ONENAND) {
 	sdp_onenand_data.cs =3D cs;
=20
 	if (platform_device_register(&sdp_onenand_device) < 0) {
 		printk(KERN_ERR "Unable to register OneNAND device\n");
 		return;
 	}
+	}
 }
