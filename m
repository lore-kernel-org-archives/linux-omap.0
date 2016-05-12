From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 13/15] usb: musb: Remove pm_runtime_set_irq_safe
Date: Wed, 11 May 2016 17:53:14 -0700
Message-ID: <1463014396-4095-14-git-send-email-tony@atomide.com>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463014396-4095-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

With the pull up being handled with delayed work, we can
now finally remove pm_runtime_set_irq_safe that blocks the
MUSB glue from idling.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 6469eff..0286a39 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2223,12 +2223,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	pm_runtime_mark_last_busy(musb->controller);
 	pm_runtime_put_autosuspend(musb->controller);
 
-	/*
-	 * For why this is currently needed, see commit 3e43a0725637
-	 * ("usb: musb: core: add pm_runtime_irq_safe()")
-	 */
-	pm_runtime_irq_safe(musb->controller);
