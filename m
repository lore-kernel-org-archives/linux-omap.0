From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] usb: musb: fix pm_runtime mismatches
Date: Fri, 16 Dec 2011 01:05:08 +0200
Message-ID: <1323990310-11905-2-git-send-email-felipe.contreras@gmail.com>
References: <1323990310-11905-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323990310-11905-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <trivial@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

Properly call pm_runtime_put() afer pm_runttime_get() on errors.

Untested.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/usb/musb/musb_gadget.c |    1 +
 drivers/usb/musb/omap2430.c    |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 922148f..95bfd2d 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1960,6 +1960,7 @@ static int musb_gadget_start(struct usb_gadget *g,
 err2:
 	if (!is_otg_enabled(musb))
 		musb_stop(musb);
+	pm_runtime_put(musb->controller);
 err0:
 	return retval;
 }
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index ba85f27..4edfb91 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -385,6 +385,7 @@ static void omap2430_musb_disable(struct musb *musb)
 
 static int omap2430_musb_exit(struct musb *musb)
 {
+	pm_runtime_put(musb->controller);
 	del_timer_sync(&musb_idle_timer);
 
 	omap2430_low_level_exit(musb);
-- 
1.7.8.rc1.14.g248db
