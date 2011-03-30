From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 00/10] omap init_early changes for irq and timer init
Date: Wed, 30 Mar 2011 13:26:15 +0530
Message-ID: <4D92E21F.6030608@ti.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:42808 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752641Ab1C3H43 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 03:56:29 -0400
Received: by mail-yi0-f48.google.com with SMTP id 28so523181yia.21
        for <linux-omap@vger.kernel.org>; Wed, 30 Mar 2011 00:56:28 -0700 (PDT)
In-Reply-To: <20110328221501.4046.41079.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony,

On 3/29/2011 3:51 AM, Tony Lindgren wrote:
> Hi all,
>
> This series continues the work to only initialize minimal omap code
> in init_early and to cut down dependencies to code that should be
> initialized later. It also cleans up the omap2+ timer init code to prepare
> things for the later patches.
>
> After this series further patches can make the dmtimer code a regular
> device driver. Later on we can also move the clockource init happen
> earlier to make sched_clock work properly with CONFIG_PRINTK_TIME.
>

Yesterday I started looking at this series but later because of my
mailer horror show, I gave up.

After going through entire series again, it looks very
good clean-up and right step towards moving rest of
the timer to drivers/ directory.

I also realized that the discussion we had before this series was
because of miss-understating about the 'wakeu_up' timer
terminology. After this series I see that you were mentioning
about the pm debug timer where as I was taling about
clock-event wakeups from CPUidle point of view.

I still have few concerns about this series.

1)We have removed the flexibility if choosing the timer from
   from board files and hard-coded them in platform timer
   header.

  Below board related hard-coding in platform files looks more
  hacky and the interface done  by Pual still has a merits of
  its own.

--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -34,7 +34,12 @@
  struct sys_timer;

  extern void omap_map_common_io(void);
-extern struct sys_timer omap_timer;
+extern struct sys_timer omap1_timer;
+extern struct sys_timer omap242x_timer;
+extern struct sys_timer omap243x_timer;
+extern struct sys_timer omap3_timer;
+extern struct sys_timer omap3_beagle_timer;
+extern struct sys_timer omap4_timer;
  extern bool omap_32k_timer_init(void);
  extern int __init omap_init_clocksource_32k(void);
  extern unsigned long long notrace omap_32k_sched_clock(void);

--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -45,10 +45,33 @@

  #include "timer-gp.h"

+/* Parent clocks, eventually these will come from the clock framework */
+
+#define OMAP2_MPU_SOURCE	"sys_ck"
+#define OMAP3_MPU_SOURCE	OMAP2_MPU_SOURCE
+#define OMAP4_MPU_SOURCE	"sys_clkin_ck"
+#define OMAP2_32K_SOURCE	"func_32k_ck"
+#define OMAP3_32K_SOURCE	"omap_32k_fck"
+#define OMAP4_32K_SOURCE	"sys_32k_ck"
+
+#ifdef CONFIG_OMAP_32K_TIMER
+#define OMAP2_CLKEV_SOURCE	OMAP2_32K_SOURCE
+#define OMAP3_CLKEV_SOURCE	OMAP3_32K_SOURCE
+#define OMAP4_CLKEV_SOURCE	OMAP4_32K_SOURCE
+#define OMAP3_BEAGLE_TIMER	12
+#else
+#define OMAP2_CLKEV_SOURCE	OMAP2_MPU_SOURCE
+#define OMAP3_CLKEV_SOURCE	OMAP3_MPU_SOURCE
+#define OMAP4_CLKEV_SOURCE	OMAP4_MPU_SOURCE
+#define OMAP3_BEAGLE_TIMER	1
+#endif

[.....]

+/*
+ * Beagle based designs typically have an issue with gptimer1. Also note
+ * that GPTIMER12 can only use the secure 32KiHz clock source.
+ */
  static void __init omap3_beagle_timer_init(void)
  {
  	omap_dm_timer_init();
-	omap2_gp_clockevent_init();
+	omap2_gp_clockevent_init(OMAP3_BEAGLE_TIMER, OMAP3_CLKEV_SOURCE);
  	omap2_gp_clocksource_init();
  }


2) In patch [6/10], you have removed wakeup timer debug
capability with comment "Later on we can reserve gptimer1
for PM code only and have similar functionality".

I don't know how this will work on OMAP. GPTIMER1 is the
only timer which is in always on power domain and wakeup
OMAP from deeper power states like CORE OSWR, CORE OFF,
DEVICE OFF.

We do implement these C-state in CPUidle as well and hence
the clock-event is expected to be of wakeup-capable.
Hence GPTIMER1 is already reserved for clock-event.

The wakeup timer used was only in suspend scenario's
and that point of time the timer system is already
suspended. So during that even if TIMER1 is re-used
for wakeup (which is the case), I don't see any issue.

At least I don't see other solution than using GPT1
for wakeup.

3) You have created few functions so that they can
be used between system timer and dmtimer driver code.
When we move the dmtimer driver to say some drivers/
directory. Is it allowed to share such functions from
device drivers

Apart from above comments, I really liked this series.
If you like you can add my,
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh


