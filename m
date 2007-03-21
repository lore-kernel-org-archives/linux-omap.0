From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 2/2] ARM: OMAP: Fix PRCM base register usage for 243x
Date: Tue, 20 Mar 2007 17:07:50 -0700
Message-ID: <20070321000827.284905000@mvista.com>
References: <20070321000748.659921000@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=prcm-base.patch
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

The PRCM base register is different on 242x and 243x.  Use
the #ifdef'd #define from omap24xx.h instead of the locally
defined one.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/mach-omap2/pm.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: dev/arch/arm/mach-omap2/pm.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/pm.c
+++ dev/arch/arm/mach-omap2/pm.c
@@ -51,7 +51,6 @@
 #include <asm/arch/dma.h>
 #include <asm/arch/board.h>
 
-#define PRCM_BASE		0x48008000
 #define PRCM_REVISION		0x000
 #define PRCM_SYSCONFIG		0x010
 #define PRCM_IRQSTATUS_MPU	0x018
@@ -150,7 +149,7 @@ static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(int dllctrl);
 static void (*saved_idle)(void);
 
-static u32 prcm_base = IO_ADDRESS(PRCM_BASE);
+static u32 prcm_base = IO_ADDRESS(OMAP24XX_PRCM_BASE);
 
 static inline void prcm_write_reg(int idx, u32 val)
 {

--
