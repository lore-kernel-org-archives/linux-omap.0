From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/6] usb: musb: Fix broken use of static variable for multiple instances
Date: Tue, 15 Nov 2016 13:37:50 -0800
Message-ID: <20161115213755.12316-2-tony@atomide.com>
References: <20161115213755.12316-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161115213755.12316-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We can't use static variable first for checking when musb is
initialized when we have multiple musb instances like on am335x.

Tested-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Reviewed-by: Johan Hovold <johan-UKKVnA4tBMC5azolltMz9laTQe2KTcn/@public.gmane.org>
Tested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.c | 9 +++++----
 drivers/usb/musb/musb_core.h | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2291,6 +2291,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	if (status)
 		goto fail5;
 
+	musb->is_initialized = 1;
 	pm_runtime_mark_last_busy(musb->controller);
 	pm_runtime_put_autosuspend(musb->controller);
 
@@ -2629,7 +2630,6 @@ static int musb_runtime_suspend(struct device *dev)
 static int musb_runtime_resume(struct device *dev)
 {
 	struct musb	*musb = dev_to_musb(dev);
-	static int	first = 1;
 
 	/*
 	 * When pm_runtime_get_sync called for the first time in driver
@@ -2640,9 +2640,10 @@ static int musb_runtime_resume(struct device *dev)
 	 * Also context restore without save does not make
 	 * any sense
 	 */
-	if (!first)
-		musb_restore_context(musb);
-	first = 0;
+	if (!musb->is_initialized)
+		return 0;
+
+	musb_restore_context(musb);
 
 	if (musb->need_finish_resume) {
 		musb->need_finish_resume = 0;
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -385,6 +385,8 @@ struct musb {
 	int			a_wait_bcon;	/* VBUS timeout in msecs */
 	unsigned long		idle_timeout;	/* Next timeout in jiffies */
 
+	unsigned		is_initialized:1;
+
 	/* active means connected and not suspended */
 	unsigned		is_active:1;
 
-- 
2.10.2
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
