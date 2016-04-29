From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 7/7] ARM: OMAP2+: McBSP: Remove the old iclk allow/deny idle code
Date: Fri, 29 Apr 2016 13:53:22 +0300
Message-ID: <1461927202-17677-8-git-send-email-peter.ujfalusi@ti.com>
References: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, jarkko.nikula@bitmer.com, paul@pwsan.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The new pdata callback (force_ick_on) is now used by the driver and the old
callback related code can be removed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c                 | 18 ------------------
 include/linux/platform_data/asoc-ti-mcbsp.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index edf4f41c0135..fc04be74e064 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -34,20 +34,6 @@
 #include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
 
-static struct clk *mcbsp_iclks[5];
-
-static int omap3_enable_st_clock(unsigned int id, bool enable)
-{
-	/*
-	 * Sidetone uses McBSP ICLK - which must not idle when sidetones
-	 * are enabled or sidetones start sounding ugly.
-	 */
-	if (enable)
-		return omap2_clk_deny_idle(mcbsp_iclks[id]);
-	else
-		return omap2_clk_allow_idle(mcbsp_iclks[id]);
-}
-
 static int omap3_mcbsp_force_ick_on(struct clk *clk, bool force_on)
 {
 	if (!clk)
@@ -75,7 +61,6 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 	struct omap_hwmod *oh_device[2];
 	struct omap_mcbsp_platform_data *pdata = NULL;
 	struct platform_device *pdev;
-	char clk_name[11];
 
 	sscanf(oh->name, "mcbsp%d", &id);
 
@@ -116,10 +101,7 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 	if (oh->dev_attr) {
 		oh_device[1] = omap_hwmod_lookup((
 		(struct omap_mcbsp_dev_attr *)(oh->dev_attr))->sidetone);
-		pdata->enable_st_clock = omap3_enable_st_clock;
 		pdata->force_ick_on = omap3_mcbsp_force_ick_on;
-		sprintf(clk_name, "mcbsp%d_ick", id);
-		mcbsp_iclks[id] = clk_get(NULL, clk_name);
 		count++;
 	}
 	pdev = omap_device_build_ss(name, id, oh_device, count, pdata,
diff --git a/include/linux/platform_data/asoc-ti-mcbsp.h b/include/linux/platform_data/asoc-ti-mcbsp.h
index 5530971abf4d..e684543254f3 100644
--- a/include/linux/platform_data/asoc-ti-mcbsp.h
+++ b/include/linux/platform_data/asoc-ti-mcbsp.h
@@ -44,7 +44,6 @@ struct omap_mcbsp_platform_data {
 	/* McBSP platform and instance specific features */
 	bool has_wakeup; /* Wakeup capability */
 	bool has_ccr; /* Transceiver has configuration control registers */
-	int (*enable_st_clock)(unsigned int, bool);
 	int (*force_ick_on)(struct clk *clk, bool force_on);
 };
 
-- 
2.8.1
