From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/8] ARM: OMAP2+: Move most of plat/io.h into local
 iomap.h
Date: Thu, 23 Feb 2012 15:46:17 -0800
Message-ID: <20120223234617.GI18185@atomide.com>
References: <20120221233619.18709.87982.stgit@kaulin.local>
 <20120221234046.18709.13863.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:28559 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756086Ab2BWXqW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 18:46:22 -0500
Content-Disposition: inline
In-Reply-To: <20120221234046.18709.13863.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120221 15:09]:
> There's no need to have these defines in plat/io.h.
> 
> Note that we now need to ifdef omap_read/write calls
> as they will be available for omap1 only.
> 
> While at it, clean up the includes to group them like
> they typically are grouped.

This one updated with the license too for iomap.h and
added include iomap.h for emu.c that may cause errors
with some .config files otherwise.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Feb 2012 14:52:40 -0800
Subject: [PATCH] ARM: OMAP2+: Move most of plat/io.h into local iomap.h

There's no need to have these defines in plat/io.h.

Note that we now need to ifdef omap_read/write calls
as they will be available for omap1 only.

While at it, clean up the includes to group them like
they typically are grouped.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 61ad385..b1f3e7c 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -19,6 +19,7 @@
 
 #include <plat/clkdev_omap.h>
 
+#include "iomap.h"
 #include "clock.h"
 #include "clock2xxx.h"
 #include "opp2xxx.h"
diff --git a/arch/arm/mach-omap2/clock2430.c b/arch/arm/mach-omap2/clock2430.c
index d87bc9c..0caf792 100644
--- a/arch/arm/mach-omap2/clock2430.c
+++ b/arch/arm/mach-omap2/clock2430.c
@@ -23,6 +23,7 @@
 
 #include <plat/clock.h>
 
+#include "iomap.h"
 #include "clock.h"
 #include "clock2xxx.h"
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 0cc1287..9a061ff 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -19,6 +19,7 @@
 
 #include <plat/clkdev_omap.h>
 
+#include "iomap.h"
 #include "clock.h"
 #include "clock2xxx.h"
 #include "opp2xxx.h"
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d75e5f6..981b9f9 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -20,14 +20,15 @@
 #include <linux/clk.h>
 #include <linux/list.h>
 
+#include <plat/hardware.h>
 #include <plat/clkdev_omap.h>
 
+#include "iomap.h"
 #include "clock.h"
 #include "clock3xxx.h"
 #include "clock34xx.h"
 #include "clock36xx.h"
 #include "clock3517.h"
-
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
 #include "prm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 08e86d7..79b98f2 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -26,8 +26,11 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/clk.h>
+
+#include <plat/hardware.h>
 #include <plat/clkdev_omap.h>
 
+#include "iomap.h"
 #include "clock.h"
 #include "clock44xx.h"
 #include "cm1_44xx.h"
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index 04d39cd..c79ed63 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -18,8 +18,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include "iomap.h"
 #include "common.h"
-
 #include "cm.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/cm44xx.c b/arch/arm/mach-omap2/cm44xx.c
index 6a83630..535d66e 100644
--- a/arch/arm/mach-omap2/cm44xx.c
+++ b/arch/arm/mach-omap2/cm44xx.c
@@ -18,8 +18,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include "iomap.h"
 #include "common.h"
-
 #include "cm.h"
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 6204dea..bd8810c 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -20,8 +20,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include "iomap.h"
 #include "common.h"
-
 #include "cm.h"
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index aaf4211..93419de 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -17,12 +17,12 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include "common.h"
 #include <plat/board.h>
 #include <plat/mux.h>
-
 #include <plat/clock.h>
 
+#include "iomap.h"
+#include "common.h"
 #include "sdrc.h"
 #include "control.h"
 
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 114c037..2fd5fd1 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -15,9 +15,10 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include "common.h"
 #include <plat/sdrc.h>
 
+#include "iomap.h"
+#include "common.h"
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
 #include "prm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index 0ba68d3..03149de 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -16,7 +16,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CONTROL_H
 #define __ARCH_ARM_MACH_OMAP2_CONTROL_H
 
-#include <mach/io.h>
 #include <mach/ctrl_module_core_44xx.h>
 #include <mach/ctrl_module_wkup_44xx.h>
 #include <mach/ctrl_module_pad_core_44xx.h>
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 0b510ad..807699b 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -24,7 +24,7 @@
 #include <asm/mach/map.h>
 #include <asm/pmu.h>
 
