From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/5] usb: musb: conditionally save and restore the context on suspend
Date: Mon, 25 Nov 2013 20:39:49 +0100
Message-ID: <1385408393-19707-2-git-send-email-zonque@gmail.com>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:42900 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757424Ab3KYTkE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 14:40:04 -0500
In-Reply-To: <1385408393-19707-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, Daniel Mack <zonque@gmail.com>

It appears not all platforms featuring a musb core need to save the musb
core registers at suspend time and restore them on resume.

The dsps platform does, however. So add a bit in struct
musb_hdrc_platform_data to let platforms specify their need of such
action being taken.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/usb/musb/musb_core.c | 17 ++++++++++++++++-
 include/linux/usb/musb.h     |  3 +++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 0a43329..a8ded57 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2202,6 +2202,7 @@ static int musb_suspend(struct device *dev)
 {
 	struct musb	*musb = dev_to_musb(dev);
 	unsigned long	flags;
+	struct musb_hdrc_platform_data *plat = dev_get_platdata(dev);
 
 	spin_lock_irqsave(&musb->lock, flags);
 
@@ -2215,16 +2216,30 @@ static int musb_suspend(struct device *dev)
 		 */
 	}
 
+	if (plat->restore_after_suspend)
+		musb_save_context(musb);
+
 	spin_unlock_irqrestore(&musb->lock, flags);
 	return 0;
 }
 
 static int musb_resume_noirq(struct device *dev)
 {
-	/* for static cmos like DaVinci, register values were preserved
+	struct musb	*musb = dev_to_musb(dev);
+	struct musb_hdrc_platform_data *plat = dev_get_platdata(dev);
+
+	/*
+	 * For static cmos like DaVinci, register values were preserved
 	 * unless for some reason the whole soc powered down or the USB
 	 * module got reset through the PSC (vs just being disabled).
+	 *
+	 * The plaform data tells us about the necessity of saving and
+	 * restoring the context across a suspend cycle.
 	 */
+
+	if (plat->restore_after_suspend)
+		musb_restore_context(musb);
+
 	return 0;
 }
 
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index eb50525..e5a581c 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -99,6 +99,9 @@ struct musb_hdrc_platform_data {
 	/* MUSB_HOST, MUSB_PERIPHERAL, or MUSB_OTG */
 	u8		mode;
 
+	/* should the musb core restore registers after suspend? */
+	u8		restore_after_suspend:1;
+
 	/* for clk_get() */
 	const char	*clock;
 
-- 
1.8.4.2

