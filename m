From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: OMAP5: Enable CPU off idle states
Date: Thu, 17 Aug 2017 16:01:22 -0700
Message-ID: <20170817230122.30655-4-tony@atomide.com>
References: <20170817230122.30655-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170817230122.30655-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

With the idle code in place needed for supporting off mode for cpus,
let's enable it. This seems to save about 0.2W of power compared to
CPU retention states based on quick measurement on omap5-uevm.

Some parts of the code is based on an earlier patch done by Santosh
Shilimkar <santosh.shilimkar@oracle.com> in TI Linux kernel tree as
commit 7e3035cf0e9b ("ARM: OMAP4+: CPUidle: Add OMAP5 idle driver
support")

Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c           | 14 ++++++++++++++
 arch/arm/mach-omap2/pm44xx.c                |  2 +-
 arch/arm/mach-omap2/powerdomains54xx_data.c | 10 +++++-----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -63,6 +63,11 @@ static struct idle_statedata omap5_idle_data[] = {
 		.mpu_state = PWRDM_POWER_RET,
 		.mpu_logic_state = PWRDM_POWER_RET,
 	},
+	{
+		.cpu_state = PWRDM_POWER_OFF,
+		.mpu_state = PWRDM_POWER_RET,
+		.mpu_logic_state = PWRDM_POWER_OFF,
+	},
 };
 
 static struct idle_statedata dra7_idle_data[] = {
@@ -296,6 +301,15 @@ static struct cpuidle_driver omap5_idle_driver = {
 			.name = "C2",
 			.desc = "CPUx CSWR, MPUSS CSWR",
 		},
+		{
+			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
+			.exit_latency = 460 + 518,
+			.target_residency = 1100,
+			.flags = CPUIDLE_FLAG_TIMER_STOP | CPUIDLE_FLAG_COUPLED,
+			.enter = omap_enter_idle_coupled,
+			.name = "C3",
+			.desc = "CPUx OFF, MPUSS OSWR",
+		},
 	},
 	.state_count = ARRAY_SIZE(omap5_idle_data),
 	.safe_state_index = 0,
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -225,7 +225,7 @@ int __init omap4_pm_init_early(void)
 	if (cpu_is_omap446x())
 		pm44xx_errata |= PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD;
 
-	if (soc_is_omap54xx() || soc_is_dra7xx())
+	if (soc_is_dra7xx())
 		pm44xx_errata |= PM_OMAP4_CPU_OSWR_DISABLE;
 
 	return 0;
diff --git a/arch/arm/mach-omap2/powerdomains54xx_data.c b/arch/arm/mach-omap2/powerdomains54xx_data.c
--- a/arch/arm/mach-omap2/powerdomains54xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains54xx_data.c
@@ -107,8 +107,8 @@ static struct powerdomain cpu0_54xx_pwrdm = {
 	.voltdm		  = { .name = "mpu" },
 	.prcm_offs	  = OMAP54XX_PRCM_MPU_PRM_C0_INST,
 	.prcm_partition	  = OMAP54XX_PRCM_MPU_PARTITION,
-	.pwrsts		  = PWRSTS_RET_ON,
-	.pwrsts_logic_ret = PWRSTS_RET,
+	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* cpu0_l1 */
@@ -124,8 +124,8 @@ static struct powerdomain cpu1_54xx_pwrdm = {
 	.voltdm		  = { .name = "mpu" },
 	.prcm_offs	  = OMAP54XX_PRCM_MPU_PRM_C1_INST,
 	.prcm_partition	  = OMAP54XX_PRCM_MPU_PARTITION,
-	.pwrsts		  = PWRSTS_RET_ON,
-	.pwrsts_logic_ret = PWRSTS_RET,
+	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* cpu1_l1 */
@@ -158,7 +158,7 @@ static struct powerdomain mpu_54xx_pwrdm = {
 	.prcm_offs	  = OMAP54XX_PRM_MPU_INST,
 	.prcm_partition	  = OMAP54XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_RET_ON,
-	.pwrsts_logic_ret = PWRSTS_RET,
+	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 2,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* mpu_l2 */
-- 
2.14.1
