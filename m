From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap4: clocks: Remove clock hacks from timer-gp.c
Date: Tue, 16 Feb 2010 21:11:25 +0530
Message-ID: <1266334896-30686-13-git-send-email-santosh.shilimkar@ti.com>
References: <1266334896-30686-1-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-2-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-3-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-4-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-5-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-6-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-7-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-8-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-9-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-10-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-11-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-12-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49222 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588Ab0BPPl7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 10:41:59 -0500
In-Reply-To: <1266334896-30686-12-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Now the omap4 clock framework is mainline and clk_get_rate()
is functional. Hence reomve the hardcoded clock hacks.

This patch also fixes
Division by zero in kernel.
Backtrace:
[<c0025fb8>] (dump_backtrace+0x0/0x110) from [<c017febc>] (dump_stack+0x18/0x1c)
 r7:60000093 r6:c0641050 r5:c0223e78 r4:c02126b4
[<c017fea4>] (dump_stack+0x0/0x1c) from [<c00260fc>] (__div0+0x18/0x20)
[<c00260e4>] (__div0+0x0/0x20) from [<c01431fc>] (Ldiv0+0x8/0x10)
[<c00318d4>] (omap_dm_timer_stop+0x0/0xb0) from [<c002c148>] (omap2_gp_timer_set_mode+0x1c/0x68)
 r5:c0223e78 r4:00000000
[<c002c12c>] (omap2_gp_timer_set_mode+0x0/0x68) from [<c0063270>] (clockevents_set_mode+0x30/0x64)
 r5:c020cae0 r4:00000000
[<c0063240>] (clockevents_set_mode+0x0/0x64) from [<c00632fc>] (clockevents_exchange_device+0x30/0x9c)
 r5:c020cae0 r4:c02146e0
[<c00632cc>] (clockevents_exchange_device+0x0/0x9c) from [<c00636e0>] (tick_notify+0x17c/0x404)
 r7:00000000 r6:c0641050 r5:00000000 r4:c020cae0
[<c0063564>] (tick_notify+0x0/0x404) from [<c005d5fc>] (notifier_call_chain+0x34/0x78)
[<c005d5c8>] (notifier_call_chain+0x0/0x78) from [<c005d684>] (__raw_notifier_call_chain+0x1c/0x24)
[<c005d668>] (__raw_notifier_call_chain+0x0/0x24) from [<c005d6ac>] (raw_notifier_call_chain+0x20/0x28)
[<c005d68c>] (raw_notifier_call_chain+0x0/0x28) from [<c0062e78>] (clockevents_do_notify+0x1c/0x24)
[<c0062e5c>] (clockevents_do_notify+0x0/0x24) from [<c0062f18>] (clockevents_register_device+0x98/0xd0)
[<c0062e80>] (clockevents_register_device+0x0/0xd0) from [<c001a194>] (percpu_timer_setup+0x80/0x9c)
 r7:00000000 r6:00000002 r5:00000002 r4:00000003
[<c001a114>] (percpu_timer_setup+0x0/0x9c) from [<c000e9f0>] (smp_prepare_cpus+0xb0/0xe8)
[<c000e940>] (smp_prepare_cpus+0x0/0xe8) from [<c00084e8>] (kernel_init+0x5c/0x1fc)
 r7:00000000 r6:00000000 r5:00000000 r4:c001b8a4
[<c000848c>] (kernel_init+0x0/0x1fc) from [<c0046c50>] (do_exit+0x0/0x604)
 r7:00000000 r6:00000000 r5:00000000 r4:00000000

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer-gp.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index cd04dea..74fbed8 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -85,8 +85,6 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_PERIODIC:
 		period = clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
 		period -= 1;
-		if (cpu_is_omap44xx())
-			period = 0xff;	/* FIXME: */
 		omap_dm_timer_set_load_start(gptimer, 1, 0xffffffff - period);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
@@ -150,9 +148,6 @@ static void __init omap2_gp_clockevent_init(void)
 		     "timer-gp: omap_dm_timer_set_source() failed\n");
 
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer));
-	if (cpu_is_omap44xx())
-		/* Assuming 32kHz clk is driving GPT1 */
-		tick_rate = 32768;	/* FIXME: */
 
 	pr_info("OMAP clockevent source: GPTIMER%d at %u Hz\n",
 		gptimer_id, tick_rate);
-- 
1.6.0.4

