From: <mythripk@ti.com>
Subject: [PATCH 2/3] OMAPDSS: HDMI: Add support for DSS_HDMI Interrupt
Date: Tue, 20 Mar 2012 18:45:06 +0530
Message-ID: <1332249307-26875-3-git-send-email-mythripk@ti.com>
References: <1332249307-26875-1-git-send-email-mythripk@ti.com>
 <1332249307-26875-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53464 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757941Ab2CTNWE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 09:22:04 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q2KDM2aa011126
	for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 08:22:03 -0500
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q2KDM12x018730
	for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 18:52:02 +0530 (IST)
In-Reply-To: <1332249307-26875-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add support for DSS_HDMI interrupt handling in HDMI driver
by registering for the same. This is the path for many necessary HDMI
interrupts such as PLL lock/unlock, PHY connect/disconnet, video frame
done etc.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss_features.c    |    1 +
 drivers/video/omap2/dss/hdmi.c            |   21 +++++++++++++++++++++
 drivers/video/omap2/dss/ti_hdmi.h         |    3 +++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   13 +++++++++++++
 4 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index ce14aa6..29c5548 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -566,6 +566,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 	.dump_core		=	ti_hdmi_4xxx_core_dump,
 	.dump_pll		=	ti_hdmi_4xxx_pll_dump,
 	.dump_phy		=	ti_hdmi_4xxx_phy_dump,
+	.irq_handle		=	ti_hdmi_4xxx_intr_handler,
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 	.audio_enable		=       ti_hdmi_4xxx_wp_audio_enable,
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index c4b4f69..14e90b5 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -67,6 +67,8 @@ static struct {
 	struct platform_device *pdev;
 	struct hdmi_ip_data ip_data;
 
+	int irq;
+	spinlock_t irq_lock;
 	struct clk *sys_clk;
 } hdmi;
 
@@ -790,6 +792,19 @@ static void hdmi_put_clocks(void)
 		clk_put(hdmi.sys_clk);
 }
 
+static irqreturn_t hdmi_irq_handler(int irq, void *arg)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hdmi.irq_lock, flags);
+
+	hdmi.ip_data.ops->irq_handle(&hdmi.ip_data);
+
+	spin_unlock_irqrestore(&hdmi.irq_lock, flags);
+
+	return IRQ_HANDLED;
+}
+
 /* HDMI HW IP initialisation */
 static int omapdss_hdmihw_probe(struct platform_device *pdev)
 {
@@ -823,6 +838,10 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
+	hdmi.irq = platform_get_irq(pdev, 0);
+	r = request_threaded_irq(hdmi.irq, NULL, hdmi_irq_handler, 0,
+				"OMAP HDMI", (void *)0);
+
 	hdmi.ip_data.core_sys_offset = HDMI_CORE_SYS;
 	hdmi.ip_data.core_av_offset = HDMI_CORE_AV;
 	hdmi.ip_data.pll_offset = HDMI_PLLCTRL;
@@ -853,6 +872,8 @@ static int omapdss_hdmihw_remove(struct platform_device *pdev)
 	snd_soc_unregister_codec(&pdev->dev);
 #endif
 
+	free_irq(hdmi.irq, NULL);
+
 	pm_runtime_disable(&pdev->dev);
 
 	hdmi_put_clocks();
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 6d65b3b..5e7e0da 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -122,6 +122,8 @@ struct ti_hdmi_ip_ops {
 
 	void (*dump_phy)(struct hdmi_ip_data *ip_data, struct seq_file *s);
 
+	void (*irq_handle)(struct hdmi_ip_data *ip_data);
+
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 	void (*audio_enable)(struct hdmi_ip_data *ip_data, bool start);
@@ -197,6 +199,7 @@ void ti_hdmi_4xxx_wp_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_pll_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
+void ti_hdmi_4xxx_intr_handler(struct hdmi_ip_data *ip_data);
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 5272f49..31d9927 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -312,6 +312,19 @@ static irqreturn_t hpd_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/* Interrupt handler */
+void ti_hdmi_4xxx_intr_handler(struct hdmi_ip_data *ip_data)
+{
+	u32 val;
+
+	val = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_IRQSTATUS);
+	/* Ack other interrupts if any */
+	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_IRQSTATUS, val);
+	/* flush posted write */
+	hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_IRQSTATUS);
+
+}
+
 int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data)
 {
 	u16 r = 0;
-- 
1.7.5.4

