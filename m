From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: OMAP2+: Separate dra7 cpuidle from omap5
Date: Thu, 17 Aug 2017 16:01:20 -0700
Message-ID: <20170817230122.30655-2-tony@atomide.com>
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

As omap5 supports deeper idle states compared to dra7, let's
separate dra7 from omap5 in preparation for adding more support
for omap5.

Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c | 42 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -65,6 +65,19 @@ static struct idle_statedata omap5_idle_data[] = {
 	},
 };
 
+static struct idle_statedata dra7_idle_data[] = {
+	{
+		.cpu_state = PWRDM_POWER_ON,
+		.mpu_state = PWRDM_POWER_ON,
+		.mpu_logic_state = PWRDM_POWER_ON,
+	},
+	{
+		.cpu_state = PWRDM_POWER_RET,
+		.mpu_state = PWRDM_POWER_RET,
+		.mpu_logic_state = PWRDM_POWER_RET,
+	},
+};
+
 static struct powerdomain *mpu_pd, *cpu_pd[MAX_CPUS];
 static struct clockdomain *cpu_clkdm[MAX_CPUS];
 
@@ -288,6 +301,32 @@ static struct cpuidle_driver omap5_idle_driver = {
 	.safe_state_index = 0,
 };
 
+static struct cpuidle_driver dra7_idle_driver = {
+	.name				= "dra7_idle",
+	.owner				= THIS_MODULE,
+	.states = {
+		{
+			/* C1 - CPU0 ON + CPU1 ON + MPU ON */
+			.exit_latency = 2 + 2,
+			.target_residency = 5,
+			.enter = omap_enter_idle_simple,
+			.name = "C1",
+			.desc = "CPUx WFI, MPUSS ON"
+		},
+		{
+			/* C2 - CPU0 RET + CPU1 RET + MPU CSWR */
+			.exit_latency = 48 + 60,
+			.target_residency = 100,
+			.flags = CPUIDLE_FLAG_TIMER_STOP,
+			.enter = omap_enter_idle_smp,
+			.name = "C2",
+			.desc = "CPUx CSWR, MPUSS CSWR",
+		},
+	},
+	.state_count = ARRAY_SIZE(dra7_idle_data),
+	.safe_state_index = 0,
+};
+
 /* Public functions */
 
 /**
@@ -303,6 +342,9 @@ int __init omap4_idle_init(void)
 	if (soc_is_omap54xx()) {
 		state_ptr = &omap5_idle_data[0];
 		idle_driver = &omap5_idle_driver;
+	} else if (soc_is_dra7xx()) {
+		state_ptr = &dra7_idle_data[0];
+		idle_driver = &dra7_idle_driver;
 	} else {
 		state_ptr = &omap4_idle_data[0];
 		idle_driver = &omap4_idle_driver;
-- 
2.14.1
