From: "Girish" <girishsg@ti.com>
Subject: [PATCH 3/5] TWL4030-Core support on 3430
Date: Fri, 2 Nov 2007 20:54:50 +0530
Message-ID: <00f701c81d64$82aa8ed0$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch adds TWL core on 3430
Signed-off-by: Girish S G <girishsg@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig   |    6 ++++++
 drivers/i2c/chips/Kconfig                 |    2 +-
 include/asm-arm/arch-omap/board-3430sdp.h |    4 ++--
 3 files changed, 9 insertions(+), 3 deletions(-)

Index: linux-omap-git/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- linux-omap-git.orig/arch/arm/configs/omap_3430sdp_defconfig	2007-10-25 20:49:43.000000000 +0530
+++ linux-omap-git/arch/arm/configs/omap_3430sdp_defconfig	2007-10-25 20:51:13.000000000 +0530
@@ -607,6 +607,12 @@
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_OMAP=y
 #
+# Miscellaneous I2C Chip support
+#
+CONFIG_TWL4030_CORE=y
+CONFIG_TWL4030_GPIO=y
+
+#
 # SPI support
 #
 # CONFIG_SPI is not set
Index: linux-omap-git/drivers/i2c/chips/Kconfig
===================================================================
--- linux-omap-git.orig/drivers/i2c/chips/Kconfig	2007-10-25 20:49:43.000000000 +0530
+++ linux-omap-git/drivers/i2c/chips/Kconfig	2007-10-25 20:51:13.000000000 +0530
@@ -132,7 +132,7 @@
 
 config TWL4030_CORE
 	bool "TI's TWL4030 companion chip Core Driver Support"
-	depends on I2C=y && ARCH_OMAP24XX
+	depends on I2C=y && (ARCH_OMAP24XX || ARCH_OMAP34XX)
 	help
 	  Say yes here if you have TWL4030 chip on your board
 
Index: linux-omap-git/include/asm-arm/arch-omap/board-3430sdp.h
===================================================================
--- linux-omap-git.orig/include/asm-arm/arch-omap/board-3430sdp.h	2007-10-25 20:49:43.000000000 +0530
+++ linux-omap-git/include/asm-arm/arch-omap/board-3430sdp.h	2007-10-25 20:51:13.000000000 +0530
@@ -51,7 +51,7 @@
 #define NAND_BASE	0x0C000000  /* NAND flash */
 #define ONENAND_MAP	0x20000000  /* OneNand flash */
 
-#ifdef CONFIG_I2C_TWL4030_CORE
+#ifdef CONFIG_TWL4030_CORE
 
 #define TWL4030_IRQNUM INT_34XX_SYS_NIRQ
 
@@ -59,7 +59,7 @@
 #define	IH_TWL4030_BASE		IH_BOARD_BASE
 #define	IH_TWL4030_END		(IH_TWL4030_BASE+8)
 
-#ifdef CONFIG_I2C_TWL4030_GPIO
+#ifdef CONFIG_TWL4030_GPIO
 
 /* TWL4030 GPIO Interrupts */
 #define IH_TWL4030_GPIO_BASE	(IH_TWL4030_END)
