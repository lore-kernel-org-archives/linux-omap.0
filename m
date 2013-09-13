From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/7] OMAPDSS: HDMI: OMAP4: Complete register definitions for wrapper
Date: Fri, 13 Sep 2013 15:59:32 +0530
Message-ID: <1379068178-17312-2-git-send-email-archit@ti.com>
References: <1379068178-17312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48379 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab3IMKae (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Sep 2013 06:30:34 -0400
In-Reply-To: <1379068178-17312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>, Archit Taneja <archit@ti.com>

From: Ricardo Neri <ricardo.neri@ti.com>

Add definitions for missing registers in the HDMI wrapper. Also, order
the registers by offset to improve readability.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 6ef2f92..469d436 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -31,9 +31,11 @@
 #define HDMI_WP_SYSCONFIG			0x10
 #define HDMI_WP_IRQSTATUS_RAW			0x24
 #define HDMI_WP_IRQSTATUS			0x28
-#define HDMI_WP_PWR_CTRL			0x40
 #define HDMI_WP_IRQENABLE_SET			0x2C
 #define HDMI_WP_IRQENABLE_CLR			0x30
+#define HDMI_WP_IRQWAKEEN			0x34
+#define HDMI_WP_PWR_CTRL			0x40
+#define HDMI_WP_DEBOUNCE			0x44
 #define HDMI_WP_VIDEO_CFG			0x50
 #define HDMI_WP_VIDEO_SIZE			0x60
 #define HDMI_WP_VIDEO_TIMING_H			0x68
-- 
1.8.1.2

