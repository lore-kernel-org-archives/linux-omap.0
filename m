From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 1/4] usb: musb: unconditionally save and restore the context on suspend
Date: Mon, 25 Nov 2013 22:26:40 +0100
Message-ID: <1385414803-13212-2-git-send-email-zonque@gmail.com>
References: <1385414803-13212-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:50892 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab3KYV1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 16:27:03 -0500
In-Reply-To: <1385414803-13212-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, Daniel Mack <zonque@gmail.com>

It appears not all platforms featuring a musb core need to save the musb
core registers at suspend time and restore them on resume.

The dsps platform does, however, and because it shouldn't cause any
trouble on other platforms, do it unconditionally for all of them.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/usb/musb/musb_core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 0a43329..797709d 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2215,16 +2215,28 @@ static int musb_suspend(struct device *dev)
 		 */
 	}
 
+	musb_save_context(musb);
+
 	spin_unlock_irqrestore(&musb->lock, flags);
 	return 0;
 }
 
 static int musb_resume_noirq(struct device *dev)
 {
-	/* for static cmos like DaVinci, register values were preserved
+	struct musb	*musb = dev_to_musb(dev);
+
+	/*
+	 * For static cmos like DaVinci, register values were preserved
 	 * unless for some reason the whole soc powered down or the USB
 	 * module got reset through the PSC (vs just being disabled).
+	 *
+	 * For the DSPS glue layer though, a full register restore has to
+	 * be done. As it shouldn't harm other platforms, we do it
+	 * unconditionally.
 	 */
+
+	musb_restore_context(musb);
+
 	return 0;
 }
 
-- 
1.8.4.2

