From: <mythripk@ti.com>
Subject: [PATCH v2 07/10] OMAP4: DSS2: HDMI: Provide a wrapper API to configure
Date: Mon, 29 Aug 2011 11:44:57 +0530
Message-ID: <1314598500-24005-8-git-send-email-mythripk@ti.com>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
 <1314598500-24005-2-git-send-email-mythripk@ti.com>
 <1314598500-24005-3-git-send-email-mythripk@ti.com>
 <1314598500-24005-4-git-send-email-mythripk@ti.com>
 <1314598500-24005-5-git-send-email-mythripk@ti.com>
 <1314598500-24005-6-git-send-email-mythripk@ti.com>
 <1314598500-24005-7-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44537 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834Ab1H2GXN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 02:23:13 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7T6N9PF014865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 01:23:12 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7T6N9Ok021152
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:53:09 +0530 (IST)
In-Reply-To: <1314598500-24005-7-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Instead of DSS knowing of the interior IP driver function provide
a wrapper API to configure.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c            |    8 ++++----
 drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c |   11 ++++++++---
 include/video/omaphdmi.h                  |    8 ++++----
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 8baf4cf..fb7d66f 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -478,13 +478,13 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	hdmi_wp_video_start(&hdmi.hdmi_data, 0);
 
 	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
-	r = hdmi_pll_program(&hdmi.hdmi_data);
+	r = hdmi_pll_enable(&hdmi.hdmi_data);
 	if (r) {
 		DSSDBG("Failed to lock PLL\n");
 		goto err;
 	}
 
-	r = hdmi_phy_init(&hdmi.hdmi_data);
+	r = hdmi_phy_enable(&hdmi.hdmi_data);
 	if (r) {
 		DSSDBG("Failed to start PHY\n");
 		goto err;
@@ -527,8 +527,8 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 0);
 
 	hdmi_wp_video_start(&hdmi.hdmi_data, 0);
-	hdmi_phy_off(&hdmi.hdmi_data);
-	hdmi_set_pll_pwr(&hdmi.hdmi_data, HDMI_PLLPWRCMD_ALLOFF);
+	hdmi_phy_disable(&hdmi.hdmi_data);
+	hdmi_pll_disable(&hdmi.hdmi_data);
 	hdmi_runtime_put();
 
 	hdmi.edid_set = 0;
diff --git a/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c b/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c
index a582522..f64e06c 100644
--- a/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c
+++ b/drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c
@@ -194,7 +194,7 @@ static int hdmi_pll_reset(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-int hdmi_pll_program(struct hdmi_ip_data *ip_data)
+int hdmi_pll_enable(struct hdmi_ip_data *ip_data)
 {
 	u16 r = 0;
 	enum hdmi_clk_refsel refsel;
@@ -220,7 +220,12 @@ int hdmi_pll_program(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-int hdmi_phy_init(struct hdmi_ip_data *ip_data)
+void hdmi_pll_disable(struct hdmi_ip_data *ip_data)
+{
+	hdmi_set_pll_pwr(ip_data, HDMI_PLLPWRCMD_ALLOFF);
+}
+
+int hdmi_phy_enable(struct hdmi_ip_data *ip_data)
 {
 	u16 r = 0;
 	void __iomem *phy_base = hdmi_phy_base(ip_data);
@@ -257,7 +262,7 @@ int hdmi_phy_init(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
-void hdmi_phy_off(struct hdmi_ip_data *ip_data)
+void hdmi_phy_disable(struct hdmi_ip_data *ip_data)
 {
 	hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_OFF);
 }
diff --git a/include/video/omaphdmi.h b/include/video/omaphdmi.h
index 9d4bc36..88b1ccb 100644
--- a/include/video/omaphdmi.h
+++ b/include/video/omaphdmi.h
@@ -83,11 +83,11 @@ struct hdmi_ip_data {
 	struct hdmi_config cfg;
 	struct hdmi_pll_info pll_data;
 };
-int hdmi_phy_init(struct hdmi_ip_data *ip_data);
-void hdmi_phy_off(struct hdmi_ip_data *ip_data);
+int hdmi_phy_enable(struct hdmi_ip_data *ip_data);
+void hdmi_phy_disable(struct hdmi_ip_data *ip_data);
 int read_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length);
 void hdmi_wp_video_start(struct hdmi_ip_data *ip_data, bool start);
-int hdmi_pll_program(struct hdmi_ip_data *ip_data);
-int hdmi_set_pll_pwr(struct hdmi_ip_data *ip_data, enum hdmi_pll_pwr val);
+int hdmi_pll_enable(struct hdmi_ip_data *ip_data);
+void hdmi_pll_disable(struct hdmi_ip_data *ip_data);
 void hdmi_basic_configure(struct hdmi_ip_data *ip_data);
 #endif
-- 
1.7.5.4

