From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/8] ARM: OMAP: Remove plat/io.h by moving it into
 mach/io.h
Date: Fri, 24 Feb 2012 10:22:46 -0800
Message-ID: <20120224182246.GL18185@atomide.com>
References: <20120221233619.18709.87982.stgit@kaulin.local>
 <20120221234049.18709.28987.stgit@kaulin.local>
 <4F4451FB.7070007@gmail.com>
 <20120224000657.GJ18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61291 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755878Ab2BXSWv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 13:22:51 -0500
Content-Disposition: inline
In-Reply-To: <20120224000657.GJ18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>

* Tony Lindgren <tony@atomide.com> [120223 15:36]:
> * Rob Herring <robherring2@gmail.com> [120221 17:53]:
> > On 02/21/2012 05:40 PM, Tony Lindgren wrote:
> > > +
> > > +/*
> > > + * NOTE: Please use ioremap + __raw_read/write where possible instead of these
> > > + */
> > > +
> > > +extern u8 omap_readb(u32 pa);
> > > +extern u16 omap_readw(u32 pa);
> > > +extern u32 omap_readl(u32 pa);
> > > +extern void omap_writeb(u8 v, u32 pa);
> > > +extern void omap_writew(u16 v, u32 pa);
> > > +extern void omap_writel(u32 v, u32 pa);
> > 
> > These can't be moved to common.h like omap2?
> 
> Not for omap1 currently because a bunch of legacy drivers are
> using them :(

Looks like we can have them in mach-omap1/include/mach/hardware.h.

Eventually the SoC specific hardware.h files could be renamed to
just something like omap1.h, omap2plus.h and so. And then they
could be included in the common hardware.h.

Updated patch below, now io.h for both omap1 and omap2+ are
minimized, and turns out only minimal driver changes were needed.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Fri, 24 Feb 2012 09:05:43 -0800
Subject: [PATCH] ARM: OMAP: Remove plat/io.h by splitting it into mach/io.h and mach/hardware.h

This is needed to minimize io.h so the SoC specific io.h
for ARMs can removed.

Note that minimal driver changes for DSS and RNG are needed to
include cpu.h for SoC detection macros.

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 0e8c176..67382dd 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 
@@ -26,6 +27,8 @@
 #include <plat/sram.h>
 #include <plat/clkdev_omap.h>
 
+#include <mach/hardware.h>
+
 #include "iomap.h"
 #include "clock.h"
 #include "opp.h"
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 10b7451..c6ce93f 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
@@ -27,6 +28,8 @@
 #include <plat/sram.h>	/* for omap_sram_reprogram_clock() */
 #include <plat/usb.h>   /* for OTG_BASE */
 
+#include <mach/hardware.h>
+
 #include "iomap.h"
 #include "clock.h"
 
diff --git a/arch/arm/mach-omap1/flash.c b/arch/arm/mach-omap1/flash.c
index 98d29a0..f9bf78d 100644
--- a/arch/arm/mach-omap1/flash.c
+++ b/arch/arm/mach-omap1/flash.c
@@ -13,6 +13,8 @@
 #include <plat/tc.h>
 #include <plat/flash.h>
 
+#include <mach/hardware.h>
+
 void omap1_set_vpp(struct platform_device *pdev, int enable)
 {
 	static int count;
diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index 7483db2..f24c1e2 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -18,6 +18,8 @@
 
 #include <plat/cpu.h>
 
+#include <mach/hardware.h>
+
 #define OMAP_DIE_ID_0		0xfffe1800
 #define OMAP_DIE_ID_1		0xfffe1804
 #define OMAP_PRODUCTION_ID_0	0xfffe2000
diff --git a/arch/arm/mach-omap1/include/mach/hardware.h b/arch/arm/mach-omap1/include/mach/hardware.h
index a3f6287..01e35fa 100644
--- a/arch/arm/mach-omap1/include/mach/hardware.h
+++ b/arch/arm/mach-omap1/include/mach/hardware.h
@@ -2,4 +2,40 @@
  * arch/arm/mach-omap1/include/mach/hardware.h
  */
 
+#ifndef __MACH_HARDWARE_H
+#define __MACH_HARDWARE_H
+
+#ifndef __ASSEMBLER__
+/*
+ * NOTE: Please use ioremap + __raw_read/write where possible instead of these
+ */
+extern u8 omap_readb(u32 pa);
+extern u16 omap_readw(u32 pa);
+extern u32 omap_readl(u32 pa);
+extern void omap_writeb(u8 v, u32 pa);
+extern void omap_writew(u16 v, u32 pa);
+extern void omap_writel(u32 v, u32 pa);
+
+#include <plat/tc.h>
+
+/* Almost all documentation for chip and board memory maps assumes
+ * BM is clear.  Most devel boards have a switch to control booting
+ * from NOR flash (using external chipselect 3) rather than mask ROM,
+ * which uses BM to interchange the physical CS0 and CS3 addresses.
+ */
+static inline u32 omap_cs0m_phys(void)
+{
+	return (omap_readl(EMIFS_CONFIG) & OMAP_EMIFS_CONFIG_BM)
+			?  OMAP_CS3_PHYS : 0;
+}
+
+static inline u32 omap_cs3_phys(void)
+{
+	return (omap_readl(EMIFS_CONFIG) & OMAP_EMIFS_CONFIG_BM)
+			? 0 : OMAP_CS3_PHYS;
+}
+
+#endif
+#endif
+
 #include <plat/hardware.h>
diff --git a/arch/arm/mach-omap1/include/mach/io.h b/arch/arm/mach-omap1/include/mach/io.h
index 57bdf74..37b12e1 100644
--- a/arch/arm/mach-omap1/include/mach/io.h
+++ b/arch/arm/mach-omap1/include/mach/io.h
@@ -1,5 +1,46 @@
 /*
  * arch/arm/mach-omap1/include/mach/io.h
+ *
+ * IO definitions for TI OMAP processors and boards
+ *
+ * Copied from arch/arm/mach-sa1100/include/mach/io.h
+ * Copyright (C) 1997-1999 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Modifications:
+ *  06-12-1997	RMK	Created.
+ *  07-04-1999	RMK	Major cleanup
  */
 
-#include <plat/io.h>
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+/*
+ * We don't actually have real ISA nor PCI buses, but there is so many
+ * drivers out there that might just work if we fake them...
+ */
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
+
+#endif
diff --git a/arch/arm/mach-omap1/include/mach/memory.h b/arch/arm/mach-omap1/include/mach/memory.h
index c633764..901082d 100644
--- a/arch/arm/mach-omap1/include/mach/memory.h
+++ b/arch/arm/mach-omap1/include/mach/memory.h
@@ -18,7 +18,8 @@
  * Note that the is_lbus_device() test is not very efficient on 1510
  * because of the strncmp().
  */
-#ifdef CONFIG_ARCH_OMAP15XX
+#if defined(CONFIG_ARCH_OMAP15XX) && !defined(__ASSEMBLER__)
+#include <plat/cpu.h>
 
 /*
  * OMAP-1510 Local Bus address offset
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 39f9d5a..7072e0d 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -33,6 +33,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 
+#include <plat/cpu.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index e069a9b..cd7fd0f 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -22,6 +22,7 @@
 #include <asm/div64.h>
 
 #include <plat/clock.h>
+#include <plat/cpu.h>
 
 #include "clock.h"
 #include "cm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index b1f3e7c..bace930 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -14,9 +14,11 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/list.h>
 
+#include <plat/hardware.h>
 #include <plat/clkdev_omap.h>
 
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/clock2430.c b/arch/arm/mach-omap2/clock2430.c
index 0caf792..dfda9a3 100644
--- a/arch/arm/mach-omap2/clock2430.c
+++ b/arch/arm/mach-omap2/clock2430.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <plat/hardware.h>
 #include <plat/clock.h>
 
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 9a061ff..3b4d09a 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/list.h>
 
+#include <plat/hardware.h>
 #include <plat/clkdev_omap.h>
 
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 80bb0f0..1250009 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <plat/cpu.h>
 #include <plat/clock.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index 952c3e0..794d827 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <plat/hardware.h>
 #include <plat/clock.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index f78ec4e..09ca9e9 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -242,5 +242,15 @@ struct omap_sdrc_params;
 extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1);
 
+/*
+ * NOTE: Please use ioremap + __raw_read/write where possible instead of these
+ */
+extern u8 omap_readb(u32 pa);
+extern u16 omap_readw(u32 pa);
+extern u32 omap_readl(u32 pa);
+extern void omap_writeb(u8 v, u32 pa);
+extern void omap_writew(u16 v, u32 pa);
+extern void omap_writel(u32 v, u32 pa);
+
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 8ad210b..386dec8 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -16,6 +16,7 @@
 
 #include <asm/mach/flash.h>
 
+#include <plat/cpu.h>
 #include <plat/nand.h>
 #include <plat/board.h>
 #include <plat/gpmc.h>
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 5cdce10..385b3e0 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -18,6 +18,7 @@
 
 #include <asm/mach/flash.h>
 
+#include <plat/cpu.h>
 #include <plat/onenand.h>
 #include <plat/board.h>
 #include <plat/gpmc.h>
diff --git a/arch/arm/mach-omap2/include/mach/io.h b/arch/arm/mach-omap2/include/mach/io.h
index fd78f31..b8758c8 100644
--- a/arch/arm/mach-omap2/include/mach/io.h
+++ b/arch/arm/mach-omap2/include/mach/io.h
@@ -1,5 +1,49 @@
 /*
  * arch/arm/mach-omap2/include/mach/io.h
+ *
+ * IO definitions for TI OMAP processors and boards
+ *
+ * Copied from arch/arm/mach-sa1100/include/mach/io.h
+ * Copyright (C) 1997-1999 Russell King
+ *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Modifications:
+ *  06-12-1997	RMK	Created.
+ *  07-04-1999	RMK	Major cleanup
  */
 
-#include <plat/io.h>
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+/*
+ * We don't actually have real ISA nor PCI buses, but there is so many
+ * drivers out there that might just work if we fake them...
+ */
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
+
+#endif
diff --git a/arch/arm/mach-omap2/opp2420_data.c b/arch/arm/mach-omap2/opp2420_data.c
index e6dda69..5037e76 100644
--- a/arch/arm/mach-omap2/opp2420_data.c
+++ b/arch/arm/mach-omap2/opp2420_data.c
@@ -28,6 +28,8 @@
  *     http://repository.maemo.org/pool/diablo/free/k/kernel-source-diablo/
  */
 
+#include <plat/hardware.h>
+
 #include "opp2xxx.h"
 #include "sdrc.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/opp2430_data.c b/arch/arm/mach-omap2/opp2430_data.c
index 1b9596a..750805c 100644
--- a/arch/arm/mach-omap2/opp2430_data.c
+++ b/arch/arm/mach-omap2/opp2430_data.c
@@ -26,6 +26,8 @@
  * This is technically part of the OMAP2xxx clock code.
  */
 
+#include <plat/hardware.h>
+
 #include "opp2xxx.h"
 #include "sdrc.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index ac0d629..894ed2d 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -26,7 +26,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
-#include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/time.h>
 #include <linux/gpio.h>
@@ -42,7 +41,6 @@
 
 #include <mach/irqs.h>
 
-#include "iomap.h"
 #include "common.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index b760fec..1f62f23 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -26,6 +26,7 @@
 
 #include <asm/assembler.h>
 
+#include <plat/hardware.h>
 #include <plat/sram.h>
 
 #include "iomap.h"
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 5f0f229..5068fe5 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -21,6 +21,7 @@
 
 #include <asm/sched_clock.h>
 
+#include <plat/hardware.h>
 #include <plat/common.h>
 #include <plat/board.h>
 
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 002fb4d..95c3ed6 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -164,6 +164,8 @@ static inline void set_gdma_dev(int req, int dev)
 }
 #else
 #define set_gdma_dev(req, dev)	do {} while (0)
+#define omap_readl(reg)		0
+#define omap_writel(val, reg)	do {} while (0)
 #endif
 
 void omap_set_dma_priority(int lch, int dst_port, int priority)
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index af3b92b..2678260 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -43,6 +43,8 @@
 
 #include <plat/dmtimer.h>
 
+#include <mach/hardware.h>
+
 static LIST_HEAD(omap_timer_list);
 static DEFINE_SPINLOCK(dm_timer_lock);
 
diff --git a/arch/arm/plat-omap/include/plat/hardware.h b/arch/arm/plat-omap/include/plat/hardware.h
index e897978..537b05a 100644
--- a/arch/arm/plat-omap/include/plat/hardware.h
+++ b/arch/arm/plat-omap/include/plat/hardware.h
@@ -43,6 +43,12 @@
 #endif
 #include <plat/serial.h>
 
+#ifdef __ASSEMBLER__
+#define IOMEM(x)		(x)
+#else
+#define IOMEM(x)		((void __force __iomem *)(x))
+#endif
+
 /*
  * ---------------------------------------------------------------------------
  * Common definitions for all OMAP processors
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
deleted file mode 100644
index 93261d9..0000000
--- a/arch/arm/plat-omap/include/plat/io.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/io.h
- *
- * IO definitions for TI OMAP processors and boards
- *
- * Copied from arch/arm/mach-sa1100/include/mach/io.h
- * Copyright (C) 1997-1999 Russell King
- *
- * Copyright (C) 2009 Texas Instruments
- * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Modifications:
- *  06-12-1997	RMK	Created.
- *  07-04-1999	RMK	Major cleanup
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#include <mach/hardware.h>
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-/*
- * We don't actually have real ISA nor PCI buses, but there is so many
- * drivers out there that might just work if we fake them...
- */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-/*
- * ----------------------------------------------------------------------------
- * I/O mapping
- * ----------------------------------------------------------------------------
- */
-
-#ifdef __ASSEMBLER__
-#define IOMEM(x)		(x)
-#else
-#define IOMEM(x)		((void __force __iomem *)(x))
-#endif
-
-/*
- * ----------------------------------------------------------------------------
- * Omap specific register access
- * ----------------------------------------------------------------------------
- */
-
-#ifndef __ASSEMBLER__
-
-/*
- * NOTE: Please use ioremap + __raw_read/write where possible instead of these
- */
-
-extern u8 omap_readb(u32 pa);
-extern u16 omap_readw(u32 pa);
-extern u32 omap_readl(u32 pa);
-extern void omap_writeb(u8 v, u32 pa);
-extern void omap_writew(u16 v, u32 pa);
-extern void omap_writel(u32 v, u32 pa);
-
-#endif
-
-#endif
diff --git a/arch/arm/plat-omap/include/plat/tc.h b/arch/arm/plat-omap/include/plat/tc.h
index 83b850f..1b4b2da 100644
--- a/arch/arm/plat-omap/include/plat/tc.h
+++ b/arch/arm/plat-omap/include/plat/tc.h
@@ -84,25 +84,6 @@
 #define EMIFS_CCS(n)		(EMIFS_CS0_CONFIG + (4 * (n)))
 #define EMIFS_ACS(n)		(EMIFS_ACS0 + (4 * (n)))
 
-/* Almost all documentation for chip and board memory maps assumes
- * BM is clear.  Most devel boards have a switch to control booting
- * from NOR flash (using external chipselect 3) rather than mask ROM,
- * which uses BM to interchange the physical CS0 and CS3 addresses.
- */
-#ifdef CONFIG_ARCH_OMAP1
-static inline u32 omap_cs0m_phys(void)
-{
-	return (omap_readl(EMIFS_CONFIG) & OMAP_EMIFS_CONFIG_BM)
-			?  OMAP_CS3_PHYS : 0;
-}
-
-static inline u32 omap_cs3_phys(void)
-{
-	return (omap_readl(EMIFS_CONFIG) & OMAP_EMIFS_CONFIG_BM)
-			? 0 : OMAP_CS3_PHYS;
-}
-#endif
-
 #endif	/* __ASSEMBLER__ */
 
 #endif	/* __ASM_ARCH_TC_H */
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
index 0d4aa0d..cff8712 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -26,8 +26,11 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
-#include <asm/system.h>
 #include <linux/spinlock.h>
+
+#include <asm/system.h>
+
+#include <plat/cpu.h>
 #include <plat/mux.h>
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index f357088..d2bbfd1 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -29,6 +29,10 @@
 #include <plat/usb.h>
 #include <plat/board.h>
 
+#include <mach/hardware.h>
+
+#include "../mach-omap2/common.h"
+
 #ifdef	CONFIG_ARCH_OMAP_OTG
 
 void __init
diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index b757fac..a07a5ca 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -26,6 +26,8 @@
 
 #include <asm/io.h>
 
+#include <plat/cpu.h>
+
 #define RNG_OUT_REG		0x00		/* Output register */
 #define RNG_STAT_REG		0x04		/* Status register
 							[0] = STAT_BUSY */
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 77c2b5a..e6af875 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -33,7 +33,10 @@
 #include <linux/pm_runtime.h>
 
 #include <video/omapdss.h>
+
+#include <plat/cpu.h>
 #include <plat/clock.h>
+
 #include "dss.h"
 #include "dss_features.h"
 
