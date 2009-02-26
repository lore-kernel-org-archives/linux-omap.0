From: Kim Kyuwon <chammoru@gmail.com>
Subject: [RESEND][PATCH 1/2] usb: musb: fix the possible panic while resuming
Date: Thu, 26 Feb 2009 17:27:47 +0900
Message-ID: <4d34a0a70902260027g686a2480qb6b6e00b8d5e8b7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:5377 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbZBZI1t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 03:27:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, OMAP <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>, Minkyu Kang <mk7.kang@samsung.com>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>

While waking up, musb can cause a kernel panic. This patch is fixing
it by enabling the clock in the resume_early method.

Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
---
 drivers/usb/musb/musb_core.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 2cc34fa..6de2cb2 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2169,16 +2169,13 @@ static int musb_suspend(struct platform_device
*pdev, pm_message_t message)
 	return 0;
 }

-static int musb_resume(struct platform_device *pdev)
+static int musb_resume_early(struct platform_device *pdev)
 {
-	unsigned long	flags;
 	struct musb	*musb = dev_to_musb(&pdev->dev);

 	if (!musb->clock)
 		return 0;

-	spin_lock_irqsave(&musb->lock, flags);
-
 	if (musb->set_clock)
 		musb->set_clock(musb->clock, 1);
 	else
@@ -2188,7 +2185,6 @@ static int musb_resume(struct platform_device *pdev)
 	 * unless for some reason the whole soc powered down and we're
 	 * not treating that as a whole-system restart (e.g. swsusp)
 	 */
-	spin_unlock_irqrestore(&musb->lock, flags);
 	return 0;
 }

@@ -2206,7 +2202,7 @@ static struct platform_driver musb_driver = {
 	.remove		= __devexit_p(musb_remove),
 	.shutdown	= musb_shutdown,
 	.suspend	= musb_suspend,
-	.resume		= musb_resume,
+	.resume_early	= musb_resume_early,
 };

 /*-------------------------------------------------------------------------*/
-- 
1.5.2.5


-- 
Q1
