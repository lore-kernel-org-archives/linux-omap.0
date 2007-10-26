From: "Girish" <girishsg@ti.com>
Subject: [PATCH 2/2] silicon revision check for OMAP2/3
Date: Fri, 26 Oct 2007 21:09:18 +0530
Message-ID: <000301c817e6$5f51ea60$6a8918ac@ent.ti.com>
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

This patch adds macro for identifying cpu type and its silicon revision of
OMAP2/3 processors. Also Some code clean up.

Signed-off-by: Girish S G <girishsg@ti.com>
diff --git a/include/asm-arm/arch-omap/cpu.h b/include/asm-arm/arch-omap/cpu.h
index b9399a8..4021389 100644
--- a/include/asm-arm/arch-omap/cpu.h
+++ b/include/asm-arm/arch-omap/cpu.h
@@ -28,7 +28,7 @@
 
 extern unsigned int system_rev;
 
-#define omap2_cpu_rev()		((system_rev >> 8) & 0x0f)
+#define omap2_cpu_rev()		((system_rev >> 12) & 0x0f)
 
 /*
  * Test if multicore OMAP support is needed
@@ -90,7 +90,7 @@ extern unsigned int system_rev;
  * cpu_is_omap243x():	True for OMAP2430
  * cpu_is_omap343x():	True for OMAP3430
  */
-#define GET_OMAP_CLASS	(system_rev & 0xff)
+#define GET_OMAP_CLASS	((system_rev >> 24) & 0xff)
 
 #define IS_OMAP_CLASS(class, id)			\
 static inline int is_omap ##class (void)		\
@@ -181,6 +181,7 @@ IS_OMAP_SUBCLASS(343x, 0x343)
  * cpu_is_omap2422():	True for OMAP2422
  * cpu_is_omap2423():	True for OMAP2423
  * cpu_is_omap2430():	True for OMAP2430
+ * cpu_is_omap3430():	True for OMAP3430
  */
 #define GET_OMAP_TYPE	((system_rev >> 16) & 0xffff)
 
@@ -267,7 +268,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 #if defined(CONFIG_ARCH_OMAP34XX)
 # undef cpu_is_omap3430
-# define cpu_is_omap3430()		is_omap3430()
+#define cpu_is_omap3430()		is_omap3430()
 #endif
 
 /* Macros to detect if we have OMAP1 or OMAP2 */
@@ -275,4 +276,60 @@ IS_OMAP_TYPE(3430, 0x3430)
 				cpu_is_omap16xx())
 #define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx())
 
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+/*
+ * Macros to detect silicon revision of OMAP2/3 processors.
+ * is_sil_rev_greater_than:	true if passed cpu type & its rev is greater.
+ * is_sil_rev_lesser_than:	true if passed cpu type & its rev is lesser.
+ * is_sil_rev_equal_to:		true if passed cpu type & its rev is equal.
+ * get_sil_rev:			return the silicon rev value.
+ */
+
+#define is_sil_rev_greater_than(rev) \
+		(((((system_rev & 0xffff0000) >> 16) == \
+		((rev & 0xffff0000) >> 16)) && 	\
+		(system_rev & 0xf000) >> 12) > ((rev & 0xf000) >> 12))
+#define is_sil_rev_less_than(rev) \
+		(((((system_rev & 0xffff0000) >> 16) == \
+		((rev & 0xffff0000) >> 16)) && 	\
+		(system_rev & 0xf000) >> 12) < ((rev & 0xf000) >> 12))
+#define is_sil_rev_equal_to(rev) \
+		(((((system_rev & 0xffff0000) >> 16) ==	\
+		((rev & 0xffff0000) >> 16)) && \
+		(system_rev & 0xf000) >> 12) == ((rev & 0xf000) >> 12))
+#define get_sil_rev() \
+		((system_rev & 0xf000) >> 12)
+
+/* Various silicon macros defined here */
+#define OMAP2420_REV_ES1_0	0x24200000
+#define OMAP2420_REV_ES2_0	0x24201000
+#define OMAP2430_REV_ES1_0	0x24300000
+#define OMAP3430_REV_ES1_0	0x34300000
+#define OMAP3430_REV_ES2_0	0x34301000
+
+/*
+ * Macro to detect device type i.e. EMU/HS/TST/GP/BAD
+ */
+#define DEVICE_TYPE_TEST	0
+#define DEVICE_TYPE_EMU 	1
+#define DEVICE_TYPE_SEC 	2
+#define DEVICE_TYPE_GP  	3
+#define DEVICE_TYPE_BAD 	4
+
+#define is_device_type_test() \
+		(((system_rev & 0x700) >> 8) == DEVICE_TYPE_TEST)
+#define is_device_type_emu() \
+		(((system_rev & 0x700) >> 8) == DEVICE_TYPE_EMU)
+#define is_device_type_sec() \
+		(((system_rev & 0x700) >> 8) == DEVICE_TYPE_SEC)
+#define is_device_type_gp() \
+		(((system_rev & 0x700) >> 8) == DEVICE_TYPE_GP)
+#define is_device_type_bad() \
+		(((system_rev & 0x700) >> 8) == DEVICE_TYPE_BAD)
+#define get_device_type() \
+		((system_rev & 0x700) >> 8)
+
+
+#endif
+
 #endif
