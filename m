From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix broken N770 build
Date: Mon, 06 Nov 2006 19:31:19 +0100
Message-ID: <454F7F77.8000302@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070801050702090509010102"
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

This is a multi-part message in MIME format.
--------------070801050702090509010102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Make build of N770 work again.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------070801050702090509010102
Content-Type: text/plain;
 name="n770_fixes_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="n770_fixes_patch.txt"

Index: linux-osk/arch/arm/mach-omap1/board-nokia770.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/board-nokia770.c
+++ linux-osk/arch/arm/mach-omap1/board-nokia770.c
@@ -76,7 +76,7 @@ static struct omap_kp_platform_data noki
 	.rows		= 8,
 	.cols		= 8,
 	.keymap		= nokia770_keymap,
-	.keymapsize	= ARRAY_SIZE(nokia770_keymap)
+	.keymapsize	= ARRAY_SIZE(nokia770_keymap),
 	.delay		= 4,
 };
 
Index: linux-osk/arch/arm/configs/n770_defconfig
===================================================================
--- linux-osk.orig/arch/arm/configs/n770_defconfig
+++ linux-osk/arch/arm/configs/n770_defconfig
@@ -790,8 +790,47 @@ CONFIG_SPI_OMAP_UWIRE=y
 #
 # Hardware Monitoring support
 #
-# CONFIG_HWMON is not set
+CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_ABITUGURU is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ADM9240 is not set
+# CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_ATXP1 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_FSCPOS is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM70 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_LM92 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47M192 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_VT1211 is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83791D is not set
+# CONFIG_SENSORS_W83792D is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83627HF is not set
+# CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
 # Misc devices
Index: linux-osk/drivers/cbus/tahvo-usb.c
===================================================================
--- linux-osk.orig/drivers/cbus/tahvo-usb.c
+++ linux-osk/drivers/cbus/tahvo-usb.c
@@ -36,7 +36,7 @@
 #include <linux/usb_ch9.h>
 #include <linux/usb_gadget.h>
 #include <linux/usb.h>
-#include <linux/usb_otg.h>
+#include <linux/usb/otg.h>
 #include <linux/i2c.h>
 #include <linux/workqueue.h>
 #include <linux/kobject.h>


--------------070801050702090509010102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070801050702090509010102--
