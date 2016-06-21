From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP4+: Prevent CPU1 related hang with kexec
Date: Tue, 21 Jun 2016 00:52:43 -0700
Message-ID: <1466495565-17480-3-git-send-email-tony@atomide.com>
References: <1466495565-17480-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466495565-17480-1-git-send-email-tony@atomide.com>
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
Cc: Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Kexec booted kernels on omap4 will hang early during the boot if the
booted kernel is different version from the previous kernel.

This is because the previous kernel may have configured low-power mode
using CPU1_WAKEUP_NS_PA_ADDR. In that case it points to the previous
kernel's omap4_secondary_startup(), and CPU1 can be in low power mode
from the previous kernel. When the new kernel configures the CPU1
clockdomain, CPU1 can wake from low power state prematurely during
omap44xx_clockdomains_init() running random code.

Let's fix the issue by configuring CPU1_WAKEUP_NS_PA_ADDR before we
call omap44xx_clockdomains_init(). Note that this is very early during
the init, and we will do proper CPU1 reset during SMP init a bit later
on in omap4_smp_prepare_cpus(). And we need to do this when SMP is
not enabled as the previous kernel may have had it enabled.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile              |  4 ++--
 arch/arm/mach-omap2/common.h              |  6 ++++--
 arch/arm/mach-omap2/io.c                  |  1 +
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 29 +++++++++++++++++++++++++----
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 04e276c..cd820f5 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -8,7 +8,7 @@ ccflags-y := -I$(srctree)/$(src)/include \
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
-	 omap_device.o sram.o drm.o
+	 omap_device.o omap-headsmp.o sram.o drm.o
 
 hwmod-common				= omap_hwmod.o omap_hwmod_reset.o \
 					  omap_hwmod_common_data.o
@@ -32,7 +32,7 @@ obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+= sdrc.o
 
 # SMP support ONLY available for OMAP4
 
-smp-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
+smp-$(CONFIG_SMP)			+= omap-smp.o
 smp-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
 omap-4-5-common				=  omap4-common.o omap-wakeupgen.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-common) $(smp-y) sleep44xx.o
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 9cbae6e..0136405 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -259,12 +259,14 @@ extern void gic_timer_retrigger(void);
 extern void omap_smc1(u32 fn, u32 arg);
 extern void omap4_sar_ram_init(void);
 extern void __iomem *omap4_get_sar_ram_base(void);
+extern void omap4_mpuss_early_init(void);
 extern void omap_do_wfi(void);
 
-#ifdef CONFIG_SMP
-/* Needed for secondary core boot */
 extern void omap4_secondary_startup(void);
 extern void omap4460_secondary_startup(void);
+
+#ifdef CONFIG_SMP
+/* Needed for secondary core boot */
 extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
 extern void omap_auxcoreboot_addr(u32 cpu_addr);
 extern u32 omap_read_auxcoreboot0(void);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4548cb9..0e9acdd 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -691,6 +691,7 @@ void __init omap4430_init_early(void)
 	omap4xxx_check_features();
 	omap2_prcm_base_init();
 	omap4_sar_ram_init();
+	omap4_mpuss_early_init();
 	omap4_pm_init_early();
 	omap44xx_voltagedomains_init();
 	omap44xx_powerdomains_init();
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 65024af..1751517 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -62,6 +62,8 @@
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
 
+static void __iomem *sar_base;
+
 #ifdef CONFIG_SMP
 
 struct omap4_cpu_pm_info {
@@ -90,7 +92,6 @@ struct cpu_pm_ops {
 
 static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
 static struct powerdomain *mpuss_pd;
-static void __iomem *sar_base;
 static u32 cpu_context_offset;
 
 static int default_finish_suspend(unsigned long cpu_state)
@@ -366,9 +367,6 @@ int __init omap4_mpuss_init(void)
 		return -ENODEV;
 	}
 
-	if (cpu_is_omap44xx())
-		sar_base = omap4_get_sar_ram_base();
-
 	/* Initilaise per CPU PM information */
 	pm_info = &per_cpu(omap4_pm_info, 0x0);
 	if (sar_base) {
@@ -444,3 +442,26 @@ int __init omap4_mpuss_init(void)
 }
 
 #endif
+
+/*
+ * For kexec, we must set CPU1_WAKEUP_NS_PA_ADDR to point to
+ * current kernel's secondary_startup() early before
+ * clockdomains_init(). Otherwise clockdomain_init() can
+ * wake CPU1 and cause a hang.
+ */
+void __init omap4_mpuss_early_init(void)
+{
+	unsigned long startup_pa;
+
+	if (!cpu_is_omap44xx())
+		return;
+
+	sar_base = omap4_get_sar_ram_base();
+
+	if (cpu_is_omap443x())
+		startup_pa = virt_to_phys(omap4_secondary_startup);
+	else
+		startup_pa = virt_to_phys(omap4460_secondary_startup);
+
+	writel_relaxed(startup_pa, sar_base + CPU1_WAKEUP_NS_PA_ADDR_OFFSET);
+}
-- 
2.8.1
