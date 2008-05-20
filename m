From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 1/5] RT: ARM: remove non-existant trace_preempt_*_idle calls from idle loop
Date: Tue, 20 May 2008 15:45:45 -0700
Message-ID: <1211323550-5318-1-git-send-email-khilman@mvista.com>
References: <483353F0.6090902@mvista.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:36944 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762238AbYETW4z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2008 18:56:55 -0400
In-Reply-To: <483353F0.6090902@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@mvista.com>

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/kernel/process.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 9308346..a0aad84 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -171,12 +171,10 @@ void cpu_idle(void)
 			idle();
 		leds_event(led_idle_end);
 		local_irq_disable();
-		trace_preempt_exit_idle();
 		tick_nohz_restart_sched_tick();
 		__preempt_enable_no_resched();
 		__schedule();
 		preempt_disable();
-		trace_preempt_enter_idle();
 		local_irq_enable();
 	}
 }
-- 
1.5.4.1.166.g6706d

