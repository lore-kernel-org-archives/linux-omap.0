From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/5] usb: musb: call musb_port_suspend from musb_bus_suspend
Date: Tue,  1 Oct 2013 15:39:54 +0200
Message-ID: <1380634797-29541-3-git-send-email-zonque@gmail.com>
References: <1380634797-29541-1-git-send-email-zonque@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380634797-29541-1-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Make musb_port_suspend() externally available, and call it when to host
goes into suspend. This allows the core to go into suspend while a
device is connected.

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_host.c    | 2 ++
 drivers/usb/musb/musb_host.h    | 2 ++
 drivers/usb/musb/musb_virthub.c | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 9a2b8c8..2b60596 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2433,6 +2433,8 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
 	struct musb	*musb = hcd_to_musb(hcd);
 	u8		devctl;
 
+	musb_port_suspend(musb, true);
+
 	if (!is_host_active(musb))
 		return 0;
 
diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
index 843f48e..dcffea7 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -93,6 +93,7 @@ extern void musb_root_disconnect(struct musb *musb);
 extern void musb_host_resume_root_hub(struct musb *musb);
 extern void musb_host_poke_root_hub(struct musb *musb);
 extern void musb_port_reset(struct musb *musb);
+extern void musb_port_suspend(struct musb *musb, bool do_suspend);
 #else
 static inline struct musb *hcd_to_musb(struct usb_hcd *hcd)
 {
@@ -123,6 +124,7 @@ static inline void musb_host_resume_root_hub(struct musb *musb)	{}
 static inline void musb_host_poll_rh_status(struct musb *musb)	{}
 static inline void musb_host_poke_root_hub(struct musb *musb)	{}
 static inline void musb_port_reset(struct musb *musb)		{}
+static inline void musb_port_suspend(struct musb *musb, bool do_suspend) {}
 #endif
 
 struct usb_hcd;
diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index 30b43a1..9f3a0f3 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -90,7 +90,7 @@ static void musb_start(struct musb *musb)
 	musb_writeb(regs, MUSB_DEVCTL, devctl);
 }
 
-static void musb_port_suspend(struct musb *musb, bool do_suspend)
+void musb_port_suspend(struct musb *musb, bool do_suspend)
 {
 	struct usb_otg	*otg = musb->xceiv->otg;
 	u8		power;
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
