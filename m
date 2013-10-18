From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 1/5] usb: musb: call musb_port_suspend from musb_bus_suspend
Date: Fri, 18 Oct 2013 11:39:31 +0200
Message-ID: <1382089175-13487-2-git-send-email-zonque@gmail.com>
References: <1382089175-13487-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:61125 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab3JRJjq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 05:39:46 -0400
In-Reply-To: <1382089175-13487-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, Daniel Mack <zonque@gmail.com>

Make musb_port_suspend() externally available, and call it when to host
goes into suspend. This allows the core to go into suspend while a
device is connected.

Signed-off-by: Daniel Mack <zonque@gmail.com>
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
index 960d735..e660af9 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -92,6 +92,7 @@ extern void musb_host_rx(struct musb *, u8);
 extern void musb_root_disconnect(struct musb *musb);
 extern void musb_host_resume_root_hub(struct musb *musb);
 extern void musb_host_poke_root_hub(struct musb *musb);
+extern void musb_port_suspend(struct musb *musb, bool do_suspend);
 #else
 static inline struct musb *hcd_to_musb(struct usb_hcd *hcd)
 {
@@ -121,6 +122,7 @@ static inline void musb_root_disconnect(struct musb *musb)	{}
 static inline void musb_host_resume_root_hub(struct musb *musb)	{}
 static inline void musb_host_poll_rh_status(struct musb *musb)	{}
 static inline void musb_host_poke_root_hub(struct musb *musb)	{}
+static inline void musb_port_suspend(struct musb *musb, bool do_suspend) {}
 #endif
 
 struct usb_hcd;
diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index 9af6bba..e977441 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -44,7 +44,7 @@
 
 #include "musb_core.h"
 
-static void musb_port_suspend(struct musb *musb, bool do_suspend)
+void musb_port_suspend(struct musb *musb, bool do_suspend)
 {
 	struct usb_otg	*otg = musb->xceiv->otg;
 	u8		power;
-- 
1.8.3.1

