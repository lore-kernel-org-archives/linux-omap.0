From: Archit Taneja <archit@ti.com>
Subject: [PATCH 4/6] omapdss: hdmi pll: Incorporate changes for OMAP5/DRA7x
Date: Thu, 17 Oct 2013 16:56:40 +0530
Message-ID: <1382009202-18984-5-git-send-email-archit@ti.com>
References: <1382009202-18984-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39510 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222Ab3JQL1p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Oct 2013 07:27:45 -0400
In-Reply-To: <1382009202-18984-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add a features struct to differentiate between the HDMI PLLs on OMAP4 and
OMAP5/DRA7x.

The OMAP5/DRA7x PLL are more sensitive compared to the PLL on OMAP4 when it
comes to locking. We need to ensure that the DCO freq calculated isn't too low
for lower pixel clocks. If not followed, the PLL doesn't lock for lower
frequencies.

Modify the PLL computation slightly to ensure the HDMI PLL locks for lower
frequencies. This will be replaced by a more complex computation which makes
sure all the PLL constraints are met.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/hdmi_pll.c | 74 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi_pll.c b/drivers/video/omap2/dss/hdmi_pll.c
index d3e6e78..e1c55c4 100644
--- a/drivers/video/omap2/dss/hdmi_pll.c
+++ b/drivers/video/omap2/dss/hdmi_pll.c
@@ -21,6 +21,13 @@
 #define HDMI_DEFAULT_REGN 16
 #define HDMI_DEFAULT_REGM2 1
 
+struct hdmi_pll_features {
+	bool sys_reset;
+	bool bound_dcofreq;
+};
+
+static const struct hdmi_pll_features *pll_feat;
+
 void hdmi_pll_dump(struct hdmi_pll_data *pll, struct seq_file *s)
 {
 #define DUMPPLL(r) seq_printf(s, "%-35s %08x\n", #r,\
@@ -55,7 +62,17 @@ void hdmi_pll_compute(struct hdmi_pll_data *pll, unsigned long clkin, int phy)
 
 	refclk = clkin / pi->regn;
 
-	pi->regm2 = HDMI_DEFAULT_REGM2;
+	/*
+	 * HACK: the HDMI PLL on omap5/dra7x doesn't lock if the required
+	 * DCOFREQ is lesser than the minimum value of the DCO's lower frequency
+	 * range. For now, we just make sure that low pixel clock rates also
+	 * generate a high enough DCOFREQ by setting the M2 post divider to a
+	 * higher value
+	 */
+	if (pll_feat->bound_dcofreq && phy <= 65000)
+		pi->regm2 = 3;
+	else
+		pi->regm2 = HDMI_DEFAULT_REGM2;
 
 	/*
 	 * multiplier is pixel_clk/ref_clk
@@ -151,8 +168,12 @@ static int hdmi_pll_config(struct hdmi_pll_data *pll)
 
 static int hdmi_pll_reset(struct hdmi_pll_data *pll)
 {
-	/* SYSRESET  controlled by power FSM */
-	REG_FLD_MOD(pll->base, PLLCTRL_PLL_CONTROL, 0x0, 3, 3);
+	/*
+	 * SYSRESET controlled by power FSM.
+	 * SYSRESETN needs to be set for omap5/dra7x, but cleared for omap4
+	 * HDMI PLL
+	 */
+	REG_FLD_MOD(pll->base, PLLCTRL_PLL_CONTROL, pll_feat->sys_reset, 3, 3);
 
 	/* READ 0x0 reset is in progress */
 	if (hdmi_wait_for_bit_change(pll->base, PLLCTRL_PLL_STATUS, 0, 0, 1)
@@ -195,11 +216,58 @@ void hdmi_pll_disable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp)
 #define PLL_OFFSET	0x200
 #define PLL_SIZE	0x100
 
+static const struct hdmi_pll_features omap44xx_pll_feats = {
+	.sys_reset		=	false,
+	.bound_dcofreq		=	false,
+};
+
+static const struct hdmi_pll_features omap54xx_pll_feats = {
+	.sys_reset		=	true,
+	.bound_dcofreq		=	true,
+};
+
+static int __init hdmi_pll_init_features(struct platform_device *pdev)
+{
+	struct hdmi_pll_features *dst;
+	const struct hdmi_pll_features *src;
+
+	dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
+	if (!dst) {
+		dev_err(&pdev->dev, "Failed to allocate HDMI PHY Features\n");
+		return -ENOMEM;
+	}
+
+	switch (omapdss_get_version()) {
+	case OMAPDSS_VER_OMAP4430_ES1:
+	case OMAPDSS_VER_OMAP4430_ES2:
+	case OMAPDSS_VER_OMAP4:
+		src = &omap44xx_pll_feats;
+		break;
+
+	case OMAPDSS_VER_OMAP5:
+		src = &omap54xx_pll_feats;
+		break;
+
+	default:
+		return -ENODEV;
+	}
+
+	memcpy(dst, src, sizeof(*dst));
+	pll_feat = dst;
+
+	return 0;
+}
+
 int hdmi_pll_init(struct platform_device *pdev, struct hdmi_pll_data *pll)
 {
+	int r;
 	struct resource *res;
 	struct resource temp_res;
 
+	r = hdmi_pll_init_features(pdev);
+	if (r)
+		return r;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hdmi_pllctrl");
 	if (!res) {
 		DSSDBG("can't get PLL mem resource by name\n");
-- 
1.8.1.2

