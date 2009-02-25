From: Kim Kyuwon <chammoru@gmail.com>
Subject: [PATCH 1/2] usb: musb: fix the possible panic while resuming
Date: Wed, 25 Feb 2009 20:53:00 +0900
Message-ID: <4d34a0a70902250353i3c6e072bnd41af327bc77601b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:36371 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbZBYLxC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 06:53:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: OMAP <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, q1.kim@samsung.com, Minkyu Kang <mk7.kang@samsung.com>

From: Kim Kyuwon <chammoru@gmail.com>

While waking up, musb can cause a kernel panic. This patch is fixing
it by enabling the clock in the resume_early method.

Signed-off-by: Kim Kyuwon <chammoru@gmail.com>
---
 drivers/usb/musb/musb_core.c |   21 +++++++--------------
 1 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 2cc34fa..ae76ad7 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2141,16 +2141,13 @@ static int __devexit musb_remove(struct
platform_device *pdev)

 #ifdef	CONFIG_PM

-static int musb_suspend(struct platform_device *pdev, pm_message_t message)
+static int musb_suspend_late(struct platform_device *pdev, pm_message_t state)
 {
-	unsigned long	flags;
-	struct musb	*musb = dev_to_musb(&pdev->dev);
+	struct musb *musb = dev_to_musb(&pdev->dev);

 	if (!musb->clock)
 		return 0;

-	spin_lock_irqsave(&musb->lock, flags);
-
 	if (is_peripheral_active(musb)) {
 		/* FIXME force disconnect unless we know USB will wake
 		 * the system up quickly enough to respond ...
@@ -2165,20 +2162,17 @@ static int musb_suspend(struct platform_device
*pdev, pm_message_t message)
 		musb->set_clock(musb->clock, 0);
 	else
 		clk_disable(musb->clock);
-	spin_unlock_irqrestore(&musb->lock, flags);
+
 	return 0;
 }

-static int musb_resume(struct platform_device *pdev)
+static int musb_resume_early(struct platform_device *pdev)
 {
-	unsigned long	flags;
-	struct musb	*musb = dev_to_musb(&pdev->dev);
+	struct musb *musb = dev_to_musb(&pdev->dev);

 	if (!musb->clock)
 		return 0;

-	spin_lock_irqsave(&musb->lock, flags);
-
 	if (musb->set_clock)
 		musb->set_clock(musb->clock, 1);
 	else
@@ -2188,7 +2182,6 @@ static int musb_resume(struct platform_device *pdev)
 	 * unless for some reason the whole soc powered down and we're
 	 * not treating that as a whole-system restart (e.g. swsusp)
 	 */
-	spin_unlock_irqrestore(&musb->lock, flags);
 	return 0;
 }

@@ -2205,8 +2198,8 @@ static struct platform_driver musb_driver = {
 	},
 	.remove		= __devexit_p(musb_remove),
 	.shutdown	= musb_shutdown,
-	.suspend	= musb_suspend,
-	.resume		= musb_resume,
+	.suspend_late	= musb_suspend_late,
+	.resume_early	= musb_resume_early,
 };

 /*-------------------------------------------------------------------------*/
-- 
1.5.2.5


-- 
Kyuwon
