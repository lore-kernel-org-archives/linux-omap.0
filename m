From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 03/10] usb: musb: tusb6010: Add MUSB_G_NO_SKB_RESERVE to quirks
Date: Wed, 10 May 2017 11:42:25 +0300
Message-ID: <20170510084231.19302-4-peter.ujfalusi@ti.com>
References: <20170510084231.19302-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170510084231.19302-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: b-liu@ti.com, tony@atomide.com, gregkh@linuxfoundation.org, vinod.koul@intel.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When using the g_ncm for networking this flag will make sure that the
buffer is alligned to 32bit so the DMA can be used to offload the data
movement.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/usb/musb/tusb6010.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index e85cc8e4e7a9..4253bfb22043 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1181,7 +1181,8 @@ static int tusb_musb_exit(struct musb *musb)
 }
 
 static const struct musb_platform_ops tusb_ops = {
-	.quirks		= MUSB_DMA_TUSB_OMAP | MUSB_IN_TUSB,
+	.quirks		= MUSB_DMA_TUSB_OMAP | MUSB_IN_TUSB |
+			  MUSB_G_NO_SKB_RESERVE,
 	.init		= tusb_musb_init,
 	.exit		= tusb_musb_exit,
 
-- 
2.12.2
