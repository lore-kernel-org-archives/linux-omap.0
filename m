From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] usb: musb: fix shutdown while usb gadget is in use
Date: Thu, 12 Jan 2012 15:22:45 +0200
Message-ID: <1326374565-23042-1-git-send-email-notasas@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

If we shutdown without stopping the gadget first or removing the cable,
gadget manages to configure itself again:

root@pandora /root# poweroff
The system is going down NOW!
Requesting system poweroff
[   47.714385] musb-hm halted.
[   48.120697]  gadget: suspend
[   48.123748]  gadget: reset config
[   48.127227]  gadget: ecm deactivated
[   48.130981] usb0: gether_disconnect
[   48.281799]  gadget: high-speed config #1: CDC Ethernet (ECM)
[   48.287872]  gadget: init ecm
[   48.290985]  gadget: notify connect false
[   48.295288]  gadget: notify speed 425984000

This is not only unwanted, it's also happening on half-unitialized
state, after musb_shutdown() has returned, which sometimes causes
hardware to fail to work after reboot. Let's better properly stop
gadget on shutdown too.

This patch moves musb_gadget_cleanup out of musb_free(), which has 2
callsites: probe error path and musb_remove. On probe error path it was
superflous since musb_gadget_cleanup is called explicitly there, and
musb_remove() calls musb_shutdown(), so cleanup will get called as before.

Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index b2ca6fd..be123a1 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -991,6 +991,9 @@ static void musb_shutdown(struct platform_device *pdev)
 	unsigned long	flags;
 
 	pm_runtime_get_sync(musb->controller);
+
+	musb_gadget_cleanup(musb);
+
 	spin_lock_irqsave(&musb->lock, flags);
 	musb_platform_disable(musb);
 	musb_generic_disable(musb);
@@ -1874,8 +1877,6 @@ static void musb_free(struct musb *musb)
 	sysfs_remove_group(&musb->controller->kobj, &musb_attr_group);
 #endif
 
-	musb_gadget_cleanup(musb);
