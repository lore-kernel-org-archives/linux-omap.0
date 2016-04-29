From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 6/7] ASoC: omap-mcbsp: sidetone: Use the new callback for iclk handling
Date: Fri, 29 Apr 2016 13:53:21 +0300
Message-ID: <1461927202-17677-7-git-send-email-peter.ujfalusi@ti.com>
References: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, jarkko.nikula@bitmer.com, paul@pwsan.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The McBSP sidetone (in OMAP3 McBSP2 and 3 module) is working with the
module's interface clock. When the sidetone is enabled the iclk must not
idle because it will result in choppy sidetone.
Switch to use the new callback for handling the iclk allow/deny idle
configuration.
For this the driver needs to get the module's ick clock and pass the clk
pointer to the callback.
In DT boot, the pdata-quirk is going to set up the callback for the driver
so save it if it is set in the pdata of the device.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcbsp.c      | 19 ++++++++++++++-----
 sound/soc/omap/mcbsp.h      |  1 +
 sound/soc/omap/omap-mcbsp.c |  3 +++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index ace73b97769f..76ce33199bf9 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -257,8 +257,8 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
 {
 	unsigned int w;
 
-	if (mcbsp->pdata->enable_st_clock)
-		mcbsp->pdata->enable_st_clock(mcbsp->id, 1);
+	if (mcbsp->pdata->force_ick_on)
+		mcbsp->pdata->force_ick_on(mcbsp->st_data->mcbsp_iclk, true);
 
 	/* Disable Sidetone clock auto-gating for normal operation */
 	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
@@ -287,8 +287,8 @@ static void omap_st_off(struct omap_mcbsp *mcbsp)
 	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
 	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w | ST_AUTOIDLE);
 
-	if (mcbsp->pdata->enable_st_clock)
-		mcbsp->pdata->enable_st_clock(mcbsp->id, 0);
+	if (mcbsp->pdata->force_ick_on)
+		mcbsp->pdata->force_ick_on(mcbsp->st_data->mcbsp_iclk, false);
 }
 
 static void omap_st_fir_write(struct omap_mcbsp *mcbsp, s16 *fir)
@@ -946,6 +946,13 @@ static int omap_st_add(struct omap_mcbsp *mcbsp, struct resource *res)
 	if (!st_data)
 		return -ENOMEM;
 
+	st_data->mcbsp_iclk = clk_get(mcbsp->dev, "ick");
+	if (IS_ERR(st_data->mcbsp_iclk)) {
+		dev_warn(mcbsp->dev,
+			 "Failed to get ick, sidetone might be broken\n");
+		st_data->mcbsp_iclk = NULL;
+	}
+
 	st_data->io_base_st = devm_ioremap(mcbsp->dev, res->start,
 					   resource_size(res));
 	if (!st_data->io_base_st)
@@ -1093,6 +1100,8 @@ void omap_mcbsp_cleanup(struct omap_mcbsp *mcbsp)
 	if (mcbsp->pdata->buffer_size)
 		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
 
-	if (mcbsp->st_data)
+	if (mcbsp->st_data) {
 		sysfs_remove_group(&mcbsp->dev->kobj, &sidetone_attr_group);
+		clk_put(mcbsp->st_data->mcbsp_iclk);
+	}
 }
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index ce6cbbf923a4..61e93b1c185d 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -280,6 +280,7 @@ struct omap_mcbsp_reg_cfg {
 
 struct omap_mcbsp_st_data {
 	void __iomem *io_base_st;
+	struct clk *mcbsp_iclk;
 	bool running;
 	bool enabled;
 	s16 taps[128];	/* Sidetone filter coefficients */
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index db07debb4a9c..d018e966e533 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -788,6 +788,7 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
 	match = of_match_device(omap_mcbsp_of_match, &pdev->dev);
 	if (match) {
 		struct device_node *node = pdev->dev.of_node;
+		struct omap_mcbsp_platform_data *pdata_quirk = pdata;
 		int buffer_size;
 
 		pdata = devm_kzalloc(&pdev->dev,
@@ -799,6 +800,8 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
 		memcpy(pdata, match->data, sizeof(*pdata));
 		if (!of_property_read_u32(node, "ti,buffer-size", &buffer_size))
 			pdata->buffer_size = buffer_size;
+		if (pdata_quirk)
+			pdata->force_ick_on = pdata_quirk->force_ick_on;
 	} else if (!pdata) {
 		dev_err(&pdev->dev, "missing platform data.\n");
 		return -EINVAL;
-- 
2.8.1