-#include <plat/tc.h>
+#include "iomap.h"
 #include <plat/board.h>
 #include <plat/mcbsp.h>
 #include <plat/mmc.h>
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 3c446d1..f36444b 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -30,6 +30,7 @@
 #include <plat/omap-pm.h>
 #include "common.h"
 
+#include "iomap.h"
 #include "mux.h"
 #include "control.h"
 #include "display.h"
diff --git a/arch/arm/mach-omap2/emu.c b/arch/arm/mach-omap2/emu.c
index 9c442e2..28d639f 100644
--- a/arch/arm/mach-omap2/emu.c
+++ b/arch/arm/mach-omap2/emu.c
@@ -21,6 +21,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
+#include "iomap.h"
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alexander Shishkin");
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3f174d5..a548257 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -24,26 +24,23 @@
 #include <linux/omapfb.h>
 
 #include <asm/tlb.h>
-
 #include <asm/mach/map.h>
 
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 #include <plat/serial.h>
-
-#include "clock2xxx.h"
-#include "clock3xxx.h"
-#include "clock44xx.h"
-
-#include "common.h"
 #include <plat/omap-pm.h>
+#include <plat/omap_hwmod.h>
+#include <plat/multi.h>
+
+#include "iomap.h"
 #include "voltage.h"
 #include "powerdomain.h"
-
 #include "clockdomain.h"
-#include <plat/omap_hwmod.h>
-#include <plat/multi.h>
 #include "common.h"
