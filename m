From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 02/10] usb: musb: Fix idling after host mode by increasing autosuspend delay
Date: Thu, 28 Apr 2016 10:33:12 -0700
Message-ID: <1461864800-29979-3-git-send-email-tony@atomide.com>
References: <1461864800-29979-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461864800-29979-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Looks like at least 2430 glue won't idle reliably with the 200 ms
autosuspend delay. This causes deeper idle states being blocked for
the whole SoC when disconnecting OTG A cable.

Increasing the delay to 500 ms seems to idle both MUSB and the PHY
reliably. This is probably because of time needed by the hardware
based negotiation between MUSB and the PHY.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 39fd958..5fa6187 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2030,7 +2030,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 
 	/* We need musb_read/write functions initialized for PM */
 	pm_runtime_use_autosuspend(musb->controller);
-	pm_runtime_set_autosuspend_delay(musb->controller, 200);
+	pm_runtime_set_autosuspend_delay(musb->controller, 500);
 	pm_runtime_enable(musb->controller);
 
 	/* The musb_platform_init() call:
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
