From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] ARM: OMAP5: Fix mpuss_early_init
Date: Wed, 26 Oct 2016 13:21:11 -0700
Message-ID: <20161026202111.6jwclrnxnslnhqay@atomide.com>
References: <20161026151703.24730-1-tony@atomide.com>
 <20161026151703.24730-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161026151703.24730-3-tony@atomide.com>
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
Cc: Nishanth Menon <nm@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>, Dave Gerlach <d-gerlach@ti.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Pau Pajuel <ppajuel@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Robert Nelson <robertcnelson@gmail.com>, Marek Belisko <marek@goldelico.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [161026 08:18]:
> We need to properly initialize mpuss also on omap5 like we do on omap4.
> Otherwise we run into similar kexec problems like we had on omap4 when
> trying to kexec from a kernel with PM initialized.
...

> +	else if (cpu_is_omap446x())
>  		startup_pa = virt_to_phys(omap4460_secondary_startup);
> +	else
> +		startup_pa = virt_to_phys(omap5_secondary_startup);

Here we need to check for omap5_secondary_hyp_startup too. And with
omap4 and omap5 being optional, we need to fix up things for make
randconfig builds as reported by the kbuild test robot.

Updated patch below.

Regards,

Tony

8< -----------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 25 Oct 2016 08:33:32 -0700
Subject: [PATCH] ARM: OMAP5: Fix mpuss_early_init

We need to properly initialize mpuss also on omap5 like we do on omap4.
Otherwise we run into similar kexec problems like we had on omap4 when
trying to kexec from a kernel with PM initialized.

Fixes: 0573b957fc21 ("ARM: OMAP4+: Prevent CPU1 related hang with kexec")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h              | 38 +++++++++++++++++++++++--------
 arch/arm/mach-omap2/io.c                  |  3 ++-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 32 ++++++++++++++++++++------
 arch/arm/mach-omap2/omap4-sar-layout.h    |  2 ++
 4 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -262,8 +262,6 @@ extern void __iomem *omap4_get_sar_ram_base(void);
 extern void omap4_mpuss_early_init(void);
 extern void omap_do_wfi(void);
 
-extern void omap4_secondary_startup(void);
-extern void omap4460_secondary_startup(void);
 
 #ifdef CONFIG_SMP
 /* Needed for secondary core boot */
@@ -275,16 +273,11 @@ extern void omap4_cpu_die(unsigned int cpu);
 extern int omap4_cpu_kill(unsigned int cpu);
 
 extern const struct smp_operations omap4_smp_ops;
-
-extern void omap5_secondary_startup(void);
-extern void omap5_secondary_hyp_startup(void);
 #endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PM)
 extern int omap4_mpuss_init(void);
 extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
-extern int omap4_finish_suspend(unsigned long cpu_state);
-extern void omap4_cpu_resume(void);
 extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
 #else
 static inline int omap4_enter_lowpower(unsigned int cpu,
@@ -305,14 +298,41 @@ static inline int omap4_mpuss_init(void)
 	return 0;
 }
 
+#endif
+
+#ifdef CONFIG_ARCH_OMAP4
+void omap4_secondary_startup(void);
+void omap4460_secondary_startup(void);
+int omap4_finish_suspend(unsigned long cpu_state);
+void omap4_cpu_resume(void);
+#else
+static inline void omap4_secondary_startup(void)
+{
+}
+
+static inline void omap4460_secondary_startup(void)
+{
+}
 static inline int omap4_finish_suspend(unsigned long cpu_state)
 {
 	return 0;
 }
-
 static inline void omap4_cpu_resume(void)
-{}
+{
+}
+#endif
 
+#if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
+void omap5_secondary_startup(void);
+void omap5_secondary_hyp_startup(void);
+#else
+static inline void omap5_secondary_startup(void)
+{
+}
+
+static inline void omap5_secondary_hyp_startup(void)
+{
+}
 #endif
 
 void pdata_quirks_init(const struct of_device_id *);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -717,10 +717,11 @@ void __init omap5_init_early(void)
 			      OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap2_control_base_init();
-	omap4_pm_init_early();
 	omap2_prcm_base_init();
 	omap5xxx_check_revision();
 	omap4_sar_ram_init();
