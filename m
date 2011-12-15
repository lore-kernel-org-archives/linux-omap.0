From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] OMAP4: mcbsp: Clock reparenting support
Date: Thu, 15 Dec 2011 11:37:39 +0200
Message-ID: <1323941859-7946-3-git-send-email-peter.ujfalusi@ti.com>
References: <1323941859-7946-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:40080 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751990Ab1LOJiD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 04:38:03 -0500
Received: by lagj5 with SMTP id j5so854176lag.15
        for <linux-omap@vger.kernel.org>; Thu, 15 Dec 2011 01:38:01 -0800 (PST)
In-Reply-To: <1323941859-7946-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

With OMAP4 the clock names are different compared to
OMAP2/3.
The internal fclk name depends on the McBSP instance
number.
In case of MCBSP_TYPE4 (OMAP4) we should use different
clock selection method compared to OMAP2/3.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 9129003..829f4c7 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -111,6 +111,23 @@ static int omap2_mcbsp_set_clk_src(struct device *dev, struct clk *clk,
 	return omap2_mcbsp_reparent_clk(dev, clk, fck_src_name);
 }
 
+/* McBSP CLKS source switching for OMAP4 */
+static int omap4_mcbsp_set_clk_src(struct device *dev, struct clk *clk,
+				   const char *src)
+{
+	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
+	char fck_src_name[30];
+
+	if (!strcmp(src, "clks_ext"))
+		strcpy(fck_src_name, "pad_clks_ck");
+	else if (!strcmp(src, "clks_fclk"))
+		sprintf(fck_src_name, "mcbsp%d_sync_mux_ck", mcbsp->id);
+	else
+		return -EINVAL;
+
+	return omap2_mcbsp_reparent_clk(dev, clk, fck_src_name);
+}
+
 static int omap3_enable_st_clock(unsigned int id, bool enable)
 {
 	unsigned int w;
@@ -184,9 +201,15 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 					name, oh->name);
 		return PTR_ERR(pdev);
 	}
-	pdata->set_clk_src = omap2_mcbsp_set_clk_src;
-	if (id == 1)
-		pdata->mux_signal = omap2_mcbsp1_mux_rx_clk;
+
+	if (oh->class->rev == MCBSP_CONFIG_TYPE4)
+		pdata->set_clk_src = omap4_mcbsp_set_clk_src;
+	else {
+		pdata->set_clk_src = omap2_mcbsp_set_clk_src;
+		if (id == 1)
+			pdata->mux_signal = omap2_mcbsp1_mux_rx_clk;
+	}
+
 	omap_mcbsp_count++;
 	return 0;
 }
-- 
1.7.8

