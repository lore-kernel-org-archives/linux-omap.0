From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/18] omap2: add PRM_BASE/CM_BASE #defines
Date: Wed, 16 May 2007 18:11:41 -0600
Message-ID: <20070517005444.042333876@pwsan.com>
References: <20070517001132.652728079@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0009-omap2-add-PRM_BASE-CM_BASE-defines.patch
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

Add symbolic constants for PRM_BASE and CM_BASE addresses.  On the
2420 and 2430 these are the same, but on later OMAP architectures,
they are different.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 include/asm-arm/arch-omap/omap24xx.h |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-omap/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap24xx.h
+++ linux-omap/include/asm-arm/arch-omap/omap24xx.h
@@ -21,11 +21,15 @@
 #define OMAP2420_CTRL_BASE	L4_24XX_BASE
 #define OMAP2420_32KSYNCT_BASE	(L4_24XX_BASE + 0x4000)
 #define OMAP2420_PRCM_BASE	(L4_24XX_BASE + 0x8000)
+#define OMAP2420_CM_BASE	(L4_24XX_BASE + 0x8000)
+#define OMAP2420_PRM_BASE	OMAP2420_CM_BASE
 #define OMAP2420_SDRC_BASE	(L3_24XX_BASE + 0x9000)
 #define OMAP2420_SMS_BASE	0x68008000
 
 #define OMAP2430_32KSYNCT_BASE	(L4_WK_243X_BASE + 0x20000)
 #define OMAP2430_PRCM_BASE	(L4_WK_243X_BASE + 0x6000)
+#define OMAP2430_CM_BASE	(L4_WK_243X_BASE + 0x6000)
+#define OMAP2430_PRM_BASE	OMAP2430_CM_BASE
 
 #define OMAP243X_SMS_BASE	0x6C000000
 #define OMAP243X_SDRC_BASE	0x6D000000
@@ -52,6 +56,8 @@
 
 #define OMAP_32KSYNCT_BASE	OMAP2420_32KSYNCT_BASE
 #define PRCM_BASE		OMAP2420_PRCM_BASE
+#define CM_BASE			OMAP2420_CM_BASE
+#define PRM_BASE		OMAP2420_PRM_BASE
 #define SDRC_BASE		OMAP2420_SDRC_BASE
 #define SMS_BASE		OMAP2420_SMS_BASE
 #define L4_OMAP_BASE		L4_24XX_BASE
@@ -62,6 +68,8 @@
 
 #define OMAP_32KSYNCT_BASE	OMAP2430_32KSYNCT_BASE
 #define PRCM_BASE		OMAP2430_PRCM_BASE
+#define CM_BASE			OMAP2430_CM_BASE
+#define PRM_BASE		OMAP2430_PRM_BASE
 #define SDRC_BASE		OMAP243X_SDRC_BASE
 #define SMS_BASE		OMAP243X_SMS_BASE
 #define L4_OMAP_BASE		L4_24XX_BASE

-- 
