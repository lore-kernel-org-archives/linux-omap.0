From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warnings in devices.c for 2430sdp config
Date: Mon, 19 Mar 2007 18:35:07 +0100
Message-ID: <45FEC9CB.9010602@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010709030107090103080309"
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
--------------010709030107090103080309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix warnings

arch/arm/plat-omap/devices.c:159: warning: 'omap_init_kp' 
defined but not used
arch/arm/plat-omap/devices.c:282: warning: 'omap_init_mmc' 
defined but not used
arch/arm/plat-omap/devices.c:436: warning: 'omap_init_wdt' 
defined but not used
arch/arm/plat-omap/devices.c:469: warning: 'omap_init_rng' 
defined but not used

if using omap_2430sdp_defconfig.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------010709030107090103080309
Content-Type: text/plain;
 name="devices_warnings_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="devices_warnings_fix.txt"

Index: linux-osk/arch/arm/plat-omap/devices.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/devices.c
+++ linux-osk/arch/arm/plat-omap/devices.c
@@ -153,7 +153,8 @@ static inline void omap_init_i2c(void) {
 #endif
 
 /*-------------------------------------------------------------------------*/
-#if	defined(CONFIG_KEYBOARD_OMAP) || defined(CONFIG_KEYBOARD_OMAP_MODULE)
+#if	(defined(CONFIG_KEYBOARD_OMAP) || defined(CONFIG_KEYBOARD_OMAP_MODULE)) && \
+        !defined(CONFIG_MACH_OMAP_2430SDP)
 
 static void omap_init_kp(void)
 {
@@ -210,7 +211,8 @@ static inline void omap_init_kp(void) {}
 
 /*-------------------------------------------------------------------------*/
 
-#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+#if	(defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)) && \
+        !defined(CONFIG_MACH_OMAP_2430SDP)
 
 #ifdef CONFIG_ARCH_OMAP24XX
 #define	OMAP_MMC1_BASE		0x4809c000
@@ -409,7 +411,8 @@ static inline void omap_init_uwire(void)
 
 /*-------------------------------------------------------------------------*/
 
-#if	defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
+#if	(defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)) && \
+        !defined(CONFIG_MACH_OMAP_2430SDP)
 
 #ifdef CONFIG_ARCH_OMAP24XX
 #define	OMAP_WDT_BASE		0x48022000
@@ -442,7 +445,8 @@ static inline void omap_init_wdt(void) {
 
 /*-------------------------------------------------------------------------*/
 
-#if defined(CONFIG_HW_RANDOM_OMAP) || defined(CONFIG_HW_RANDOM_OMAP_MODULE)
+#if     (defined(CONFIG_HW_RANDOM_OMAP) || defined(CONFIG_HW_RANDOM_OMAP_MODULE)) && \
+        !defined(CONFIG_MACH_OMAP_2430SDP)
 
 #ifdef CONFIG_ARCH_OMAP24XX
 #define	OMAP_RNG_BASE		0x480A0000


--------------010709030107090103080309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010709030107090103080309--
