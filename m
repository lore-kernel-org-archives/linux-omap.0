From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.18-omap] omap2/memory.c compile fixes
Date: Tue, 17 Oct 2006 14:11:31 -0700
Message-ID: <200610171411.31718.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Remove some conflicting declarations in omap2/memory.c so that the
file builds again.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: h4/arch/arm/mach-omap2/memory.c
===================================================================
--- h4.orig/arch/arm/mach-omap2/memory.c	2006-10-13 18:26:36.000000000 -0700
+++ h4/arch/arm/mach-omap2/memory.c	2006-10-13 18:42:22.000000000 -0700
@@ -30,37 +30,6 @@
 #include "prcm-regs.h"
 #include "memory.h"
 
-#define SMS_BASE		0x68008000
-#define SMS_SYSCONFIG		0x010
-
-#define SDRC_BASE		0x68009000
-#define SDRC_SYSCONFIG		0x010
-#define SDRC_SYSSTATUS		0x014
-
-static const u32 sms_base = IO_ADDRESS(SMS_BASE);
-static const u32 sdrc_base = IO_ADDRESS(SDRC_BASE);
-
-
-static inline void sms_write_reg(int idx, u32 val)
-{
-	__raw_writel(val, sms_base + idx);
-}
-
-static inline u32 sms_read_reg(int idx)
-{
-	return __raw_readl(sms_base + idx);
-}
-
-static inline void sdrc_write_reg(int idx, u32 val)
-{
-	__raw_writel(val, sdrc_base + idx);
-}
-
-static inline u32 sdrc_read_reg(int idx)
-{
-	return __raw_readl(sdrc_base + idx);
-}
-
 
 static struct memory_timings mem_timings;
 
@@ -132,18 +101,19 @@ void omap2_init_memory_params(u32 force_
 	mem_timings.slow_dll_ctrl |= ((1 << 1) | (3 << 8));
 }
 
+/* turn on smart idle modes for SDRAM scheduler and controller */
 void __init omap2_init_memory(void)
 {
 	u32 l;
 
-	l = sms_read_reg(SMS_SYSCONFIG);
+	l = SMS_SYSCONFIG;
 	l &= ~(0x3 << 3);
 	l |= (0x2 << 3);
-	sms_write_reg(SMS_SYSCONFIG, l);
+	SMS_SYSCONFIG = l;
 
-	l = sdrc_read_reg(SDRC_SYSCONFIG);
+	l = SDRC_SYSCONFIG;
 	l &= ~(0x3 << 3);
 	l |= (0x2 << 3);
-	sdrc_write_reg(SDRC_SYSCONFIG, l);
+	SDRC_SYSCONFIG = l;
 
 }
