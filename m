From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] Fix cpu_is_omap343x()
Date: Wed, 28 Nov 2007 18:20:21 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711281817470.9880@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


cpu_is_omap343x() is missing its setup code, and returns 0 on all platforms -
including OMAP343x.  

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 include/asm-arm/arch-omap/cpu.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-omap/include/asm-arm/arch-omap/cpu.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/cpu.h	2007-11-23 17:46:16.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/cpu.h	2007-11-28 17:59:03.000000000 -0700
@@ -122,6 +122,7 @@
 #define cpu_is_omap24xx()		0
 #define cpu_is_omap242x()		0
 #define cpu_is_omap243x()		0
+#define cpu_is_omap34xx()		0
 #define cpu_is_omap343x()		0
 
 #if defined(MULTI_OMAP1)
@@ -160,9 +161,9 @@
 # endif
 # if defined(CONFIG_ARCH_OMAP34XX)
 #  undef  cpu_is_omap34xx
+#  undef  cpu_is_omap343x
 #  define cpu_is_omap34xx()		1
-# else
-#  define cpu_is_omap34xx()		0
+#  define cpu_is_omap343x()		is_omap343x()
 # endif
 #endif
 
