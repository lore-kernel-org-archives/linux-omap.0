From: <mythripk@ti.com>
Subject: [PATCH 1/3] OMAPDSS: HDMI: support for interrupt enabling
Date: Tue, 20 Mar 2012 18:45:05 +0530
Message-ID: <1332249307-26875-2-git-send-email-mythripk@ti.com>
References: <1332249307-26875-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53463 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757939Ab2CTNWE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 09:22:04 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q2KDM2Oc011125
	for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 08:22:03 -0500
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q2KDM12w018730
	for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 18:52:02 +0530 (IST)
In-Reply-To: <1332249307-26875-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add function to enable or clear interrupts in the HDMI wrapper.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi.h         |   16 ++++++++++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   45 +++++++++++++++++++++++++++++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    1 +
 3 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 1f58b84..6d65b3b 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -80,6 +80,22 @@ struct hdmi_pll_info {
 	enum hdmi_clk_refsel refsel;
 };
 
+struct hdmi_irq_vector {
+	u8	pll_recal;
+	u8	pll_unlock;
+	u8	pll_lock;
+	u8	phy_disconnect;
+	u8	phy_connect;
+	u8	phy_short_5v;
+	u8	video_end_fr;
+	u8	video_vsync;
+	u8	fifo_sample_req;
+	u8	fifo_overflow;
+	u8	fifo_underflow;
+	u8	ocp_timeout;
+	u8	core;
+};
+
 struct ti_hdmi_ip_ops {
 
 	void (*video_configure)(struct hdmi_ip_data *ip_data);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index bfe6fe6..5272f49 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -224,6 +224,51 @@ void ti_hdmi_4xxx_pll_disable(struct hdmi_ip_data *ip_data)
 	hdmi_set_pll_pwr(ip_data, HDMI_PLLPWRCMD_ALLOFF);
 }
 
+static void hdmi_wp_irq_init(struct hdmi_irq_vector *irq_enable)
+{
+	irq_enable->pll_recal = 0;
+	irq_enable->pll_unlock = 0;
+	irq_enable->pll_lock = 0;
+	irq_enable->phy_disconnect = 0;
+	irq_enable->phy_connect = 0;
+	irq_enable->phy_short_5v = 0;
+	irq_enable->video_end_fr = 0;
+	irq_enable->video_vsync = 0;
+	irq_enable->fifo_sample_req = 0;
+	irq_enable->fifo_overflow = 0;
+	irq_enable->fifo_underflow = 0;
+	irq_enable->ocp_timeout = 0;
+	irq_enable->core = 0;
+}
+
+static void hdmi_wp_clr_irq(struct hdmi_ip_data *ip_data)
+{
+	hdmi_write_reg(hdmi_wp_base(ip_data),
+			HDMI_WP_IRQENABLE_CLR, 0XFFFFFFFF);
+}
+
+static void hdmi_wp_irq_enable(struct hdmi_ip_data *ip_data,
+				struct hdmi_irq_vector *irq_enable)
+{
+	u32 r = 0;
+
+	r = ((irq_enable->pll_recal << 31) |
+		(irq_enable->pll_unlock << 30) |
+		(irq_enable->pll_lock << 29) |
+		(irq_enable->phy_disconnect << 26) |
+		(irq_enable->phy_connect << 25) |
+		(irq_enable->phy_short_5v << 24) |
+		(irq_enable->video_end_fr << 17) |
+		(irq_enable->video_vsync << 16) |
+		(irq_enable->fifo_sample_req << 10) |
+		(irq_enable->fifo_overflow << 9) |
+		(irq_enable->fifo_underflow << 8) |
+		(irq_enable->ocp_timeout << 4) |
+		(irq_enable->core << 0));
+
+	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_IRQENABLE_SET, r);
+}
+
 static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
 {
 	unsigned long flags;
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index a14d1a0..3090e81 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -38,6 +38,7 @@
 #define HDMI_WP_IRQSTATUS			0x28
 #define HDMI_WP_PWR_CTRL			0x40
 #define HDMI_WP_IRQENABLE_SET			0x2C
+#define HDMI_WP_IRQENABLE_CLR			0x30
 #define HDMI_WP_VIDEO_CFG			0x50
 #define HDMI_WP_VIDEO_SIZE			0x60
 #define HDMI_WP_VIDEO_TIMING_H			0x68
-- 
1.7.5.4

