From: "Chandra shekhar" <x0044955@ti.com>
Subject: [PATCH 2/2] I2C and TWL4030 suport on 34xx
Date: Fri, 16 Nov 2007 19:18:26 +0530
Message-ID: <200711161348.lAGDmQcN013413@dbdp31.itg.ti.com>
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

TWL4030 core support for 3430

Signed-off-by: chandra shekhar <x0044955@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig   |    5 +++++
 drivers/i2c/chips/Kconfig                 |    2 +-
 include/asm-arm/arch-omap/board-3430sdp.h |    4 ++--
 3 files changed, 8 insertions(+), 3 deletions(-)

Index: linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/configs/omap_3430sdp_defconfig	2007-11-16 09:59:35.780049672 -0500
+++ linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig	2007-11-16 10:02:32.575172728 -0500
@@ -605,6 +605,11 @@
 CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_OMAP=y
+#
+# Miscellaneous I2C Chip support
+#
+CONFIG_TWL4030_CORE=y
+CONFIG_TWL4030_GPIO=y
 
 #
 # SPI support
Index: linux-omap-2.6/drivers/i2c/chips/Kconfig
===================================================================
--- linux-omap-2.6.orig/drivers/i2c/chips/Kconfig	2007-11-16 09:59:35.780049672 -0500
+++ linux-omap-2.6/drivers/i2c/chips/Kconfig	2007-11-16 10:02:32.575172728 -0500
@@ -132,7 +132,7 @@
 
 config TWL4030_CORE
 	bool "TI's TWL4030 companion chip Core Driver Support"
-	depends on I2C=y && ARCH_OMAP24XX
+	depends on I2C=y && (ARCH_OMAP24XX || ARCH_OMAP34XX)
 	help
 	  Say yes here if you have TWL4030 chip on your board
 
Index: linux-omap-2.6/include/asm-arm/arch-omap/board-3430sdp.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/board-3430sdp.h	2007-11-16 09:59:35.780049672 -0500
+++ linux-omap-2.6/include/asm-arm/arch-omap/board-3430sdp.h	2007-11-16 10:03:45.306115944 -0500
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
