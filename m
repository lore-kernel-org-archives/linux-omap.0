From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v3 6/7] OMAPDSS: HDMI: Add op to get audio DMA port address offset
Date: Tue, 6 Nov 2012 00:19:16 -0600
Message-ID: <1352182757-1216-7-git-send-email-ricardo.neri@ti.com>
References: <1352182757-1216-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60078 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab2KFFVw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 00:21:52 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA65LpQ7031869
	for <linux-omap@vger.kernel.org>; Mon, 5 Nov 2012 23:21:51 -0600
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA65Lpua016125
	for <linux-omap@vger.kernel.org>; Mon, 5 Nov 2012 23:21:51 -0600
In-Reply-To: <1352182757-1216-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: peter.ujfalusi@ti.com, s-guiriec@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

It could be possible that the DMA port differs accross diferent HDMI IPs. Thus,
add an IP-specific function to obtain the address offset and size of the DMA
data port.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss_features.c    |    1 +
 drivers/video/omap2/dss/ti_hdmi.h         |    3 +++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    9 +++++++++
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 3e8287c..8dcecbc 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -820,6 +820,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 	.audio_start		=       ti_hdmi_4xxx_audio_start,
 	.audio_stop		=       ti_hdmi_4xxx_audio_stop,
 	.audio_config		=	ti_hdmi_4xxx_audio_config,
+	.audio_get_dma_port	=	ti_hdmi_4xxx_audio_get_dma_port,
 #endif
 
 };
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index b046c20..216aa70 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -102,6 +102,8 @@ struct ti_hdmi_ip_ops {
 
 	int (*audio_config)(struct hdmi_ip_data *ip_data,
 		struct omap_dss_audio *audio);
+
+	int (*audio_get_dma_port)(u32 *offset, u32 *size);
 #endif
 
 };
@@ -183,5 +185,6 @@ int ti_hdmi_4xxx_audio_start(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_audio_stop(struct hdmi_ip_data *ip_data);
 int ti_hdmi_4xxx_audio_config(struct hdmi_ip_data *ip_data,
 		struct omap_dss_audio *audio);
+int ti_hdmi_4xxx_audio_get_dma_port(u32 *offset, u32 *size);
 #endif
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index a6efff2..e18b222 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1418,4 +1418,13 @@ void ti_hdmi_4xxx_audio_stop(struct hdmi_ip_data *ip_data)
 	REG_FLD_MOD(hdmi_wp_base(ip_data),
 		    HDMI_WP_AUDIO_CTRL, false, 30, 30);
 }
+
+int ti_hdmi_4xxx_audio_get_dma_port(u32 *offset, u32 *size)
+{
+	if (!offset || !size)
+		return -EINVAL;
+	*offset = HDMI_WP_AUDIO_DATA;
+	*size = 4;
+	return 0;
+}
 #endif
-- 
1.7.5.4

