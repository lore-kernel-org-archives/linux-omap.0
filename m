From: <mythripk@ti.com>
Subject: [PATCH 3/3] OMAPDSS: HDMI: wait for TMDS to be high before putting
Date: Tue, 20 Mar 2012 18:45:07 +0530
Message-ID: <1332249307-26875-4-git-send-email-mythripk@ti.com>
References: <1332249307-26875-1-git-send-email-mythripk@ti.com>
 <1332249307-26875-2-git-send-email-mythripk@ti.com>
 <1332249307-26875-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53465 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757951Ab2CTNWE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 09:22:04 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q2KDM2sW011127
	for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 08:22:03 -0500
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q2KDM130018730
	for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 18:52:02 +0530 (IST)
In-Reply-To: <1332249307-26875-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Currently TX_PHY is put to TX_ON(transmission state) on receiving HPD.
It just ensures that the TV is connected but does not guarantee
that TMDS data lines and clock lines are up and ready for transmission.
Which although is very rare scenario has a potential to  damage the HDMI
port.
Thus this patch adds the support based on PHY interrupts.
On getting a HPD it registers for PHY connect/disconnect interrupt,
On recieving those it is made sure TMDS lines are UP before changing
the PHY state from LDO_ON to TX_ON.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi.h         |    1 +
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   61 ++++++++++++++++++++++++++---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    2 +
 3 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 5e7e0da..5051df6 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -186,6 +186,7 @@ struct hdmi_ip_data {
 	/* ti_hdmi_4xxx_ip private data. These should be in a separate struct */
 	int hpd_gpio;
 	bool phy_tx_enabled;
+	bool phy_enabled;
 };
 int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 31d9927..a54c811 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -273,7 +273,8 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
 {
 	unsigned long flags;
 	bool hpd;
-	int r;
+	int r = 0;
+	struct hdmi_irq_vector irq_enable;
 	/* this should be in ti_hdmi_4xxx_ip private data */
 	static DEFINE_SPINLOCK(phy_tx_lock);
 
@@ -286,11 +287,21 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
 		return 0;
 	}
 
-	if (hpd)
-		r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
-	else
+	hdmi_wp_clr_irq(ip_data);
+	hdmi_wp_irq_init(&irq_enable);
+	if (hpd) {
+		if (ip_data->phy_enabled) {
+			r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
+		} else {
+			irq_enable.phy_connect = 1;
+			irq_enable.phy_disconnect = 0;
+		}
+	} else {
 		r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_LDOON);
-
+		irq_enable.phy_connect = 0;
+		irq_enable.phy_disconnect = 0;
+		ip_data->phy_enabled = false;
+	}
 	if (r) {
 		DSSERR("Failed to %s PHY TX power\n",
 				hpd ? "enable" : "disable");
@@ -300,6 +311,7 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
 	ip_data->phy_tx_enabled = hpd;
 err:
 	spin_unlock_irqrestore(&phy_tx_lock, flags);
+	hdmi_wp_irq_enable(ip_data, &irq_enable);
 	return r;
 }
 
@@ -312,17 +324,54 @@ static irqreturn_t hpd_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+int hdmi_ti_4xxx_rxdet(struct hdmi_ip_data *ip_data)
+{
+       int tmds_lines =0;
+
+	tmds_lines = hdmi_read_reg(hdmi_phy_base(ip_data),
+					HDMI_TXPHY_PAD_CFG_CTRL);
+
+	return (tmds_lines && 0x7F80);
+}
 /* Interrupt handler */
 void ti_hdmi_4xxx_intr_handler(struct hdmi_ip_data *ip_data)
 {
-	u32 val;
+	u32 val, r = 0;
+	struct hdmi_irq_vector irq_enable;
 
 	val = hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_IRQSTATUS);
+
+	hdmi_wp_clr_irq(ip_data);
+	hdmi_wp_irq_init(&irq_enable);
+
+	if (val & HDMI_WP_IRQSTATUS_PHYCONNECT) {
+		if (ip_data->phy_tx_enabled && hdmi_ti_4xxx_rxdet(ip_data)) {
+			r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
+			irq_enable.phy_connect = 0;
+			irq_enable.phy_disconnect = 1;
+			ip_data->phy_enabled = true;
+		}
+	}
+
+	/* We can get connect / disconnect simultaneously due to glitch	*/
+	if (val & HDMI_WP_IRQSTATUS_PHYDISCONNECT) {
+		if (ip_data->phy_tx_enabled && !hdmi_ti_4xxx_rxdet(ip_data)) {
+			r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_LDOON);
+			irq_enable.phy_connect = 1;
+			irq_enable.phy_disconnect = 0;
+			ip_data->phy_enabled = false;
+		}
+	}
+
+	if (r)
+		DSSERR("Failed to set PHY TX power\n");
+
 	/* Ack other interrupts if any */
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_IRQSTATUS, val);
 	/* flush posted write */
 	hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_IRQSTATUS);
 
+	hdmi_wp_irq_enable(ip_data, &irq_enable);
 }
 
 int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data)
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 3090e81..38af675 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -48,6 +48,8 @@
 #define HDMI_WP_AUDIO_CFG2			0x84
 #define HDMI_WP_AUDIO_CTRL			0x88
 #define HDMI_WP_AUDIO_DATA			0x8C
+#define HDMI_WP_IRQSTATUS_PHYCONNECT		0x02000000
+#define HDMI_WP_IRQSTATUS_PHYDISCONNECT		0x04000000
 
 /* HDMI IP Core System */
 
-- 
1.7.5.4

