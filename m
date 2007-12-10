From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: [RFC/PATCH 5/5] HDQ/1-wire support for OMAP2430/3430
Date: Mon, 10 Dec 2007 15:50:08 +0530
Message-ID: <005d01c83b16$3dbb6630$fe8818ac@ent.ti.com>
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
To: 'Evgeniy Polyakov' <johnpol@2ka.mipt.ru>, linux-omap-open-source@linux.omap.com
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch enables W1 and OMAP HDQ support for OMAP3430.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>

Index: linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/configs/omap_3430sdp_defconfig	2007-11-29 02:39:54.000000000 -0500
+++ linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig	2007-11-29 02:44:43.602245040 -0500
@@ -618,7 +618,24 @@
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
-# CONFIG_W1 is not set
+CONFIG_W1=y
+
+#
+# 1-wire Bus Masters
+#
+# CONFIG_W1_MASTER_DS2482 is not set
+# CONFIG_W1_MASTER_DS1WM is not set
+CONFIG_HDQ_MASTER_OMAP=y
+
+#
+# 1-wire Slaves
+#
+# CONFIG_W1_SLAVE_THERM is not set
+# CONFIG_W1_SLAVE_SMEM is not set
+# CONFIG_W1_SLAVE_DS2433 is not set
+# CONFIG_W1_SLAVE_DS2760 is not set
+CONFIG_W1_SLAVE_BQ27000=y
+# CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 CONFIG_MISC_DEVICES=y
 # CONFIG_EEPROM_93CX6 is not set
