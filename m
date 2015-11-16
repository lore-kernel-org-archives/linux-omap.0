From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH RESEND] ARM: OMAP2+: PM: Denote the cpuidle tracepoints as _rcuidle()
Date: Mon, 16 Nov 2015 18:09:21 +0800
Message-ID: <1447668561-6587-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@deeprootsystems.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-omap@vger.kernel.org

The cpuidle tracepoints are called within a rcu_idle_exit() section, and
must be denoted with the _rcuidle() version of the tracepoint.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/mach-omap2/pm34xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 87b98bf9..2dbd378 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -301,11 +301,11 @@ static void omap3_pm_idle(void)
 	if (omap_irq_pending())
 		return;
 
-	trace_cpu_idle(1, smp_processor_id());
+	trace_cpu_idle_rcuidle(1, smp_processor_id());
 
 	omap_sram_idle();
 
-	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
+	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 
 #ifdef CONFIG_SUSPEND
-- 
2.6.2
