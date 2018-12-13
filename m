From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 2/9] ARM: qcom: remove unnecessary boot_lock
Date: Thu, 13 Dec 2018 18:00:46 +0000
Message-ID: <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181213175952.GC26090@n2100.armlinux.org.uk>
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
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-oxnas@groups.io, linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-omap@vger.kernel.org

The boot_lock is something that was required for ARM development
platforms to ensure that the delay calibration worked properly.  This
is not necessary for modern platforms that have better bus bandwidth
and do not need to calibrate the delay loop for secondary cores.
Remove the boot_lock entirely.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-qcom/platsmp.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
index 5494c9e0c909..99a6a5e809e0 100644
--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -46,8 +46,6 @@
 
 extern void secondary_startup_arm(void);
 
-static DEFINE_SPINLOCK(boot_lock);
-
 #ifdef CONFIG_HOTPLUG_CPU
 static void qcom_cpu_die(unsigned int cpu)
 {
@@ -55,15 +53,6 @@ static void qcom_cpu_die(unsigned int cpu)
 }
 #endif
 
-static void qcom_secondary_init(unsigned int cpu)
-{
-	/*
-	 * Synchronise with the boot thread.
-	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
-}
-
 static int scss_release_secondary(unsigned int cpu)
 {
 	struct device_node *node;
@@ -281,24 +270,12 @@ static int qcom_boot_secondary(unsigned int cpu, int (*func)(unsigned int))
 	}
 
 	/*
-	 * set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	spin_lock(&boot_lock);
-
-	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
-	/*
-	 * now the secondary core is starting up let it run its
-	 * calibrations, then wait for it to finish
-	 */
-	spin_unlock(&boot_lock);
-
 	return ret;
 }
 
@@ -334,7 +311,6 @@ static void __init qcom_smp_prepare_cpus(unsigned int max_cpus)
 
 static const struct smp_operations smp_msm8660_ops __initconst = {
 	.smp_prepare_cpus	= qcom_smp_prepare_cpus,
-	.smp_secondary_init	= qcom_secondary_init,
 	.smp_boot_secondary	= msm8660_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= qcom_cpu_die,
@@ -344,7 +320,6 @@ CPU_METHOD_OF_DECLARE(qcom_smp, "qcom,gcc-msm8660", &smp_msm8660_ops);
 
 static const struct smp_operations qcom_smp_kpssv1_ops __initconst = {
 	.smp_prepare_cpus	= qcom_smp_prepare_cpus,
-	.smp_secondary_init	= qcom_secondary_init,
 	.smp_boot_secondary	= kpssv1_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= qcom_cpu_die,
@@ -354,7 +329,6 @@ CPU_METHOD_OF_DECLARE(qcom_smp_kpssv1, "qcom,kpss-acc-v1", &qcom_smp_kpssv1_ops)
 
 static const struct smp_operations qcom_smp_kpssv2_ops __initconst = {
 	.smp_prepare_cpus	= qcom_smp_prepare_cpus,
-	.smp_secondary_init	= qcom_secondary_init,
 	.smp_boot_secondary	= kpssv2_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= qcom_cpu_die,
-- 
2.7.4
