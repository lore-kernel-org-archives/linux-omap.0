From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 4/4] PERF: fix power:cpu_idle double end events
Date: Wed, 27 Oct 2010 01:43:25 +0200
Message-ID: <1288136605-10526-5-git-send-email-trenn@suse.de>
References: <1288136605-10526-1-git-send-email-trenn@suse.de>
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <1288136605-10526-1-git-send-email-trenn@suse.de>
Sender: linux-trace-users-owner@vger.kernel.org
To: arjan@linux.intel.com, jean.pihet@newoldbits.com, mingo@elte.hu, rjw@sisk.pl, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Robert Schoene <robert.schoene@tu-dresden.de>
List-Id: linux-omap@vger.kernel.org

cpu_idle events (transition into sleep state and exiting) are
both fired in pm_idle().

Entering sleep state and exiting should always get fired inside
pm_idle() already.

This is a revert of commit c882e0feb937af4e5b991cbd1c

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Robert Schoene <robert.schoene@tu-dresden.de>
CC: Arjan van de Ven <arjan@linux.intel.com>
CC: Ingo Molnar <mingo@elte.hu>
---
 arch/x86/kernel/process_32.c |    4 ----
 arch/x86/kernel/process_64.c |    6 ------
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 4b9befa..8d12878 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -57,8 +57,6 @@
 #include <asm/syscalls.h>
 #include <asm/debugreg.h>
 
-#include <trace/events/power.h>
-
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
 /*
@@ -113,8 +111,6 @@ void cpu_idle(void)
 			stop_critical_timings();
 			pm_idle();
 			start_critical_timings();
-			trace_power_end(smp_processor_id());
-			trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 		}
 		tick_nohz_restart_sched_tick();
 		preempt_enable_no_resched();
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 28153a9..d7b3e95 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -51,8 +51,6 @@
 #include <asm/syscalls.h>
 #include <asm/debugreg.h>
 
-#include <trace/events/power.h>
-
 asmlinkage extern void ret_from_fork(void);
 
 DEFINE_PER_CPU(unsigned long, old_rsp);
@@ -141,10 +139,6 @@ void cpu_idle(void)
 			pm_idle();
 			start_critical_timings();
 
-			trace_power_end(smp_processor_id());
-			trace_cpu_idle(PWR_EVENT_EXIT,
-				       smp_processor_id());
-
 			/* In many cases the interrupt that ended idle
 			   has already called exit_idle. But some idle
 			   loops can be woken up without interrupt. */
-- 
1.6.3

