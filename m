From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM: omap2+: make omap4_get_cpu1_ns_pa_addr declaration usable
Date: Fri, 21 Apr 2017 23:55:28 +0200
Message-ID: <20170421215556.2244576-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

When CONFIG_PM is disabled, we get a build error:

arch/arm/mach-omap2/omap-smp.c: In function 'omap4_smp_maybe_reset_cpu1':
arch/arm/mach-omap2/omap-smp.c:309:20: error: implicit declaration of function 'omap4_get_cpu1_ns_pa_addr'; did you mean 'omap4_get_scu_base'? [-Werror=implicit-function-declaration]

We need to fix this in multiple files, to ensure the declaration is visible,
to actually build the function without CONFIG_PM, and to only call it
when OMAP4 and/or OMAP5 are enabled.

Fixes: 351b7c490700 ("ARM: omap2+: Revert omap-smp.c changes resetting CPU1 during boot")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/common.h              |  3 ++-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 10 +++++-----
 arch/arm/mach-omap2/omap-smp.c            | 11 +++++++----
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 3089d3bfa19b..8cc6338fcb12 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -266,11 +266,12 @@ extern int omap4_cpu_kill(unsigned int cpu);
 extern const struct smp_operations omap4_smp_ops;
 #endif
 
+extern u32 omap4_get_cpu1_ns_pa_addr(void);
+
 #if defined(CONFIG_SMP) && defined(CONFIG_PM)
 extern int omap4_mpuss_init(void);
 extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
 extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
-extern u32 omap4_get_cpu1_ns_pa_addr(void);
 #else
 static inline int omap4_enter_lowpower(unsigned int cpu,
 					unsigned int power_state)
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 03ec6d307c82..4cfc4f9b2c69 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -213,11 +213,6 @@ static void __init save_l2x0_context(void)
 {}
 #endif
 
-u32 omap4_get_cpu1_ns_pa_addr(void)
-{
-	return old_cpu1_ns_pa_addr;
-}
-
 /**
  * omap4_enter_lowpower: OMAP4 MPUSS Low Power Entry Function
  * The purpose of this function is to manage low power programming
@@ -457,6 +452,11 @@ int __init omap4_mpuss_init(void)
 
 #endif
 
+u32 omap4_get_cpu1_ns_pa_addr(void)
+{
+	return old_cpu1_ns_pa_addr;
+}
+
 /*
  * For kexec, we must set CPU1_WAKEUP_NS_PA_ADDR to point to
  * current kernel's secondary_startup() early before
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 3faf454ba487..33e4953c61a8 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -306,7 +306,6 @@ static void __init omap4_smp_maybe_reset_cpu1(struct omap_smp_config *c)
 
 	cpu1_startup_pa = readl_relaxed(cfg.wakeupgen_base +
 					OMAP_AUX_CORE_BOOT_1);
-	cpu1_ns_pa_addr = omap4_get_cpu1_ns_pa_addr();
 
 	/* Did the configured secondary_startup() get overwritten? */
 	if (!omap4_smp_cpu1_startup_valid(cpu1_startup_pa))
@@ -316,9 +315,13 @@ static void __init omap4_smp_maybe_reset_cpu1(struct omap_smp_config *c)
 	 * If omap4 or 5 has NS_PA_ADDR configured, CPU1 may be in a
 	 * deeper idle state in WFI and will wake to an invalid address.
 	 */
-	if ((soc_is_omap44xx() || soc_is_omap54xx()) &&
-	    !omap4_smp_cpu1_startup_valid(cpu1_ns_pa_addr))
-		needs_reset = true;
+	if ((soc_is_omap44xx() || soc_is_omap54xx())) {
+		cpu1_ns_pa_addr = omap4_get_cpu1_ns_pa_addr();
+		if (!omap4_smp_cpu1_startup_valid(cpu1_ns_pa_addr))
+			needs_reset = true;
+	} else {
+		cpu1_ns_pa_addr = 0;
+	}
 
 	if (!needs_reset || !c->cpu1_rstctrl_va)
 		return;
-- 
2.9.0