+#include "clock2xxx.h"
+#include "clock3xxx.h"
+#include "clock44xx.h"
 
 /*
  * The machine specific code may provide the extra mapping besides the
diff --git a/arch/arm/mach-omap2/iomap.h b/arch/arm/mach-omap2/iomap.h
new file mode 100644
index 0000000..e6f9581
--- /dev/null
+++ b/arch/arm/mach-omap2/iomap.h
@@ -0,0 +1,203 @@
+/*
+ * IO mappings for OMAP2+
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
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifdef __ASSEMBLER__
+#define IOMEM(x)		(x)
+#else
+#define IOMEM(x)		((void __force __iomem *)(x))
+#endif
+
+#define OMAP2_L3_IO_OFFSET	0x90000000
+#define OMAP2_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L3_IO_OFFSET) /* L3 */
+
+#define OMAP2_L4_IO_OFFSET	0xb2000000
+#define OMAP2_L4_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L4_IO_OFFSET) /* L4 */
+
+#define OMAP4_L3_IO_OFFSET	0xb4000000
+#define OMAP4_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_L3_IO_OFFSET) /* L3 */
+
+#define AM33XX_L4_WK_IO_OFFSET	0xb5000000
+#define AM33XX_L4_WK_IO_ADDRESS(pa)	IOMEM((pa) + AM33XX_L4_WK_IO_OFFSET)
+
+#define OMAP4_L3_PER_IO_OFFSET	0xb1100000
+#define OMAP4_L3_PER_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_L3_PER_IO_OFFSET)
+
+#define OMAP4_GPMC_IO_OFFSET		0xa9000000
+#define OMAP4_GPMC_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_GPMC_IO_OFFSET)
+
+#define OMAP2_EMU_IO_OFFSET		0xaa800000	/* Emulation */
+#define OMAP2_EMU_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_EMU_IO_OFFSET)
+
+/*
+ * ----------------------------------------------------------------------------
+ * Omap2 specific IO mapping
+ * ----------------------------------------------------------------------------
+ */
+
+/* We map both L3 and L4 on OMAP2 */
+#define L3_24XX_PHYS	L3_24XX_BASE	/* 0x68000000 --> 0xf8000000*/
+#define L3_24XX_VIRT	(L3_24XX_PHYS + OMAP2_L3_IO_OFFSET)
+#define L3_24XX_SIZE	SZ_1M		/* 44kB of 128MB used, want 1MB sect */
+#define L4_24XX_PHYS	L4_24XX_BASE	/* 0x48000000 --> 0xfa000000 */
+#define L4_24XX_VIRT	(L4_24XX_PHYS + OMAP2_L4_IO_OFFSET)
+#define L4_24XX_SIZE	SZ_1M		/* 1MB of 128MB used, want 1MB sect */
+
+#define L4_WK_243X_PHYS		L4_WK_243X_BASE	/* 0x49000000 --> 0xfb000000 */
+#define L4_WK_243X_VIRT		(L4_WK_243X_PHYS + OMAP2_L4_IO_OFFSET)
+#define L4_WK_243X_SIZE		SZ_1M
+#define OMAP243X_GPMC_PHYS	OMAP243X_GPMC_BASE
+#define OMAP243X_GPMC_VIRT	(OMAP243X_GPMC_PHYS + OMAP2_L3_IO_OFFSET)
+						/* 0x6e000000 --> 0xfe000000 */
+#define OMAP243X_GPMC_SIZE	SZ_1M
+#define OMAP243X_SDRC_PHYS	OMAP243X_SDRC_BASE
+						/* 0x6D000000 --> 0xfd000000 */
+#define OMAP243X_SDRC_VIRT	(OMAP243X_SDRC_PHYS + OMAP2_L3_IO_OFFSET)
+#define OMAP243X_SDRC_SIZE	SZ_1M
+#define OMAP243X_SMS_PHYS	OMAP243X_SMS_BASE
+						/* 0x6c000000 --> 0xfc000000 */
+#define OMAP243X_SMS_VIRT	(OMAP243X_SMS_PHYS + OMAP2_L3_IO_OFFSET)
+#define OMAP243X_SMS_SIZE	SZ_1M
+
+/* 2420 IVA */
+#define DSP_MEM_2420_PHYS	OMAP2420_DSP_MEM_BASE
+						/* 0x58000000 --> 0xfc100000 */
+#define DSP_MEM_2420_VIRT	0xfc100000
+#define DSP_MEM_2420_SIZE	0x28000
+#define DSP_IPI_2420_PHYS	OMAP2420_DSP_IPI_BASE
+						/* 0x59000000 --> 0xfc128000 */
+#define DSP_IPI_2420_VIRT	0xfc128000
+#define DSP_IPI_2420_SIZE	SZ_4K
+#define DSP_MMU_2420_PHYS	OMAP2420_DSP_MMU_BASE
+						/* 0x5a000000 --> 0xfc129000 */
+#define DSP_MMU_2420_VIRT	0xfc129000
+#define DSP_MMU_2420_SIZE	SZ_4K
+
+/* 2430 IVA2.1 - currently unmapped */
+
+/*
+ * ----------------------------------------------------------------------------
+ * Omap3 specific IO mapping
+ * ----------------------------------------------------------------------------
+ */
+
+/* We map both L3 and L4 on OMAP3 */
+#define L3_34XX_PHYS		L3_34XX_BASE	/* 0x68000000 --> 0xf8000000 */
+#define L3_34XX_VIRT		(L3_34XX_PHYS + OMAP2_L3_IO_OFFSET)
+#define L3_34XX_SIZE		SZ_1M   /* 44kB of 128MB used, want 1MB sect */
+
+#define L4_34XX_PHYS		L4_34XX_BASE	/* 0x48000000 --> 0xfa000000 */
+#define L4_34XX_VIRT		(L4_34XX_PHYS + OMAP2_L4_IO_OFFSET)
+#define L4_34XX_SIZE		SZ_4M   /* 1MB of 128MB used, want 1MB sect */
+
+/*
+ * ----------------------------------------------------------------------------
+ * AM33XX specific IO mapping
+ * ----------------------------------------------------------------------------
+ */
+#define L4_WK_AM33XX_PHYS	L4_WK_AM33XX_BASE
+#define L4_WK_AM33XX_VIRT	(L4_WK_AM33XX_PHYS + AM33XX_L4_WK_IO_OFFSET)
+#define L4_WK_AM33XX_SIZE	SZ_4M   /* 1MB of 128MB used, want 1MB sect */
+
+/*
+ * Need to look at the Size 4M for L4.
+ * VPOM3430 was not working for Int controller
+ */
+
+#define L4_PER_34XX_PHYS	L4_PER_34XX_BASE
+						/* 0x49000000 --> 0xfb000000 */
+#define L4_PER_34XX_VIRT	(L4_PER_34XX_PHYS + OMAP2_L4_IO_OFFSET)
+#define L4_PER_34XX_SIZE	SZ_1M
+
+#define L4_EMU_34XX_PHYS	L4_EMU_34XX_BASE
+						/* 0x54000000 --> 0xfe800000 */
+#define L4_EMU_34XX_VIRT	(L4_EMU_34XX_PHYS + OMAP2_EMU_IO_OFFSET)
+#define L4_EMU_34XX_SIZE	SZ_8M
+
+#define OMAP34XX_GPMC_PHYS	OMAP34XX_GPMC_BASE
+						/* 0x6e000000 --> 0xfe000000 */
+#define OMAP34XX_GPMC_VIRT	(OMAP34XX_GPMC_PHYS + OMAP2_L3_IO_OFFSET)
+#define OMAP34XX_GPMC_SIZE	SZ_1M
+
+#define OMAP343X_SMS_PHYS	OMAP343X_SMS_BASE
+						/* 0x6c000000 --> 0xfc000000 */
+#define OMAP343X_SMS_VIRT	(OMAP343X_SMS_PHYS + OMAP2_L3_IO_OFFSET)
+#define OMAP343X_SMS_SIZE	SZ_1M
+
+#define OMAP343X_SDRC_PHYS	OMAP343X_SDRC_BASE
+						/* 0x6D000000 --> 0xfd000000 */
+#define OMAP343X_SDRC_VIRT	(OMAP343X_SDRC_PHYS + OMAP2_L3_IO_OFFSET)
+#define OMAP343X_SDRC_SIZE	SZ_1M
+
+/* 3430 IVA - currently unmapped */
+
+/*
+ * ----------------------------------------------------------------------------
+ * Omap4 specific IO mapping
+ * ----------------------------------------------------------------------------
+ */
+
+/* We map both L3 and L4 on OMAP4 */
+#define L3_44XX_PHYS		L3_44XX_BASE	/* 0x44000000 --> 0xf8000000 */
+#define L3_44XX_VIRT		(L3_44XX_PHYS + OMAP4_L3_IO_OFFSET)
+#define L3_44XX_SIZE		SZ_1M
+
+#define L4_44XX_PHYS		L4_44XX_BASE	/* 0x4a000000 --> 0xfc000000 */
+#define L4_44XX_VIRT		(L4_44XX_PHYS + OMAP2_L4_IO_OFFSET)
+#define L4_44XX_SIZE		SZ_4M
+
+#define L4_PER_44XX_PHYS	L4_PER_44XX_BASE
+						/* 0x48000000 --> 0xfa000000 */
+#define L4_PER_44XX_VIRT	(L4_PER_44XX_PHYS + OMAP2_L4_IO_OFFSET)
+#define L4_PER_44XX_SIZE	SZ_4M
+
+#define L4_ABE_44XX_PHYS	L4_ABE_44XX_BASE
+						/* 0x49000000 --> 0xfb000000 */
+#define L4_ABE_44XX_VIRT	(L4_ABE_44XX_PHYS + OMAP2_L4_IO_OFFSET)
+#define L4_ABE_44XX_SIZE	SZ_1M
+
+#define L4_EMU_44XX_PHYS	L4_EMU_44XX_BASE
+						/* 0x54000000 --> 0xfe800000 */
+#define L4_EMU_44XX_VIRT	(L4_EMU_44XX_PHYS + OMAP2_EMU_IO_OFFSET)
+#define L4_EMU_44XX_SIZE	SZ_8M
+
+#define OMAP44XX_GPMC_PHYS	OMAP44XX_GPMC_BASE
+						/* 0x50000000 --> 0xf9000000 */
+#define OMAP44XX_GPMC_VIRT	(OMAP44XX_GPMC_PHYS + OMAP4_GPMC_IO_OFFSET)
+#define OMAP44XX_GPMC_SIZE	SZ_1M
+
+
+#define OMAP44XX_EMIF1_PHYS	OMAP44XX_EMIF1_BASE
+						/* 0x4c000000 --> 0xfd100000 */
+#define OMAP44XX_EMIF1_VIRT	(OMAP44XX_EMIF1_PHYS + OMAP4_L3_PER_IO_OFFSET)
+#define OMAP44XX_EMIF1_SIZE	SZ_1M
+
+#define OMAP44XX_EMIF2_PHYS	OMAP44XX_EMIF2_BASE
+						/* 0x4d000000 --> 0xfd200000 */
+#define OMAP44XX_EMIF2_SIZE	SZ_1M
+#define OMAP44XX_EMIF2_VIRT	(OMAP44XX_EMIF1_VIRT + OMAP44XX_EMIF1_SIZE)
+
+#define OMAP44XX_DMM_PHYS	OMAP44XX_DMM_BASE
+						/* 0x4e000000 --> 0xfd300000 */
+#define OMAP44XX_DMM_SIZE	SZ_1M
+#define OMAP44XX_DMM_VIRT	(OMAP44XX_EMIF2_VIRT + OMAP44XX_EMIF2_SIZE)
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 1fef061..6da2d0e 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -14,10 +14,13 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <mach/hardware.h>
+
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
 
