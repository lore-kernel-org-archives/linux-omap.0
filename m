From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 4/7] ARM: OMAP3: pdata-quirks: Add support for McBSP2/3 sidetone handling
Date: Wed, 25 May 2016 17:20:58 +0300
Message-ID: <1464186061-28639-5-git-send-email-peter.ujfalusi@ti.com>
References: <1464186061-28639-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464186061-28639-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, jarkko.nikula@bitmer.com, paul@pwsan.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

McBSP2/3 module's sidetone module operates using the module's ICLK clock.
When the Sidetone is in use the interface clock of the module must not
idle. To prevent the iclk idling the driver expects to have pdata callback
to call. With this patch the callback is going to be set up for DT boot
also.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c                 |  9 +++++++++
 arch/arm/mach-omap2/pdata-quirks.c          | 18 ++++++++++++++++++
 include/linux/platform_data/asoc-ti-mcbsp.h |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 959cb4cb1062..edf4f41c0135 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -59,6 +59,15 @@ static int omap3_mcbsp_force_ick_on(struct clk *clk, bool force_on)
 		return omap2_clk_allow_idle(clk);
 }
 
+void __init omap3_mcbsp_init_pdata_callback(
+					struct omap_mcbsp_platform_data *pdata)
+{
+	if (!pdata)
+		return;
+
+	pdata->force_ick_on = omap3_mcbsp_force_ick_on;
+}
+
 static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 {
 	int id, count = 1;
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 6571ad959908..ab2b2b2b90e5 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -26,6 +26,7 @@
 #include <linux/platform_data/wkup_m3.h>
 #include <linux/platform_data/pwm_omap_dmtimer.h>
 #include <linux/platform_data/media/ir-rx51.h>
+#include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <plat/dmtimer.h>
 
 #include "common.h"
@@ -505,6 +506,16 @@ static struct platform_device __maybe_unused rx51_lirc_device = {
 	},
 };
 
+#if IS_ENABLED(CONFIG_SND_OMAP_SOC_MCBSP)
+static struct omap_mcbsp_platform_data mcbsp_pdata;
+static void __init omap3_mcbsp_init(void)
+{
+	omap3_mcbsp_init_pdata_callback(&mcbsp_pdata);
+}
+#else
+static void __init omap3_mcbsp_init(void) {}
+#endif
+
 /*
  * Few boards still need auxdata populated before we populate
  * the dev entries in of_platform_populate().
@@ -536,6 +547,11 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci_mdio", 0x5c030000, "davinci_mdio.0", NULL),
 	OF_DEV_AUXDATA("ti,am3517-emac", 0x5c000000, "davinci_emac.0",
 		       &am35xx_emac_pdata),
+	/* McBSP modules with sidetone core */
+#if IS_ENABLED(CONFIG_SND_OMAP_SOC_MCBSP)
+	OF_DEV_AUXDATA("ti,omap3-mcbsp", 0x49022000, "49022000.mcbsp", &mcbsp_pdata),
+	OF_DEV_AUXDATA("ti,omap3-mcbsp", 0x49024000, "49024000.mcbsp", &mcbsp_pdata),
+#endif
 #endif
 #ifdef CONFIG_SOC_AM33XX
 	OF_DEV_AUXDATA("ti,am3352-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
@@ -608,6 +624,8 @@ void __init pdata_quirks_init(const struct of_device_id *omap_dt_match_table)
 	    of_machine_is_compatible("ti,omap3"))
 		omap_sdrc_init(NULL, NULL);
 
+	if (of_machine_is_compatible("ti,omap3"))
+		omap3_mcbsp_init();
 	pdata_quirks_check(auxdata_quirks);
 	of_platform_populate(NULL, omap_dt_match_table,
 			     omap_auxdata_lookup, NULL);
diff --git a/include/linux/platform_data/asoc-ti-mcbsp.h b/include/linux/platform_data/asoc-ti-mcbsp.h
index 73e5e832fa23..5530971abf4d 100644
--- a/include/linux/platform_data/asoc-ti-mcbsp.h
+++ b/include/linux/platform_data/asoc-ti-mcbsp.h
@@ -56,4 +56,6 @@ struct omap_mcbsp_dev_attr {
 	const char *sidetone;
 };
 
+void omap3_mcbsp_init_pdata_callback(struct omap_mcbsp_platform_data *pdata);
+
 #endif
-- 
2.8.2
