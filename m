From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] DSP: Move code to use only one dsp_common.h
Date: Tue, 27 Nov 2007 21:18:12 -0800
Message-ID: <20071128051811.GI11825@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

As discussed earlier, here are the patches to move dspgateway
to under drivers.

Hiroshi san & Toshihiro san, can you take a quick look at these
two patches and ack?

I've only compile tested on osk and n800. There should not be any
functional changes. Some inline functions I had to export though.

Regards,

Tony

--k1lZvvs/B4yU6o8G
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline;
	filename="0001-DSP-Move-code-to-use-only-one-dsp_common.h.patch"

>From a4945cb4c9427fd5bcf699607bab1d9cc9f32dae Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 27 Nov 2007 20:37:53 -0800
Subject: [PATCH] DSP: Move code to use only one dsp_common.h

Remove arch-arm/plat-omap/dsp/dsp_common.h, and move
definitions to include/asm-arm/arch-omap/dsp_common.h.

This is done in order to prepare dsp for moving to live
under drivers. No functional changes.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-nokia770.c   |    3 +-
 arch/arm/mach-omap1/mmu.c              |    2 +
 arch/arm/mach-omap1/mmu.h              |    3 -
 arch/arm/mach-omap1/pm.c               |    1 -
 arch/arm/mach-omap2/board-n800-audio.c |    2 +-
 arch/arm/mach-omap2/board-n800-dsp.c   |    3 +-
 arch/arm/mach-omap2/mmu.h              |    3 -
 arch/arm/plat-omap/devices.c           |    3 +-
 arch/arm/plat-omap/dsp/dsp.h           |  144 +++++++++++++++++++-
 arch/arm/plat-omap/dsp/dsp_common.c    |    4 +-
 arch/arm/plat-omap/dsp/dsp_common.h    |  241 --------------------------------
 arch/arm/plat-omap/dsp/dsp_core.c      |   37 +++++-
 arch/arm/plat-omap/dsp/uaccess_dsp.h   |    3 +-
 arch/arm/plat-omap/mcbsp.c             |    2 +-
 arch/arm/plat-omap/mmu.c               |    1 +
 include/asm-arm/arch-omap/dsp_common.h |   39 +++++
 16 files changed, 231 insertions(+), 260 deletions(-)
 delete mode 100644 arch/arm/plat-omap/dsp/dsp_common.h

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index da0b90f..54502b1 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -36,8 +36,7 @@
 #include <asm/arch/omapfb.h>
 #include <asm/arch/hwa742.h>
 #include <asm/arch/lcd_mipid.h>
-
-#include "../plat-omap/dsp/dsp_common.h"
+#include <asm/arch/dsp_common.h>
 
 #define ADS7846_PENDOWN_GPIO	15
 
diff --git a/arch/arm/mach-omap1/mmu.c b/arch/arm/mach-omap1/mmu.c
index f1b682a..a254410 100644
--- a/arch/arm/mach-omap1/mmu.c
+++ b/arch/arm/mach-omap1/mmu.c
@@ -32,6 +32,8 @@
 #include <linux/err.h>
 #include "mmu.h"
 #include <asm/tlbflush.h>
+#include <asm/arch/dsp.h>
+#include <asm/arch/dsp_common.h>
 
 static void *dspvect_page;
 #define DSP_INIT_PAGE	0xfff000
diff --git a/arch/arm/mach-omap1/mmu.h b/arch/arm/mach-omap1/mmu.h
index 75966b2..9ab2d99 100644
--- a/arch/arm/mach-omap1/mmu.h
+++ b/arch/arm/mach-omap1/mmu.h
@@ -118,9 +118,6 @@ static inline void omap_mmu_write_reg(struct omap_mmu *mmu,
 	__raw_writew(val, mmu->base + reg);
 }
 
