From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v4 2/9] OMAP4 : DSS2 : HDMI: Select between HDMI VENC clock source.
Date: Wed,  9 Mar 2011 17:15:11 +0530
Message-ID: <1299671118-20839-3-git-send-email-mythripk@ti.com>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
 <1299671118-20839-2-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41928 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756885Ab1CILv4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 06:51:56 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p29BprdD017232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 9 Mar 2011 05:51:55 -0600
In-Reply-To: <1299671118-20839-2-git-send-email-mythripk@ti.com>
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
index 2be4d03..1d91b0a 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -559,6 +559,11 @@ void dss_set_dac_pwrdn_bgz(bool enable)
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
index 85d4141..29f31fd 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -129,6 +129,11 @@ struct dss_clk_source_name {
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
@@ -215,6 +220,7 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force);
 int dss_init_platform_driver(void);
 void dss_uninit_platform_driver(void);
 
+void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
 void dss_save_context(void);
 void dss_restore_context(void);
 void dss_clk_enable(enum dss_clock clks);
-- 
1.5.6.3

