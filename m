From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 1/5] ARM: omap2: remove unnecessary boot_lock
Date: Thu, 13 Dec 2018 11:55:36 +0000
Message-ID: <E1gXPaa-00063v-L6@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-msm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The boot_lock is something that was required for ARM development
platforms to ensure that the delay calibration worked properly.  This
is not necessary for modern platforms that have better bus bandwidth
and do not need to calibrate the delay loop for secondary cores.
Remove the boot_lock entirely.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-omap2/omap-smp.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 1c73694c871a..10e070368f64 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -69,8 +69,6 @@ static const struct omap_smp_config omap5_cfg __initconst = {
 	.startup_addr = omap5_secondary_startup,
 };
 
-static DEFINE_SPINLOCK(boot_lock);
-
 void __iomem *omap4_get_scu_base(void)
 {
 	return cfg.scu_base;
@@ -173,12 +171,6 @@ static void omap4_secondary_init(unsigned int cpu)
 		/* Enable ACR to allow for ICUALLU workaround */
 		omap5_secondary_harden_predictor();
 	}
-
-	/*
-	 * Synchronise with the boot thread.
-	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
 }
 
 static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -188,12 +180,6 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	static struct powerdomain *cpu1_pwrdm;
 
 	/*
-	 * Set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	spin_lock(&boot_lock);
-
-	/*
 	 * Update the AuxCoreBoot0 with boot state for secondary core.
 	 * omap4_secondary_startup() routine will hold the secondary core till
 	 * the AuxCoreBoot1 register is updated with cpu state
@@ -266,12 +252,6 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
-	/*
-	 * Now the secondary core is starting up let it run its
-	 * calibrations, then wait for it to finish
-	 */
-	spin_unlock(&boot_lock);
-
 	return 0;
 }
 
-- 
2.7.4