+#include <mach/hardware.h>
+
+#include "iomap.h"
 
 /* selected INTC register offsets */
 
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index c1bf3ef..deffbf1 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -23,11 +23,12 @@
 #include <asm/cacheflush.h>
 #include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
+
 #include <mach/hardware.h>
 #include <mach/omap-secure.h>
 
+#include "iomap.h"
 #include "common.h"
-
 #include "clockdomain.h"
 
 /* SCU base address */
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 6d63973..423a9a9 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -35,12 +35,14 @@
 #include <asm/mach/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/irqs.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/dma.h>
 #include <plat/board.h>
 
+#include <mach/irqs.h>
+
+#include "iomap.h"
 #include "common.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
@@ -49,7 +51,6 @@
 #include "sdrc.h"
 #include "pm.h"
 #include "control.h"
-
 #include "powerdomain.h"
 #include "clockdomain.h"
 
diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.c b/arch/arm/mach-omap2/prcm_mpu44xx.c
index ca669b5..928dbd4 100644
--- a/arch/arm/mach-omap2/prcm_mpu44xx.c
+++ b/arch/arm/mach-omap2/prcm_mpu44xx.c
@@ -15,8 +15,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include "iomap.h"
 #include "common.h"
-
 #include "prcm_mpu44xx.h"
 #include "cm-regbits-44xx.h"
 
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 33dd655..f4c1519 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -17,10 +17,11 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "common.h"
 #include <plat/cpu.h>
 #include <plat/prcm.h>
 