-int omap_dsp_request_mem(void);
-void omap_dsp_release_mem(void);
-
 static inline void omap_mmu_itack(struct omap_mmu *mmu)
 {
 	omap_mmu_write_reg(mmu, OMAP_MMU_IT_ACK_IT_ACK, OMAP_MMU_IT_ACK);
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 10aa872..afc4874 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -57,7 +57,6 @@
 #include <asm/arch/pm.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/dma.h>
-#include <asm/arch/dsp_common.h>
 #include <asm/arch/dmtimer.h>
 
 static unsigned int arm_sleep_save[ARM_SLEEP_SAVE_SIZE];
diff --git a/arch/arm/mach-omap2/board-n800-audio.c b/arch/arm/mach-omap2/board-n800-audio.c
index 5940f61..75c4e4e 100644
--- a/arch/arm/mach-omap2/board-n800-audio.c
+++ b/arch/arm/mach-omap2/board-n800-audio.c
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 #include <asm/arch/eac.h>
 
-#include "../plat-omap/dsp/dsp_common.h"
+#include <asm/arch/dsp_common.h>
 
 #if defined(CONFIG_SPI_TSC2301_AUDIO) && defined(CONFIG_SND_OMAP24XX_EAC)
 #define AUDIO_ENABLED
diff --git a/arch/arm/mach-omap2/board-n800-dsp.c b/arch/arm/mach-omap2/board-n800-dsp.c
index b6da02f..d524b62 100644
--- a/arch/arm/mach-omap2/board-n800-dsp.c
+++ b/arch/arm/mach-omap2/board-n800-dsp.c
@@ -30,8 +30,7 @@
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/board.h>
-
-#include "../plat-omap/dsp/dsp_common.h"
+#include <asm/arch/dsp_common.h>
 
 #if	defined(CONFIG_OMAP_DSP)
 
diff --git a/arch/arm/mach-omap2/mmu.h b/arch/arm/mach-omap2/mmu.h
index c4922d1..736932e 100644
--- a/arch/arm/mach-omap2/mmu.h
+++ b/arch/arm/mach-omap2/mmu.h
@@ -59,9 +59,6 @@
 
 #define IOMAP_VAL	0x3f
 
-#define omap_dsp_request_mem()	do { } while (0)
-#define omap_dsp_release_mem()	do { } while (0)
-
 #define INIT_TLB_ENTRY(ent,v,p,ps)				\
 do {								\
 	(ent)->va	= (v);					\
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index c25070b..aa5c6ca 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -25,6 +25,7 @@
 #include <asm/arch/mux.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/menelaus.h>
+#include <asm/arch/dsp_common.h>
 
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 # include "../mach-omap2/control.h"
@@ -32,8 +33,6 @@
 
 #if	defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
 
-#include "../plat-omap/dsp/dsp_common.h"
-
 static struct dsp_platform_data dsp_pdata = {
 	.kdev_list = LIST_HEAD_INIT(dsp_pdata.kdev_list),
 };
diff --git a/arch/arm/plat-omap/dsp/dsp.h b/arch/arm/plat-omap/dsp/dsp.h
index a5512db..a7eee1d 100644
--- a/arch/arm/plat-omap/dsp/dsp.h
+++ b/arch/arm/plat-omap/dsp/dsp.h
@@ -25,9 +25,17 @@
 #define __PLAT_OMAP_DSP_DSP_H
 
 #include "hardware_dsp.h"
-#include "dsp_common.h"
+#include <asm/arch/dsp_common.h>
 #include <asm/arch/mmu.h>
 
+
+#ifdef CONFIG_ARCH_OMAP2
+#include "../../mach-omap2/prm.h"
+#include "../../mach-omap2/prm_regbits_24xx.h"
+#include "../../mach-omap2/cm.h"
+#include "../../mach-omap2/cm_regbits_24xx.h"
+#endif
+
 /*
  * MAJOR device number: !! allocated arbitrary !!
  */
@@ -119,6 +127,8 @@ struct mb_exarg {
 	u16 *argv;
 };
 
+typedef u32 dsp_long_t;	/* must have ability to carry TADD_ABORTADR */
+
 extern void dsp_mbox_start(void);
 extern void dsp_mbox_stop(void);
 extern int dsp_mbox_config(void *p);
@@ -246,4 +256,136 @@ extern struct omap_mmu dsp_mmu;
 #define dsp_mem_enable(addr)	omap_mmu_mem_enable(&dsp_mmu, (addr))
 #define dsp_mem_disable(addr)	omap_mmu_mem_disable(&dsp_mmu, (addr))
 
+#define DSPSPACE_SIZE	0x1000000
+
+#define omap_set_bit_regw(b,r) \
+	do { omap_writew(omap_readw(r) | (b), (r)); } while(0)
+#define omap_clr_bit_regw(b,r) \
+	do { omap_writew(omap_readw(r) & ~(b), (r)); } while(0)
+#define omap_set_bit_regl(b,r) \
+	do { omap_writel(omap_readl(r) | (b), (r)); } while(0)
+#define omap_clr_bit_regl(b,r) \
+	do { omap_writel(omap_readl(r) & ~(b), (r)); } while(0)
+#define omap_set_bits_regl(val,mask,r) \
+	do { omap_writel((omap_readl(r) & ~(mask)) | (val), (r)); } while(0)
+
+#define dspword_to_virt(dw)	((void *)(dspmem_base + ((dw) << 1)))
+#define dspbyte_to_virt(db)	((void *)(dspmem_base + (db)))
+#define virt_to_dspword(va) \
+	((dsp_long_t)(((unsigned long)(va) - dspmem_base) >> 1))
+#define virt_to_dspbyte(va) \
+	((dsp_long_t)((unsigned long)(va) - dspmem_base))
+#define is_dsp_internal_mem(va) \
+	(((unsigned long)(va) >= dspmem_base) &&  \
+	 ((unsigned long)(va) < dspmem_base + dspmem_size))
+#define is_dspbyte_internal_mem(db)	((db) < dspmem_size)
+#define is_dspword_internal_mem(dw)	(((dw) << 1) < dspmem_size)
+
+#ifdef CONFIG_ARCH_OMAP1
+/*
+ * MPUI byteswap/wordswap on/off
+ *   default setting: wordswap = all, byteswap = APIMEM only
+ */
+#define mpui_wordswap_on() \
+	omap_set_bits_regl(MPUI_CTRL_WORDSWAP_ALL, MPUI_CTRL_WORDSWAP_MASK, \
+			   MPUI_CTRL)
+
+#define mpui_wordswap_off() \
+	omap_set_bits_regl(MPUI_CTRL_WORDSWAP_NONE, MPUI_CTRL_WORDSWAP_MASK, \
+			   MPUI_CTRL)
+
+#define mpui_byteswap_on() \
+	omap_set_bits_regl(MPUI_CTRL_BYTESWAP_API, MPUI_CTRL_BYTESWAP_MASK, \
+			   MPUI_CTRL)
+
+#define mpui_byteswap_off() \
+	omap_set_bits_regl(MPUI_CTRL_BYTESWAP_NONE, MPUI_CTRL_BYTESWAP_MASK, \
+			   MPUI_CTRL)
+
+/*
+ * TC wordswap on / off
+ */
+#define tc_wordswap() \
+	do { \
+		omap_writel(TC_ENDIANISM_SWAP_WORD | TC_ENDIANISM_EN, \
+			    TC_ENDIANISM); \
+	} while(0)
+
+#define tc_noswap()	omap_clr_bit_regl(TC_ENDIANISM_EN, TC_ENDIANISM)
+
+/*
+ * enable priority registers, EMIF, MPUI control logic
+ */
+#define __dsp_enable()	omap_set_bit_regw(ARM_RSTCT1_DSP_RST, ARM_RSTCT1)
+#define __dsp_disable()	omap_clr_bit_regw(ARM_RSTCT1_DSP_RST, ARM_RSTCT1)
+#define __dsp_run()	omap_set_bit_regw(ARM_RSTCT1_DSP_EN, ARM_RSTCT1)
+#define __dsp_reset()	omap_clr_bit_regw(ARM_RSTCT1_DSP_EN, ARM_RSTCT1)
+#endif /* CONFIG_ARCH_OMAP1 */
+
+#ifdef CONFIG_ARCH_OMAP2
+/*
+ * PRCM / IPI control logic
+ *
+ * REVISIT: these macros should probably be static inline functions
+ */
+#define __dsp_core_enable() \
+	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
+	     & ~OMAP24XX_RST1_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
+#define __dsp_core_disable() \
+	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
+	     | OMAP24XX_RST1_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
+#define __dsp_per_enable() \
+	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
+	     & ~OMAP24XX_RST2_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
+#define __dsp_per_disable() \
+	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
+	     | OMAP24XX_RST2_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
+#endif /* CONFIG_ARCH_OMAP2 */
+
+#if defined(CONFIG_ARCH_OMAP1)
+extern struct clk *dsp_ck_handle;
+extern struct clk *api_ck_handle;
+#elif defined(CONFIG_ARCH_OMAP2)
+extern struct clk *dsp_fck_handle;
+extern struct clk *dsp_ick_handle;
+#endif
+extern dsp_long_t dspmem_base, dspmem_size,
+		  daram_base, daram_size,
+		  saram_base, saram_size;
+
+enum cpustat_e {
+	CPUSTAT_RESET = 0,
+#ifdef CONFIG_ARCH_OMAP1
+	CPUSTAT_GBL_IDLE,
+	CPUSTAT_CPU_IDLE,
+#endif
+	CPUSTAT_RUN,
+	CPUSTAT_MAX
+};
+
+int dsp_set_rstvect(dsp_long_t adr);
+dsp_long_t dsp_get_rstvect(void);
+void dsp_set_idle_boot_base(dsp_long_t adr, size_t size);
+void dsp_reset_idle_boot_base(void);
+void dsp_cpustat_request(enum cpustat_e req);
+enum cpustat_e dsp_cpustat_get_stat(void);
+u16 dsp_cpustat_get_icrmask(void);
+void dsp_cpustat_set_icrmask(u16 mask);
+void dsp_register_mem_cb(int (*req_cb)(void), void (*rel_cb)(void));
+void dsp_unregister_mem_cb(void);
+
+#if defined(CONFIG_ARCH_OMAP1)
+#define command_dvfs_stop(m) (0)
+#define command_dvfs_start(m) (0)
+#elif defined(CONFIG_ARCH_OMAP2)
+#define command_dvfs_stop(m) \
+	(((m)->cmd_l == KFUNC_POWER) && ((m)->data == DVFS_STOP))
+#define command_dvfs_start(m) \
+	(((m)->cmd_l == KFUNC_POWER) && ((m)->data == DVFS_START))
+#endif
+
+extern struct omap_dsp *omap_dsp;
+
+extern int dsp_late_init(void);
+
 #endif /* __PLAT_OMAP_DSP_DSP_H */
diff --git a/arch/arm/plat-omap/dsp/dsp_common.c b/arch/arm/plat-omap/dsp/dsp_common.c
index b7a7ed3..99be995 100644
--- a/arch/arm/plat-omap/dsp/dsp_common.c
+++ b/arch/arm/plat-omap/dsp/dsp_common.c
@@ -33,10 +33,12 @@
 #include <asm/io.h>
 #include <asm/tlbflush.h>
 #include <asm/irq.h>
+#include <asm/arch/dsp_common.h>
+#include "dsp.h"
+
 #ifdef CONFIG_ARCH_OMAP1
 #include <asm/arch/tc.h>
 #endif
-#include "dsp_common.h"
 
 #if defined(CONFIG_ARCH_OMAP1)
 #define dsp_boot_config(mode)	omap_writew((mode), MPUI_DSP_BOOT_CONFIG)
diff --git a/arch/arm/plat-omap/dsp/dsp_common.h b/arch/arm/plat-omap/dsp/dsp_common.h
deleted file mode 100644
index 2ef1e58..0000000
--- a/arch/arm/plat-omap/dsp/dsp_common.h
+++ /dev/null
@@ -1,241 +0,0 @@
-/*
- * This file is part of OMAP DSP driver (DSP Gateway version 3.3.1)
- *
- * Copyright (C) 2002-2006 Nokia Corporation. All rights reserved.
- *
- * Contact: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef DRIVER_DSP_COMMON_H
-#define DRIVER_DSP_COMMON_H
-
-#include <linux/clk.h>
-#include <asm/arch/mmu.h>
-#include "hardware_dsp.h"
-
-#ifdef CONFIG_ARCH_OMAP2
-#include "../../mach-omap2/prm.h"
-#include "../../mach-omap2/prm_regbits_24xx.h"
-#include "../../mach-omap2/cm.h"
-#include "../../mach-omap2/cm_regbits_24xx.h"
-#endif
-
-#define DSPSPACE_SIZE	0x1000000
-
-#define omap_set_bit_regw(b,r) \
-	do { omap_writew(omap_readw(r) | (b), (r)); } while(0)
-#define omap_clr_bit_regw(b,r) \
-	do { omap_writew(omap_readw(r) & ~(b), (r)); } while(0)
-#define omap_set_bit_regl(b,r) \
-	do { omap_writel(omap_readl(r) | (b), (r)); } while(0)
-#define omap_clr_bit_regl(b,r) \
-	do { omap_writel(omap_readl(r) & ~(b), (r)); } while(0)
-#define omap_set_bits_regl(val,mask,r) \
-	do { omap_writel((omap_readl(r) & ~(mask)) | (val), (r)); } while(0)
-
-#define dspword_to_virt(dw)	((void *)(dspmem_base + ((dw) << 1)))
-#define dspbyte_to_virt(db)	((void *)(dspmem_base + (db)))
-#define virt_to_dspword(va) \
-	((dsp_long_t)(((unsigned long)(va) - dspmem_base) >> 1))
-#define virt_to_dspbyte(va) \
-	((dsp_long_t)((unsigned long)(va) - dspmem_base))
-#define is_dsp_internal_mem(va) \
-	(((unsigned long)(va) >= dspmem_base) &&  \
-	 ((unsigned long)(va) < dspmem_base + dspmem_size))
-#define is_dspbyte_internal_mem(db)	((db) < dspmem_size)
-#define is_dspword_internal_mem(dw)	(((dw) << 1) < dspmem_size)
-
-#ifdef CONFIG_ARCH_OMAP1
-/*
- * MPUI byteswap/wordswap on/off
- *   default setting: wordswap = all, byteswap = APIMEM only
- */
-#define mpui_wordswap_on() \
-	omap_set_bits_regl(MPUI_CTRL_WORDSWAP_ALL, MPUI_CTRL_WORDSWAP_MASK, \
-			   MPUI_CTRL)
-
-#define mpui_wordswap_off() \
-	omap_set_bits_regl(MPUI_CTRL_WORDSWAP_NONE, MPUI_CTRL_WORDSWAP_MASK, \
-			   MPUI_CTRL)
-
-#define mpui_byteswap_on() \
-	omap_set_bits_regl(MPUI_CTRL_BYTESWAP_API, MPUI_CTRL_BYTESWAP_MASK, \
-			   MPUI_CTRL)
-
-#define mpui_byteswap_off() \
-	omap_set_bits_regl(MPUI_CTRL_BYTESWAP_NONE, MPUI_CTRL_BYTESWAP_MASK, \
-			   MPUI_CTRL)
-
-/*
- * TC wordswap on / off
- */
-#define tc_wordswap() \
-	do { \
-		omap_writel(TC_ENDIANISM_SWAP_WORD | TC_ENDIANISM_EN, \
-			    TC_ENDIANISM); \
-	} while(0)
-
-#define tc_noswap()	omap_clr_bit_regl(TC_ENDIANISM_EN, TC_ENDIANISM)
-
-/*
- * enable priority registers, EMIF, MPUI control logic
- */
-#define __dsp_enable()	omap_set_bit_regw(ARM_RSTCT1_DSP_RST, ARM_RSTCT1)
-#define __dsp_disable()	omap_clr_bit_regw(ARM_RSTCT1_DSP_RST, ARM_RSTCT1)
-#define __dsp_run()	omap_set_bit_regw(ARM_RSTCT1_DSP_EN, ARM_RSTCT1)
-#define __dsp_reset()	omap_clr_bit_regw(ARM_RSTCT1_DSP_EN, ARM_RSTCT1)
-#endif /* CONFIG_ARCH_OMAP1 */
-
-#ifdef CONFIG_ARCH_OMAP2
-/*
- * PRCM / IPI control logic
- *
- * REVISIT: these macros should probably be static inline functions
- */
-#define __dsp_core_enable() \
-	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
-	     & ~OMAP24XX_RST1_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
-#define __dsp_core_disable() \
-	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
-	     | OMAP24XX_RST1_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
-#define __dsp_per_enable() \
-	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
-	     & ~OMAP24XX_RST2_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
-#define __dsp_per_disable() \
-	do { prm_write_mod_reg(prm_read_mod_reg(OMAP24XX_DSP_MOD, RM_RSTCTRL) \
-	     | OMAP24XX_RST2_DSP, OMAP24XX_DSP_MOD, RM_RSTCTRL); } while (0)
-#endif /* CONFIG_ARCH_OMAP2 */
-
-typedef u32 dsp_long_t;	/* must have ability to carry TADD_ABORTADR */
-
-#if defined(CONFIG_ARCH_OMAP1)
-extern struct clk *dsp_ck_handle;
-extern struct clk *api_ck_handle;
-#elif defined(CONFIG_ARCH_OMAP2)
-extern struct clk *dsp_fck_handle;
-extern struct clk *dsp_ick_handle;
-#endif
-extern dsp_long_t dspmem_base, dspmem_size,
-		  daram_base, daram_size,
-		  saram_base, saram_size;
-
-enum cpustat_e {
-	CPUSTAT_RESET = 0,
-#ifdef CONFIG_ARCH_OMAP1
-	CPUSTAT_GBL_IDLE,
-	CPUSTAT_CPU_IDLE,
-#endif
-	CPUSTAT_RUN,
-	CPUSTAT_MAX
-};
-
-int dsp_set_rstvect(dsp_long_t adr);
-dsp_long_t dsp_get_rstvect(void);
-void dsp_set_idle_boot_base(dsp_long_t adr, size_t size);
-void dsp_reset_idle_boot_base(void);
-void dsp_cpustat_request(enum cpustat_e req);
-enum cpustat_e dsp_cpustat_get_stat(void);
-u16 dsp_cpustat_get_icrmask(void);
-void dsp_cpustat_set_icrmask(u16 mask);
-void dsp_register_mem_cb(int (*req_cb)(void), void (*rel_cb)(void));
-void dsp_unregister_mem_cb(void);
-
-#if defined(CONFIG_ARCH_OMAP1)
-static inline void dsp_clk_enable(void) {}
-static inline void dsp_clk_disable(void) {}
-#elif defined(CONFIG_ARCH_OMAP2)
-static inline void dsp_clk_enable(void)
-{
-	u32 r;
-
-	/*XXX should be handled in mach-omap[1,2] XXX*/
-	prm_write_mod_reg(OMAP24XX_FORCESTATE | (1 << OMAP_POWERSTATE_SHIFT),
-			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
-
-	r = cm_read_mod_reg(OMAP24XX_DSP_MOD, CM_AUTOIDLE);
-	r |= OMAP2420_AUTO_DSP_IPI;
-	cm_write_mod_reg(r, OMAP24XX_DSP_MOD, CM_AUTOIDLE);
-
-	r = cm_read_mod_reg(OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
-	r |= OMAP24XX_AUTOSTATE_DSP;
-	cm_write_mod_reg(r, OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
-
-	clk_enable(dsp_fck_handle);
-	clk_enable(dsp_ick_handle);
-	__dsp_per_enable();
-}
-static inline void dsp_clk_disable(void)
-{
-	__dsp_per_disable();
-	clk_disable(dsp_ick_handle);
-	clk_disable(dsp_fck_handle);
-
-	prm_write_mod_reg(OMAP24XX_FORCESTATE | (3 << OMAP_POWERSTATE_SHIFT),
-			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
-}
-#endif
-
-struct dsp_kfunc_device {
-	char		*name;
-	struct clk	*fck;
-	struct clk	*ick;;
-	spinlock_t	 lock;
-	int		 enabled;
-	int		 type;
-#define DSP_KFUNC_DEV_TYPE_COMMON	1
-#define DSP_KFUNC_DEV_TYPE_AUDIO	2
-
-	struct list_head	entry;
-
-	int	(*probe)(struct dsp_kfunc_device *, int);
-	int	(*remove)(struct dsp_kfunc_device *, int);
-	int	(*enable)(struct dsp_kfunc_device *, int);
-	int	(*disable)(struct dsp_kfunc_device *, int);
-};
-
-extern int dsp_kfunc_device_register(struct dsp_kfunc_device *);
-
-struct dsp_platform_data {
-	struct list_head kdev_list;
-};
-
-struct omap_dsp {
-	struct mutex		lock;
-	int			enabled;	/* stored peripheral status */
-	struct omap_mmu		*mmu;
-	struct omap_mbox	*mbox;
-	struct device		*dev;
-	struct list_head	*kdev_list;
-	int			initialized;
-};
-
-#if defined(CONFIG_ARCH_OMAP1)
-#define command_dvfs_stop(m) (0)
-#define command_dvfs_start(m) (0)
-#elif defined(CONFIG_ARCH_OMAP2)
-#define command_dvfs_stop(m) \
-	(((m)->cmd_l == KFUNC_POWER) && ((m)->data == DVFS_STOP))
-#define command_dvfs_start(m) \
-	(((m)->cmd_l == KFUNC_POWER) && ((m)->data == DVFS_START))
-#endif
-
-extern struct omap_dsp *omap_dsp;
-
-extern int dsp_late_init(void);
-
-#endif /* DRIVER_DSP_COMMON_H */
diff --git a/arch/arm/plat-omap/dsp/dsp_core.c b/arch/arm/plat-omap/dsp/dsp_core.c
index f3a91d0..05274be 100644
--- a/arch/arm/plat-omap/dsp/dsp_core.c
+++ b/arch/arm/plat-omap/dsp/dsp_core.c
@@ -30,11 +30,11 @@
 #include <linux/clk.h>
 #include <asm/delay.h>
 #include <asm/arch/mailbox.h>
+#include <asm/arch/dsp.h>
 #include <asm/arch/dsp_common.h>
 #include "dsp_mbcmd.h"
 #include "dsp.h"
 #include "ipbuf.h"
-#include "dsp_common.h"
 
 MODULE_AUTHOR("Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>");
 MODULE_DESCRIPTION("OMAP DSP driver module");
@@ -454,6 +454,41 @@ static void mbox_kfunc(struct mbcmd *mb)
 	}
 }
 
+#if defined(CONFIG_ARCH_OMAP1)
+static inline void dsp_clk_enable(void) {}
+static inline void dsp_clk_disable(void) {}
+#elif defined(CONFIG_ARCH_OMAP2)
+static inline void dsp_clk_enable(void)
+{
+	u32 r;
+
+	/*XXX should be handled in mach-omap[1,2] XXX*/
+	prm_write_mod_reg(OMAP24XX_FORCESTATE | (1 << OMAP_POWERSTATE_SHIFT),
+			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
+
+	r = cm_read_mod_reg(OMAP24XX_DSP_MOD, CM_AUTOIDLE);
+	r |= OMAP2420_AUTO_DSP_IPI;
+	cm_write_mod_reg(r, OMAP24XX_DSP_MOD, CM_AUTOIDLE);
+
+	r = cm_read_mod_reg(OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
+	r |= OMAP24XX_AUTOSTATE_DSP;
+	cm_write_mod_reg(r, OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
+
+	clk_enable(dsp_fck_handle);
+	clk_enable(dsp_ick_handle);
+	__dsp_per_enable();
+}
+static inline void dsp_clk_disable(void)
+{
+	__dsp_per_disable();
+	clk_disable(dsp_ick_handle);
+	clk_disable(dsp_fck_handle);
+
+	prm_write_mod_reg(OMAP24XX_FORCESTATE | (3 << OMAP_POWERSTATE_SHIFT),
+			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
+}
+#endif
+
 int dsp_late_init(void)
 {
 	int ret;
diff --git a/arch/arm/plat-omap/dsp/uaccess_dsp.h b/arch/arm/plat-omap/dsp/uaccess_dsp.h
index 9291930..028814f 100644
--- a/arch/arm/plat-omap/dsp/uaccess_dsp.h
+++ b/arch/arm/plat-omap/dsp/uaccess_dsp.h
@@ -25,7 +25,8 @@
 #define _OMAP_DSP_UACCESS_DSP_H
 
 #include <asm/uaccess.h>
-#include "dsp_common.h"
+#include <asm/arch/dsp_common.h>
+#include "dsp.h"
 
 #define HAVE_ASM_COPY_FROM_USER_DSP_2B
 
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index f2ebad2..a17b5ae 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -28,8 +28,8 @@
 #include <asm/arch/dma.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/irqs.h>
-#include <asm/arch/dsp_common.h>
 #include <asm/arch/mcbsp.h>
+#include <asm/arch/dsp_common.h>
 
 #ifdef CONFIG_MCBSP_DEBUG
 #define DBG(x...)	printk(x)
diff --git a/arch/arm/plat-omap/mmu.c b/arch/arm/plat-omap/mmu.c
index 890a9c8..c92afd6 100644
--- a/arch/arm/plat-omap/mmu.c
+++ b/arch/arm/plat-omap/mmu.c
@@ -38,6 +38,7 @@
 #include <asm/pgtable.h>
 #include <asm/arch/mmu.h>
 #include <asm/sizes.h>
+#include <asm/arch/dsp_common.h>
 
 #if defined(CONFIG_ARCH_OMAP1)
 #include "../mach-omap1/mmu.h"
diff --git a/include/asm-arm/arch-omap/dsp_common.h b/include/asm-arm/arch-omap/dsp_common.h
index c61f868..a11deed 100644
--- a/include/asm-arm/arch-omap/dsp_common.h
+++ b/include/asm-arm/arch-omap/dsp_common.h
@@ -24,11 +24,50 @@
 #ifndef ASM_ARCH_DSP_COMMON_H
 #define ASM_ARCH_DSP_COMMON_H
 
+#include <linux/clk.h>
+
+struct dsp_kfunc_device {
+	char		*name;
+	struct clk	*fck;
+	struct clk	*ick;;
+	spinlock_t	 lock;
+	int		 enabled;
+	int		 type;
+#define DSP_KFUNC_DEV_TYPE_COMMON	1
+#define DSP_KFUNC_DEV_TYPE_AUDIO	2
+
+	struct list_head	entry;
+
+	int	(*probe)(struct dsp_kfunc_device *, int);
+	int	(*remove)(struct dsp_kfunc_device *, int);
+	int	(*enable)(struct dsp_kfunc_device *, int);
+	int	(*disable)(struct dsp_kfunc_device *, int);
+};
+
+extern int dsp_kfunc_device_register(struct dsp_kfunc_device *);
+
+struct dsp_platform_data {
+	struct list_head kdev_list;
+};
+
+struct omap_dsp {
+	struct mutex		lock;
+	int			enabled;	/* stored peripheral status */
+	struct omap_mmu		*mmu;
+	struct omap_mbox	*mbox;
+	struct device		*dev;
+	struct list_head	*kdev_list;
+	int			initialized;
+};
+
 #ifdef CONFIG_ARCH_OMAP1
 extern void omap_dsp_request_mpui(void);
 extern void omap_dsp_release_mpui(void);
 extern int omap_dsp_request_mem(void);
 extern int omap_dsp_release_mem(void);
+#elif defined(CONFIG_ARCH_OMAP2)
+#define omap_dsp_request_mem()	do { } while (0)
+#define omap_dsp_release_mem()	do { } while (0)
 #endif
 
 #endif /* ASM_ARCH_DSP_COMMON_H */
-- 
1.5.3.6.GIT


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--k1lZvvs/B4yU6o8G--
