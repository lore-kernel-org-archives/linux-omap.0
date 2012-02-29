From: Robert Lee <rob.lee@linaro.org>
Subject: [PATCH v6 9/9] SH: shmobile: Consolidate time keeping and irq enable
Date: Tue, 28 Feb 2012 21:11:49 -0600
Message-ID: <1330485109-7327-10-git-send-email-rob.lee@linaro.org>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: len.brown@intel.com, khilman@ti.com
Cc: robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Enable core cpuidle timekeeping and irq enabling and remove that
handling from this code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/sh/kernel/cpu/shmobile/cpuidle.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
index 6d62eb4..1ddc876 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -29,7 +29,6 @@ static int cpuidle_sleep_enter(struct cpuidle_device *dev,
 				int index)
 {
 	unsigned long allowed_mode = SUSP_SH_SLEEP;
-	ktime_t before, after;
 	int requested_state = index;
 	int allowed_state;
 	int k;
@@ -47,19 +46,16 @@ static int cpuidle_sleep_enter(struct cpuidle_device *dev,
 	 */
 	k = min_t(int, allowed_state, requested_state);
 
-	before = ktime_get();
 	sh_mobile_call_standby(cpuidle_mode[k]);
-	after = ktime_get();
-
-	dev->last_residency = (int)ktime_to_ns(ktime_sub(after, before)) >> 10;
 
 	return k;
 }
 
 static struct cpuidle_device cpuidle_dev;
 static struct cpuidle_driver cpuidle_driver = {
-	.name =		"sh_idle",
-	.owner =	THIS_MODULE,
+	.name			= "sh_idle",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
 };
 
 void sh_mobile_setup_cpuidle(void)
-- 
1.7.1

