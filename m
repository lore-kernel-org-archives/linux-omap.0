From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.34-rc2+ 05/11] musb: potential use after free
Date: Wed, 24 Mar 2010 13:47:53 +0200
Message-ID: <1269431279-22438-6-git-send-email-felipe.balbi@nokia.com>
References: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53816 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab0CXLsk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 07:48:40 -0400
In-Reply-To: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Dan Carpenter <error27@gmail.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Dan Carpenter <error27@gmail.com>

We assign "urb->hcpriv = qh;" a few lines down.  I'm pretty sure we
want it "urb->hcpriv" to be NULL not a freed value.

Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_host.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index dec896e..877d20b 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2042,6 +2042,7 @@ static int musb_urb_enqueue(
 		 * odd, rare, error prone, but legal.
 		 */
 		kfree(qh);
+		qh = NULL;
 		ret = 0;
 	} else
 		ret = musb_schedule(musb, qh,
-- 
1.7.0.rc0.33.g7c3932

