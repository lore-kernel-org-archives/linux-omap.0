From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/7] omap2 arch: fix CONTROL_DEVCONF addresses for OMAP3430
Date: Wed, 19 Sep 2007 15:10:00 -0600
Message-ID: <20070919211138.760254597@pwsan.com>
References: <20070919210959.062447046@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=fix_3430_control_devconf.patch
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

OMAP3430 has two CONTROL_DEVCONF addresses, CONTROL_DEVCONF0 and 
CONTROL_DEVCONF1; define them both.  Also, the existing address for
CONTROL_DEVCONF0 was incorrect; fix it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 include/asm-arm/arch-omap/omap34xx.h |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-omap/include/asm-arm/arch-omap/omap34xx.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/omap34xx.h	2007-09-15 16:49:17.000000000 -0600
+++ linux-omap/include/asm-arm/arch-omap/omap34xx.h	2007-09-15 17:06:38.000000000 -0600
@@ -55,6 +55,12 @@
 
 #if defined(CONFIG_ARCH_OMAP3430)
 
+/*
+ * REVISIT: OMAP3430 has two CONTROL_DEVCONF registers, CONTROL_DEVCONF0
+ * and CONTROL_DEVCONF1.  We should probably split those defines, along
+ * with any other System Control Module registers and read/write fns,
+ * out to a separate scm.h file, and do this for 24xx also.
+ */
 #define OMAP2_32KSYNCT_BASE		OMAP3430_32KSYNCT_BASE
 #define OMAP2_CM_BASE			OMAP3430_CM_BASE
 #define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
@@ -63,7 +69,8 @@
 #define OMAP2_L4_BASE			L4_34XX_BASE
 #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
 #define OMAP2_CTRL_BASE			OMAP3430_CTRL_BASE
-#define OMAP34XX_CONTROL_DEVCONF	(L4_34XX_BASE + 0x274)
+#define OMAP34XX_CONTROL_DEVCONF0	(L4_34XX_BASE + 0x2274)
+#define OMAP34XX_CONTROL_DEVCONF1	(L4_34XX_BASE + 0x22D8)
 
 #endif
 

-- 
