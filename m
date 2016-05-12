From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 01/15] usb: musb: Fix idling after host mode by increasing autosuspend delay
Date: Wed, 11 May 2016 17:53:02 -0700
Message-ID: <1463014396-4095-2-git-send-email-tony@atomide.com>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463014396-4095-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Looks like at least 2430 glue won't idle reliably with the 200 ms
autosuspend delay. This causes deeper idle states being blocked for
the whole SoC when disconnecting OTG A cable.

Increasing the delay to 500 ms seems to idle both MUSB and the PHY
reliably. This is probably because of time needed by the hardware
based negotiation between MUSB and the PHY.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 39fd958..460176c 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2028,9 +2028,15 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	musb_readl = musb_default_readl;
 	musb_writel = musb_default_writel;
 
-	/* We need musb_read/write functions initialized for PM */
+	/*
+	 * We need musb_read/write functions initialized for PM.
+	 * Note that at least 2430 glue needs autosuspend delay
+	 * somewhere above 300 ms for the hardware to idle properly
+	 * after disconnecting the cable in host mode. Let's use
+	 * 500 ms for some margin.
+	 */
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
