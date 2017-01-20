From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] usb: musb: Fix external abort on non-linefetch for musb_irq_work()
Date: Fri, 20 Jan 2017 11:27:38 -0800
Message-ID: <20170120192738.24973-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

While testing musb host mode cable plugging on a BeagleBone, I came across this
error:

Unhandled fault: external abort on non-linefetch (0x1008) at 0xd1dcfc60
...
[<bf668390>] (musb_default_readb [musb_hdrc]) from [<bf668578>] (musb_irq_work+0x1c/0x180 [musb_hdrc])
[<bf668578>] (musb_irq_work [musb_hdrc]) from [<c0156554>] (process_one_work+0x2b4/0x808)
[<c0156554>] (process_one_work) from [<c015767c>] (worker_thread+0x3c/0x550)
[<c015767c>] (worker_thread) from [<c015d568>] (kthread+0x104/0x148)
[<c015d568>] (kthread) from [<c01078d0>] (ret_from_fork+0x14/0x24)

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---

I found one more corner case issue in my usb cable plugfest yesterday.

 drivers/usb/musb/musb_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1925,6 +1925,14 @@ static void musb_pm_runtime_check_session(struct musb *musb)
 static void musb_irq_work(struct work_struct *data)
 {
 	struct musb *musb = container_of(data, struct musb, irq_work.work);
+	int error;
+
+	error = pm_runtime_get_sync(musb->controller);
+	if (error < 0) {
+		dev_err(musb->controller, "Could not enable: %i\n", error);
+
+		return;
+	}
 
 	musb_pm_runtime_check_session(musb);
 
@@ -1932,6 +1940,9 @@ static void musb_irq_work(struct work_struct *data)
 		musb->xceiv_old_state = musb->xceiv->otg->state;
 		sysfs_notify(&musb->controller->kobj, NULL, "mode");
 	}
+
+	pm_runtime_mark_last_busy(musb->controller);
+	pm_runtime_put_autosuspend(musb->controller);
 }
 
 static void musb_recover_from_babble(struct musb *musb)
-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
