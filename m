From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v5 02/10] OMAP4 : DSS2 : HDMI: Select between HDMI VENC clock source.
Date: Thu, 10 Mar 2011 16:14:10 +0530
Message-ID: <1299753858-12222-3-git-send-email-mythripk@ti.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
 <1299753858-12222-2-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44168 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310Ab1CJKuz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 05:50:55 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2AAoq9Z021441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 04:50:55 -0600
In-Reply-To: <1299753858-12222-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>


Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss.c |    5 +++++
 drivers/video/omap2/dss/dss.h |    6 ++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index aed9345..0be83c8 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -605,6 +605,11 @@ void dss_set_dac_pwrdn_bgz(bool enable)
 	REG_FLD_MOD(DSS_CONTROL, enable, 5, 5);	/* DAC Power-Down Control */
 }
 
+void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
+{
+	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* VENC_HDMI_SWITCH */
+}
+
 static int dss_init(void)
 {
 	int r;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index b845468..c2c0fcf 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -132,6 +132,11 @@ struct dss_clk_source_name {
 	const char *clksrc_name;
 };
 
+enum dss_hdmi_venc_clk_source_select {
+	DSS_VENC_TV_CLK = 0,
+	DSS_HDMI_M_PCLK = 1,
+};
+
 struct dss_clock_info {
 	/* rates that we get with dividers below */
 	unsigned long fck;
@@ -220,6 +225,7 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force);
 int dss_init_platform_driver(void);
 void dss_uninit_platform_driver(void);
 
+void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
 void dss_save_context(void);
 void dss_restore_context(void);
 void dss_clk_enable(enum dss_clock clks);
-- 
1.5.6.3

