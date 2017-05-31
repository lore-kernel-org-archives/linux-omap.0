From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/11] ARM: OMAP2+: Remove unused legacy code for io.c
Date: Wed, 31 May 2017 15:51:34 -0700
Message-ID: <20170531225139.30723-7-tony@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170531225139.30723-1-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We are now booting all mach-omap2 in device tree only mode.
Any code that is only called in legacy boot mode where
of_have_populated_dt() is not set is safe to remove now.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c | 59 ++++++++++++------------------------------------
 1 file changed, 14 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -493,67 +493,39 @@ void __init omap3_init_early(void)
 	omap2_set_globals_tap(OMAP343X_CLASS, OMAP2_L4_IO_ADDRESS(0x4830A000));
 	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
 			       OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE));
-	/* XXX: remove these once OMAP3 is DT only */
-	if (!of_have_populated_dt()) {
-		omap2_set_globals_control(
-			OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE));
-		omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE));
-		omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
-				     NULL);
-	}
 	omap2_control_base_init();
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
 	omap2_prcm_base_init();
-	/* XXX: remove these once OMAP3 is DT only */
-	if (!of_have_populated_dt()) {
-		omap3xxx_prm_init(NULL);
-		omap3xxx_cm_init(NULL);
-	}
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
 	omap3xxx_clockdomains_init();
 	omap3xxx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	if (!of_have_populated_dt()) {
-		omap3_control_legacy_iomap_init();
-		if (soc_is_am35xx())
-			omap_clk_soc_init = am35xx_clk_legacy_init;
-		else if (cpu_is_omap3630())
-			omap_clk_soc_init = omap36xx_clk_legacy_init;
-		else if (omap_rev() == OMAP3430_REV_ES1_0)
-			omap_clk_soc_init = omap3430es1_clk_legacy_init;
-		else
-			omap_clk_soc_init = omap3430_clk_legacy_init;
-	}
 }
 
 void __init omap3430_init_early(void)
 {
 	omap3_init_early();
-	if (of_have_populated_dt())
-		omap_clk_soc_init = omap3430_dt_clk_init;
+	omap_clk_soc_init = omap3430_dt_clk_init;
 }
 
 void __init omap35xx_init_early(void)
 {
 	omap3_init_early();
-	if (of_have_populated_dt())
-		omap_clk_soc_init = omap3430_dt_clk_init;
+	omap_clk_soc_init = omap3430_dt_clk_init;
 }
 
 void __init omap3630_init_early(void)
 {
 	omap3_init_early();
-	if (of_have_populated_dt())
-		omap_clk_soc_init = omap3630_dt_clk_init;
+	omap_clk_soc_init = omap3630_dt_clk_init;
 }
 
 void __init am35xx_init_early(void)
 {
 	omap3_init_early();
-	if (of_have_populated_dt())
-		omap_clk_soc_init = am35xx_dt_clk_init;
+	omap_clk_soc_init = am35xx_dt_clk_init;
 }
 
 void __init omap3_init_late(void)
@@ -628,8 +600,7 @@ void __init ti816x_init_early(void)
 	ti816x_clockdomains_init();
 	dm816x_hwmod_init();
 	omap_hwmod_init_postsetup();
-	if (of_have_populated_dt())
-		omap_clk_soc_init = dm816x_dt_clk_init;
+	omap_clk_soc_init = dm816x_dt_clk_init;
 }
 #endif
 
@@ -785,21 +756,19 @@ int __init omap_clk_init(void)
 
 	omap2_clk_setup_ll_ops();
 
-	if (of_have_populated_dt()) {
-		ret = omap_control_init();
-		if (ret)
-			return ret;
+	ret = omap_control_init();
+	if (ret)
+		return ret;
 
-		ret = omap_prcm_init();
-		if (ret)
-			return ret;
+	ret = omap_prcm_init();
+	if (ret)
+		return ret;
 
-		of_clk_init(NULL);
+	of_clk_init(NULL);
 
-		ti_dt_clk_init_retry_clks();
+	ti_dt_clk_init_retry_clks();
 
-		ti_dt_clockdomains_setup();
-	}
+	ti_dt_clockdomains_setup();
 
 	ret = omap_clk_soc_init();
 
-- 
2.13.0
