From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/7] arm: omap: Move dmtimer.h out of plat-omap
Date: Tue, 31 Oct 2017 15:58:41 +0530
Message-ID: <1509445726-21040-3-git-send-email-j-keerthy@ti.com>
References: <1509445726-21040-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1509445726-21040-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The header file is currently under plat-omap directory
under arch/omap. Move this out to an accessible place.

No Code changes done to the header file.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap1/pm.c                           |   2 +-
 arch/arm/mach-omap1/timer.c                        |   2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   2 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   2 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |   2 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   2 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |   2 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |   2 +-
 arch/arm/mach-omap2/timer.c                        |   2 +-
 arch/arm/plat-omap/dmtimer.c                       |   2 +-
 arch/arm/plat-omap/include/plat/dmtimer.h          | 418 ---------------------
 include/clocksource/dmtimer.h                      | 418 +++++++++++++++++++++
 15 files changed, 431 insertions(+), 431 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/dmtimer.h
 create mode 100644 include/clocksource/dmtimer.h

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index f1135bf..a07d47cf 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -55,7 +55,7 @@
 #include <mach/tc.h>
 #include <mach/mux.h>
 #include <linux/omap-dma.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
index 8fb1ec6..7c057ab 100644
--- a/arch/arm/mach-omap1/timer.c
+++ b/arch/arm/mach-omap1/timer.c
@@ -27,7 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/dmtimer-omap.h>
 
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "soc.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 1a15a34..45c1043 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -16,7 +16,7 @@
 #include <linux/i2c-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/omap-dma.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "l3_2xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 3801850..892ca58 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -18,7 +18,7 @@
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/omap-dma.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "l3_2xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index beec4cd..82b51c0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -11,7 +11,7 @@
 
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/omap-dma.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include "omap_hwmod.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 9cfba41..2423c51 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -25,7 +25,7 @@
 #include "l4_3xxx.h"
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "soc.h"
 #include "omap_hwmod.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index c477096..22e0e38 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -30,7 +30,7 @@
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 988e7ea..530334e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -26,7 +26,7 @@
 #include <linux/omap-dma.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index d05e553d..adabdef 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -26,7 +26,7 @@
 #include <linux/omap-dma.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 77a515b..d05dd2d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -18,7 +18,7 @@
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "omap_hwmod_common_data.h"
 #include "cm81xx.h"
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 6b433fc..ad9df86 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -27,7 +27,7 @@
 #include <linux/platform_data/pwm_omap_dmtimer.h>
 #include <linux/platform_data/media/ir-rx51.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 #include "common.h"
 #include "common-board-devices.h"
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index ece09c9..31c1b01 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -26,6 +26,7 @@
  * License. See the file "COPYING" in the main directory of this archive
  * for more details.
  */
+#include <clocksource/dmtimer.h>
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
@@ -49,7 +50,6 @@
 #include "omap_hwmod.h"
 #include "omap_device.h"
 #include <plat/counter-32k.h>
-#include <plat/dmtimer.h>
 #include "omap-pm.h"
 
 #include "soc.h"
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 72565fc..afe1dc9 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -47,7 +47,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/dmtimer-omap.h>
 
-#include <plat/dmtimer.h>
+#include <clocksource/dmtimer.h>
 
 static u32 omap_reserved_systimers;
 static LIST_HEAD(omap_timer_list);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
