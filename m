From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.23-omap] fix omap2 kconfig goofage
Date: Fri, 12 Oct 2007 14:23:48 -0700
Message-ID: <200710121423.48331.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Clean up OMAP2 Kconfig.  Again.

 - 34xx shouldn't go in the middle of the 24xx stuff, it
   goofs the dependency tree displayed by e.g. kconfig.
   In particular, not in the middle of the H4-specific
   options.

 - Make the 2420 boards depend on OMAP2420, and 2430 boards
   on OMAP2430 ... a 2420-only kernel shouldn't show 2430
   boards, and vice versa.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
I don't know why that 34xx breakage keeps re-appearing...

 arch/arm/mach-omap2/Kconfig |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- o26.orig/arch/arm/mach-omap2/Kconfig	2007-10-12 13:35:37.000000000 -0700
+++ o26/arch/arm/mach-omap2/Kconfig	2007-10-12 13:43:10.000000000 -0700
@@ -5,10 +5,6 @@ config ARCH_OMAP24XX
 	bool "OMAP24xx Based System"
 	depends on ARCH_OMAP2
 
-config ARCH_OMAP34XX
-	bool "OMAP34xx Based System"
-	depends on ARCH_OMAP3
-
 config ARCH_OMAP2420
 	bool "OMAP2420 support"
 	depends on ARCH_OMAP24XX
@@ -19,6 +15,10 @@ config ARCH_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP24XX
 
+config ARCH_OMAP34XX
+	bool "OMAP34xx Based System"
+	depends on ARCH_OMAP3
+
 config ARCH_OMAP3430
 	bool "OMAP3430 support"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
@@ -32,7 +32,7 @@ config MACH_OMAP_GENERIC
 
 config MACH_NOKIA_N800
 	bool "Nokia N800"
-	depends on ARCH_OMAP24XX
+	depends on ARCH_OMAP2420
 	select VIDEO_TCM825X if VIDEO_OMAP2
 	select CBUS if VIDEO_TCM825X
 	select CBUS_RETU if VIDEO_TCM825X
@@ -45,14 +45,10 @@ config MACH_OMAP2_TUSB6010
 
 config MACH_OMAP_H4
 	bool "OMAP 2420 H4 board"
-	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+	depends on ARCH_OMAP2 && ARCH_OMAP2420
 	select OMAP_DEBUG_DEVICES
 	select GPIOEXPANDER_OMAP
 
-
-config MACH_OMAP_3430SDP
-	bool "OMAP 3430 SDP board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 config MACH_OMAP_H4_TUSB
 	bool "TUSB 6010 EVM board"
 	depends on MACH_OMAP_H4
@@ -89,10 +85,11 @@ config MACH_OMAP2_H4_USB1
 
 config MACH_OMAP_APOLLON
 	bool "OMAP 2420 Apollon board"
-	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+	depends on ARCH_OMAP2 && ARCH_OMAP2420
 
 config MACH_OMAP_APOLLON_PLUS
 	bool "OMAP 2420 Apollon Plus board"
+	depends on ARCH_OMAP2 && ARCH_OMAP2420
 	select MACH_OMAP_APOLLON
 	help
 	  It contains more LEDs, SWs, and so on
@@ -102,5 +99,9 @@ config MACH_OMAP_APOLLON_PLUS
 
 config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
-	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+	depends on ARCH_OMAP2 && ARCH_OMAP2430
+
+config MACH_OMAP_3430SDP
+	bool "OMAP 3430 SDP board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
