From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 2/2] ARM: OMAP: Update 32k sync timer for OMAP3
Date: Tue, 13 Nov 2007 14:45:43 -0800
Message-ID: <20071113224627.025687345@mvista.com>
References: <20071113224541.567151514@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=omap3-32k-sync-support.patch
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

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/plat-omap/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: dev/arch/arm/plat-omap/common.c
===================================================================
--- dev.orig/arch/arm/plat-omap/common.c
+++ dev/arch/arm/plat-omap/common.c
@@ -191,7 +191,7 @@ console_initcall(omap_add_serial_console
 
 #if defined(CONFIG_ARCH_OMAP16XX)
 #define TIMER_32K_SYNCHRONIZED		0xfffbc410
-#elif defined(CONFIG_ARCH_OMAP24XX)
+#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define TIMER_32K_SYNCHRONIZED		(OMAP2_32KSYNCT_BASE + 0x10)
 #endif
 

--
