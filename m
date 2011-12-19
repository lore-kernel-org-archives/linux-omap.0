From: Felipe Contreras <felipe.contreras-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] usb: musb: fix pm_runtime mismatch
Date: Mon, 19 Dec 2011 22:01:54 +0200
Message-ID: <1324324914-14584-1-git-send-email-felipe.contreras@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>, Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

In musb_init_controller() there's a pm_runtime_put(), but there's no
pm_runtime_get(), which creates a mismatch that causes the driver to
sleep when it shouldn't.

This was introduced in 7acc619[1], but it wasn't triggered in my setup
until 18a2689[2] was merged to Linus' branch at point df0914[3]. IOW;
when PM is working as it was supposed to.

However, it seems most of the time this is used in a way that keeps the
counter above 0, so nobody noticed. Also, it seems to depend on the
configuration used in versions before 3.1, but not later (or in it).

I found the problem by loading isp1704_charger before any usb gadgets:
http://article.gmane.org/gmane.linux.kernel/1226122

All versions after 2.6.39 are affected.

[1] usb: musb: Idle path retention and offmode support for OMAP3
[2] OMAP2+: musb: hwmod adaptation for musb registration
[3] Merge branch 'omap-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index b63ab15..920f04e 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2012,8 +2012,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	if (status < 0)
 		goto fail3;
 
-	pm_runtime_put(musb->controller);