deleted file mode 100644
index dd79f30..0000000
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ /dev/null
@@ -1,418 +0,0 @@
-/*
- * arch/arm/plat-omap/include/plat/dmtimer.h
- *
- * OMAP Dual-Mode Timers
- *
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
- * Tarun Kanti DebBarma <tarun.kanti@ti.com>
- * Thara Gopinath <thara@ti.com>
- *
- * Platform device conversion and hwmod support.
- *
- * Copyright (C) 2005 Nokia Corporation
- * Author: Lauri Leukkunen <lauri.leukkunen@nokia.com>
- * PWM and clock framwork support by Timo Teras.
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
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the  GNU General Public License along
- * with this program; if not, write  to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-
-#ifndef __ASM_ARCH_DMTIMER_H
-#define __ASM_ARCH_DMTIMER_H
-
-/* clock sources */
-#define OMAP_TIMER_SRC_SYS_CLK			0x00
-#define OMAP_TIMER_SRC_32_KHZ			0x01
-#define OMAP_TIMER_SRC_EXT_CLK			0x02
-
-/* timer interrupt enable bits */
-#define OMAP_TIMER_INT_CAPTURE			(1 << 2)
-#define OMAP_TIMER_INT_OVERFLOW			(1 << 1)
-#define OMAP_TIMER_INT_MATCH			(1 << 0)
-
-/* trigger types */
-#define OMAP_TIMER_TRIGGER_NONE			0x00
-#define OMAP_TIMER_TRIGGER_OVERFLOW		0x01
-#define OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE	0x02
-
-/* posted mode types */
-#define OMAP_TIMER_NONPOSTED			0x00
-#define OMAP_TIMER_POSTED			0x01
-
-/* timer capabilities used in hwmod database */
-#define OMAP_TIMER_SECURE				0x80000000
-#define OMAP_TIMER_ALWON				0x40000000
-#define OMAP_TIMER_HAS_PWM				0x20000000
-#define OMAP_TIMER_NEEDS_RESET				0x10000000
-#define OMAP_TIMER_HAS_DSP_IRQ				0x08000000
-
-/*
- * timer errata flags
- *
- * Errata i103/i767 impacts all OMAP3/4/5 devices including AM33xx. This
- * errata prevents us from using posted mode on these devices, unless the
- * timer counter register is never read. For more details please refer to
- * the OMAP3/4/5 errata documents.
- */
-#define OMAP_TIMER_ERRATA_I103_I767			0x80000000
-
-struct omap_timer_capability_dev_attr {
-	u32 timer_capability;
-};
-
-struct timer_regs {
-	u32 tidr;
-	u32 tier;
-	u32 twer;
-	u32 tclr;
-	u32 tcrr;
-	u32 tldr;
-	u32 ttrg;
-	u32 twps;
-	u32 tmar;
-	u32 tcar1;
-	u32 tsicr;
-	u32 tcar2;
-	u32 tpir;
-	u32 tnir;
-	u32 tcvr;
-	u32 tocr;
-	u32 towr;
-};
-
-struct omap_dm_timer {
-	int id;
-	int irq;
-	struct clk *fclk;
-
-	void __iomem	*io_base;
-	void __iomem	*irq_stat;	/* TISR/IRQSTATUS interrupt status */
-	void __iomem	*irq_ena;	/* irq enable */
-	void __iomem	*irq_dis;	/* irq disable, only on v2 ip */
-	void __iomem	*pend;		/* write pending */
-	void __iomem	*func_base;	/* function register base */
-
-	unsigned long rate;
-	unsigned reserved:1;
-	unsigned posted:1;
-	struct timer_regs context;
-	int (*get_context_loss_count)(struct device *);
-	int ctx_loss_count;
-	int revision;
-	u32 capability;
-	u32 errata;
-	struct platform_device *pdev;
-	struct list_head node;
-};
-
-int omap_dm_timer_reserve_systimer(int id);
-struct omap_dm_timer *omap_dm_timer_request(void);
-struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
-struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap);
-struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node *np);
-int omap_dm_timer_free(struct omap_dm_timer *timer);
-void omap_dm_timer_enable(struct omap_dm_timer *timer);
-void omap_dm_timer_disable(struct omap_dm_timer *timer);
-
-int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
-
-u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
-struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer);
-
-int omap_dm_timer_trigger(struct omap_dm_timer *timer);
-int omap_dm_timer_start(struct omap_dm_timer *timer);
-int omap_dm_timer_stop(struct omap_dm_timer *timer);
-
-int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source);
-int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload, unsigned int value);
-int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload, unsigned int value);
-int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable, unsigned int match);
-int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on, int toggle, int trigger);
-int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler);
-
-int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer, unsigned int value);
-int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask);
-
-unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer);
-int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value);
-unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer);
-int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value);
-
-int omap_dm_timers_active(void);
-
-/*
- * Do not use the defines below, they are not needed. They should be only
- * used by dmtimer.c and sys_timer related code.
- */
-
-/*
- * The interrupt registers are different between v1 and v2 ip.
- * These registers are offsets from timer->iobase.
- */
-#define OMAP_TIMER_ID_OFFSET		0x00
-#define OMAP_TIMER_OCP_CFG_OFFSET	0x10
-
-#define OMAP_TIMER_V1_SYS_STAT_OFFSET	0x14
-#define OMAP_TIMER_V1_STAT_OFFSET	0x18
-#define OMAP_TIMER_V1_INT_EN_OFFSET	0x1c
-
-#define OMAP_TIMER_V2_IRQSTATUS_RAW	0x24
-#define OMAP_TIMER_V2_IRQSTATUS		0x28
-#define OMAP_TIMER_V2_IRQENABLE_SET	0x2c
-#define OMAP_TIMER_V2_IRQENABLE_CLR	0x30
-
-/*
- * The functional registers have a different base on v1 and v2 ip.
- * These registers are offsets from timer->func_base. The func_base
- * is samae as io_base for v1 and io_base + 0x14 for v2 ip.
- *
- */
-#define OMAP_TIMER_V2_FUNC_OFFSET		0x14
-
-#define _OMAP_TIMER_WAKEUP_EN_OFFSET	0x20
-#define _OMAP_TIMER_CTRL_OFFSET		0x24
-#define		OMAP_TIMER_CTRL_GPOCFG		(1 << 14)
-#define		OMAP_TIMER_CTRL_CAPTMODE	(1 << 13)
-#define		OMAP_TIMER_CTRL_PT		(1 << 12)
-#define		OMAP_TIMER_CTRL_TCM_LOWTOHIGH	(0x1 << 8)
-#define		OMAP_TIMER_CTRL_TCM_HIGHTOLOW	(0x2 << 8)
-#define		OMAP_TIMER_CTRL_TCM_BOTHEDGES	(0x3 << 8)
-#define		OMAP_TIMER_CTRL_SCPWM		(1 << 7)
-#define		OMAP_TIMER_CTRL_CE		(1 << 6) /* compare enable */
-#define		OMAP_TIMER_CTRL_PRE		(1 << 5) /* prescaler enable */
-#define		OMAP_TIMER_CTRL_PTV_SHIFT	2 /* prescaler value shift */
-#define		OMAP_TIMER_CTRL_POSTED		(1 << 2)
-#define		OMAP_TIMER_CTRL_AR		(1 << 1) /* auto-reload enable */
-#define		OMAP_TIMER_CTRL_ST		(1 << 0) /* start timer */
-#define _OMAP_TIMER_COUNTER_OFFSET	0x28
-#define _OMAP_TIMER_LOAD_OFFSET		0x2c
-#define _OMAP_TIMER_TRIGGER_OFFSET	0x30
-#define _OMAP_TIMER_WRITE_PEND_OFFSET	0x34
-#define		WP_NONE			0	/* no write pending bit */
-#define		WP_TCLR			(1 << 0)
-#define		WP_TCRR			(1 << 1)
-#define		WP_TLDR			(1 << 2)
-#define		WP_TTGR			(1 << 3)
-#define		WP_TMAR			(1 << 4)
-#define		WP_TPIR			(1 << 5)
-#define		WP_TNIR			(1 << 6)
-#define		WP_TCVR			(1 << 7)
-#define		WP_TOCR			(1 << 8)
-#define		WP_TOWR			(1 << 9)
-#define _OMAP_TIMER_MATCH_OFFSET	0x38
-#define _OMAP_TIMER_CAPTURE_OFFSET	0x3c
-#define _OMAP_TIMER_IF_CTRL_OFFSET	0x40
-#define _OMAP_TIMER_CAPTURE2_OFFSET		0x44	/* TCAR2, 34xx only */
-#define _OMAP_TIMER_TICK_POS_OFFSET		0x48	/* TPIR, 34xx only */
-#define _OMAP_TIMER_TICK_NEG_OFFSET		0x4c	/* TNIR, 34xx only */
-#define _OMAP_TIMER_TICK_COUNT_OFFSET		0x50	/* TCVR, 34xx only */
-#define _OMAP_TIMER_TICK_INT_MASK_SET_OFFSET	0x54	/* TOCR, 34xx only */
-#define _OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET	0x58	/* TOWR, 34xx only */
-
-/* register offsets with the write pending bit encoded */
-#define	WPSHIFT					16
-
-#define OMAP_TIMER_WAKEUP_EN_REG		(_OMAP_TIMER_WAKEUP_EN_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_CTRL_REG			(_OMAP_TIMER_CTRL_OFFSET \
-							| (WP_TCLR << WPSHIFT))
-
-#define OMAP_TIMER_COUNTER_REG			(_OMAP_TIMER_COUNTER_OFFSET \
-							| (WP_TCRR << WPSHIFT))
-
-#define OMAP_TIMER_LOAD_REG			(_OMAP_TIMER_LOAD_OFFSET \
-							| (WP_TLDR << WPSHIFT))
-
-#define OMAP_TIMER_TRIGGER_REG			(_OMAP_TIMER_TRIGGER_OFFSET \
-							| (WP_TTGR << WPSHIFT))
-
-#define OMAP_TIMER_WRITE_PEND_REG		(_OMAP_TIMER_WRITE_PEND_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_MATCH_REG			(_OMAP_TIMER_MATCH_OFFSET \
-							| (WP_TMAR << WPSHIFT))
-
-#define OMAP_TIMER_CAPTURE_REG			(_OMAP_TIMER_CAPTURE_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_IF_CTRL_REG			(_OMAP_TIMER_IF_CTRL_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_CAPTURE2_REG			(_OMAP_TIMER_CAPTURE2_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_TICK_POS_REG			(_OMAP_TIMER_TICK_POS_OFFSET \
-							| (WP_TPIR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_NEG_REG			(_OMAP_TIMER_TICK_NEG_OFFSET \
-							| (WP_TNIR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_COUNT_REG		(_OMAP_TIMER_TICK_COUNT_OFFSET \
-							| (WP_TCVR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_INT_MASK_SET_REG				\
-		(_OMAP_TIMER_TICK_INT_MASK_SET_OFFSET | (WP_TOCR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
-		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
-
-static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
-						int posted)
-{
-	if (posted)
-		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
-			cpu_relax();
-
-	return readl_relaxed(timer->func_base + (reg & 0xff));
-}
-
-static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
-					u32 reg, u32 val, int posted)
-{
-	if (posted)
-		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
-			cpu_relax();
-
-	writel_relaxed(val, timer->func_base + (reg & 0xff));
-}
-
-static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
-{
-	u32 tidr;
-
-	/* Assume v1 ip if bits [31:16] are zero */
-	tidr = readl_relaxed(timer->io_base);
-	if (!(tidr >> 16)) {
-		timer->revision = 1;
-		timer->irq_stat = timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
-		timer->irq_ena = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
-		timer->irq_dis = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
-		timer->pend = timer->io_base + _OMAP_TIMER_WRITE_PEND_OFFSET;
-		timer->func_base = timer->io_base;
-	} else {
-		timer->revision = 2;
-		timer->irq_stat = timer->io_base + OMAP_TIMER_V2_IRQSTATUS;
-		timer->irq_ena = timer->io_base + OMAP_TIMER_V2_IRQENABLE_SET;
-		timer->irq_dis = timer->io_base + OMAP_TIMER_V2_IRQENABLE_CLR;
-		timer->pend = timer->io_base +
-			_OMAP_TIMER_WRITE_PEND_OFFSET +
-				OMAP_TIMER_V2_FUNC_OFFSET;
-		timer->func_base = timer->io_base + OMAP_TIMER_V2_FUNC_OFFSET;
-	}
-}
-
-/*
- * __omap_dm_timer_enable_posted - enables write posted mode
- * @timer:      pointer to timer instance handle
- *
- * Enables the write posted mode for the timer. When posted mode is enabled
- * writes to certain timer registers are immediately acknowledged by the
- * internal bus and hence prevents stalling the CPU waiting for the write to
- * complete. Enabling this feature can improve performance for writing to the
- * timer registers.
- */
-static inline void __omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
-{
-	if (timer->posted)
-		return;
-
-	if (timer->errata & OMAP_TIMER_ERRATA_I103_I767) {
-		timer->posted = OMAP_TIMER_NONPOSTED;
-		__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG, 0, 0);
-		return;
-	}
-
-	__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG,
-			      OMAP_TIMER_CTRL_POSTED, 0);
-	timer->context.tsicr = OMAP_TIMER_CTRL_POSTED;
-	timer->posted = OMAP_TIMER_POSTED;
-}
-
-/**
- * __omap_dm_timer_override_errata - override errata flags for a timer
- * @timer:      pointer to timer handle
- * @errata:	errata flags to be ignored
- *
- * For a given timer, override a timer errata by clearing the flags
- * specified by the errata argument. A specific erratum should only be
- * overridden for a timer if the timer is used in such a way the erratum
- * has no impact.
- */
-static inline void __omap_dm_timer_override_errata(struct omap_dm_timer *timer,
-						   u32 errata)
-{
-	timer->errata &= ~errata;
-}
-
-static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
-					int posted, unsigned long rate)
-{
-	u32 l;
-
-	l = __omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
-	if (l & OMAP_TIMER_CTRL_ST) {
-		l &= ~0x1;
-		__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, l, posted);
-#ifdef CONFIG_ARCH_OMAP2PLUS
-		/* Readback to make sure write has completed */
-		__omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
-		/*
-		 * Wait for functional clock period x 3.5 to make sure that
-		 * timer is stopped
-		 */
-		udelay(3500000 / rate + 1);
-#endif
-	}
-
-	/* Ack possibly pending interrupt */
-	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, timer->irq_stat);
-}
-
-static inline void __omap_dm_timer_load_start(struct omap_dm_timer *timer,
-						u32 ctrl, unsigned int load,
-						int posted)
-{
-	__omap_dm_timer_write(timer, OMAP_TIMER_COUNTER_REG, load, posted);
-	__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, ctrl, posted);
-}
-
-static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
-						unsigned int value)
-{
-	writel_relaxed(value, timer->irq_ena);
-	__omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
-}
-
-static inline unsigned int
-__omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted)
-{
-	return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_REG, posted);
-}
-
-static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
-						unsigned int value)
-{
-	writel_relaxed(value, timer->irq_stat);
-}
-
-#endif /* __ASM_ARCH_DMTIMER_H */
diff --git a/include/clocksource/dmtimer.h b/include/clocksource/dmtimer.h
new file mode 100644
index 0000000..dd79f30
--- /dev/null
+++ b/include/clocksource/dmtimer.h
@@ -0,0 +1,418 @@
+/*
+ * arch/arm/plat-omap/include/plat/dmtimer.h
+ *
+ * OMAP Dual-Mode Timers
+ *
+ * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Tarun Kanti DebBarma <tarun.kanti@ti.com>
+ * Thara Gopinath <thara@ti.com>
+ *
+ * Platform device conversion and hwmod support.
+ *
+ * Copyright (C) 2005 Nokia Corporation
+ * Author: Lauri Leukkunen <lauri.leukkunen@nokia.com>
+ * PWM and clock framwork support by Timo Teras.
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
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#ifndef __ASM_ARCH_DMTIMER_H
+#define __ASM_ARCH_DMTIMER_H
+
+/* clock sources */
+#define OMAP_TIMER_SRC_SYS_CLK			0x00
+#define OMAP_TIMER_SRC_32_KHZ			0x01
+#define OMAP_TIMER_SRC_EXT_CLK			0x02
+
+/* timer interrupt enable bits */
+#define OMAP_TIMER_INT_CAPTURE			(1 << 2)
+#define OMAP_TIMER_INT_OVERFLOW			(1 << 1)
+#define OMAP_TIMER_INT_MATCH			(1 << 0)
+
+/* trigger types */
+#define OMAP_TIMER_TRIGGER_NONE			0x00
+#define OMAP_TIMER_TRIGGER_OVERFLOW		0x01
+#define OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE	0x02
+
+/* posted mode types */
+#define OMAP_TIMER_NONPOSTED			0x00
+#define OMAP_TIMER_POSTED			0x01
+
+/* timer capabilities used in hwmod database */
+#define OMAP_TIMER_SECURE				0x80000000
+#define OMAP_TIMER_ALWON				0x40000000
+#define OMAP_TIMER_HAS_PWM				0x20000000
+#define OMAP_TIMER_NEEDS_RESET				0x10000000
+#define OMAP_TIMER_HAS_DSP_IRQ				0x08000000
+
+/*
+ * timer errata flags
+ *
+ * Errata i103/i767 impacts all OMAP3/4/5 devices including AM33xx. This
+ * errata prevents us from using posted mode on these devices, unless the
+ * timer counter register is never read. For more details please refer to
+ * the OMAP3/4/5 errata documents.
+ */
+#define OMAP_TIMER_ERRATA_I103_I767			0x80000000
+
+struct omap_timer_capability_dev_attr {
+	u32 timer_capability;
+};
+
+struct timer_regs {
+	u32 tidr;
+	u32 tier;
+	u32 twer;
+	u32 tclr;
+	u32 tcrr;
+	u32 tldr;
+	u32 ttrg;
+	u32 twps;
+	u32 tmar;
+	u32 tcar1;
+	u32 tsicr;
+	u32 tcar2;
+	u32 tpir;
+	u32 tnir;
+	u32 tcvr;
+	u32 tocr;
+	u32 towr;
+};
+
+struct omap_dm_timer {
+	int id;
+	int irq;
+	struct clk *fclk;
+
+	void __iomem	*io_base;
+	void __iomem	*irq_stat;	/* TISR/IRQSTATUS interrupt status */
+	void __iomem	*irq_ena;	/* irq enable */
+	void __iomem	*irq_dis;	/* irq disable, only on v2 ip */
+	void __iomem	*pend;		/* write pending */
+	void __iomem	*func_base;	/* function register base */
+
+	unsigned long rate;
+	unsigned reserved:1;
+	unsigned posted:1;
+	struct timer_regs context;
+	int (*get_context_loss_count)(struct device *);
+	int ctx_loss_count;
+	int revision;
+	u32 capability;
+	u32 errata;
+	struct platform_device *pdev;
+	struct list_head node;
+};
+
+int omap_dm_timer_reserve_systimer(int id);
+struct omap_dm_timer *omap_dm_timer_request(void);
+struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
+struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap);
+struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node *np);
+int omap_dm_timer_free(struct omap_dm_timer *timer);
+void omap_dm_timer_enable(struct omap_dm_timer *timer);
+void omap_dm_timer_disable(struct omap_dm_timer *timer);
+
+int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
+
+u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
+struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer);
+
+int omap_dm_timer_trigger(struct omap_dm_timer *timer);
+int omap_dm_timer_start(struct omap_dm_timer *timer);
+int omap_dm_timer_stop(struct omap_dm_timer *timer);
+
+int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source);
+int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload, unsigned int value);
+int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload, unsigned int value);
+int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable, unsigned int match);
+int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on, int toggle, int trigger);
+int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler);
+
+int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer, unsigned int value);
+int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask);
+
+unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer);
+int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value);
+unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer);
+int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value);
+
+int omap_dm_timers_active(void);
+
+/*
+ * Do not use the defines below, they are not needed. They should be only
+ * used by dmtimer.c and sys_timer related code.
+ */
+
+/*
+ * The interrupt registers are different between v1 and v2 ip.
+ * These registers are offsets from timer->iobase.
+ */
+#define OMAP_TIMER_ID_OFFSET		0x00
+#define OMAP_TIMER_OCP_CFG_OFFSET	0x10
+
+#define OMAP_TIMER_V1_SYS_STAT_OFFSET	0x14
+#define OMAP_TIMER_V1_STAT_OFFSET	0x18
+#define OMAP_TIMER_V1_INT_EN_OFFSET	0x1c
+
+#define OMAP_TIMER_V2_IRQSTATUS_RAW	0x24
+#define OMAP_TIMER_V2_IRQSTATUS		0x28
+#define OMAP_TIMER_V2_IRQENABLE_SET	0x2c
+#define OMAP_TIMER_V2_IRQENABLE_CLR	0x30
+
+/*
+ * The functional registers have a different base on v1 and v2 ip.
+ * These registers are offsets from timer->func_base. The func_base
+ * is samae as io_base for v1 and io_base + 0x14 for v2 ip.
+ *
+ */
+#define OMAP_TIMER_V2_FUNC_OFFSET		0x14
+
+#define _OMAP_TIMER_WAKEUP_EN_OFFSET	0x20
+#define _OMAP_TIMER_CTRL_OFFSET		0x24
+#define		OMAP_TIMER_CTRL_GPOCFG		(1 << 14)
+#define		OMAP_TIMER_CTRL_CAPTMODE	(1 << 13)
+#define		OMAP_TIMER_CTRL_PT		(1 << 12)
+#define		OMAP_TIMER_CTRL_TCM_LOWTOHIGH	(0x1 << 8)
+#define		OMAP_TIMER_CTRL_TCM_HIGHTOLOW	(0x2 << 8)
+#define		OMAP_TIMER_CTRL_TCM_BOTHEDGES	(0x3 << 8)
+#define		OMAP_TIMER_CTRL_SCPWM		(1 << 7)
+#define		OMAP_TIMER_CTRL_CE		(1 << 6) /* compare enable */
+#define		OMAP_TIMER_CTRL_PRE		(1 << 5) /* prescaler enable */
+#define		OMAP_TIMER_CTRL_PTV_SHIFT	2 /* prescaler value shift */
+#define		OMAP_TIMER_CTRL_POSTED		(1 << 2)
+#define		OMAP_TIMER_CTRL_AR		(1 << 1) /* auto-reload enable */
+#define		OMAP_TIMER_CTRL_ST		(1 << 0) /* start timer */
+#define _OMAP_TIMER_COUNTER_OFFSET	0x28
+#define _OMAP_TIMER_LOAD_OFFSET		0x2c
+#define _OMAP_TIMER_TRIGGER_OFFSET	0x30
+#define _OMAP_TIMER_WRITE_PEND_OFFSET	0x34
+#define		WP_NONE			0	/* no write pending bit */
+#define		WP_TCLR			(1 << 0)
+#define		WP_TCRR			(1 << 1)
+#define		WP_TLDR			(1 << 2)
+#define		WP_TTGR			(1 << 3)
+#define		WP_TMAR			(1 << 4)
+#define		WP_TPIR			(1 << 5)
+#define		WP_TNIR			(1 << 6)
+#define		WP_TCVR			(1 << 7)
+#define		WP_TOCR			(1 << 8)
+#define		WP_TOWR			(1 << 9)
+#define _OMAP_TIMER_MATCH_OFFSET	0x38
+#define _OMAP_TIMER_CAPTURE_OFFSET	0x3c
+#define _OMAP_TIMER_IF_CTRL_OFFSET	0x40
+#define _OMAP_TIMER_CAPTURE2_OFFSET		0x44	/* TCAR2, 34xx only */
+#define _OMAP_TIMER_TICK_POS_OFFSET		0x48	/* TPIR, 34xx only */
+#define _OMAP_TIMER_TICK_NEG_OFFSET		0x4c	/* TNIR, 34xx only */
+#define _OMAP_TIMER_TICK_COUNT_OFFSET		0x50	/* TCVR, 34xx only */
+#define _OMAP_TIMER_TICK_INT_MASK_SET_OFFSET	0x54	/* TOCR, 34xx only */
+#define _OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET	0x58	/* TOWR, 34xx only */
+
+/* register offsets with the write pending bit encoded */
+#define	WPSHIFT					16
+
+#define OMAP_TIMER_WAKEUP_EN_REG		(_OMAP_TIMER_WAKEUP_EN_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_CTRL_REG			(_OMAP_TIMER_CTRL_OFFSET \
+							| (WP_TCLR << WPSHIFT))
+
+#define OMAP_TIMER_COUNTER_REG			(_OMAP_TIMER_COUNTER_OFFSET \
+							| (WP_TCRR << WPSHIFT))
+
+#define OMAP_TIMER_LOAD_REG			(_OMAP_TIMER_LOAD_OFFSET \
+							| (WP_TLDR << WPSHIFT))
+
+#define OMAP_TIMER_TRIGGER_REG			(_OMAP_TIMER_TRIGGER_OFFSET \
+							| (WP_TTGR << WPSHIFT))
+
+#define OMAP_TIMER_WRITE_PEND_REG		(_OMAP_TIMER_WRITE_PEND_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_MATCH_REG			(_OMAP_TIMER_MATCH_OFFSET \
+							| (WP_TMAR << WPSHIFT))
+
+#define OMAP_TIMER_CAPTURE_REG			(_OMAP_TIMER_CAPTURE_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_IF_CTRL_REG			(_OMAP_TIMER_IF_CTRL_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_CAPTURE2_REG			(_OMAP_TIMER_CAPTURE2_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_TICK_POS_REG			(_OMAP_TIMER_TICK_POS_OFFSET \
+							| (WP_TPIR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_NEG_REG			(_OMAP_TIMER_TICK_NEG_OFFSET \
+							| (WP_TNIR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_COUNT_REG		(_OMAP_TIMER_TICK_COUNT_OFFSET \
+							| (WP_TCVR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_INT_MASK_SET_REG				\
+		(_OMAP_TIMER_TICK_INT_MASK_SET_OFFSET | (WP_TOCR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
+		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
+
+static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
+						int posted)
+{
+	if (posted)
+		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
+			cpu_relax();
+
+	return readl_relaxed(timer->func_base + (reg & 0xff));
+}
+
+static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
+					u32 reg, u32 val, int posted)
+{
+	if (posted)
+		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
+			cpu_relax();
+
+	writel_relaxed(val, timer->func_base + (reg & 0xff));
+}
+
+static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
+{
+	u32 tidr;
+
+	/* Assume v1 ip if bits [31:16] are zero */
+	tidr = readl_relaxed(timer->io_base);
+	if (!(tidr >> 16)) {
+		timer->revision = 1;
+		timer->irq_stat = timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
+		timer->irq_ena = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
+		timer->irq_dis = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
+		timer->pend = timer->io_base + _OMAP_TIMER_WRITE_PEND_OFFSET;
+		timer->func_base = timer->io_base;
+	} else {
+		timer->revision = 2;
+		timer->irq_stat = timer->io_base + OMAP_TIMER_V2_IRQSTATUS;
+		timer->irq_ena = timer->io_base + OMAP_TIMER_V2_IRQENABLE_SET;
+		timer->irq_dis = timer->io_base + OMAP_TIMER_V2_IRQENABLE_CLR;
+		timer->pend = timer->io_base +
+			_OMAP_TIMER_WRITE_PEND_OFFSET +
+				OMAP_TIMER_V2_FUNC_OFFSET;
+		timer->func_base = timer->io_base + OMAP_TIMER_V2_FUNC_OFFSET;
+	}
+}
+
+/*
+ * __omap_dm_timer_enable_posted - enables write posted mode
+ * @timer:      pointer to timer instance handle
+ *
+ * Enables the write posted mode for the timer. When posted mode is enabled
+ * writes to certain timer registers are immediately acknowledged by the
+ * internal bus and hence prevents stalling the CPU waiting for the write to
+ * complete. Enabling this feature can improve performance for writing to the
+ * timer registers.
+ */
+static inline void __omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
+{
+	if (timer->posted)
+		return;
+
+	if (timer->errata & OMAP_TIMER_ERRATA_I103_I767) {
+		timer->posted = OMAP_TIMER_NONPOSTED;
+		__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG, 0, 0);
+		return;
+	}
+
+	__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG,
+			      OMAP_TIMER_CTRL_POSTED, 0);
+	timer->context.tsicr = OMAP_TIMER_CTRL_POSTED;
+	timer->posted = OMAP_TIMER_POSTED;
+}
+
+/**
+ * __omap_dm_timer_override_errata - override errata flags for a timer
+ * @timer:      pointer to timer handle
+ * @errata:	errata flags to be ignored
+ *
+ * For a given timer, override a timer errata by clearing the flags
+ * specified by the errata argument. A specific erratum should only be
+ * overridden for a timer if the timer is used in such a way the erratum
+ * has no impact.
+ */
+static inline void __omap_dm_timer_override_errata(struct omap_dm_timer *timer,
+						   u32 errata)
+{
+	timer->errata &= ~errata;
+}
+
+static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
+					int posted, unsigned long rate)
+{
+	u32 l;
+
+	l = __omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
+	if (l & OMAP_TIMER_CTRL_ST) {
+		l &= ~0x1;
+		__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, l, posted);
+#ifdef CONFIG_ARCH_OMAP2PLUS
+		/* Readback to make sure write has completed */
+		__omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
+		/*
+		 * Wait for functional clock period x 3.5 to make sure that
+		 * timer is stopped
+		 */
+		udelay(3500000 / rate + 1);
+#endif
+	}
+
+	/* Ack possibly pending interrupt */
+	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, timer->irq_stat);
+}
+
+static inline void __omap_dm_timer_load_start(struct omap_dm_timer *timer,
+						u32 ctrl, unsigned int load,
+						int posted)
+{
+	__omap_dm_timer_write(timer, OMAP_TIMER_COUNTER_REG, load, posted);
+	__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, ctrl, posted);
+}
+
+static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
+						unsigned int value)
+{
+	writel_relaxed(value, timer->irq_ena);
+	__omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
+}
+
+static inline unsigned int
+__omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted)
+{
+	return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_REG, posted);
+}
+
+static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
+						unsigned int value)
+{
+	writel_relaxed(value, timer->irq_stat);
+}
+
+#endif /* __ASM_ARCH_DMTIMER_H */
-- 
1.9.1
