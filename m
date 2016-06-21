From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: OMAP4+: Initialize SAR RAM base early for proper
 CPU1 reset for kexec
Date: Tue, 21 Jun 2016 00:52:42 -0700
Message-ID: <1466495565-17480-2-git-send-email-tony@atomide.com>
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

Prepare things for making kexec work on SMP omap variants by initializing
SARM RAM base early. This allows us to configure CPU1 for kexec in case
the previous kernel has put CPU1 in low power mode.

Note that this should not prevent moving other SAR RAM code to live
under drivers. However for kexec, we will need this very early.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h       |  1 +
 arch/arm/mach-omap2/io.c           |  2 ++
 arch/arm/mach-omap2/omap4-common.c | 14 ++++++--------
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index f7666b9..9cbae6e 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -257,6 +257,7 @@ extern void gic_dist_enable(void);
 extern bool gic_dist_disabled(void);
 extern void gic_timer_retrigger(void);
 extern void omap_smc1(u32 fn, u32 arg);
+extern void omap4_sar_ram_init(void);
 extern void __iomem *omap4_get_sar_ram_base(void);
 extern void omap_do_wfi(void);
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 49de4dd..4548cb9 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -690,6 +690,7 @@ void __init omap4430_init_early(void)
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
 	omap2_prcm_base_init();
+	omap4_sar_ram_init();
 	omap4_pm_init_early();
 	omap44xx_voltagedomains_init();
 	omap44xx_powerdomains_init();
@@ -718,6 +719,7 @@ void __init omap5_init_early(void)
 	omap4_pm_init_early();
 	omap2_prcm_base_init();
 	omap5xxx_check_revision();
+	omap4_sar_ram_init();
 	omap54xx_voltagedomains_init();
 	omap54xx_powerdomains_init();
 	omap54xx_clockdomains_init();
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index fb6fe26..cf65ab8 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -266,10 +266,11 @@ void __iomem *omap4_get_sar_ram_base(void)
 }
 
 /*
- * SAR RAM used to save and restore the HW
- * context in low power modes
+ * SAR RAM used to save and restore the HW context in low power modes.
+ * Note that we need to initialize this very early for kexec. See
+ * omap4_mpuss_early_init().
  */
-static int __init omap4_sar_ram_init(void)
+void __init omap4_sar_ram_init(void)
 {
 	unsigned long sar_base;
 
@@ -282,16 +283,13 @@ static int __init omap4_sar_ram_init(void)
 	else if (soc_is_omap54xx())
 		sar_base = OMAP54XX_SAR_RAM_BASE;
 	else
-		return -ENOMEM;
+		return;
 
 	/* Static mapping, never released */
 	sar_ram_base = ioremap(sar_base, SZ_16K);
 	if (WARN_ON(!sar_ram_base))
-		return -ENOMEM;
-
-	return 0;
+		return;
 }
-omap_early_initcall(omap4_sar_ram_init);
 
 static const struct of_device_id intc_match[] = {
 	{ .compatible = "ti,omap4-wugen-mpu", },
-- 
2.8.1
