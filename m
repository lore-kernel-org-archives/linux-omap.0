From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: [RFC/PATCH 4/5] HDQ/1-wire support for OMAP2430/3430
Date: Mon, 10 Dec 2007 15:49:40 +0530
Message-ID: <005c01c83b16$2cd1b7c0$fe8818ac@ent.ti.com>
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

This patch enables W1 and OMAP HDQ support for OMAP2430.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>

Index: linux-omap-2.6/arch/arm/configs/omap_2430sdp_defconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/configs/omap_2430sdp_defconfig	2007-11-27 09:34:42.000000000 -0500
+++ linux-omap-2.6/arch/arm/configs/omap_2430sdp_defconfig	2007-11-29 02:34:27.747869136 -0500
@@ -750,7 +750,25 @@
 # CONFIG_SPI_TSC2301 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
-# CONFIG_W1 is not set
+CONFIG_W1=y
+
+#
+# 1-wire Bus Masters
+#
+# CONFIG_W1_MASTER_DS2490 is not set
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
