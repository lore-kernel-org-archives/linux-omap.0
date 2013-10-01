From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 3/5] usb: musb: conditionally save and restore the context on suspend
Date: Tue,  1 Oct 2013 15:39:55 +0200
Message-ID: <1380634797-29541-4-git-send-email-zonque@gmail.com>
References: <1380634797-29541-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:51007 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223Ab3JANkH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Oct 2013 09:40:07 -0400
In-Reply-To: <1380634797-29541-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, Daniel Mack <zonque@gmail.com>

It appears not all platforms featuring a musb core need to save the musb
core registers at suspend time and restore them on resume.

The dsps platform does, however. So add a bit in struct
musb_hdrc_platform_data to let platforms specify their need of such
action being taken.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/usb/musb/musb_core.c | 17 ++++++++++++++++-
 include/linux/usb/musb.h     |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 2b9f4b4..f17604e 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2152,6 +2152,7 @@ static int musb_suspend(struct device *dev)
 {
 	struct musb	*musb = dev_to_musb(dev);
 	unsigned long	flags;
+	struct musb_hdrc_platform_data *plat = dev_get_platdata(dev);
 
 	spin_lock_irqsave(&musb->lock, flags);
 
@@ -2165,16 +2166,30 @@ static int musb_suspend(struct device *dev)
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
index 053c268..296be6c 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -100,6 +100,7 @@ struct musb_hdrc_platform_data {
 	u8		mode;
 
 	u8		has_mailbox:1;
+	u8		restore_after_suspend:1;
 
 	/* for clk_get() */
 	const char	*clock;
-- 
1.8.3.1