+#include "iomap.h"
+#include "common.h"
 #include "vp.h"
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index f6de5bc..9b3898a 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -16,8 +16,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include "iomap.h"
 #include "common.h"
-
 #include "prm44xx.h"
 #include "prminst44xx.h"
 #include "prm-regbits-44xx.h"
diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
index 7479d7e..845c4fd 100644
--- a/arch/arm/mach-omap2/sdram-nokia.c
+++ b/arch/arm/mach-omap2/sdram-nokia.c
@@ -17,7 +17,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <plat/io.h>
 #include "common.h"
 #include <plat/clock.h>
 #include <plat/sdrc.h>
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 791a63c..2c329a6 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -24,13 +24,14 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include "common.h"
 #include <plat/clock.h>
 #include <plat/sram.h>
+#include <plat/sdrc.h>
 
+#include "iomap.h"
+#include "common.h"
 #include "prm2xxx_3xxx.h"
 #include "clock.h"
-#include <plat/sdrc.h>
 #include "sdrc.h"
 
 /* Memory timing, DLL mode flags */
diff --git a/arch/arm/mach-omap2/sleep24xx.S b/arch/arm/mach-omap2/sleep24xx.S
index b5071a4..d4bf904 100644
--- a/arch/arm/mach-omap2/sleep24xx.S
+++ b/arch/arm/mach-omap2/sleep24xx.S
@@ -27,7 +27,6 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <mach/io.h>
 
 #include <plat/omap24xx.h>
 
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index f2ea1bd..b760fec 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -23,10 +23,12 @@
  * MA 02111-1307 USA
  */
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+
 #include <plat/sram.h>
-#include <mach/io.h>
 
+#include "iomap.h"
 #include "cm2xxx_3xxx.h"
 #include "prm2xxx_3xxx.h"
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
index ff9b9db..ee0bfcc 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -29,10 +29,12 @@
  * These crashes may be intermittent.
  */
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
-#include <mach/io.h>
+
 #include <mach/hardware.h>
 
+#include "iomap.h"
 #include "prm2xxx_3xxx.h"
 #include "cm2xxx_3xxx.h"
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
index 7673020..d4d39ef 100644
--- a/arch/arm/mach-omap2/sram243x.S
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -29,10 +29,12 @@
  * These crashes may be intermittent.
  */
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
-#include <mach/io.h>
+
 #include <mach/hardware.h>
 
+#include "iomap.h"
 #include "prm2xxx_3xxx.h"
 #include "cm2xxx_3xxx.h"
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 6f5849a..df5a213 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -26,11 +26,12 @@
  * MA 02111-1307 USA
  */
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
-#include <mach/hardware.h>
 
-#include <mach/io.h>
+#include <mach/hardware.h>
 
