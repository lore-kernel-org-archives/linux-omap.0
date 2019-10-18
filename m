From: Adam Ford <aford173@gmail.com>
Subject: [PATCH] fbdev/omap: fix max fclk divider for omap36xx
Date: Fri, 18 Oct 2019 08:05:07 -0500
Message-ID: <20191018130507.29893-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The OMAP36xx and AM/DM37x TRMs say that the maximum divider for DSS fclk
(in CM_CLKSEL_DSS) is 32. Experimentation shows that this is not
correct, and using divider of 32 breaks DSS with a flood or underflows
and sync losts. Dividers up to 31 seem to work fine.

There is another patch to the DT files to limit the divider correctly,
but as the DSS driver also needs to know the maximum divider to be able
to iteratively find good rates, we also need to do the fix in the DSS
driver.

Signed-off-by: Adam Ford <aford173@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: stable@vger.kernel.org # linux-4.4.y only

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 9200a8668b49..a57c3a5f4bf8 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -843,7 +843,7 @@ static const struct dss_features omap34xx_dss_feats = {
 };
 
 static const struct dss_features omap3630_dss_feats = {
-	.fck_div_max		=	32,
+	.fck_div_max		=	31,
 	.dss_fck_multiplier	=	1,
 	.parent_clk_name	=	"dpll4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
-- 
2.17.1
