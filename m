From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 5/7] OMAP: DSS2: DSI: Pass pointer to struct to packet_sent_handler isrs
Date: Thu, 12 May 2011 17:26:28 +0530
Message-ID: <1305201390-9724-6-git-send-email-archit@ti.com>
References: <1305201390-9724-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33305 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756027Ab1ELLwH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 07:52:07 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4CBq60t025566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 06:52:06 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4CBq6Px009305
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 06:52:06 -0500 (CDT)
In-Reply-To: <1305201390-9724-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

dsi_packet_sent_handler_vp() and dsi_packet_sent_handler_l4() currently
receive the completion parameter as their argument. This is not sufficient
information to differentiate between DSI1 and DSI2 platform devices.

Pass the struct "dsi_packet_sent_handler_data" to the packet_sent_handler
isrs, these contain the platform_device pointer of the DSI device and the
pointer to the completion struct.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   43 +++++++++++++++++++++++-----------------
 1 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 61ee3db..762b0fe 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -330,6 +330,11 @@ struct dsi_data {
 	unsigned scp_clk_refcount;
 };
 
+struct dsi_packet_sent_handler_data {
+	struct platform_device *dsidev;
+	struct completion *completion;
+};
+
 static struct platform_device *dsi_pdev_map[MAX_NUM_DSI];
 
 #ifdef DEBUG
@@ -2394,27 +2399,28 @@ static bool dsi_vc_is_enabled(struct platform_device *dsidev, int channel)
 
 static void dsi_packet_sent_handler_vp(void *data, u32 mask)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_id(0);
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct dsi_packet_sent_handler_data *vp_data =
+		(struct dsi_packet_sent_handler_data *) data;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(vp_data->dsidev);
 	const int channel = dsi->update_channel;
 	u8 bit = dsi->te_enabled ? 30 : 31;
 
-	if (REG_GET(dsidev, DSI_VC_TE(channel), bit, bit) == 0)
-		complete((struct completion *)data);
+	if (REG_GET(vp_data->dsidev, DSI_VC_TE(channel), bit, bit) == 0)
+		complete(vp_data->completion);
 }
 
 static int dsi_sync_vc_vp(struct platform_device *dsidev, int channel)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	DECLARE_COMPLETION_ONSTACK(completion);
+	struct dsi_packet_sent_handler_data vp_data = { dsidev, &completion };
 	int r = 0;
 	u8 bit;
 
-	DECLARE_COMPLETION_ONSTACK(completion);
-
 	bit = dsi->te_enabled ? 30 : 31;
 
 	r = dsi_register_isr_vc(dsidev, channel, dsi_packet_sent_handler_vp,
-		&completion, DSI_VC_IRQ_PACKET_SENT);
+		&vp_data, DSI_VC_IRQ_PACKET_SENT);
 	if (r)
 		goto err0;
 
@@ -2429,34 +2435,35 @@ static int dsi_sync_vc_vp(struct platform_device *dsidev, int channel)
 	}
 
 	dsi_unregister_isr_vc(dsidev, channel, dsi_packet_sent_handler_vp,
-		&completion, DSI_VC_IRQ_PACKET_SENT);
+		&vp_data, DSI_VC_IRQ_PACKET_SENT);
 
 	return 0;
 err1:
 	dsi_unregister_isr_vc(dsidev, channel, dsi_packet_sent_handler_vp,
-		&completion, DSI_VC_IRQ_PACKET_SENT);
+		&vp_data, DSI_VC_IRQ_PACKET_SENT);
 err0:
 	return r;
 }
 
 static void dsi_packet_sent_handler_l4(void *data, u32 mask)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_id(0);
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct dsi_packet_sent_handler_data *l4_data =
+		(struct dsi_packet_sent_handler_data *) data;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(l4_data->dsidev);
 	const int channel = dsi->update_channel;
 
-	if (REG_GET(dsidev, DSI_VC_CTRL(channel), 5, 5) == 0)
-		complete((struct completion *)data);
+	if (REG_GET(l4_data->dsidev, DSI_VC_CTRL(channel), 5, 5) == 0)
+		complete(l4_data->completion);
 }
 
 static int dsi_sync_vc_l4(struct platform_device *dsidev, int channel)
 {
-	int r = 0;
-
 	DECLARE_COMPLETION_ONSTACK(completion);
+	struct dsi_packet_sent_handler_data l4_data = { dsidev, &completion };
+	int r = 0;
 
 	r = dsi_register_isr_vc(dsidev, channel, dsi_packet_sent_handler_l4,
-		&completion, DSI_VC_IRQ_PACKET_SENT);
+		&l4_data, DSI_VC_IRQ_PACKET_SENT);
 	if (r)
 		goto err0;
 
@@ -2471,12 +2478,12 @@ static int dsi_sync_vc_l4(struct platform_device *dsidev, int channel)
 	}
 
 	dsi_unregister_isr_vc(dsidev, channel, dsi_packet_sent_handler_l4,
-		&completion, DSI_VC_IRQ_PACKET_SENT);
+		&l4_data, DSI_VC_IRQ_PACKET_SENT);
 
 	return 0;
 err1:
 	dsi_unregister_isr_vc(dsidev, channel, dsi_packet_sent_handler_l4,
-		&completion, DSI_VC_IRQ_PACKET_SENT);
+		&l4_data, DSI_VC_IRQ_PACKET_SENT);
 err0:
 	return r;
 }
-- 
1.7.1

