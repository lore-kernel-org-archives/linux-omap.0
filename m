From: <mythripk@ti.com>
Subject: [PATCH v2 2/3] OMAPDSS: HDMI: Handle HPD event in ip
Date: Fri, 6 Jan 2012 18:14:36 +0530
Message-ID: <1325853877-6712-3-git-send-email-mythripk@ti.com>
References: <1325853877-6712-1-git-send-email-mythripk@ti.com>
 <1325853877-6712-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36712 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274Ab2AFMwH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jan 2012 07:52:07 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q06Cq5v9024679
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 06:52:05 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q06Cq4Fj025615
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 18:22:04 +0530 (IST)
In-Reply-To: <1325853877-6712-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

HPD event is notified to ip file and based on the
notification appropriate action is taken. As the PHY
should be in LDO_ON state and not TX_ON (transmission),
this transition is handled in ip file.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi.h         |    4 +++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   31 ++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 9a31683..eba2ed4 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -113,6 +113,8 @@ struct ti_hdmi_ip_ops {
 
 	int (*configure_range)(struct hdmi_ip_data *ip_data);
 
+	int (*notify_hpd)(struct hdmi_ip_data *ip_data, int hpd_state);
+
 };
 
 /*
@@ -167,6 +169,7 @@ struct hdmi_ip_data {
 	struct hdmi_pll_info pll_data;
 	struct hdmi_core_infoframe_avi avi_cfg;
 	enum hdmi_range range;
+	bool hdmi_phy_tx_enabled;
 };
 int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
@@ -185,4 +188,5 @@ void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable);
 #endif
 int ti_hdmi_4xxx_configure_range(struct hdmi_ip_data *ip_data);
+int ti_hdmi_4xxx_notify_hpd(struct hdmi_ip_data *ip_data, bool hpd_state);
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 58c5782..10c845d 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -223,15 +223,11 @@ void ti_hdmi_4xxx_pll_disable(struct hdmi_ip_data *ip_data)
 	hdmi_set_pll_pwr(ip_data, HDMI_PLLPWRCMD_ALLOFF);
 }
 
-int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data)
+int ti_hdmi_4xxx_phy_poweron(struct hdmi_ip_data *ip_data)
 {
 	u16 r = 0;
 	void __iomem *phy_base = hdmi_phy_base(ip_data);
 
-	r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_LDOON);
-	if (r)
-		return r;
-
 	r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
 	if (r)
 		return r;
@@ -260,11 +256,36 @@ int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data)
 	return 0;
 }
 
+int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data)
+{
+	int r = 0;
+
+	r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_LDOON);
+
+	return r;
+}
+
 void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data)
 {
 	hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_OFF);
 }
 
+int ti_hdmi_4xxx_notify_hpd(struct hdmi_ip_data *ip_data, bool hpd_state)
+{
+	int r = 0;
+
+	if (hpd_state != ip_data->hdmi_phy_tx_enabled) {
+		if (hpd_state)
+			r = ti_hdmi_4xxx_phy_poweron(ip_data);
+		else
+			r = ti_hdmi_4xxx_phy_enable(ip_data);
+		if (!r)
+			ip_data->hdmi_phy_tx_enabled = hpd_state;
+	}
+
+	return r;
+}
+
 static int hdmi_core_ddc_init(struct hdmi_ip_data *ip_data)
 {
 	void __iomem *base = hdmi_core_sys_base(ip_data);
-- 
1.7.5.4

