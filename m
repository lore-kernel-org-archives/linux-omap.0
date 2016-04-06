From: Jonas Rabenstein <ve92mose@stud.informatik.uni-erlangen.de>
Subject: [PATCH v3] arm: omap2: remove redundant multiplatform checks
Date: Wed,  6 Apr 2016 10:14:08 +0200
Message-ID: <1459930448-32638-1-git-send-email-ve92mose@stud.informatik.uni-erlangen.de>
References: <201604060526.ouhQYqrT%fengguang.wu@intel.com> <1459895738-6546-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57048FE3.30909@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lokesh Vutla <a0131933@ti.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

The directory arch/arm/mach-omap2 is only selected for compilation if
CONFIG_ARCH_OMAP2PLUS is selected. CONFIG_ARCH_OMAP2PLUS itself is a
silent option and all machines selecting this option are multiplatform
devices. As a consequence checks for CONFIG_ARCH_MULTIPLATFORM as well
as CONFIG_ARCH_OMAP2PLUS within that directory are superfluous and can
be removed.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
change in v3:
 * fix build error with unselected ARCH_OMAP2 and ARCH_OMAP3

 arch/arm/mach-omap2/Makefile |   2 +-
 arch/arm/mach-omap2/soc.h    | 140 +++++++------------------------------------
 2 files changed, 22 insertions(+), 120 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 0ba6a0e..04e276c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
+ccflags-y := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-omap/include
 
 # Common support
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 364418c..2aa01c2 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -39,82 +39,10 @@
 #include <linux/of.h>
 
 /*
- * Test if multicore OMAP support is needed
+ * OMAP2+ is always defined as ARCH_MULTIPLATFORM in Kconfig
  */
 #undef MULTI_OMAP2
-#undef OMAP_NAME
-
-#ifdef CONFIG_ARCH_MULTIPLATFORM
 #define MULTI_OMAP2
-#endif
-#ifdef CONFIG_SOC_OMAP2420
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME omap2420
-# endif
-#endif
-#ifdef CONFIG_SOC_OMAP2430
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME omap2430
-# endif
-#endif
-#ifdef CONFIG_ARCH_OMAP3
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME omap3
-# endif
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME omap4
-# endif
-#endif
-
-#ifdef CONFIG_SOC_OMAP5
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME omap5
-# endif
-#endif
-
-#ifdef CONFIG_SOC_AM33XX
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME am33xx
-# endif
-#endif
-
-#ifdef CONFIG_SOC_AM43XX
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME am43xx
-# endif
-#endif
-
-#ifdef CONFIG_SOC_DRA7XX
-# ifdef OMAP_NAME
-#  undef MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME DRA7XX
-# endif
-#endif
 
 /*
  * Omap device type i.e. EMU/HS/TST/GP/BAD
@@ -242,11 +170,6 @@ IS_AM_SUBCLASS(437x, 0x437)
 IS_DRA_SUBCLASS(75x, 0x75)
 IS_DRA_SUBCLASS(72x, 0x72)
 
-#define soc_is_omap24xx()		0
-#define soc_is_omap242x()		0
-#define soc_is_omap243x()		0
-#define soc_is_omap34xx()		0
-#define soc_is_omap343x()		0
 #define soc_is_ti81xx()			0
 #define soc_is_ti816x()			0
 #define soc_is_ti814x()			0
@@ -265,46 +188,27 @@ IS_DRA_SUBCLASS(72x, 0x72)
 #define soc_is_dra74x()			0
 #define soc_is_dra72x()			0
 
-#if defined(MULTI_OMAP2)
-# if defined(CONFIG_ARCH_OMAP2)
-#  undef  soc_is_omap24xx
-#  define soc_is_omap24xx()		is_omap24xx()
-# endif
-# if defined (CONFIG_SOC_OMAP2420)
-#  undef  soc_is_omap242x
-#  define soc_is_omap242x()		is_omap242x()
-# endif
-# if defined (CONFIG_SOC_OMAP2430)
-#  undef  soc_is_omap243x
-#  define soc_is_omap243x()		is_omap243x()
-# endif
-# if defined(CONFIG_ARCH_OMAP3)
-#  undef  soc_is_omap34xx
-#  undef  soc_is_omap343x
-#  define soc_is_omap34xx()		is_omap34xx()
-#  define soc_is_omap343x()		is_omap343x()
-# endif
+#if defined(CONFIG_ARCH_OMAP2)
+# define soc_is_omap24xx()		is_omap24xx()
 #else
-# if defined(CONFIG_ARCH_OMAP2)
-#  undef  soc_is_omap24xx
-#  define soc_is_omap24xx()		1
-# endif
-# if defined(CONFIG_SOC_OMAP2420)
-#  undef  soc_is_omap242x
-#  define soc_is_omap242x()		1
-# endif
-# if defined(CONFIG_SOC_OMAP2430)
-#  undef  soc_is_omap243x
-#  define soc_is_omap243x()		1
-# endif
-# if defined(CONFIG_ARCH_OMAP3)
-#  undef  soc_is_omap34xx
-#  define soc_is_omap34xx()		1
-# endif
-# if defined(CONFIG_SOC_OMAP3430)
-#  undef  soc_is_omap343x
-#  define soc_is_omap343x()		1
-# endif
+# define soc_is_omap24xx()		0
+#endif
+#if defined(CONFIG_SOC_OMAP2420)
+# define soc_is_omap242x()		is_omap242x()
+#else
+# define soc_is_omap242x()		0
+#endif
+#if defined(CONFIG_SOC_OMAP2430)
+# define soc_is_omap243x()		is_omap243x()
+#else
+# define soc_is_omap243x()		0
+#endif
+#if defined(CONFIG_ARCH_OMAP3)
+# define soc_is_omap34xx()		is_omap34xx()
+# define soc_is_omap343x()		is_omap343x()
+#else
+# define soc_is_omap34xx()		0
+# define soc_is_omap343x()		0
 #endif
 
 /*
@@ -339,7 +243,6 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define soc_is_omap5430()		0
 
 /* These are needed for the common code */
-#ifdef CONFIG_ARCH_OMAP2PLUS
 #define soc_is_omap7xx()		0
 #define soc_is_omap15xx()		0
 #define soc_is_omap16xx()		0
@@ -350,7 +253,6 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define soc_is_omap1710()		0
 #define cpu_class_is_omap1()		0
 #define cpu_class_is_omap2()		1
-#endif
 
 #if defined(CONFIG_ARCH_OMAP2)
 # undef  soc_is_omap2420
-- 
1.9.1