+	omap4_mpuss_early_init();
+	omap4_pm_init_early();
 	omap54xx_voltagedomains_init();
 	omap54xx_powerdomains_init();
 	omap54xx_clockdomains_init();
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -48,6 +48,7 @@
 #include <asm/smp_scu.h>
 #include <asm/pgalloc.h>
 #include <asm/suspend.h>
+#include <asm/virt.h>
 #include <asm/hardware/cache-l2x0.h>
 
 #include "soc.h"
@@ -371,8 +372,12 @@ int __init omap4_mpuss_init(void)
 	pm_info = &per_cpu(omap4_pm_info, 0x0);
 	if (sar_base) {
 		pm_info->scu_sar_addr = sar_base + SCU_OFFSET0;
-		pm_info->wkup_sar_addr = sar_base +
-					CPU0_WAKEUP_NS_PA_ADDR_OFFSET;
+		if (cpu_is_omap44xx())
+			pm_info->wkup_sar_addr = sar_base +
+				CPU0_WAKEUP_NS_PA_ADDR_OFFSET;
+		else
+			pm_info->wkup_sar_addr = sar_base +
+				OMAP5_CPU0_WAKEUP_NS_PA_ADDR_OFFSET;
 		pm_info->l2x0_sar_addr = sar_base + L2X0_SAVE_OFFSET0;
 	}
 	pm_info->pwrdm = pwrdm_lookup("cpu0_pwrdm");
@@ -391,8 +396,12 @@ int __init omap4_mpuss_init(void)
 	pm_info = &per_cpu(omap4_pm_info, 0x1);
 	if (sar_base) {
 		pm_info->scu_sar_addr = sar_base + SCU_OFFSET1;
-		pm_info->wkup_sar_addr = sar_base +
-					CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
+		if (cpu_is_omap44xx())
+			pm_info->wkup_sar_addr = sar_base +
+				CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
+		else
+			pm_info->wkup_sar_addr = sar_base +
+				OMAP5_CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
 		pm_info->l2x0_sar_addr = sar_base + L2X0_SAVE_OFFSET1;
 	}
 
@@ -453,15 +462,24 @@ void __init omap4_mpuss_early_init(void)
 {
 	unsigned long startup_pa;
 
-	if (!cpu_is_omap44xx())
+	if (!(cpu_is_omap44xx() || soc_is_omap54xx()))
 		return;
 
 	sar_base = omap4_get_sar_ram_base();
 
 	if (cpu_is_omap443x())
 		startup_pa = virt_to_phys(omap4_secondary_startup);
-	else
+	else if (cpu_is_omap446x())
 		startup_pa = virt_to_phys(omap4460_secondary_startup);
+	else if ((__boot_cpu_mode & MODE_MASK) == HYP_MODE)
+		startup_pa = virt_to_phys(omap5_secondary_hyp_startup);
+	else
+		startup_pa = virt_to_phys(omap5_secondary_startup);
 
-	writel_relaxed(startup_pa, sar_base + CPU1_WAKEUP_NS_PA_ADDR_OFFSET);
+	if (cpu_is_omap44xx())
+		writel_relaxed(startup_pa, sar_base +
+			       CPU1_WAKEUP_NS_PA_ADDR_OFFSET);
+	else
+		writel_relaxed(startup_pa, sar_base +
+			       OMAP5_CPU1_WAKEUP_NS_PA_ADDR_OFFSET);
 }
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -31,6 +31,8 @@
 /* CPUx Wakeup Non-Secure Physical Address offsets in SAR_BANK3 */
 #define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
 #define CPU1_WAKEUP_NS_PA_ADDR_OFFSET		0xa08
+#define OMAP5_CPU0_WAKEUP_NS_PA_ADDR_OFFSET	0xe00
+#define OMAP5_CPU1_WAKEUP_NS_PA_ADDR_OFFSET	0xe04
 
 #define SAR_BACKUP_STATUS_OFFSET		(SAR_BANK3_OFFSET + 0x500)
 #define SAR_SECURE_RAM_SIZE_OFFSET		(SAR_BANK3_OFFSET + 0x504)
-- 
2.9.3
