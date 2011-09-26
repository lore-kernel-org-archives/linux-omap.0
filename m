From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 4/5] OMAP_VOUT: Add support for DSI panels
Date: Mon, 26 Sep 2011 12:12:09 +0530
Message-ID: <1317019330-4090-5-git-send-email-archit@ti.com>
References: <1317019330-4090-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1317019330-4090-1-git-send-email-archit@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: hvaibhav@ti.com
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, sumit.semwal@ti.com, linux-media@vger.kernel.org, Archit Taneja <archit@ti.com>
List-Id: linux-omap@vger.kernel.org

Add support for DSI panels. DSI video mode panels will work directly. For
command mode panels, we will need to trigger updates regularly. This isn't done
by the omap_vout driver currently. It can still be supported if we connect a
framebuffer device to the panel and configure it in auto update mode.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/media/video/omap/omap_vout.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/omap/omap_vout.c b/drivers/media/video/omap/omap_vout.c
index a0ca5f5..df0713c 100644
--- a/drivers/media/video/omap/omap_vout.c
+++ b/drivers/media/video/omap/omap_vout.c
@@ -590,6 +590,7 @@ static void omap_vout_isr(void *arg, unsigned int irqstatus)
 	do_gettimeofday(&timevalue);
 
 	switch (cur_display->type) {
+	case OMAP_DISPLAY_TYPE_DSI:
 	case OMAP_DISPLAY_TYPE_DPI:
 		if (mgr_id == OMAP_DSS_CHANNEL_LCD)
 			irq = DISPC_IRQ_VSYNC;
-- 
1.7.1
