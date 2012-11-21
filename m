From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP2+: PRM: initialize some PRM functions early
Date: Wed, 21 Nov 2012 23:09:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211212308210.32242@utopia.booyaka.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


Some PRM functions will need to be called by the hwmod code early in
kernel init.  To handle this, split the PRM initialization code into
early and late phases.  The early init is handled via mach-omap2/io.c,
while the late init is handled by subsys_initcall().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

This one is needed in order for the updated version of "ARM: OMAP: hwmod: 
Add support for per hwmod/module context lost count" to work correctly.

 arch/arm/mach-omap2/io.c      |    8 ++++++++
 arch/arm/mach-omap2/prm2xxx.c |    3 +--
 arch/arm/mach-omap2/prm2xxx.h |    3 +--
 arch/arm/mach-omap2/prm3xxx.c |   17 ++++++++++-------
 arch/arm/mach-omap2/prm3xxx.h |    1 +
 arch/arm/mach-omap2/prm44xx.c |   16 +++++++++-------
 arch/arm/mach-omap2/prm44xx.h |    1 +
 7 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 924bf24..007dc4d 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -51,6 +51,10 @@
 #include "prcm_mpu44xx.h"
 #include "prminst44xx.h"
 #include "cminst44xx.h"
+#include "prm2xxx.h"
+#include "prm3xxx.h"
+#include "prm44xx.h"
+
 /*
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
@@ -392,6 +396,7 @@ void __init omap2420_init_early(void)
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE));
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE), NULL);
 	omap2xxx_check_revision();
+	omap2xxx_prm_init();
 	omap2xxx_cm_init();
 	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
@@ -422,6 +427,7 @@ void __init omap2430_init_early(void)
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE));
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE), NULL);
 	omap2xxx_check_revision();
+	omap2xxx_prm_init();
 	omap2xxx_cm_init();
 	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
@@ -457,6 +463,7 @@ void __init omap3_init_early(void)
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE), NULL);
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
+	omap3xxx_prm_init();
 	omap3xxx_cm_init();
 	omap_common_init_early();
 	omap3xxx_voltagedomains_init();
@@ -591,6 +598,7 @@ void __init omap4430_init_early(void)
 	omap_cm_base_init();
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
+	omap44xx_prm_init();
 	omap_common_init_early();
 	omap44xx_voltagedomains_init();
 	omap44xx_powerdomains_init();
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index bf24fc4..faeab18 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -118,14 +118,13 @@ static struct prm_ll_data omap2xxx_prm_ll_data = {
 	.read_reset_sources = &omap2xxx_prm_read_reset_sources,
 };
 
-static int __init omap2xxx_prm_init(void)
+int __init omap2xxx_prm_init(void)
 {
 	if (!cpu_is_omap24xx())
 		return 0;
 
 	return prm_register(&omap2xxx_prm_ll_data);
 }
-subsys_initcall(omap2xxx_prm_init);
 
 static void __exit omap2xxx_prm_exit(void)
 {
diff --git a/arch/arm/mach-omap2/prm2xxx.h b/arch/arm/mach-omap2/prm2xxx.h
index fe8a14f..3194dd8 100644
--- a/arch/arm/mach-omap2/prm2xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx.h
@@ -126,8 +126,7 @@ extern int omap2xxx_clkdm_wakeup(struct clockdomain *clkdm);
 
 extern void omap2xxx_prm_dpll_reset(void);
 
-extern int __init prm2xxx_init(void);
-extern int __exit prm2xxx_exit(void);
+extern int __init omap2xxx_prm_init(void);
 
 #endif
 
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index b86116c..db198d0 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -383,27 +383,30 @@ static struct prm_ll_data omap3xxx_prm_ll_data = {
 	.read_reset_sources = &omap3xxx_prm_read_reset_sources,
 };
 
-static int __init omap3xxx_prm_init(void)
+int __init omap3xxx_prm_init(void)
+{
+	if (!cpu_is_omap34xx())
+		return 0;
+
+	return prm_register(&omap3xxx_prm_ll_data);
+}
+
+static int __init omap3xxx_prm_late_init(void)
 {
 	int ret;
 
 	if (!cpu_is_omap34xx())
 		return 0;
 
-	ret = prm_register(&omap3xxx_prm_ll_data);
-	if (ret)
-		return ret;
-
 	omap3xxx_prm_enable_io_wakeup();
 	ret = omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
 	if (!ret)
 		irq_set_status_flags(omap_prcm_event_to_irq("io"),
 				     IRQ_NOAUTOEN);
 
-
 	return ret;
 }
-subsys_initcall(omap3xxx_prm_init);
+subsys_initcall(omap3xxx_prm_late_init);
 
 static void __exit omap3xxx_prm_exit(void)
 {
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 10cd41a..277f717 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -154,6 +154,7 @@ extern void omap3xxx_prm_restore_irqen(u32 *saved_mask);
 
 extern void omap3xxx_prm_dpll3_reset(void);
 
+extern int __init omap3xxx_prm_init(void);
 extern u32 omap3xxx_prm_get_reset_sources(void);
 
 #endif /* __ASSEMBLER */
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 6d3467a..9db1bd2 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -615,22 +615,24 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 	.read_reset_sources = &omap44xx_prm_read_reset_sources,
 };
 
-static int __init omap44xx_prm_init(void)
+int __init omap44xx_prm_init(void)
 {
-	int ret;
-
 	if (!cpu_is_omap44xx())
 		return 0;
 
-	ret = prm_register(&omap44xx_prm_ll_data);
-	if (ret)
-		return ret;
+	return prm_register(&omap44xx_prm_ll_data);
+}
+
+static int __init omap44xx_prm_late_init(void)
+{
+	if (!cpu_is_omap44xx())
+		return 0;
 
 	omap44xx_prm_enable_io_wakeup();
 
 	return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
 }
-subsys_initcall(omap44xx_prm_init);
+subsys_initcall(omap44xx_prm_late_init);
 
 static void __exit omap44xx_prm_exit(void)
 {
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index c8e1acc..22b0979 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -771,6 +771,7 @@ extern void omap44xx_prm_ocp_barrier(void);
 extern void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask);
 extern void omap44xx_prm_restore_irqen(u32 *saved_mask);
 
+extern int __init omap44xx_prm_init(void);
 extern u32 omap44xx_prm_get_reset_sources(void);
 
 # endif
-- 
1.7.10.4
