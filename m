From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] omap2: convert existing SDRC register users to use
	sdrc.h
Date: Wed, 16 May 2007 18:05:38 -0600
Message-ID: <20070517001009.129045161@pwsan.com>
References: <20070517000943.977105773@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0002-omap2-convert-existing-SDRC-register-users-to-use-s.patch
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

Convert files that use SDRC registers in mach-omap2/ to use sdrc.h
symbolic constants and sdrc_{read,write}_reg().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c  |    4 +++-
 arch/arm/mach-omap2/memory.c |   21 +++++++++++----------
 arch/arm/mach-omap2/pm.c     |    7 ++++---
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d60d171..1d02406 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -32,6 +32,7 @@
 #include "prcm-regs.h"
 #include "memory.h"
 #include "clock.h"
+#include "sdrc.h"
 
 #undef DEBUG
 
@@ -447,7 +448,8 @@ static long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
  */
 static u32 omap2_dll_force_needed(void)
 {
-	u32 dll_state = SDRC_DLLA_CTRL;		/* dlla and dllb are a set */
+	/* dlla and dllb are a set */
+	u32 dll_state = sdrc_read_reg(SDRC_DLLA_CTRL);
 
 	if ((dll_state & (1 << 2)) == (1 << 2))
 		return 1;
diff --git a/arch/arm/mach-omap2/memory.c b/arch/arm/mach-omap2/memory.c
index 3e5d8cd..7b44a96 100644
--- a/arch/arm/mach-omap2/memory.c
+++ b/arch/arm/mach-omap2/memory.c
@@ -27,9 +27,10 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
 
-#include "prcm-regs.h"
 #include "memory.h"
+#include "sdrc.h"
 
+#define SMS_SYSCONFIG			(SMS_BASE + 0x010)
 
 static struct memory_timings mem_timings;
 
@@ -53,7 +54,7 @@ void omap2_init_memory_params(u32 force_lock_to_unlock_mode)
 	unsigned long dll_cnt;
 	u32 fast_dll = 0;
 
-	mem_timings.m_type = !((SDRC_MR_0 & 0x3) == 0x1); /* DDR = 1, SDR = 0 */
+	mem_timings.m_type = !((sdrc_read_reg(SDRC_MR_0) & 0x3) == 0x1); /* DDR = 1, SDR = 0 */
 
 	/* 2422 es2.05 and beyond has a single SIP DDR instead of 2 like others.
 	 * In the case of 2422, its ok to use CS1 instead of CS0.
@@ -73,11 +74,11 @@ void omap2_init_memory_params(u32 force_lock_to_unlock_mode)
 		mem_timings.dll_mode = M_LOCK;
 
 	if (mem_timings.base_cs == 0) {
-		fast_dll = SDRC_DLLA_CTRL;
-		dll_cnt = SDRC_DLLA_STATUS & 0xff00;
+		fast_dll = sdrc_read_reg(SDRC_DLLA_CTRL);
+		dll_cnt = sdrc_read_reg(SDRC_DLLA_STATUS) & 0xff00;
 	} else {
-		fast_dll = SDRC_DLLB_CTRL;
-		dll_cnt = SDRC_DLLB_STATUS & 0xff00;
+		fast_dll = sdrc_read_reg(SDRC_DLLB_CTRL);
+		dll_cnt = sdrc_read_reg(SDRC_DLLB_STATUS) & 0xff00;
 	}
 	if (force_lock_to_unlock_mode) {
 		fast_dll &= ~0xff00;
@@ -106,14 +107,14 @@ void __init omap2_init_memory(void)
 {
 	u32 l;
 
-	l = SMS_SYSCONFIG;
+	l = omap_readl(SMS_SYSCONFIG);
 	l &= ~(0x3 << 3);
 	l |= (0x2 << 3);
-	SMS_SYSCONFIG = l;
+	omap_writel(l, SMS_SYSCONFIG);
 
-	l = SDRC_SYSCONFIG;
+	l = sdrc_read_reg(SDRC_SYSCONFIG);
 	l &= ~(0x3 << 3);
 	l |= (0x2 << 3);
-	SDRC_SYSCONFIG = l;
+	sdrc_write_reg(l, SDRC_SYSCONFIG);
 
 }
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 887c95d..931ad86 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -46,6 +46,8 @@
 #include <asm/arch/board.h>
 #include <asm/arch/gpio.h>
 
+#include "sdrc.h"
+
 #define PRCM_REVISION		0x000
 #define PRCM_SYSCONFIG		0x010
 #define PRCM_IRQSTATUS_MPU	0x018
@@ -141,7 +143,7 @@
 #define PM_PWSTST_DSP		0x8e4
 
 static void (*omap2_sram_idle)(void);
-static void (*omap2_sram_suspend)(int dllctrl);
+static void (*omap2_sram_suspend)(void __iomem *dllctrl);
 static void (*saved_idle)(void);
 
 static u32 prcm_base = IO_ADDRESS(PRCM_BASE);
@@ -438,7 +440,6 @@ static struct subsys_attribute sleep_while_idle_attr = {
 static struct clk *osc_ck, *emul_ck;
 
 #define CONTROL_DEVCONF		__REG32(0x48000274)
-#define SDRC_DLLA_CTRL		__REG32(0x68009060)
 
 static int omap2_fclks_active(void)
 {
@@ -516,7 +517,7 @@ static void omap2_enter_full_retention(void)
 
 	serial_console_sleep(1);
 	/* Jump to SRAM suspend code */
-	omap2_sram_suspend(SDRC_DLLA_CTRL);
+	omap2_sram_suspend(OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
 no_sleep:
 	serial_console_sleep(0);
 
-- 
1.5.1.3

-- 
