From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 1/2] Revert "ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()"
Date: Thu, 17 Oct 2013 12:24:07 +0300
Message-ID: <525FACB7.9000903@ti.com>
References: <1382000776-15897-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382000776-15897-2-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: open list <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Taras Kondratiuk <taras.kondratiuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

The same workaround as ff999b8a0983ee15668394ed49e38d3568fc6859
"ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX GIC control 
register change."
need to be applied not only when system is booting, but when MPU hits 
OSWR state through CPUIdle too.

Unfortunately, commit "ARM: OMAP4+: CPUidle: Deprecate use of
omap4_mpuss_read_prev_context_state()" prevents us from implementing 
workaround
for this ROM code bug, because it should be applied only (and only)
when MPU really hits OSWR and its was lost context.

Hence revert commit e7457253494fff660a72bc0cedeee97491ccd173
"ARM: OMAP4+: CPUidle: Deprecate use of 
omap4_mpuss_read_prev_context_state()".

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>
Reported-and-Tested-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
  arch/arm/mach-omap2/common.h              |    5 +++++
  arch/arm/mach-omap2/cpuidle44xx.c         |    3 +--
  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   14 ++++++++++++++
  3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 4a5684b..b875a4a 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -259,6 +259,7 @@ extern int omap4_enter_lowpower(unsigned int cpu, 
unsigned int power_state);
  extern int omap4_finish_suspend(unsigned long cpu_state);
  extern void omap4_cpu_resume(void);
  extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
+extern u32 omap4_mpuss_read_prev_context_state(void);
  #else
  static inline int omap4_enter_lowpower(unsigned int cpu,
  					unsigned int power_state)
@@ -286,6 +287,10 @@ static inline int omap4_finish_suspend(unsigned 
long cpu_state)
  static inline void omap4_cpu_resume(void)
  {}

+static inline u32 omap4_mpuss_read_prev_context_state(void)
+{
+	return 0;
+}
  #endif

  struct omap_sdrc_params;
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c 
b/arch/arm/mach-omap2/cpuidle44xx.c
index 4c8982a..384aa1c 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -143,8 +143,7 @@ static int omap_enter_idle_coupled(struct 
cpuidle_device *dev,
  	 * Call idle CPU cluster PM exit notifier chain
  	 * to restore GIC and wakeupgen context.
  	 */
-	if (dev->cpu == 0 && (cx->mpu_state == PWRDM_POWER_RET) &&
-		(cx->mpu_logic_state == PWRDM_POWER_OFF))
+	if (dev->cpu == 0 && omap4_mpuss_read_prev_context_state())
  		cpu_cluster_pm_exit();

  fail:
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c 
b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index f991016..178caa8 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -172,6 +172,20 @@ static inline void 
cpu_clear_prev_logic_pwrst(unsigned int cpu_id)
  	}
  }

+/**
+ * omap4_mpuss_read_prev_context_state:
+ * Function returns the MPUSS previous context state
+ */
+u32 omap4_mpuss_read_prev_context_state(void)
+{
+	u32 reg;
+
+	reg = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
+		OMAP4430_PRM_MPU_INST, OMAP4_RM_MPU_MPU_CONTEXT_OFFSET);
+	reg &= OMAP4430_LOSTCONTEXT_DFF_MASK;
+	return reg;
+}
+
  /*
   * Store the CPU cluster state for L2X0 low power operations.
   */
-- 
1.7.9.5
