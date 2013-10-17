From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/6] omapdss: hdmi phy: Incorporate changes for OMAP5/DRA7x
Date: Thu, 17 Oct 2013 16:56:39 +0530
Message-ID: <1382009202-18984-4-git-send-email-archit@ti.com>
References: <1382009202-18984-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50824 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222Ab3JQL1n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Oct 2013 07:27:43 -0400
In-Reply-To: <1382009202-18984-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

OMAP5/DRA7x HDMI PHY has some differences compared to OMAP4 HDMI PHY.

Create a features struct which help the diagram configure the PHY based
on what SoC it is.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/hdmi.h     |  1 +
 drivers/video/omap2/dss/hdmi_phy.c | 94 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
index b410b14..8fa2121 100644
--- a/drivers/video/omap2/dss/hdmi.h
+++ b/drivers/video/omap2/dss/hdmi.h
@@ -80,6 +80,7 @@
 #define HDMI_TXPHY_DIGITAL_CTRL			0x4
 #define HDMI_TXPHY_POWER_CTRL			0x8
 #define HDMI_TXPHY_PAD_CFG_CTRL			0xC
+#define HDMI_TXPHY_BIST_CONTROL			0x1C
 
 enum hdmi_pll_pwr {
 	HDMI_PLLPWRCMD_ALLOFF = 0,
diff --git a/drivers/video/omap2/dss/hdmi_phy.c b/drivers/video/omap2/dss/hdmi_phy.c
index 45acb99..4d9debb 100644
--- a/drivers/video/omap2/dss/hdmi_phy.c
+++ b/drivers/video/omap2/dss/hdmi_phy.c
@@ -12,11 +12,22 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <video/omapdss.h>
 
 #include "dss.h"
 #include "hdmi.h"
 
+struct hdmi_phy_features {
+	bool bist_ctrl;
+	bool calc_freqout;
+	bool ldo_voltage;
+	unsigned long dcofreq_min;	/* in KHz */
+	unsigned long max_phy;		/* in KHz */
+};
+
+static const struct hdmi_phy_features *phy_feat;
+
 void hdmi_phy_dump(struct hdmi_phy_data *phy, struct seq_file *s)
 {
 #define DUMPPHY(r) seq_printf(s, "%-35s %08x\n", #r,\
@@ -26,6 +37,8 @@ void hdmi_phy_dump(struct hdmi_phy_data *phy, struct seq_file *s)
 	DUMPPHY(HDMI_TXPHY_DIGITAL_CTRL);
 	DUMPPHY(HDMI_TXPHY_POWER_CTRL);
 	DUMPPHY(HDMI_TXPHY_PAD_CFG_CTRL);
+	if (phy_feat->bist_ctrl)
+		DUMPPHY(HDMI_TXPHY_BIST_CONTROL);
 }
 
 static irqreturn_t hdmi_irq_handler(int irq, void *data)
@@ -64,12 +77,20 @@ int hdmi_phy_enable(struct hdmi_phy_data *phy, struct hdmi_wp_data *wp,
 {
 	u16 r = 0;
 	u32 irqstatus;
+	u8 freqout;
 
 	hdmi_wp_clear_irqenable(wp, 0xffffffff);
 
 	irqstatus = hdmi_wp_get_irqstatus(wp);
 	hdmi_wp_set_irqstatus(wp, irqstatus);
 
+	/*
+	 * In OMAP5+, the HFBITCLK must be divided by 2 before issuing the
+	 * HDMI_PHYPWRCMD_LDOON command.
+	*/
+	if (phy_feat->bist_ctrl)
+		REG_FLD_MOD(phy->base, HDMI_TXPHY_BIST_CONTROL, 1, 11, 11);
+
 	r = hdmi_wp_set_phy_pwr(wp, HDMI_PHYPWRCMD_LDOON);
 	if (r)
 		return r;
@@ -80,17 +101,33 @@ int hdmi_phy_enable(struct hdmi_phy_data *phy, struct hdmi_wp_data *wp,
 	 */
 	hdmi_read_reg(phy->base, HDMI_TXPHY_TX_CTRL);
 
+	if (phy_feat->calc_freqout) {
+		/* DCOCLK/10 is pixel clock, compare pclk with DCOCLK_MIN/10 */
+		u32 dco_min = phy_feat->dcofreq_min / 10;
+		u32 pclk = cfg->timings.pixel_clock;
+
+		if (pclk < dco_min)
+			freqout = 0;
+		else if ((pclk >= dco_min) && (pclk < phy_feat->max_phy))
+			freqout = 1;
+		else
+			freqout = 2;
+	} else {
+		freqout = 1;
+	}
+
 	/*
 	 * Write to phy address 0 to configure the clock
 	 * use HFBITCLK write HDMI_TXPHY_TX_CONTROL_FREQOUT field
 	 */
-	REG_FLD_MOD(phy->base, HDMI_TXPHY_TX_CTRL, 0x1, 31, 30);
+	REG_FLD_MOD(phy->base, HDMI_TXPHY_TX_CTRL, freqout, 31, 30);
 
 	/* Write to phy address 1 to start HDMI line (TXVALID and TMDSCLKEN) */
 	hdmi_write_reg(phy->base, HDMI_TXPHY_DIGITAL_CTRL, 0xF0000000);
 
 	/* Setup max LDO voltage */
-	REG_FLD_MOD(phy->base, HDMI_TXPHY_POWER_CTRL, 0xB, 3, 0);
+	if (phy_feat->ldo_voltage)
+		REG_FLD_MOD(phy->base, HDMI_TXPHY_POWER_CTRL, 0xB, 3, 0);
 
 	/* Write to phy address 3 to change the polarity control */
 	REG_FLD_MOD(phy->base, HDMI_TXPHY_PAD_CFG_CTRL, 0x1, 27, 27);
@@ -119,11 +156,64 @@ void hdmi_phy_disable(struct hdmi_phy_data *phy, struct hdmi_wp_data *wp)
 #define PHY_OFFSET	0x300
 #define PHY_SIZE	0x100
 
+static const struct hdmi_phy_features omap44xx_phy_feats = {
+	.bist_ctrl	=	false,
+	.calc_freqout	=	false,
+	.ldo_voltage	=	true,
+	.dcofreq_min	=	500000,
+	.max_phy	=	185675,
+};
+
+static const struct hdmi_phy_features omap54xx_phy_feats = {
+	.bist_ctrl	=	true,
+	.calc_freqout	=	true,
+	.ldo_voltage	=	false,
+	.dcofreq_min	=	750000,
+	.max_phy	=	186000,
+};
+
+static int hdmi_phy_init_features(struct platform_device *pdev)
+{
+	struct hdmi_phy_features *dst;
+	const struct hdmi_phy_features *src;
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
+		src = &omap44xx_phy_feats;
+		break;
+
+	case OMAPDSS_VER_OMAP5:
+		src = &omap54xx_phy_feats;
+		break;
+
+	default:
+		return -ENODEV;
+	}
+
+	memcpy(dst, src, sizeof(*dst));
+	phy_feat = dst;
+
+	return 0;
+}
+
 int hdmi_phy_init(struct platform_device *pdev, struct hdmi_phy_data *phy)
 {
+	int r;
 	struct resource *res;
 	struct resource temp_res;
 
+	r = hdmi_phy_init_features(pdev);
+	if (r)
+		return r;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hdmi_txphy");
 	if (!res) {
 		DSSDBG("can't get PHY mem resource by name\n");
-- 
1.8.1.2

