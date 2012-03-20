From: Robert Lee <rob.lee@linaro.org>
Subject: [PATCH v8 5/8] ARM: omap: Consolidate OMAP3 time keeping and irq
 enable
Date: Tue, 20 Mar 2012 15:22:46 -0500
Message-ID: <1332274969-15782-6-git-send-email-rob.lee@linaro.org>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: len.brown@intel.com
Cc: nicolas.pitre@linaro.org, venki@google.com, linaro-dev@lists.linaro.org, linux-sh@vger.kernel.org, tony@atomide.com, nicolas.ferre@atmel.com, linux@arm.linux.org.uk, ccross@google.com, kernel@wantstofly.org, khilman@ti.com, kgene.kim@samsung.com, mturquette@linaro.org, daniel.lezcano@linaro.org, magnus.damm@gmail.com, arnd.bergmann@linaro.org, jon-hunter@ti.com, patches@linaro.org, nsekhar@ti.com, jean.pihet@newoldbits.com, rjw@sisk.pl, Baohua.Song@csr.com, vincent.guittot@linaro.org, linux-omap@vger.kernel.org, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, g.trinabh@gmail.com, linux-pm@vger.kernel.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, lethal@linux-sh.org, amit.kachhap@linaro.org, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

Use core cpuidle timekeeping and irqen wrapper and remove that
handling from this code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Jean Pihet<j-pihet@ti.com>
Acked-by: Jean Pihet<j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   42 +++++++++++++++----------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 464cffd..5358664 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -87,29 +87,14 @@ static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
 	return 0;
 }
 
-/**
- * omap3_enter_idle - Programs OMAP3 to enter the specified state
- * @dev: cpuidle device
- * @drv: cpuidle driver
- * @index: the index of state to be entered
- *
- * Called from the CPUidle framework to program the device to the
- * specified target state selected by the governor.
- */
-static int omap3_enter_idle(struct cpuidle_device *dev,
+static int __omap3_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
 	struct omap3_idle_statedata *cx =
 			cpuidle_get_statedata(&dev->states_usage[index]);
-	struct timespec ts_preidle, ts_postidle, ts_idle;
 	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
-	int idle_time;
-
-	/* Used to keep track of the total time in idle */
-	getnstimeofday(&ts_preidle);
 
-	local_irq_disable();
 	local_fiq_disable();
 
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
@@ -148,22 +133,29 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	}
 
 return_sleep_time:
-	getnstimeofday(&ts_postidle);
-	ts_idle = timespec_sub(ts_postidle, ts_preidle);
 
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
 
 /**
+ * omap3_enter_idle - Programs OMAP3 to enter the specified state
+ * @dev: cpuidle device
+ * @drv: cpuidle driver
+ * @index: the index of state to be entered
+ *
+ * Called from the CPUidle framework to program the device to the
+ * specified target state selected by the governor.
+ */
+static inline int omap3_enter_idle(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	return cpuidle_wrap_enter(dev, drv, index, __omap3_enter_idle);
+}
+
+/**
  * next_valid_state - Find next valid C-state
  * @dev: cpuidle device
  * @drv: cpuidle driver
-- 
1.7.9.4
