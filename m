From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 6/6] ARM: OMAP2+: sram: remove legacy OMAP3 code
Date: Mon, 9 May 2016 16:49:26 -0500
Message-ID: <1462830566-28708-7-git-send-email-d-gerlach@ti.com>
References: <1462830566-28708-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1462830566-28708-1-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Now that we have converted OMAP3 PM code to use generic sram driver we
no longer need to provide OMAP3 specific SRAM code for the omap SRAM
API.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c | 16 ----------------
 arch/arm/mach-omap2/sram.c   | 23 -----------------------
 2 files changed, 39 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5ebbf5c30c6e..22d4c8742f99 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -502,22 +502,6 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 }
 
-/*
- * Push functions to SRAM
- *
- * The minimum set of functions is pushed to SRAM for execution:
- * - omap3_do_wfi for erratum i581 WA,
- * - save_secure_ram_context for security extensions.
- */
-void omap_push_sram_idle(void)
-{
-	omap3_do_wfi_sram = omap_sram_push(omap3_do_wfi, omap3_do_wfi_sz);
-
-	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
-		_omap_save_secure_sram = omap_sram_push(save_secure_ram_context,
-				save_secure_ram_context_sz);
-}
-
 static void __init pm_errata_configure(void)
 {
 	if (cpu_is_omap3630()) {
diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index 83d0e61f49e6..7881304b5205 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -209,27 +209,6 @@ static inline int omap243x_sram_init(void)
 }
 #endif
 
-#ifdef CONFIG_ARCH_OMAP3
-
-void omap3_sram_restore_context(void)
-{
-	omap_sram_reset();
-
-	omap_push_sram_idle();
-}
-
-static inline int omap34xx_sram_init(void)
-{
-	omap3_sram_restore_context();
-	return 0;
-}
-#else
-static inline int omap34xx_sram_init(void)
-{
-	return 0;
-}
-#endif /* CONFIG_ARCH_OMAP3 */
-
 int __init omap_sram_init(void)
 {
 	omap_detect_sram();
@@ -239,8 +218,6 @@ int __init omap_sram_init(void)
 		omap242x_sram_init();
 	else if (cpu_is_omap2430())
 		omap243x_sram_init();
-	else if (cpu_is_omap34xx())
-		omap34xx_sram_init();
 
 	return 0;
 }
-- 
2.7.3