+#include "iomap.h"
 #include "sdrc.h"
 #include "cm2xxx_3xxx.h"
 
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index e5e8e08..93261d9 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -60,180 +60,6 @@
 #define IOMEM(x)		((void __force __iomem *)(x))
 #endif
 
-#define OMAP2_L3_IO_OFFSET	0x90000000
-#define OMAP2_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L3_IO_OFFSET) /* L3 */
-
-
-#define OMAP2_L4_IO_OFFSET	0xb2000000
-#define OMAP2_L4_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L4_IO_OFFSET) /* L4 */
-
-#define OMAP4_L3_IO_OFFSET	0xb4000000
-#define OMAP4_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_L3_IO_OFFSET) /* L3 */
-
-#define AM33XX_L4_WK_IO_OFFSET	0xb5000000
-#define AM33XX_L4_WK_IO_ADDRESS(pa)	IOMEM((pa) + AM33XX_L4_WK_IO_OFFSET)
-
-#define OMAP4_L3_PER_IO_OFFSET	0xb1100000
-#define OMAP4_L3_PER_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_L3_PER_IO_OFFSET)
-
-#define OMAP4_GPMC_IO_OFFSET		0xa9000000
-#define OMAP4_GPMC_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_GPMC_IO_OFFSET)
-
-#define OMAP2_EMU_IO_OFFSET		0xaa800000	/* Emulation */
-#define OMAP2_EMU_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_EMU_IO_OFFSET)
-
-/*
- * ----------------------------------------------------------------------------
- * Omap2 specific IO mapping
- * ----------------------------------------------------------------------------
- */
-
-/* We map both L3 and L4 on OMAP2 */
-#define L3_24XX_PHYS	L3_24XX_BASE	/* 0x68000000 --> 0xf8000000*/
-#define L3_24XX_VIRT	(L3_24XX_PHYS + OMAP2_L3_IO_OFFSET)
-#define L3_24XX_SIZE	SZ_1M		/* 44kB of 128MB used, want 1MB sect */
-#define L4_24XX_PHYS	L4_24XX_BASE	/* 0x48000000 --> 0xfa000000 */
-#define L4_24XX_VIRT	(L4_24XX_PHYS + OMAP2_L4_IO_OFFSET)
-#define L4_24XX_SIZE	SZ_1M		/* 1MB of 128MB used, want 1MB sect */
-
-#define L4_WK_243X_PHYS		L4_WK_243X_BASE	/* 0x49000000 --> 0xfb000000 */
-#define L4_WK_243X_VIRT		(L4_WK_243X_PHYS + OMAP2_L4_IO_OFFSET)
-#define L4_WK_243X_SIZE		SZ_1M
-#define OMAP243X_GPMC_PHYS	OMAP243X_GPMC_BASE
-#define OMAP243X_GPMC_VIRT	(OMAP243X_GPMC_PHYS + OMAP2_L3_IO_OFFSET)
-						/* 0x6e000000 --> 0xfe000000 */
-#define OMAP243X_GPMC_SIZE	SZ_1M
-#define OMAP243X_SDRC_PHYS	OMAP243X_SDRC_BASE
-						/* 0x6D000000 --> 0xfd000000 */
-#define OMAP243X_SDRC_VIRT	(OMAP243X_SDRC_PHYS + OMAP2_L3_IO_OFFSET)
-#define OMAP243X_SDRC_SIZE	SZ_1M
-#define OMAP243X_SMS_PHYS	OMAP243X_SMS_BASE
-						/* 0x6c000000 --> 0xfc000000 */
-#define OMAP243X_SMS_VIRT	(OMAP243X_SMS_PHYS + OMAP2_L3_IO_OFFSET)
-#define OMAP243X_SMS_SIZE	SZ_1M
-
-/* 2420 IVA */
-#define DSP_MEM_2420_PHYS	OMAP2420_DSP_MEM_BASE
-						/* 0x58000000 --> 0xfc100000 */
-#define DSP_MEM_2420_VIRT	0xfc100000
-#define DSP_MEM_2420_SIZE	0x28000
-#define DSP_IPI_2420_PHYS	OMAP2420_DSP_IPI_BASE
-						/* 0x59000000 --> 0xfc128000 */
-#define DSP_IPI_2420_VIRT	0xfc128000
-#define DSP_IPI_2420_SIZE	SZ_4K
-#define DSP_MMU_2420_PHYS	OMAP2420_DSP_MMU_BASE
-						/* 0x5a000000 --> 0xfc129000 */
-#define DSP_MMU_2420_VIRT	0xfc129000
-#define DSP_MMU_2420_SIZE	SZ_4K
-
-/* 2430 IVA2.1 - currently unmapped */
-
-/*
- * ----------------------------------------------------------------------------
- * Omap3 specific IO mapping
- * ----------------------------------------------------------------------------
- */
-
-/* We map both L3 and L4 on OMAP3 */
-#define L3_34XX_PHYS		L3_34XX_BASE	/* 0x68000000 --> 0xf8000000 */
-#define L3_34XX_VIRT		(L3_34XX_PHYS + OMAP2_L3_IO_OFFSET)
-#define L3_34XX_SIZE		SZ_1M   /* 44kB of 128MB used, want 1MB sect */
-
-#define L4_34XX_PHYS		L4_34XX_BASE	/* 0x48000000 --> 0xfa000000 */
-#define L4_34XX_VIRT		(L4_34XX_PHYS + OMAP2_L4_IO_OFFSET)
-#define L4_34XX_SIZE		SZ_4M   /* 1MB of 128MB used, want 1MB sect */
-
-/*
- * ----------------------------------------------------------------------------
- * AM33XX specific IO mapping
- * ----------------------------------------------------------------------------
- */
-#define L4_WK_AM33XX_PHYS	L4_WK_AM33XX_BASE
-#define L4_WK_AM33XX_VIRT	(L4_WK_AM33XX_PHYS + AM33XX_L4_WK_IO_OFFSET)
-#define L4_WK_AM33XX_SIZE	SZ_4M   /* 1MB of 128MB used, want 1MB sect */
-
-/*
- * Need to look at the Size 4M for L4.
- * VPOM3430 was not working for Int controller
- */
-
-#define L4_PER_34XX_PHYS	L4_PER_34XX_BASE
-						/* 0x49000000 --> 0xfb000000 */
-#define L4_PER_34XX_VIRT	(L4_PER_34XX_PHYS + OMAP2_L4_IO_OFFSET)
-#define L4_PER_34XX_SIZE	SZ_1M
-
-#define L4_EMU_34XX_PHYS	L4_EMU_34XX_BASE
-						/* 0x54000000 --> 0xfe800000 */
-#define L4_EMU_34XX_VIRT	(L4_EMU_34XX_PHYS + OMAP2_EMU_IO_OFFSET)
-#define L4_EMU_34XX_SIZE	SZ_8M
-
-#define OMAP34XX_GPMC_PHYS	OMAP34XX_GPMC_BASE
-						/* 0x6e000000 --> 0xfe000000 */
-#define OMAP34XX_GPMC_VIRT	(OMAP34XX_GPMC_PHYS + OMAP2_L3_IO_OFFSET)
-#define OMAP34XX_GPMC_SIZE	SZ_1M
-
-#define OMAP343X_SMS_PHYS	OMAP343X_SMS_BASE
-						/* 0x6c000000 --> 0xfc000000 */
-#define OMAP343X_SMS_VIRT	(OMAP343X_SMS_PHYS + OMAP2_L3_IO_OFFSET)
-#define OMAP343X_SMS_SIZE	SZ_1M
-
-#define OMAP343X_SDRC_PHYS	OMAP343X_SDRC_BASE
-						/* 0x6D000000 --> 0xfd000000 */
-#define OMAP343X_SDRC_VIRT	(OMAP343X_SDRC_PHYS + OMAP2_L3_IO_OFFSET)
-#define OMAP343X_SDRC_SIZE	SZ_1M
-
-/* 3430 IVA - currently unmapped */
-
-/*
- * ----------------------------------------------------------------------------
- * Omap4 specific IO mapping
- * ----------------------------------------------------------------------------
- */
-
-/* We map both L3 and L4 on OMAP4 */
-#define L3_44XX_PHYS		L3_44XX_BASE	/* 0x44000000 --> 0xf8000000 */
-#define L3_44XX_VIRT		(L3_44XX_PHYS + OMAP4_L3_IO_OFFSET)
-#define L3_44XX_SIZE		SZ_1M
-
-#define L4_44XX_PHYS		L4_44XX_BASE	/* 0x4a000000 --> 0xfc000000 */
-#define L4_44XX_VIRT		(L4_44XX_PHYS + OMAP2_L4_IO_OFFSET)
-#define L4_44XX_SIZE		SZ_4M
-
-#define L4_PER_44XX_PHYS	L4_PER_44XX_BASE
-						/* 0x48000000 --> 0xfa000000 */
-#define L4_PER_44XX_VIRT	(L4_PER_44XX_PHYS + OMAP2_L4_IO_OFFSET)
-#define L4_PER_44XX_SIZE	SZ_4M
-
-#define L4_ABE_44XX_PHYS	L4_ABE_44XX_BASE
-						/* 0x49000000 --> 0xfb000000 */
-#define L4_ABE_44XX_VIRT	(L4_ABE_44XX_PHYS + OMAP2_L4_IO_OFFSET)
-#define L4_ABE_44XX_SIZE	SZ_1M
-
-#define L4_EMU_44XX_PHYS	L4_EMU_44XX_BASE
-						/* 0x54000000 --> 0xfe800000 */
-#define L4_EMU_44XX_VIRT	(L4_EMU_44XX_PHYS + OMAP2_EMU_IO_OFFSET)
-#define L4_EMU_44XX_SIZE	SZ_8M
-
-#define OMAP44XX_GPMC_PHYS	OMAP44XX_GPMC_BASE
-						/* 0x50000000 --> 0xf9000000 */
-#define OMAP44XX_GPMC_VIRT	(OMAP44XX_GPMC_PHYS + OMAP4_GPMC_IO_OFFSET)
-#define OMAP44XX_GPMC_SIZE	SZ_1M
-
-
-#define OMAP44XX_EMIF1_PHYS	OMAP44XX_EMIF1_BASE
-						/* 0x4c000000 --> 0xfd100000 */
-#define OMAP44XX_EMIF1_VIRT	(OMAP44XX_EMIF1_PHYS + OMAP4_L3_PER_IO_OFFSET)
-#define OMAP44XX_EMIF1_SIZE	SZ_1M
-
-#define OMAP44XX_EMIF2_PHYS	OMAP44XX_EMIF2_BASE
-						/* 0x4d000000 --> 0xfd200000 */
-#define OMAP44XX_EMIF2_SIZE	SZ_1M
-#define OMAP44XX_EMIF2_VIRT	(OMAP44XX_EMIF1_VIRT + OMAP44XX_EMIF1_SIZE)
-
-#define OMAP44XX_DMM_PHYS	OMAP44XX_DMM_BASE
-						/* 0x4e000000 --> 0xfd300000 */
-#define OMAP44XX_DMM_SIZE	SZ_1M
-#define OMAP44XX_DMM_VIRT	(OMAP44XX_EMIF2_VIRT + OMAP44XX_EMIF2_SIZE)
 /*
  * ----------------------------------------------------------------------------
  * Omap specific register access
diff --git a/arch/arm/plat-omap/include/plat/tc.h b/arch/arm/plat-omap/include/plat/tc.h
index d2fcd78..83b850f 100644
--- a/arch/arm/plat-omap/include/plat/tc.h
+++ b/arch/arm/plat-omap/include/plat/tc.h
@@ -89,7 +89,8 @@
  * from NOR flash (using external chipselect 3) rather than mask ROM,
  * which uses BM to interchange the physical CS0 and CS3 addresses.
  */
