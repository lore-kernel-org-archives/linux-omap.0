From: Robert Lee <rob.lee@linaro.org>
Subject: [PATCH v7 7/9] ARM: omap: Consolidate OMAP4 time keeping and irq enable
Date: Wed, 29 Feb 2012 18:42:56 -0600
Message-ID: <1330562578-3410-8-git-send-email-rob.lee@linaro.org>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: rjw@sisk.pl, len.brown@intel.com
Cc: khilman@ti.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Enable core cpuidle timekeeping and irq enabling and remove that
handling from this code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   21 +++------------------
 1 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index cfdbb86..e2ff9f6 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -62,16 +62,10 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 {
 	struct omap4_idle_statedata *cx =
 			cpuidle_get_statedata(&dev->states_usage[index]);
-	struct timespec ts_preidle, ts_postidle, ts_idle;
 	u32 cpu1_state;
-	int idle_time;
 	int new_state_idx;
 	int cpu_id = smp_processor_id();
 
-	/* Used to keep track of the total time in idle */
-	getnstimeofday(&ts_preidle);
-
-	local_irq_disable();
 	local_fiq_disable();
 
 	/*
@@ -129,26 +123,17 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	if (index > 0)
 		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
 
-	getnstimeofday(&ts_postidle);
-	ts_idle = timespec_sub(ts_postidle, ts_preidle);
-
-	local_irq_enable();
 	local_fiq_enable();
 
-	idle_time = ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * \
-								USEC_PER_SEC;
-
-	/* Update cpuidle counters */
-	dev->last_residency = idle_time;
-
 	return index;
 }
 
 DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
 
 struct cpuidle_driver omap4_idle_driver = {
-	.name =		"omap4_idle",
-	.owner =	THIS_MODULE,
+	.name				= "omap4_idle",
+	.owner				= THIS_MODULE,
+	.en_core_tk_irqen		= 1,
 };
 
 static inline void _fill_cstate(struct cpuidle_driver *drv,
-- 
1.7.1

