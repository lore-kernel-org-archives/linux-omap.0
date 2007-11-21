From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH RESEND 1/4] Runtime constants: introduce
	omap2_set_globals_*()
Date: Tue, 20 Nov 2007 17:16:21 -0700
Message-ID: <20071121002107.981742289@pwsan.com>
References: <20071121001620.571082090@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=mb-introduce-set-bases.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add the omap2_set_globals_{242x,243x,343x}() functions.  These
functions are called early upon boot in the map_io() functions in the
board-specific init files.  The functions are currently no-ops.  Later
patches augment these functions to set global variables to the base
virtual addresses of OMAP modules.  This makes it possible to write
code that can run without modification on multiple OMAP chip
revisions.

The *_set_globals_* functions are added into
arch/arm/plat-omap/common.c.  This patch currently only introduces
OMAP2 and OMAP3 functions, but a later patch introduces an
OMAP16XX-specific version, omap1_set_globals_16xx().

Also, while we are here, we get rid of the unused OMAP_L4_BASE define.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/board-2430osk.c  |    1 +
 arch/arm/mach-omap2/board-2430sdp.c  |    1 +
 arch/arm/mach-omap2/board-3430sdp.c  |    1 +
 arch/arm/mach-omap2/board-apollon.c  |    1 +
 arch/arm/mach-omap2/board-generic.c  |    1 +
 arch/arm/mach-omap2/board-h4.c       |    1 +
 arch/arm/mach-omap2/board-n800.c     |    1 +
 arch/arm/plat-omap/common.c          |   21 +++++++++++++++++++++
 include/asm-arm/arch-omap/common.h   |    4 ++++
 include/asm-arm/arch-omap/omap24xx.h |    2 --
 include/asm-arm/arch-omap/omap34xx.h |    1 -
 11 files changed, 32 insertions(+), 3 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/board-n800.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/board-n800.c	2007-11-20 17:10:42.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/board-n800.c	2007-11-20 17:12:45.000000000 -0700
@@ -479,6 +479,7 @@
 	omap_board_config = n800_config;
 	omap_board_config_size = ARRAY_SIZE(n800_config);
 
+	omap2_set_globals_242x();
 	omap2_map_common_io();
 }
 
Index: linux-omap/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap24xx.h	2007-11-20 17:10:42.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/omap24xx.h	2007-11-20 17:12:45.000000000 -0700
@@ -85,7 +85,6 @@
 #define OMAP2_PRM_BASE		OMAP2420_PRM_BASE
 #define OMAP2_SDRC_BASE		OMAP2420_SDRC_BASE
 #define OMAP2_SMS_BASE		OMAP2420_SMS_BASE
-#define OMAP2_L4_BASE		L4_24XX_BASE
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP2_CTRL_BASE		OMAP2420_CTRL_BASE
 
@@ -97,7 +96,6 @@
 #define OMAP2_PRM_BASE		OMAP2430_PRM_BASE
 #define OMAP2_SDRC_BASE		OMAP243X_SDRC_BASE
 #define OMAP2_SMS_BASE		OMAP243X_SMS_BASE
-#define OMAP2_L4_BASE		L4_24XX_BASE
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP2_CTRL_BASE		OMAP243X_CTRL_BASE
 
Index: linux-omap/include/asm-arm/arch-omap/omap34xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap34xx.h	2007-11-20 17:10:42.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/omap34xx.h	2007-11-20 17:12:45.000000000 -0700
@@ -66,7 +66,6 @@
 #define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
 #define OMAP2_SDRC_BASE			OMAP343X_SDRC_BASE
 #define OMAP2_SMS_BASE			OMAP343X_SMS_BASE
-#define OMAP2_L4_BASE			L4_34XX_BASE
 #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
 #define OMAP2_CTRL_BASE			OMAP3430_CTRL_BASE
 #define OMAP34XX_CONTROL_DEVCONF0	(L4_34XX_BASE + 0x2274)
Index: linux-omap/arch/arm/mach-omap2/board-2430sdp.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/board-2430sdp.c	2007-11-20 17:10:42.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/board-2430sdp.c	2007-11-20 17:12:45.000000000 -0700
@@ -392,6 +392,7 @@
 
 static void __init omap_2430sdp_map_io(void)
 {
+	omap2_set_globals_243x();
 	omap2_map_common_io();
 }
 
Index: linux-omap/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/board-3430sdp.c	2007-11-20 17:10:42.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/board-3430sdp.c	2007-11-20 17:12:45.000000000 -0700
@@ -328,6 +328,7 @@
 
 static void __init omap_3430sdp_map_io(void)
 {
+	omap2_set_globals_343x();
 	omap2_map_common_io();
 }
 arch_initcall(omap3430_i2c_init);
Index: linux-omap/arch/arm/mach-omap2/board-apollon.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/board-apollon.c	2007-11-20 17:10:42.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/board-apollon.c	2007-11-20 17:12:45.000000000 -0700
@@ -390,6 +390,7 @@
 
 static void __init omap_apollon_map_io(void)
 {
+	omap2_set_globals_242x();
 	omap2_map_common_io();
 }
 
Index: linux-omap/arch/arm/mach-omap2/board-generic.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/board-generic.c	2007-11-20 17:10:42.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/board-generic.c	2007-11-20 17:12:45.000000000 -0700
@@ -67,6 +67,7 @@
 
 static void __init omap_generic_map_io(void)
 {
+	omap2_set_globals_242x(); /* should be 242x, 243x, or 343x */
 	omap2_map_common_io();
 }
 
Index: linux-omap/arch/arm/mach-omap2/board-h4.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/board-h4.c	2007-11-20 17:10:42.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/board-h4.c	2007-11-20 17:12:45.000000000 -0700
@@ -741,6 +741,7 @@
 
 static void __init omap_h4_map_io(void)
 {
+	omap2_set_globals_242x();
 	omap2_map_common_io();
 }
 
Index: linux-omap/arch/arm/mach-omap2/board-2430osk.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/board-2430osk.c	2007-11-20 17:10:42.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/board-2430osk.c	2007-11-20 17:12:45.000000000 -0700
@@ -125,6 +125,7 @@
 
 static void __init omap_2430osk_map_io(void)
 {
+	omap2_set_globals_243x();
 	omap2_map_common_io();
 }
 
Index: linux-omap/arch/arm/plat-omap/common.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/common.c	2007-11-20 17:10:42.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/common.c	2007-11-20 17:12:45.000000000 -0700
@@ -230,3 +230,24 @@
 arch_initcall(omap_init_clocksource_32k);
 
 #endif	/* TIMER_32K_SYNCHRONIZED */
+
+/* Global address base setup code */
+
+#if defined(CONFIG_ARCH_OMAP2420)
+void __init omap2_set_globals_242x(void)
+{
+}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP2430)
+void __init omap2_set_globals_243x(void)
+{
+}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP3430)
+void __init omap2_set_globals_343x(void)
+{
+}
+#endif
+
Index: linux-omap/include/asm-arm/arch-omap/common.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/common.h	2007-11-20 17:10:42.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/common.h	2007-11-20 17:12:45.000000000 -0700
@@ -44,4 +44,8 @@
 #define omap_register_i2c_bus(...)	do { } while (0)
 #endif
 
+void omap2_set_globals_242x(void);
+void omap2_set_globals_243x(void);
+void omap2_set_globals_343x(void);
+
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */

-- 
