From: Archit Taneja <archit@ti.com>
Subject: [PATCH 07/11] omapdss: HDMI: add HDMI wrapper IRQ flags
Date: Tue, 17 Sep 2013 12:36:33 +0530
Message-ID: <1379401597-27222-8-git-send-email-archit@ti.com>
References: <1379401597-27222-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34373 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246Ab3IQHHw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Sep 2013 03:07:52 -0400
In-Reply-To: <1379401597-27222-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add flags for the interrupts present in HDMI wrapper block, these will be used
to configure HDMI_IRQENABLE_SET/CLEAR and HDMI_IRQSTATUS registers.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/hdmi_phy.c |  3 ---
 drivers/video/omap2/dss/ti_hdmi.h  | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi_phy.c b/drivers/video/omap2/dss/hdmi_phy.c
index b79c56b..b7d171c 100644
--- a/drivers/video/omap2/dss/hdmi_phy.c
+++ b/drivers/video/omap2/dss/hdmi_phy.c
@@ -17,9 +17,6 @@
 #include "dss.h"
 #include "ti_hdmi.h"
 
-#define HDMI_IRQ_LINK_CONNECT		(1 << 25)
-#define HDMI_IRQ_LINK_DISCONNECT	(1 << 26)
-
 void hdmi_phy_dump(struct hdmi_phy_data *phy, struct seq_file *s)
 {
 #define DUMPPHY(r) seq_printf(s, "%-35s %08x\n", #r,\
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index cf096fd..5034080 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -49,6 +49,21 @@
 #define HDMI_WP_AUDIO_CTRL			0x88
 #define HDMI_WP_AUDIO_DATA			0x8C
 
+/* HDMI WP IRQ flags */
+
+#define HDMI_IRQ_OCP_TIMEOUT			(1 << 4)
+#define HDMI_IRQ_AUDIO_FIFO_UNDERFLOW		(1 << 8)
+#define HDMI_IRQ_AUDIO_FIFO_OVERFLOW		(1 << 9)
+#define HDMI_IRQ_AUDIO_FIFO_SAMPLE_REQ		(1 << 10)
+#define HDMI_IRQ_VIDEO_VSYNC			(1 << 16)
+#define HDMI_IRQ_VIDEO_FRAME_DONE		(1 << 17)
+#define HDMI_IRQ_PHY_LINE5V_ASSERT		(1 << 24)
+#define HDMI_IRQ_LINK_CONNECT			(1 << 25)
+#define HDMI_IRQ_LINK_DISCONNECT		(1 << 26)
+#define HDMI_IRQ_PLL_LOCK			(1 << 29)
+#define HDMI_IRQ_PLL_UNLOCK			(1 << 30)
+#define HDMI_IRQ_PLL_RECAL			(1 << 31)
+
 /* HDMI PLL */
 
 #define PLLCTRL_PLL_CONTROL			0x0
-- 
1.8.1.2

