From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/3] usb: musb: export musb_interrupt symbol
Date: Wed, 11 May 2011 13:06:55 +0300
Message-ID: <1305108415-27206-4-git-send-email-balbi@ti.com>
References: <1305108415-27206-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:47126 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755301Ab1EKPtV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 11:49:21 -0400
In-Reply-To: <1305108415-27206-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

currently that's used by another module
(am35x) which, granted, it shouldn't be
using that, but in order to avoid compile
errors, let's export that symbol temporarily
until re-factoring work is done on that
driver.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/musb_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index d8014a3..4f0f6d4 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1643,7 +1643,7 @@ irqreturn_t musb_interrupt(struct musb *musb)
 
 	return retval;
 }
-
+EXPORT_SYMBOL_GPL(musb_interrupt);
 
 #ifndef CONFIG_MUSB_PIO_ONLY
 static int __initdata use_dma = 1;
-- 
1.7.4.1.343.ga91df

