From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] OMAPDSS: DSI: cleanup DSI_IRQ_ERROR_MASK define
Date: Mon, 23 Nov 2015 21:22:36 +0300
Message-ID: <20151123182235.GA2825@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

DSI_IRQ_SYNC_LOST was ORed twice so we can remove one.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index b3606de..e86df6d 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -144,7 +144,7 @@ struct dsi_reg { u16 module; u16 idx; };
 #define DSI_IRQ_TA_TIMEOUT	(1 << 20)
 #define DSI_IRQ_ERROR_MASK \
 	(DSI_IRQ_HS_TX_TIMEOUT | DSI_IRQ_LP_RX_TIMEOUT | DSI_IRQ_SYNC_LOST | \
-	DSI_IRQ_TA_TIMEOUT | DSI_IRQ_SYNC_LOST)
+	DSI_IRQ_TA_TIMEOUT)
 #define DSI_IRQ_CHANNEL_MASK	0xf
 
 /* Virtual channel interrupts */
