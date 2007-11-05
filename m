From: "Girish" <girishsg@ti.com>
Subject: [PATCH 2/3: Resending] silicon revision check for OMAP2/3
Date: Mon, 5 Nov 2007 16:42:32 +0530
Message-ID: <012001c81f9c$c3a922e0$6a8918ac@ent.ti.com>
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

Hi,
Comments fixed. 
This patch is in the series of "[PATCH Resending 0/3]OMAP:id/silicon rev check and omap24xx.h cleanup".

This patch adds macro for identifying 3430 cpu type and silicon revision of OMAP2/3 processors as well.

Signed-off-by: Girish S G <girishsg@ti.com>
---
 include/asm-arm/arch-omap/cpu.h |   62 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 60 insertions(+), 2 deletions(-)

Index: linux-omap-git/include/asm-arm/arch-omap/cpu.h
===================================================================
--- linux-omap-git.orig/include/asm-arm/arch-omap/cpu.h	2007-11-02 19:32:55.000000000 +0530
+++ linux-omap-git/include/asm-arm/arch-omap/cpu.h	2007-11-05 16:30:49.000000000 +0530
@@ -28,7 +28,7 @@
 
 extern unsigned int system_rev;
 
-#define omap2_cpu_rev()		((system_rev >> 8) & 0x0f)
+#define omap2_cpu_rev()		((system_rev >> 12) & 0x0f)
 
 /*
  * Test if multicore OMAP support is needed
@@ -90,7 +90,7 @@
  * cpu_is_omap243x():	True for OMAP2430
  * cpu_is_omap343x():	True for OMAP3430
  */
-#define GET_OMAP_CLASS	(system_rev & 0xff)
+#define GET_OMAP_CLASS	((system_rev >> 24) & 0xff)
 
 #define IS_OMAP_CLASS(class, id)			\
 static inline int is_omap ##class (void)		\
@@ -181,6 +181,7 @@
  * cpu_is_omap2422():	True for OMAP2422
  * cpu_is_omap2423():	True for OMAP2423
  * cpu_is_omap2430():	True for OMAP2430
+ * cpu_is_omap3430():	True for OMAP3430
  */
 #define GET_OMAP_TYPE	((system_rev >> 16) & 0xffff)
 
@@ -275,4 +276,61 @@
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
+#define get_sil_omap_type(rev)	((rev & 0xffff0000) >> 16)
+#define get_sil_revision(rev)	((rev & 0x00000f000) >> 12)
+
+#define is_sil_rev_greater_than(rev) \
+		((get_sil_omap_type(system_rev) == get_sil_omap_type(rev)) && \
+		(get_sil_revision(system_rev) > get_sil_revision(rev)))
+
+#define is_sil_rev_less_than(rev) \
+		((get_sil_omap_type(system_rev) == get_sil_omap_type(rev)) && \
+		(get_sil_revision(system_rev) < get_sil_revision(rev)))
+
+#define is_sil_rev_equal_to(rev) \
+		((get_sil_omap_type(system_rev) == get_sil_omap_type(rev)) && \
+		(get_sil_revision(system_rev) == get_sil_revision(rev)))
+
+#define get_sil_rev() \
+		get_sil_revision(system_rev)
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
+#define get_device_type()	\
+		((system_rev & 0x700) >> 8)
+#define is_device_type_test()	\
+		(get_device_type() == DEVICE_TYPE_TEST)
+#define is_device_type_emu()	\
+		(get_device_type() == DEVICE_TYPE_EMU)
+#define is_device_type_sec()	\
+		(get_device_type() == DEVICE_TYPE_SEC)
+#define is_device_type_gp()	\
+		(get_device_type() == DEVICE_TYPE_GP)
+#define is_device_type_bad()	\
+		(get_device_type() == DEVICE_TYPE_BAD)
+
+#endif
+
 #endif
