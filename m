From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 03/11] ARM: OMAP3: McBSP: do not access CM register directly
Date: Fri, 11 Oct 2013 19:15:33 +0300
Message-ID: <1381508141-15244-4-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54826 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757212Ab3JKQQV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 12:16:21 -0400
In-Reply-To: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@linaro.org, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

McBSP driver require special hacks to enable/disable the autoidle feature
for its interface clock for the proper function of the sidetone hardware.
Currently the driver just writes CM registers directly, which should be
avoided. Thus, changed the driver to use the new deny/allow_autoidle
clock API calls.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 5d87680..b4ac3af 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -25,6 +25,7 @@
 
 #include "soc.h"
 #include "omap_device.h"
+#include "clock.h"
 
 /*
  * FIXME: Find a mechanism to enable/disable runtime the McBSP ICLK autoidle.
@@ -33,22 +34,18 @@
 #include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
 
+static struct clk *mcbsp_iclks[5];
+
 static int omap3_enable_st_clock(unsigned int id, bool enable)
 {
-	unsigned int w;
-
 	/*
 	 * Sidetone uses McBSP ICLK - which must not idle when sidetones
 	 * are enabled or sidetones start sounding ugly.
 	 */
-	w = omap2_cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
 	if (enable)
-		w &= ~(1 << (id - 2));
+		return omap2_clk_deny_idle(mcbsp_iclks[id]);
 	else
-		w |= 1 << (id - 2);
-	omap2_cm_write_mod_reg(w, OMAP3430_PER_MOD, CM_AUTOIDLE);
-
-	return 0;
+		return omap2_clk_allow_idle(mcbsp_iclks[id]);
 }
 
 static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
@@ -58,6 +55,7 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 	struct omap_hwmod *oh_device[2];
 	struct omap_mcbsp_platform_data *pdata = NULL;
 	struct platform_device *pdev;
+	char clk_name[11];
 
 	sscanf(oh->name, "mcbsp%d", &id);
 
@@ -99,6 +97,8 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		oh_device[1] = omap_hwmod_lookup((
 		(struct omap_mcbsp_dev_attr *)(oh->dev_attr))->sidetone);
 		pdata->enable_st_clock = omap3_enable_st_clock;
+		sprintf(clk_name, "mcbsp%d_ick", id);
+		mcbsp_iclks[id] = clk_get(NULL, clk_name);
 		count++;
 	}
 	pdev = omap_device_build_ss(name, id, oh_device, count, pdata,
-- 
1.7.9.5

