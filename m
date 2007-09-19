From: <sshahrom@micron.com>
Subject: [PATCH 2/4] [MTD] NAND : Resubmitting support for 2K page nand
Date: Wed, 19 Sep 2007 14:24:58 -0700
Message-ID: <809D758398CC1F49AA8E493528AD4A27014DF6D1@ntxsjombx02.micron.com>
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

:100644 100644 295a568... 0000000... M	drivers/mtd/nand/Kconfig
:100644 100644 f9a1f6b... 0000000... M	drivers/mtd/nand/Makefile

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 295a568..d28b247 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -69,6 +69,12 @@ config MTD_NAND_AMS_DELTA
 	help
 	  Support for NAND flash on Amstrad E3 (Delta).
=20
+config MTD_NAND_OMAP2
+	tristate "NAND Flash device on OMAP 2420H4/2430SDP boards"
+	depends on (ARM && ARCH_OMAP2 && MTD_NAND)
+	help
+          Support for NAND flash on Texas Instruments 2430SDP/2420H4 =
platforms.
+
 config MTD_NAND_OMAP
 	tristate "NAND Flash device on OMAP H3/H2/P2 boards"
 	depends on ARM && ARCH_OMAP1 && MTD_NAND && (MACH_OMAP_H2 || =
MACH_OMAP_H3 || MACH_OMAP_PERSEUS2)
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index f9a1f6b..1539c98 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_MTD_NAND_NANDSIM)		+=3D nands
 obj-$(CONFIG_MTD_NAND_CS553X)		+=3D cs553x_nand.o
 obj-$(CONFIG_MTD_NAND_NDFC)		+=3D ndfc.o
 obj-$(CONFIG_MTD_NAND_OMAP) 		+=3D omap-nand-flash.o
+obj-$(CONFIG_MTD_NAND_OMAP2) 		+=3D omap2.o
 obj-$(CONFIG_MTD_NAND_OMAP_HW)		+=3D omap-hw.o
 obj-$(CONFIG_MTD_NAND_AT91)		+=3D at91_nand.o
 obj-$(CONFIG_MTD_NAND_CM_X270)		+=3D cmx270_nand.o


Signed-off-by: Shahrom Sharif-Kashani <sshahrom@micron.com>
