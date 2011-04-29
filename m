From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v13 00/11] dmtimer adaptation to platform_driver
Date: Fri, 29 Apr 2011 16:35:28 +0530
Message-ID: <4DBA9B78.5080604@ti.com>
References: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:40575 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752418Ab1D2LGA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 07:06:00 -0400
Received: by yxl31 with SMTP id 31so1401099yxl.41
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 04:05:58 -0700 (PDT)
In-Reply-To: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Tarun,

On 4/16/2011 9:20 PM, Tarun Kanti DebBarma wrote:
> dmtimer adaptation to platform_driver.
>
> This patch series is adaptation of dmtimer code to platform driver
> using omap_device and omap_hwmod abstraction.
>
> Baseline:
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> Branch: devel-timer
>

[...]

>
> Tarun Kanti DebBarma (11):
>    OMAP2+: dmtimer: add device names to flck nodes
>    OMAP4: hwmod data: add dmtimer version information
>    OMAP1: dmtimer: conversion to platform devices
>    OMAP2+: dmtimer: convert to platform devices
>    OMAP: dmtimer: platform driver
>    dmtimer: switch-over to platform device driver
>    OMAP: dmtimer: pm_runtime support
>    OMAP: dmtimer: add timeout to low-level routines
>    OMAP: dmtimer: use mutex instead of spinlock
>    OMAP: dmtimer: mark clocksource and clockevent timers reserved
>    OMAP: dmtimer: convert to a driver
>
>   arch/arm/mach-omap1/Makefile               |    2 +-
>   arch/arm/mach-omap1/dmtimer.c              |  173 ++++++++
>   arch/arm/mach-omap1/pm.c                   |    2 +-
>   arch/arm/mach-omap1/timer32k.c             |    2 +-
>   arch/arm/mach-omap2/clock2420_data.c       |   52 +++-
>   arch/arm/mach-omap2/clock2430_data.c       |   48 ++
>   arch/arm/mach-omap2/clock3xxx_data.c       |   36 ++
>   arch/arm/mach-omap2/clock44xx_data.c       |   33 ++
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |   25 +-
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |   25 +-
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   30 ++-
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28 ++
>   arch/arm/mach-omap2/pm-debug.c             |    2 +-
>   arch/arm/mach-omap2/timer.c                |  202 +++++++++-
>   arch/arm/plat-omap/Makefile                |    1 -
>   arch/arm/plat-omap/dmtimer.c               |  569 +++++++++++-------------
>   arch/arm/plat-omap/include/plat/dmtimer.h  |  135 +++++--
>   drivers/misc/Makefile                      |    1 +
>   drivers/misc/timer-omap.c                  |  643 ++++++++++++++++++++++++++++
>   drivers/tty/serial/omap-serial.c           |    2 +-
>   include/linux/timer-omap.h                 |  351 +++++++++++++++
>   21 files changed, 2003 insertions(+), 359 deletions(-)
>   create mode 100644 arch/arm/mach-omap1/dmtimer.c
>   create mode 100644 drivers/misc/timer-omap.c
>   create mode 100644 include/linux/timer-omap.h
>
While reviewing this series I realised that you haven't removed
the files after moving the files to drivers/*. That's why we
don't see the negative diffstat from arch/arm/*omap*/

Look at the diffstat with updated patch below. A whopping
~1000 lines from arch/arm/* are getting removed.

Any ways wait for Tony to review this series before posting
next version.

Regards
Santosh


 From d9df922c74648659eca9959c0906d4c4c8e5113c Mon Sep 17 00:00:00 2001
From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Date: Fri, 29 Apr 2011 14:44:50 +0530
Subject: [PATCH] timer: move the OMAP timer driver to drivers/misc

Make plat-omap/dmtimer.c a normal driver. It is moved to drivers/misc
as timer-omap.c and the corresponding header file has been moved to
include/linux as timer-omap.h. Files which included plat/dmtimer.h
are changed to include linux/timer-omap.h now.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
  arch/arm/mach-omap1/dmtimer.c              |    3 +-
  arch/arm/mach-omap1/pm.c                   |    2 +-
  arch/arm/mach-omap1/timer32k.c             |    2 +-
  arch/arm/mach-omap2/omap_hwmod_2420_data.c |    3 +-
  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +-
  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +-
  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
  arch/arm/mach-omap2/pm-debug.c             |    2 +-
  arch/arm/mach-omap2/timer.c                |    2 +-
  arch/arm/plat-omap/Makefile                |    1 -
  arch/arm/plat-omap/dmtimer.c               |  645 
----------------------------
  arch/arm/plat-omap/include/plat/dmtimer.h  |  349 ---------------
  drivers/misc/Makefile                      |    1 +
  drivers/misc/timer-omap.c                  |  642 
+++++++++++++++++++++++++++
  drivers/tty/serial/omap-serial.c           |    2 +-
  include/linux/timer-omap.h                 |  351 +++++++++++++++
  16 files changed, 1007 insertions(+), 1006 deletions(-)
  delete mode 100644 arch/arm/plat-omap/dmtimer.c
  delete mode 100644 arch/arm/plat-omap/include/plat/dmtimer.h
  create mode 100644 drivers/misc/timer-omap.c
  create mode 100644 include/linux/timer-omap.h

diff --git a/arch/arm/mach-omap1/dmtimer.c b/arch/arm/mach-omap1/dmtimer.c
index 980b23b..3a0cece 100644
--- a/arch/arm/mach-omap1/dmtimer.c
+++ b/arch/arm/mach-omap1/dmtimer.c
@@ -25,11 +25,10 @@
  #include <linux/err.h>
  #include <linux/slab.h>
  #include <linux/platform_device.h>
+#include <linux/timer-omap.h>

  #include <mach/irqs.h>

-#include <plat/dmtimer.h>
-
  #define OMAP1610_GPTIMER1_BASE		0xfffb1400
  #define OMAP1610_GPTIMER2_BASE		0xfffb1c00
  #define OMAP1610_GPTIMER3_BASE		0xfffb2400
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 98ba978..4344a70 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -42,6 +42,7 @@
  #include <linux/sysfs.h>
  #include <linux/module.h>
  #include <linux/io.h>
+#include <linux/timer-omap.h>

  #include <asm/irq.h>
  #include <asm/atomic.h>
@@ -55,7 +56,6 @@
  #include <plat/tc.h>
  #include <plat/mux.h>
  #include <plat/dma.h>
-#include <plat/dmtimer.h>

  #include "pm.h"

diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 96604a5..83b4094 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -45,6 +45,7 @@
  #include <linux/clocksource.h>
  #include <linux/clockchips.h>
  #include <linux/io.h>
+#include <linux/timer-omap.h>

  #include <asm/system.h>
  #include <mach/hardware.h>
@@ -53,7 +54,6 @@
  #include <asm/mach/irq.h>
  #include <asm/mach/time.h>
  #include <plat/common.h>
-#include <plat/dmtimer.h>

  /*
   * 
---------------------------------------------------------------------------
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c 
b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 1f7cb36..fe080f4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -11,6 +11,8 @@
   * XXX handle crossbar/shared link difference for L3?
   * XXX these should be marked initdata for multi-OMAP kernels
   */
+#include <linux/timer-omap.h>
+
  #include <plat/omap_hwmod.h>
  #include <mach/irqs.h>
  #include <plat/cpu.h>
@@ -19,7 +21,6 @@
  #include <plat/i2c.h>
  #include <plat/gpio.h>
  #include <plat/mcspi.h>
