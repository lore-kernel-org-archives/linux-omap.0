From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/18] omap2: add OMAP2_PRM_BASE/OMAP2_CM_BASE #defines
Date: Fri, 25 May 2007 02:23:25 -0600
Message-ID: <20070525082501.414021098@pwsan.com>
References: <20070525082322.168056647@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0003-omap2-add-OMAP2_PRM_BASE-OMAP2_CM_BASE-defines.patch
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

Add symbolic constants for OMAP2_PRM_BASE and OMAP2_CM_BASE addresses.
On the 2420 and 2430 these are the same, but on later OMAP
architectures, they are different.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 include/asm-arm/arch-omap/omap24xx.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/asm-arm/arch-omap/omap24xx.h b/include/asm-arm/arch-omap/omap24xx.h
index 174a321..a1cdf30 100644
--- a/include/asm-arm/arch-omap/omap24xx.h
+++ b/include/asm-arm/arch-omap/omap24xx.h
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
 
 #define OMAP2_32KSYNCT_BASE	OMAP2420_32KSYNCT_BASE
 #define OMAP2_PRCM_BASE		OMAP2420_PRCM_BASE
+#define OMAP2_CM_BASE		OMAP2420_CM_BASE
+#define OMAP2_PRM_BASE		OMAP2420_PRM_BASE
 #define OMAP2_SDRC_BASE		OMAP2420_SDRC_BASE
 #define OMAP2_SMS_BASE		OMAP2420_SMS_BASE
 #define OMAP2_L4_BASE		L4_24XX_BASE
@@ -62,6 +68,8 @@
 
 #define OMAP2_32KSYNCT_BASE	OMAP2430_32KSYNCT_BASE
 #define OMAP2_PRCM_BASE		OMAP2430_PRCM_BASE
+#define OMAP2_CM_BASE		OMAP2430_CM_BASE
+#define OMAP2_PRM_BASE		OMAP2430_PRM_BASE
 #define OMAP2_SDRC_BASE		OMAP243X_SDRC_BASE
 #define OMAP2_SMS_BASE		OMAP243X_SMS_BASE
 #define OMAP2_L4_BASE		L4_24XX_BASE
-- 
1.5.1.3

-- 
