From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/3] omap2: remove SDRC register defines from prcm-regs.h
Date: Wed, 16 May 2007 18:05:39 -0600
Message-ID: <20070517001009.217269478@pwsan.com>
References: <20070517000943.977105773@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0003-omap2-remove-SDRC-register-defines-from-prcm-regs.h.patch
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

Remove SDRC registers from prcm-regs.h, since they are now located in
sdrc.h.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm-regs.h |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-regs.h b/arch/arm/mach-omap2/prcm-regs.h
index b7fc98d..7c9fdca 100644
--- a/arch/arm/mach-omap2/prcm-regs.h
+++ b/arch/arm/mach-omap2/prcm-regs.h
@@ -199,7 +199,6 @@
 #define UART1_SYSCONFIG		__REG32(OMAP24XX_L4_IO_BASE + 0x6A054)
 #define UART2_SYSCONFIG		__REG32(OMAP24XX_L4_IO_BASE + 0x6C054)
 #define UART3_SYSCONFIG		__REG32(OMAP24XX_L4_IO_BASE + 0x6E054)
-#define SDRC_SYSCONFIG		__REG32(SDRC_BASE + 0x10)
 #define OMAP24XX_SMS_BASE	(L3_24XX_BASE + 0x8000)
 #define SMS_SYSCONFIG		__REG32(OMAP24XX_SMS_BASE + 0x10)
 #define SSI_SYSCONFIG		__REG32(DISP_BASE + 0x8010)
@@ -262,14 +261,6 @@
 /* rkw -- base fix up please... */
 #define GPTIMER3_TISR		__REG32(OMAP24XX_L4_IO_BASE + 0x78018)
 
-/* SDRC */
-#define SDRC_DLLA_CTRL		__REG32(SDRC_BASE + 0x060)
-#define SDRC_DLLA_STATUS	__REG32(SDRC_BASE + 0x064)
-#define SDRC_DLLB_CTRL		__REG32(SDRC_BASE + 0x068)
-#define SDRC_DLLB_STATUS	__REG32(SDRC_BASE + 0x06C)
-#define SDRC_POWER		__REG32(SDRC_BASE + 0x070)
-#define SDRC_MR_0		__REG32(SDRC_BASE + 0x084)
-
 /* GPIO 1 */
 #define GPIO1_BASE		GPIOX_BASE(1)
 #define GPIO1_REG32(offset)	__REG32(GPIO1_BASE + (offset))
-- 
1.5.1.3

-- 