-#include <plat/dmtimer.h>
  #include <plat/l3_2xxx.h>
  #include <plat/l4_2xxx.h>

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c 
b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index d7c6487..85dec8a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -11,6 +11,8 @@
   * XXX handle crossbar/shared link difference for L3?
   * XXX these should be marked initdata for multi-OMAP kernels
   */
+#include <linux/timer-omap.h>
+
  #include <plat/omap_hwmod.h>
  #include <mach/irqs.h>
  #include <plat/cpu.h>
@@ -20,7 +22,6 @@
  #include <plat/gpio.h>
  #include <plat/mcbsp.h>
  #include <plat/mcspi.h>
-#include <plat/dmtimer.h>
  #include <plat/mmc.h>
  #include <plat/l3_2xxx.h>

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 7fb2ecc..2649ed8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -13,6 +13,8 @@
   *
   * XXX these should be marked initdata for multi-OMAP kernels
   */
+#include <linux/timer-omap.h>
+
  #include <plat/omap_hwmod.h>
  #include <mach/irqs.h>
  #include <plat/cpu.h>
@@ -25,7 +27,6 @@
  #include <plat/mmc.h>
  #include <plat/mcbsp.h>
  #include <plat/mcspi.h>
-#include <plat/dmtimer.h>

  #include "omap_hwmod_common_data.h"

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 38d5848..35204ef 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -19,6 +19,7 @@
   */

  #include <linux/io.h>
+#include <linux/timer-omap.h>

  #include <plat/omap_hwmod.h>
  #include <plat/cpu.h>
@@ -27,7 +28,6 @@
  #include <plat/mcspi.h>
  #include <plat/mcbsp.h>
  #include <plat/mmc.h>
-#include <plat/dmtimer.h>

  #include "omap_hwmod_common_data.h"

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 6e19f10..404faf7 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -26,12 +26,12 @@
  #include <linux/io.h>
  #include <linux/module.h>
  #include <linux/slab.h>
+#include <linux/timer-omap.h>

  #include <plat/clock.h>
  #include <plat/board.h>
  #include "powerdomain.h"
  #include "clockdomain.h"
-#include <plat/dmtimer.h>
  #include <plat/omap-pm.h>

  #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b7862ca..5fd2363 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -36,9 +36,9 @@
  #include <linux/clocksource.h>
  #include <linux/clockchips.h>
  #include <linux/slab.h>
+#include <linux/timer-omap.h>

  #include <asm/mach/time.h>
-#include <plat/dmtimer.h>
  #include <asm/localtimer.h>
  #include <asm/sched_clock.h>
  #include <plat/common.h>
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index a4a1285..472eeed 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -22,7 +22,6 @@ obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o
  obj-$(CONFIG_OMAP_IOMMU_DEBUG) += iommu-debug.o

  obj-$(CONFIG_CPU_FREQ) += cpu-omap.o
-obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
  obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
  obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
  i2c-omap-$(CONFIG_I2C_OMAP) := i2c.o
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
deleted file mode 100644
index 14d01ec..0000000
--- a/arch/arm/plat-omap/dmtimer.c
+++ /dev/null
@@ -1,645 +0,0 @@
-/*
- * linux/arch/arm/plat-omap/dmtimer.c
- *
- * OMAP Dual-Mode Timers
- *
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
- * Tarun Kanti DebBarma <tarun.kanti@ti.com>
- * Thara Gopinath <thara@ti.com>
- *
- * dmtimer adaptation to platform_driver.
- *
- * Copyright (C) 2005 Nokia Corporation
- * OMAP2 support by Juha Yrjola
- * API improvements and OMAP2 clock framework support by Timo Teras
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
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the  GNU General Public License along
- * with this program; if not, write  to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/pm_runtime.h>
-#include <linux/err.h>
-
-#include <plat/dmtimer.h>
-
-static LIST_HEAD(omap_timer_list);
-static DEFINE_MUTEX(dm_timer_mutex);
-
-/**
- * omap_dm_timer_read_reg - read timer registers in posted and 
non-posted mode
- * @timer:      timer pointer over which read operation to perform
- * @reg:        lowest byte holds the register offset
- *
- * The posted mode bit is encoded in reg. Note that in posted mode write
- * pending bit must be checked. Otherwise a read of a non completed write
- * will produce an error.
- */
-static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, 
u32 reg)
-{
-	if (reg >= OMAP_TIMER_WAKEUP_EN_REG)
-		reg += timer->func_offset;
-	else if (reg >= OMAP_TIMER_STAT_REG)
-		reg += timer->intr_offset;
-
-	return __omap_dm_timer_read(timer->io_base, reg, timer->posted,
-					timer->func_offset);
-}
-
-/**
- * omap_dm_timer_write_reg - write timer registers in posted and 
non-posted mode
- * @timer:      timer pointer over which write operation is to perform
- * @reg:        lowest byte holds the register offset
- * @value:      data to write into the register
- *
- * The posted mode bit is encoded in reg. Note that in posted mode the 
write
- * pending bit must be checked. Otherwise a write on a register which has a
- * pending write will be lost.
- */
-static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
-						u32 value)
-{
-	if (reg >= OMAP_TIMER_WAKEUP_EN_REG)
-		reg += timer->func_offset;
-	else if (reg >= OMAP_TIMER_STAT_REG)
-		reg += timer->intr_offset;
-
-	__omap_dm_timer_write(timer->io_base, reg, value, timer->posted,
-				timer->func_offset);
-}
-
-static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
-{
-	int c;
-
-	c = 0;
-	while (!(omap_dm_timer_read_reg(timer, OMAP_TIMER_SYS_STAT_REG) & 1)) {
-		c++;
-		if (c > 100000) {
-			printk(KERN_ERR "Timer failed to reset\n");
-			return;
-		}
-	}
-}
-
-/* Assumes the source clock has been set by caller */
-void __omap_dm_timer_reset(struct omap_dm_timer *timer, int autoidle,
-				int wakeup)
-{
-	u32 l;
-
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
-	l |= 0x02 << 3;  /* Set to smart-idle mode */
-	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
-
-	if (autoidle)
-		l |= 0x1 << 0;
-
-	if (wakeup)
-		l |= 1 << 2;
-
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
-}
-
-static void omap_dm_timer_reset(struct omap_dm_timer *timer)
-{
-	int autoidle = 0, wakeup = 0;
-
-	if (timer->pdev->id != 1) {
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
-		omap_dm_timer_wait_for_reset(timer);
-	}
-	__omap_dm_timer_reset(timer, autoidle, wakeup);
-}
-
-void omap_dm_timer_prepare(struct omap_dm_timer *timer)
-{
-	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
-
-	timer->fclk = clk_get(&timer->pdev->dev, "fck");
-	if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
-		timer->fclk = NULL;
-		dev_err(&timer->pdev->dev, ": No fclk handle.\n");
-		return;
-	}
-
-	omap_dm_timer_enable(timer);
-
-	if (pdata->needs_manual_reset)
-		omap_dm_timer_reset(timer);
-
-	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
-
-	__omap_dm_timer_set_posted(timer->io_base, timer->func_offset);
-	timer->posted = 1;
-}
-
-struct omap_dm_timer *omap_dm_timer_request(void)
-{
-	struct omap_dm_timer *timer = NULL, *t;
-
-	mutex_lock(&dm_timer_mutex);
-	list_for_each_entry(t, &omap_timer_list, node) {
-		if (t->reserved)
-			continue;
-
-		timer = t;
-		timer->reserved = 1;
-		break;
-	}
-	mutex_unlock(&dm_timer_mutex);
-
-	if (timer)
-		omap_dm_timer_prepare(timer);
-	else
-		pr_debug("%s: free timer not available.\n", __func__);
-
-	return timer;
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_request);
-
-struct omap_dm_timer *omap_dm_timer_request_specific(int id)
-{
-	struct omap_dm_timer *timer = NULL, *t;
-
-	mutex_lock(&dm_timer_mutex);
-	list_for_each_entry(t, &omap_timer_list, node) {
-		if (t->pdev->id == id && !t->reserved) {
-			timer = t;
-			timer->reserved = 1;
-			break;
-		}
-	}
-	mutex_unlock(&dm_timer_mutex);
-
-	if (timer)
-		omap_dm_timer_prepare(timer);
-	else
-		pr_debug("%s: timer%d not available.\n", __func__, id);
-
-	return timer;
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
-
-void omap_dm_timer_free(struct omap_dm_timer *timer)
-{
-	omap_dm_timer_disable(timer);
-
-	clk_put(timer->fclk);
-
-	WARN_ON(!timer->reserved);
-	timer->reserved = 0;
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_free);
-
-void omap_dm_timer_enable(struct omap_dm_timer *timer)
-{
-	if (timer->enabled)
-		return;
-
-	pm_runtime_get_sync(&timer->pdev->dev);
-
-	timer->enabled = 1;
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
-
-void omap_dm_timer_disable(struct omap_dm_timer *timer)
-{
-	if (!timer->enabled)
-		return;
-
-	pm_runtime_put_sync(&timer->pdev->dev);
-
-	timer->enabled = 0;
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
-
-int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
-{
-	return timer->irq;
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
-
-#if defined(CONFIG_ARCH_OMAP1)
-
-/**
- * omap_dm_timer_modify_idlect_mask - Check if any running timers use 
ARMXOR
- * @inputmask: current value of idlect mask
- */
-__u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
-{
-	int i = 0;
-	struct omap_dm_timer *timer = NULL;
-
-	/* If ARMXOR cannot be idled this function call is unnecessary */
-	if (!(inputmask & (1 << 1)))
-		return inputmask;
-
-	/* If any active timer is using ARMXOR return modified mask */
-	mutex_lock(&dm_timer_mutex);
-	list_for_each_entry(timer, &omap_timer_list, node) {
-
-		u32 l;
-
-		l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-		if (l & OMAP_TIMER_CTRL_ST) {
-			if (((omap_readl(MOD_CONF_CTRL_1) >> (i * 2)) & 0x03) == 0)
-				inputmask &= ~(1 << 1);
-			else
-				inputmask &= ~(1 << 2);
-		}
-		i++;
-	}
-	mutex_unlock(&dm_timer_mutex);
-
-	return inputmask;
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
-
-#else
-
-struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
-{
-	return timer->fclk;
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_get_fclk);
-
-__u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
-{
-	BUG();
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
-
-#endif
-
-void omap_dm_timer_trigger(struct omap_dm_timer *timer)
-{
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
-
-void omap_dm_timer_start(struct omap_dm_timer *timer)
-{
-	u32 l;
-
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	if (!(l & OMAP_TIMER_CTRL_ST)) {
-		l |= OMAP_TIMER_CTRL_ST;
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
-	}
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_start);
-
-void omap_dm_timer_stop(struct omap_dm_timer *timer)
-{
-	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
-	bool omap2 = true;
-	unsigned long rate = clk_get_rate(timer->fclk) + 1;
-
-	if (unlikely(pdata->needs_manual_reset))
-		omap2 = false;
-
-	__omap_dm_timer_stop(timer->io_base, rate, timer->posted, omap2,
-			timer->intr_offset, timer->func_offset);
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
-
-int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
-{
-	int ret = -EINVAL;
-	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
-
-	if (source < 0 || source >= 3)
-		return -EINVAL;
-
-	omap_dm_timer_disable(timer);
-	/* change the timer clock source */
-	ret = pdata->set_timer_src(timer->pdev, source);
-	omap_dm_timer_enable(timer);
-
-	/*
-	 * When the functional clock disappears, too quick writes seem
-	 * to cause an abort. XXX Is this still necessary?
-	 */
-	__delay(300000);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
-
-void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
-			    unsigned int load)
-{
-	u32 l;
-
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	if (autoreload)
-		l |= OMAP_TIMER_CTRL_AR;
-	else
-		l &= ~OMAP_TIMER_CTRL_AR;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
-
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_load);
-
-/* Optimized set_load which removes costly spin wait in timer_start */
-void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int 
autoreload,
-                            unsigned int load)
-{
-	u32 l;
-
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	if (autoreload) {
-		l |= OMAP_TIMER_CTRL_AR;
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
-	} else {
-		l &= ~OMAP_TIMER_CTRL_AR;
-	}
-	l |= OMAP_TIMER_CTRL_ST;
-
-	__omap_dm_timer_load_start(timer->io_base, l, load, timer->posted,
-					timer->func_offset);
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
-
-void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
-			     unsigned int match)
-{
-	u32 l;
-
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	if (enable)
-		l |= OMAP_TIMER_CTRL_CE;
-	else
-		l &= ~OMAP_TIMER_CTRL_CE;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG, match);
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_match);
-
-void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
-			   int toggle, int trigger)
-{
-	u32 l;
-
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
-	       OMAP_TIMER_CTRL_PT | (0x03 << 10));
-	if (def_on)
-		l |= OMAP_TIMER_CTRL_SCPWM;
-	if (toggle)
-		l |= OMAP_TIMER_CTRL_PT;
-	l |= trigger << 10;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
-
-void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int 
prescaler)
-{
-	u32 l;
-
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
-	if (prescaler >= 0x00 && prescaler <= 0x07) {
-		l |= OMAP_TIMER_CTRL_PRE;
-		l |= prescaler << 2;
-	}
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
-
-void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
-				  unsigned int value)
-{
-	__omap_dm_timer_int_enable(timer->io_base, value, timer->posted,
-			timer->intr_offset, timer->func_offset);
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
-
-unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
-{
-	unsigned int l;
-
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_STAT_REG);
-
-	return l;
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
-
-void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned 
int value)
-{
-	__omap_dm_timer_write_status(timer->io_base, value, timer->posted,
-				timer->intr_offset, timer->func_offset);
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
-
-unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
-{
-	return __omap_dm_timer_read_counter(timer->io_base, timer->posted,
-						timer->func_offset);
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
-
-void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned 
int value)
-{
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, value);
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
-
-int omap_dm_timers_active(void)
-{
-	struct omap_dm_timer *timer;
-
-	list_for_each_entry(timer, &omap_timer_list, node) {
-		if (!timer->enabled)
-			continue;
-
-		if (omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG) &
-		    OMAP_TIMER_CTRL_ST) {
-			return 1;
-		}
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(omap_dm_timers_active);
-
-/**
- * omap_dm_timer_probe - probe function called for every registered device
- * @pdev:	pointer to current timer platform device
- *
- * Called by driver framework at the end of device registration for all
- * timer devices.
- */
-static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
-{
-	int ret;
-	struct omap_dm_timer *timer;
-	struct resource *mem, *irq, *ioarea;
-	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "%s: no platform data.\n", __func__);
-		return -ENODEV;
-	}
-
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (unlikely(!irq)) {
-		dev_err(&pdev->dev, "%s: no IRQ resource.\n", __func__);
-		ret = -ENODEV;
-		goto err_free_pdev;
-	}
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!mem)) {
-		dev_err(&pdev->dev, "%s: no memory resource.\n", __func__);
-		ret = -ENODEV;
-		goto err_free_pdev;
-	}
-
-	ioarea = request_mem_region(mem->start, resource_size(mem),
-			pdev->name);
-	if (!ioarea) {
-		dev_err(&pdev->dev, "%s: region already claimed.\n", __func__);
-		ret = -EBUSY;
-		goto err_free_pdev;
-	}
-
-	timer = kzalloc(sizeof(struct omap_dm_timer), GFP_KERNEL);
-	if (!timer) {
-		dev_err(&pdev->dev, "%s: no memory for omap_dm_timer.\n",
-			__func__);
-		ret = -ENOMEM;
-		goto err_release_ioregion;
-	}
-
-	timer->io_base = ioremap(mem->start, resource_size(mem));
-	if (!timer->io_base) {
-		dev_err(&pdev->dev, "%s: ioremap failed.\n", __func__);
-		ret = -ENOMEM;
-		goto err_free_mem;
-	}
-
-	if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_2) {
-		timer->func_offset = VERSION2_TIMER_WAKEUP_EN_REG_OFFSET;
-		timer->intr_offset = VERSION2_TIMER_STAT_REG_OFFSET;
-	} else {
-		timer->func_offset = 0;
-		timer->intr_offset = 0;
-	}
-
-	timer->id = pdev->id;
-	timer->irq = irq->start;
-	timer->pdev = pdev;
-#if defined(CONFIG_ARCH_OMAP2PLUS)
-	/* Mark clocksource and clockevent timers as reserved */
-	if ((sys_timer_reserved >> (pdev->id - 1)) & 0x1)
-		timer->reserved = 1;
-	else
-#endif
-		timer->reserved = 0;
-
-	 /* Skip pm_runtime_enable for OMAP1 */
-	if (!pdata->needs_manual_reset)
-		pm_runtime_enable(&pdev->dev);
-
-	/* add the timer element to the list */
-	mutex_lock(&dm_timer_mutex);
-	list_add_tail(&timer->node, &omap_timer_list);
-	mutex_unlock(&dm_timer_mutex);
-
-	dev_dbg(&pdev->dev, "Device Probed.\n");
-
-	return 0;
-
-err_free_mem:
-	kfree(timer);
-
-err_release_ioregion:
-	release_mem_region(mem->start, resource_size(mem));
-
-err_free_pdev:
-	kfree(pdata);
-	platform_device_unregister(pdev);
-
-	return ret;
-}
-
-/**
- * omap_dm_timer_remove - cleanup a registered timer device
- * @pdev:	pointer to current timer platform device
- *
- * Called by driver framework whenever a timer device is unregistered.
- * In addition to freeing platform resources it also deletes the timer
- * entry from the local list.
- */
-static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
-{
-	struct omap_dm_timer *timer, *tmp;
-	int ret = -EINVAL;
-
-	mutex_lock(&dm_timer_mutex);
-	list_for_each_entry_safe(timer, tmp, &omap_timer_list, node) {
-		if (timer->pdev->id == pdev->id) {
-			kfree(timer->pdev->dev.platform_data);
-			platform_device_del(timer->pdev);
-			list_del(&timer->node);
-			kfree(timer);
-			ret = 0;
-			break;
-		}
-	}
-	mutex_unlock(&dm_timer_mutex);
-
-	return ret;
-}
-
-static struct platform_driver omap_dm_timer_driver = {
-	.probe  = omap_dm_timer_probe,
-	.remove = omap_dm_timer_remove,
-	.driver = {
-		.name   = "omap_timer",
-	},
-};
-
-static int __init omap_dm_timer_driver_init(void)
-{
-	return platform_driver_register(&omap_dm_timer_driver);
-}
-
-static void __exit omap_dm_timer_driver_exit(void)
-{
-	platform_driver_unregister(&omap_dm_timer_driver);
-}
-
-early_platform_init("earlytimer", &omap_dm_timer_driver);
-module_init(omap_dm_timer_driver_init);
-module_exit(omap_dm_timer_driver_exit);
-
-MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRIVER_NAME);
-MODULE_AUTHOR("Texas Instruments Inc");
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h 
b/arch/arm/plat-omap/include/plat/dmtimer.h
deleted file mode 100644
index 9093b65..0000000
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ /dev/null
@@ -1,349 +0,0 @@
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
-#ifndef __ASM_ARCH_DMTIMER_H
-#define __ASM_ARCH_DMTIMER_H
-
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <plat/common.h>
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
-/*
- * IP revision identifier so that Highlander IP
- * in OMAP4 can be distinguished.
- */
-#define OMAP_TIMER_IP_VERSION_1			0x1
-#define OMAP_TIMER_IP_VERSION_2			0x2
-
-/*
- * OMAP4 IP revision has different register offsets
- * for interrupt registers and functional registers.
- */
-#define VERSION2_TIMER_WAKEUP_EN_REG_OFFSET     0x14
-#define VERSION2_TIMER_STAT_REG_OFFSET          0x10
-
-/* timer capabilities used in hwmod database */
-#define OMAP_TIMER_SECURE				0x80000000
-#define OMAP_TIMER_ALWON				0x40000000
-#define OMAP_TIMER_HAS_PWM				0x20000000
-
-struct omap_timer_capability_dev_attr {
-	u32 timer_capability;
-};
-
-extern struct omap_dm_timer *gptimer_wakeup;
-
-struct dmtimer_platform_data {
-	int (*set_timer_src)(struct platform_device *pdev, int source);
-	int timer_ip_type;
-	u32 needs_manual_reset:1;
-};
-
-struct omap_dm_timer *omap_dm_timer_request(void);
-struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
-void omap_dm_timer_free(struct omap_dm_timer *timer);
-void omap_dm_timer_enable(struct omap_dm_timer *timer);
-void omap_dm_timer_disable(struct omap_dm_timer *timer);
-
-int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
-
-u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
-struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer);
-
-void omap_dm_timer_trigger(struct omap_dm_timer *timer);
-void omap_dm_timer_start(struct omap_dm_timer *timer);
-void omap_dm_timer_stop(struct omap_dm_timer *timer);
-
-int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source);
-void omap_dm_timer_set_load(struct omap_dm_timer *timer, int 
autoreload, unsigned int value);
-void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int 
autoreload, unsigned int value);
-void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable, 
unsigned int match);
-void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on, int 
toggle, int trigger);
-void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int 
prescaler);
-
-void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer, unsigned 
int value);
-
-unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer);
-void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned 
int value);
-unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer);
-void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned 
int value);
-
-int omap_dm_timers_active(void);
-
-/*
- * Do not use the defines below, they are not needed. They should be only
- * used by dmtimer.c and sys_timer related code.
- */
-
-/* register offsets */
-#define _OMAP_TIMER_ID_OFFSET		0x00
-#define _OMAP_TIMER_OCP_CFG_OFFSET	0x10
-#define _OMAP_TIMER_SYS_STAT_OFFSET	0x14
-#define _OMAP_TIMER_STAT_OFFSET		0x18
-#define _OMAP_TIMER_INT_EN_OFFSET	0x1c
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
-#define OMAP_TIMER_ID_REG			(_OMAP_TIMER_ID_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_OCP_CFG_REG			(_OMAP_TIMER_OCP_CFG_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_SYS_STAT_REG			(_OMAP_TIMER_SYS_STAT_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_STAT_REG			(_OMAP_TIMER_STAT_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_INT_EN_REG			(_OMAP_TIMER_INT_EN_OFFSET \
-							| (WP_NONE << WPSHIFT))
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
-#define MAX_WRITE_PEND_WAIT            10000 /* 10ms timeout delay */
-
-struct omap_dm_timer {
-	unsigned long phys_base;
-	int id;
-	int irq;
-	struct clk *iclk, *fclk;
-	void __iomem *io_base;
-	unsigned long rate;
-	unsigned reserved:1;
-	unsigned enabled:1;
-	unsigned posted:1;
-	u8 func_offset;
-	u8 intr_offset;
-	struct platform_device *pdev;
-	struct list_head node;
-};
-
-extern u32 sys_timer_reserved;
-void __omap_dm_timer_reset(struct omap_dm_timer *timer, int autoidle,
-				int wakeup);
-
-static inline u32
-__omap_dm_timer_read(void __iomem *base, u32 reg, int posted, u8 
func_offset)
-{
-	int i = 0;
-
-	if (posted) {
-		omap_test_timeout(!(__raw_readl(base +
-			((OMAP_TIMER_WRITE_PEND_REG + func_offset) & 0xff)) &
-			(reg >> WPSHIFT)), MAX_WRITE_PEND_WAIT, i);
-
-		if (WARN_ON_ONCE(i == MAX_WRITE_PEND_WAIT))
-			pr_err("read timeout.\n");
-	}
-
-	return __raw_readl(base + (reg & 0xff));
-}
-
-static inline void __omap_dm_timer_write(void __iomem *base, u32 reg, 
u32 val,
-						int posted, u8 func_offset)
-{
-	int i = 0;
-
-	if (posted) {
-		omap_test_timeout(!(__raw_readl(base +
-			((OMAP_TIMER_WRITE_PEND_REG + func_offset) & 0xff)) &
-			(reg >> WPSHIFT)), MAX_WRITE_PEND_WAIT, i);
-
-		if (WARN_ON(i == MAX_WRITE_PEND_WAIT))
-			pr_err("write timeout.\n");
-	}
-
-	__raw_writel(val, base + (reg & 0xff));
-}
-
-static inline void __omap_dm_timer_load_start(void __iomem *base, u32 ctrl,
-			unsigned int load, int posted, u8 func_offset)
-{
-	__omap_dm_timer_write(base, OMAP_TIMER_COUNTER_REG + func_offset,
-				load, posted, func_offset);
-	__omap_dm_timer_write(base, OMAP_TIMER_CTRL_REG + func_offset,
-				ctrl, posted, func_offset);
-}
-
-static inline void __omap_dm_timer_int_enable(void __iomem *base,
-		unsigned int value, int posted, u8 intr_offset, u8 func_offset)
-{
-	__omap_dm_timer_write(base, OMAP_TIMER_INT_EN_REG + intr_offset,
-				value, posted, func_offset);
-	__omap_dm_timer_write(base, OMAP_TIMER_WAKEUP_EN_REG + func_offset,
-				value, posted, func_offset);
-}
-
-static inline unsigned int
-__omap_dm_timer_read_counter(void __iomem *base, int posted, u8 
func_offset)
-{
-	return __omap_dm_timer_read(base, OMAP_TIMER_COUNTER_REG + func_offset,
-					posted,	func_offset);
-}
-
-static inline void __omap_dm_timer_write_status(void __iomem *base,
-		unsigned int value, int posted, u8 intr_offset, u8 func_offset)
-{
-	__omap_dm_timer_write(base, OMAP_TIMER_STAT_REG + intr_offset,
-				value, posted, func_offset);
-}
-
-static inline void
-__omap_dm_timer_set_posted(void __iomem *base, u8 func_offset)
-{
-	__omap_dm_timer_write(base, OMAP_TIMER_IF_CTRL_REG + func_offset,
-				OMAP_TIMER_CTRL_POSTED, 0, func_offset);
-}
-
-static inline void __omap_dm_timer_stop(void __iomem *base, unsigned 
long rate,
-			int posted, bool omap2, u8 intr_offset, u8 func_offset)
-{
-	u32 l;
-
-	l = __omap_dm_timer_read(base, OMAP_TIMER_CTRL_REG + func_offset,
-					posted, func_offset);
-	if (l & OMAP_TIMER_CTRL_ST) {
-		l &= ~0x1;
-		__omap_dm_timer_write(base, OMAP_TIMER_CTRL_REG + func_offset,
-					l, posted, func_offset);
-		if (omap2) {
-			/* Readback to make sure write has completed */
-			__omap_dm_timer_read(base, OMAP_TIMER_CTRL_REG +
-					func_offset, posted, func_offset);
-			udelay(3500000 / rate);
-		}
-	}
-	__omap_dm_timer_write(base, OMAP_TIMER_STAT_REG + intr_offset,
-				OMAP_TIMER_INT_OVERFLOW, posted, func_offset);
-}
-#endif /* __ASM_ARCH_DMTIMER_H */
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index f546860..c95496d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -44,3 +44,4 @@ obj-$(CONFIG_PCH_PHUB)		+= pch_phub.o
  obj-y				+= ti-st/
  obj-$(CONFIG_AB8500_PWM)	+= ab8500-pwm.o
  obj-y				+= lis3lv02d/
+obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-omap.o
diff --git a/drivers/misc/timer-omap.c b/drivers/misc/timer-omap.c
new file mode 100644
index 0000000..22e4352
--- /dev/null
+++ b/drivers/misc/timer-omap.c
@@ -0,0 +1,642 @@
+/*
+ * linux/arch/arm/plat-omap/dmtimer.c
+ *
+ * OMAP Dual-Mode Timers
+ *
+ * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Tarun Kanti DebBarma <tarun.kanti@ti.com>
+ * Thara Gopinath <thara@ti.com>
+ *
+ * dmtimer adaptation to platform_driver.
+ *
+ * Copyright (C) 2005 Nokia Corporation
+ * OMAP2 support by Juha Yrjola
+ * API improvements and OMAP2 clock framework support by Timo Teras
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
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/clk.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+#include <linux/err.h>
+#include <linux/timer-omap.h>
+
+static LIST_HEAD(omap_timer_list);
+static DEFINE_MUTEX(dm_timer_mutex);
+
+/**
+ * omap_dm_timer_read_reg - read timer registers in posted and 
non-posted mode
+ * @timer:      timer pointer over which read operation to perform
+ * @reg:        lowest byte holds the register offset
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode write
+ * pending bit must be checked. Otherwise a read of a non completed write
+ * will produce an error.
+ */
+static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, 
u32 reg)
+{
+	if (reg >= OMAP_TIMER_WAKEUP_EN_REG)
+		reg += timer->func_offset;
+	else if (reg >= OMAP_TIMER_STAT_REG)
+		reg += timer->intr_offset;
+
+	return __omap_dm_timer_read(timer->io_base, reg, timer->posted,
+					timer->func_offset);
+}
+
+/**
+ * omap_dm_timer_write_reg - write timer registers in posted and 
non-posted mode
+ * @timer:      timer pointer over which write operation is to perform
+ * @reg:        lowest byte holds the register offset
+ * @value:      data to write into the register
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode the 
write
+ * pending bit must be checked. Otherwise a write on a register which has a
+ * pending write will be lost.
+ */
+static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
+						u32 value)
+{
+	if (reg >= OMAP_TIMER_WAKEUP_EN_REG)
+		reg += timer->func_offset;
+	else if (reg >= OMAP_TIMER_STAT_REG)
+		reg += timer->intr_offset;
+
+	__omap_dm_timer_write(timer->io_base, reg, value, timer->posted,
+				timer->func_offset);
+}
+
+static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
+{
+	int c;
+
+	c = 0;
+	while (!(omap_dm_timer_read_reg(timer, OMAP_TIMER_SYS_STAT_REG) & 1)) {
+		c++;
+		if (c > 100000) {
+			printk(KERN_ERR "Timer failed to reset\n");
+			return;
+		}
+	}
+}
+
+/* Assumes the source clock has been set by caller */
+void __omap_dm_timer_reset(struct omap_dm_timer *timer, int autoidle,
+				int wakeup)
+{
+	u32 l;
+
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
+	l |= 0x02 << 3;  /* Set to smart-idle mode */
+	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
+
+	if (autoidle)
+		l |= 0x1 << 0;
+
+	if (wakeup)
+		l |= 1 << 2;
+
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
+}
+
+static void omap_dm_timer_reset(struct omap_dm_timer *timer)
+{
+	int autoidle = 0, wakeup = 0;
+
+	if (timer->pdev->id != 1) {
+		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
+		omap_dm_timer_wait_for_reset(timer);
+	}
+	__omap_dm_timer_reset(timer, autoidle, wakeup);
+}
+
+void omap_dm_timer_prepare(struct omap_dm_timer *timer)
+{
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
+	timer->fclk = clk_get(&timer->pdev->dev, "fck");
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
+		timer->fclk = NULL;
+		dev_err(&timer->pdev->dev, ": No fclk handle.\n");
+		return;
+	}
+
+	omap_dm_timer_enable(timer);
+
+	if (pdata->needs_manual_reset)
+		omap_dm_timer_reset(timer);
+
+	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+
+	__omap_dm_timer_set_posted(timer->io_base, timer->func_offset);
+	timer->posted = 1;
+}
+
+struct omap_dm_timer *omap_dm_timer_request(void)
+{
+	struct omap_dm_timer *timer = NULL, *t;
+
+	mutex_lock(&dm_timer_mutex);
+	list_for_each_entry(t, &omap_timer_list, node) {
+		if (t->reserved)
+			continue;
+
+		timer = t;
+		timer->reserved = 1;
+		break;
+	}
+	mutex_unlock(&dm_timer_mutex);
+
+	if (timer)
+		omap_dm_timer_prepare(timer);
+	else
+		pr_debug("%s: free timer not available.\n", __func__);
+
+	return timer;
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_request);
+
+struct omap_dm_timer *omap_dm_timer_request_specific(int id)
+{
+	struct omap_dm_timer *timer = NULL, *t;
+
+	mutex_lock(&dm_timer_mutex);
+	list_for_each_entry(t, &omap_timer_list, node) {
+		if (t->pdev->id == id && !t->reserved) {
+			timer = t;
+			timer->reserved = 1;
+			break;
+		}
+	}
+	mutex_unlock(&dm_timer_mutex);
+
+	if (timer)
+		omap_dm_timer_prepare(timer);
+	else
+		pr_debug("%s: timer%d not available.\n", __func__, id);
+
+	return timer;
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
+
+void omap_dm_timer_free(struct omap_dm_timer *timer)
+{
+	omap_dm_timer_disable(timer);
+
+	clk_put(timer->fclk);
+
+	WARN_ON(!timer->reserved);
+	timer->reserved = 0;
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_free);
+
+void omap_dm_timer_enable(struct omap_dm_timer *timer)
+{
+	if (timer->enabled)
+		return;
+
+	pm_runtime_get_sync(&timer->pdev->dev);
+
+	timer->enabled = 1;
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
+
+void omap_dm_timer_disable(struct omap_dm_timer *timer)
+{
+	if (!timer->enabled)
+		return;
+
+	pm_runtime_put_sync(&timer->pdev->dev);
+
+	timer->enabled = 0;
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
+
+int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
+{
+	return timer->irq;
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
+
+#if defined(CONFIG_ARCH_OMAP1)
+
+/**
+ * omap_dm_timer_modify_idlect_mask - Check if any running timers use 
ARMXOR
+ * @inputmask: current value of idlect mask
+ */
+__u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
+{
+	int i = 0;
+	struct omap_dm_timer *timer = NULL;
+
+	/* If ARMXOR cannot be idled this function call is unnecessary */
+	if (!(inputmask & (1 << 1)))
+		return inputmask;
+
+	/* If any active timer is using ARMXOR return modified mask */
+	mutex_lock(&dm_timer_mutex);
+	list_for_each_entry(timer, &omap_timer_list, node) {
+
+		u32 l;
+
+		l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+		if (l & OMAP_TIMER_CTRL_ST) {
+			if (((omap_readl(MOD_CONF_CTRL_1) >> (i * 2)) & 0x03) == 0)
+				inputmask &= ~(1 << 1);
+			else
+				inputmask &= ~(1 << 2);
+		}
+		i++;
+	}
+	mutex_unlock(&dm_timer_mutex);
+
+	return inputmask;
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
+
+#else
+
+struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
+{
+	return timer->fclk;
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_get_fclk);
+
+__u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
+{
+	BUG();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
+
+#endif
+
+void omap_dm_timer_trigger(struct omap_dm_timer *timer)
+{
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
+
+void omap_dm_timer_start(struct omap_dm_timer *timer)
+{
+	u32 l;
+
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	if (!(l & OMAP_TIMER_CTRL_ST)) {
+		l |= OMAP_TIMER_CTRL_ST;
+		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+	}
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_start);
+
+void omap_dm_timer_stop(struct omap_dm_timer *timer)
+{
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+	bool omap2 = true;
+	unsigned long rate = clk_get_rate(timer->fclk) + 1;
+
+	if (unlikely(pdata->needs_manual_reset))
+		omap2 = false;
+
+	__omap_dm_timer_stop(timer->io_base, rate, timer->posted, omap2,
+			timer->intr_offset, timer->func_offset);
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
+
+int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
+{
+	int ret = -EINVAL;
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
+	if (source < 0 || source >= 3)
+		return -EINVAL;
+
+	omap_dm_timer_disable(timer);
+	/* change the timer clock source */
+	ret = pdata->set_timer_src(timer->pdev, source);
+	omap_dm_timer_enable(timer);
+
+	/*
+	 * When the functional clock disappears, too quick writes seem
+	 * to cause an abort. XXX Is this still necessary?
+	 */
+	__delay(300000);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
+
+void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
+			    unsigned int load)
+{
+	u32 l;
+
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	if (autoreload)
+		l |= OMAP_TIMER_CTRL_AR;
+	else
+		l &= ~OMAP_TIMER_CTRL_AR;
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
+
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_load);
+
+/* Optimized set_load which removes costly spin wait in timer_start */
+void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int 
autoreload,
+				unsigned int load)
+{
+	u32 l;
+
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	if (autoreload) {
+		l |= OMAP_TIMER_CTRL_AR;
+		omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
+	} else {
+		l &= ~OMAP_TIMER_CTRL_AR;
+	}
+	l |= OMAP_TIMER_CTRL_ST;
+
+	__omap_dm_timer_load_start(timer->io_base, l, load, timer->posted,
+					timer->func_offset);
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
+
+void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
+			     unsigned int match)
+{
+	u32 l;
+
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	if (enable)
+		l |= OMAP_TIMER_CTRL_CE;
+	else
+		l &= ~OMAP_TIMER_CTRL_CE;
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG, match);
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_match);
+
+void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
+			   int toggle, int trigger)
+{
+	u32 l;
+
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
+	       OMAP_TIMER_CTRL_PT | (0x03 << 10));
+	if (def_on)
+		l |= OMAP_TIMER_CTRL_SCPWM;
+	if (toggle)
+		l |= OMAP_TIMER_CTRL_PT;
+	l |= trigger << 10;
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
+
+void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int 
prescaler)
+{
+	u32 l;
+
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
+	if (prescaler >= 0x00 && prescaler <= 0x07) {
+		l |= OMAP_TIMER_CTRL_PRE;
+		l |= prescaler << 2;
+	}
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
+
+void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
+				  unsigned int value)
+{
+	__omap_dm_timer_int_enable(timer->io_base, value, timer->posted,
+			timer->intr_offset, timer->func_offset);
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
+
+unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
+{
+	unsigned int l;
+
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_STAT_REG);
+
+	return l;
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
+
+void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned 
int value)
+{
+	__omap_dm_timer_write_status(timer->io_base, value, timer->posted,
+				timer->intr_offset, timer->func_offset);
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
+
+unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
+{
+	return __omap_dm_timer_read_counter(timer->io_base, timer->posted,
+						timer->func_offset);
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
+
+void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned 
int value)
+{
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, value);
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
+
+int omap_dm_timers_active(void)
+{
+	struct omap_dm_timer *timer;
+
+	list_for_each_entry(timer, &omap_timer_list, node) {
+		if (!timer->enabled)
+			continue;
+
+		if (omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG) &
+		    OMAP_TIMER_CTRL_ST) {
+			return 1;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(omap_dm_timers_active);
+
+/**
+ * omap_dm_timer_probe - probe function called for every registered device
+ * @pdev:	pointer to current timer platform device
+ *
+ * Called by driver framework at the end of device registration for all
+ * timer devices.
+ */
+static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct omap_dm_timer *timer;
+	struct resource *mem, *irq, *ioarea;
+	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: no platform data.\n", __func__);
+		return -ENODEV;
+	}
+
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (unlikely(!irq)) {
+		dev_err(&pdev->dev, "%s: no IRQ resource.\n", __func__);
+		ret = -ENODEV;
+		goto err_free_pdev;
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(!mem)) {
+		dev_err(&pdev->dev, "%s: no memory resource.\n", __func__);
+		ret = -ENODEV;
+		goto err_free_pdev;
+	}
+
+	ioarea = request_mem_region(mem->start, resource_size(mem),
+			pdev->name);
+	if (!ioarea) {
+		dev_err(&pdev->dev, "%s: region already claimed.\n", __func__);
+		ret = -EBUSY;
+		goto err_free_pdev;
+	}
+
+	timer = kzalloc(sizeof(struct omap_dm_timer), GFP_KERNEL);
+	if (!timer) {
+		dev_err(&pdev->dev, "%s: no memory for omap_dm_timer.\n",
+			__func__);
+		ret = -ENOMEM;
+		goto err_release_ioregion;
+	}
+
+	timer->io_base = ioremap(mem->start, resource_size(mem));
+	if (!timer->io_base) {
+		dev_err(&pdev->dev, "%s: ioremap failed.\n", __func__);
+		ret = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_2) {
+		timer->func_offset = VERSION2_TIMER_WAKEUP_EN_REG_OFFSET;
+		timer->intr_offset = VERSION2_TIMER_STAT_REG_OFFSET;
+	} else {
+		timer->func_offset = 0;
+		timer->intr_offset = 0;
+	}
+
+	timer->id = pdev->id;
+	timer->irq = irq->start;
+	timer->pdev = pdev;
+#if defined(CONFIG_ARCH_OMAP2PLUS)
+	/* Mark clocksource and clockevent timers as reserved */
+	if ((sys_timer_reserved >> (pdev->id - 1)) & 0x1)
+		timer->reserved = 1;
+	else
+#endif
+		timer->reserved = 0;
+
+	 /* Skip pm_runtime_enable for OMAP1 */
+	if (!pdata->needs_manual_reset)
+		pm_runtime_enable(&pdev->dev);
+
+	/* add the timer element to the list */
+	mutex_lock(&dm_timer_mutex);
+	list_add_tail(&timer->node, &omap_timer_list);
+	mutex_unlock(&dm_timer_mutex);
+
+	dev_dbg(&pdev->dev, "Device Probed.\n");
+
+	return 0;
+
+err_free_mem:
+	kfree(timer);
+
+err_release_ioregion:
+	release_mem_region(mem->start, resource_size(mem));
+
+err_free_pdev:
+	kfree(pdata);
+	platform_device_unregister(pdev);
+
+	return ret;
+}
+
+/**
+ * omap_dm_timer_remove - cleanup a registered timer device
+ * @pdev:	pointer to current timer platform device
+ *
+ * Called by driver framework whenever a timer device is unregistered.
+ * In addition to freeing platform resources it also deletes the timer
+ * entry from the local list.
+ */
+static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
+{
+	struct omap_dm_timer *timer, *tmp;
+	int ret = -EINVAL;
+
+	mutex_lock(&dm_timer_mutex);
+	list_for_each_entry_safe(timer, tmp, &omap_timer_list, node) {
+		if (timer->pdev->id == pdev->id) {
+			kfree(timer->pdev->dev.platform_data);
+			platform_device_del(timer->pdev);
+			list_del(&timer->node);
+			kfree(timer);
+			ret = 0;
+			break;
+		}
+	}
+	mutex_unlock(&dm_timer_mutex);
+
+	return ret;
+}
+
+static struct platform_driver omap_dm_timer_driver = {
+	.probe  = omap_dm_timer_probe,
+	.remove = omap_dm_timer_remove,
+	.driver = {
+		.name   = "omap_timer",
+	},
+};
+
+static int __init omap_dm_timer_driver_init(void)
+{
+	return platform_driver_register(&omap_dm_timer_driver);
+}
+
+static void __exit omap_dm_timer_driver_exit(void)
+{
+	platform_driver_unregister(&omap_dm_timer_driver);
+}
+
+early_platform_init("earlytimer", &omap_dm_timer_driver);
+module_init(omap_dm_timer_driver_init);
+module_exit(omap_dm_timer_driver_exit);
+
+MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_AUTHOR("Texas Instruments Inc");
diff --git a/drivers/tty/serial/omap-serial.c 
b/drivers/tty/serial/omap-serial.c
index 7635379..a8178eb 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -37,9 +37,9 @@
  #include <linux/clk.h>
  #include <linux/serial_core.h>
  #include <linux/irq.h>
+#include <linux/timer-omap.h>

  #include <plat/dma.h>
-#include <plat/dmtimer.h>
  #include <plat/omap-serial.h>

  static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
diff --git a/include/linux/timer-omap.h b/include/linux/timer-omap.h
new file mode 100644
index 0000000..f72a975
--- /dev/null
+++ b/include/linux/timer-omap.h
@@ -0,0 +1,351 @@
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
+#ifndef __ASM_ARCH_DMTIMER_H
+#define __ASM_ARCH_DMTIMER_H
+
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+
+#include <plat/common.h>
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
+/*
+ * IP revision identifier so that Highlander IP
+ * in OMAP4 can be distinguished.
+ */
+#define OMAP_TIMER_IP_VERSION_1			0x1
+#define OMAP_TIMER_IP_VERSION_2			0x2
+
+/*
+ * OMAP4 IP revision has different register offsets
+ * for interrupt registers and functional registers.
+ */
+#define VERSION2_TIMER_WAKEUP_EN_REG_OFFSET     0x14
+#define VERSION2_TIMER_STAT_REG_OFFSET          0x10
+
+/* timer capabilities used in hwmod database */
+#define OMAP_TIMER_SECURE				0x80000000
+#define OMAP_TIMER_ALWON				0x40000000
+#define OMAP_TIMER_HAS_PWM				0x20000000
+
+struct omap_timer_capability_dev_attr {
+	u32 timer_capability;
+};
+
+extern struct omap_dm_timer *gptimer_wakeup;
+
+struct dmtimer_platform_data {
+	int (*set_timer_src)(struct platform_device *pdev, int source);
+	int timer_ip_type;
+	u32 needs_manual_reset:1;
+};
+
+struct omap_dm_timer *omap_dm_timer_request(void);
+struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
+void omap_dm_timer_free(struct omap_dm_timer *timer);
+void omap_dm_timer_enable(struct omap_dm_timer *timer);
+void omap_dm_timer_disable(struct omap_dm_timer *timer);
+
+int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
+
+u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
+struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer);
+
+void omap_dm_timer_trigger(struct omap_dm_timer *timer);
+void omap_dm_timer_start(struct omap_dm_timer *timer);
+void omap_dm_timer_stop(struct omap_dm_timer *timer);
+
+int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source);
+void omap_dm_timer_set_load(struct omap_dm_timer *timer, int 
autoreload, unsigned int value);
+void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int 
autoreload, unsigned int value);
+void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable, 
unsigned int match);
+void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on, int 
toggle, int trigger);
+void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int 
prescaler);
+
+void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer, unsigned 
int value);
+
+unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer);
+void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned 
int value);
+unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer);
+void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned 
int value);
+
+int omap_dm_timers_active(void);
+
+/*
+ * Do not use the defines below, they are not needed. They should be only
+ * used by dmtimer.c and sys_timer related code.
+ */
+
+/* register offsets */
+#define _OMAP_TIMER_ID_OFFSET		0x00
+#define _OMAP_TIMER_OCP_CFG_OFFSET	0x10
+#define _OMAP_TIMER_SYS_STAT_OFFSET	0x14
+#define _OMAP_TIMER_STAT_OFFSET		0x18
+#define _OMAP_TIMER_INT_EN_OFFSET	0x1c
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
+#define OMAP_TIMER_ID_REG			(_OMAP_TIMER_ID_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_OCP_CFG_REG			(_OMAP_TIMER_OCP_CFG_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_SYS_STAT_REG			(_OMAP_TIMER_SYS_STAT_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_STAT_REG			(_OMAP_TIMER_STAT_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_INT_EN_REG			(_OMAP_TIMER_INT_EN_OFFSET \
+							| (WP_NONE << WPSHIFT))
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
+#define MAX_WRITE_PEND_WAIT            10000 /* 10ms timeout delay */
+
+struct omap_dm_timer {
+	unsigned long phys_base;
+	int id;
+	int irq;
+	struct clk *iclk, *fclk;
+	void __iomem *io_base;
+	unsigned long rate;
+	unsigned reserved:1;
+	unsigned enabled:1;
+	unsigned posted:1;
+	u8 func_offset;
+	u8 intr_offset;
+	struct platform_device *pdev;
+	struct list_head node;
+};
+
+extern u32 sys_timer_reserved;
+void __omap_dm_timer_reset(struct omap_dm_timer *timer, int autoidle,
+				int wakeup);
+
+static inline u32
+__omap_dm_timer_read(void __iomem *base, u32 reg, int posted, u8 
func_offset)
+{
+	int i = 0;
+
+	if (posted) {
+		omap_test_timeout(!(__raw_readl(base +
+			((OMAP_TIMER_WRITE_PEND_REG + func_offset) & 0xff)) &
+			(reg >> WPSHIFT)), MAX_WRITE_PEND_WAIT, i);
+
+		if (WARN_ON_ONCE(i == MAX_WRITE_PEND_WAIT))
+			pr_err("read timeout.\n");
+	}
+
+	return __raw_readl(base + (reg & 0xff));
+}
+
+static inline void __omap_dm_timer_write(void __iomem *base, u32 reg, 
u32 val,
+						int posted, u8 func_offset)
+{
+	int i = 0;
+
+	if (posted) {
+		omap_test_timeout(!(__raw_readl(base +
+			((OMAP_TIMER_WRITE_PEND_REG + func_offset) & 0xff)) &
+			(reg >> WPSHIFT)), MAX_WRITE_PEND_WAIT, i);
+
+		if (WARN_ON(i == MAX_WRITE_PEND_WAIT))
+			pr_err("write timeout.\n");
+	}
+
+	__raw_writel(val, base + (reg & 0xff));
+}
+
+static inline void __omap_dm_timer_load_start(void __iomem *base, u32 ctrl,
+			unsigned int load, int posted, u8 func_offset)
+{
+	__omap_dm_timer_write(base, OMAP_TIMER_COUNTER_REG + func_offset,
+				load, posted, func_offset);
+	__omap_dm_timer_write(base, OMAP_TIMER_CTRL_REG + func_offset,
+				ctrl, posted, func_offset);
+}
+
+static inline void __omap_dm_timer_int_enable(void __iomem *base,
+		unsigned int value, int posted, u8 intr_offset, u8 func_offset)
+{
+	__omap_dm_timer_write(base, OMAP_TIMER_INT_EN_REG + intr_offset,
+				value, posted, func_offset);
+	__omap_dm_timer_write(base, OMAP_TIMER_WAKEUP_EN_REG + func_offset,
+				value, posted, func_offset);
+}
+
+static inline unsigned int
+__omap_dm_timer_read_counter(void __iomem *base, int posted, u8 
func_offset)
+{
+	return __omap_dm_timer_read(base, OMAP_TIMER_COUNTER_REG + func_offset,
+					posted,	func_offset);
+}
+
+static inline void __omap_dm_timer_write_status(void __iomem *base,
+		unsigned int value, int posted, u8 intr_offset, u8 func_offset)
+{
+	__omap_dm_timer_write(base, OMAP_TIMER_STAT_REG + intr_offset,
+				value, posted, func_offset);
+}
+
+static inline void
+__omap_dm_timer_set_posted(void __iomem *base, u8 func_offset)
+{
+	__omap_dm_timer_write(base, OMAP_TIMER_IF_CTRL_REG + func_offset,
+				OMAP_TIMER_CTRL_POSTED, 0, func_offset);
+}
+
+static inline void __omap_dm_timer_stop(void __iomem *base, unsigned 
long rate,
+			int posted, bool omap2, u8 intr_offset, u8 func_offset)
+{
+	u32 l;
+
+	l = __omap_dm_timer_read(base, OMAP_TIMER_CTRL_REG + func_offset,
+					posted, func_offset);
+	if (l & OMAP_TIMER_CTRL_ST) {
+		l &= ~0x1;
+		__omap_dm_timer_write(base, OMAP_TIMER_CTRL_REG + func_offset,
+					l, posted, func_offset);
+		if (omap2) {
+			/* Readback to make sure write has completed */
+			__omap_dm_timer_read(base, OMAP_TIMER_CTRL_REG +
+					func_offset, posted, func_offset);
+			udelay(3500000 / rate);
+		}
+	}
+	__omap_dm_timer_write(base, OMAP_TIMER_STAT_REG + intr_offset,
+				OMAP_TIMER_INT_OVERFLOW, posted, func_offset);
+}
+#endif /* __ASM_ARCH_DMTIMER_H */
-- 
1.6.0.4