-static inline u32 omap_cs0_phys(void)
+#ifdef CONFIG_ARCH_OMAP1
+static inline u32 omap_cs0m_phys(void)
 {
 	return (omap_readl(EMIFS_CONFIG) & OMAP_EMIFS_CONFIG_BM)
 			?  OMAP_CS3_PHYS : 0;
@@ -100,6 +101,7 @@ static inline u32 omap_cs3_phys(void)
 	return (omap_readl(EMIFS_CONFIG) & OMAP_EMIFS_CONFIG_BM)
 			? 0 : OMAP_CS3_PHYS;
 }
+#endif
 
 #endif	/* __ASSEMBLER__ */
 
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 4243bdc..3022fc2 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -31,11 +31,10 @@
 
 #include "sram.h"
 
-/* XXX These "sideways" includes are a sign that something is wrong */
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-# include "../mach-omap2/prm2xxx_3xxx.h"
-# include "../mach-omap2/sdrc.h"
-#endif
+/* XXX These "sideways" includes will disappear when sram.c becomes a driver */
+#include "../mach-omap2/iomap.h"
+#include "../mach-omap2/prm2xxx_3xxx.h"
+#include "../mach-omap2/sdrc.h"
 
 #define OMAP1_SRAM_PA		0x20000000
 #define OMAP2_SRAM_PUB_PA	(OMAP2_SRAM_PA + 0xf800)
