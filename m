From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/2] musb_gadget: fix compilation warning
Date: Mon, 22 Nov 2010 14:22:41 +0530
Message-ID: <1290415961-21177-2-git-send-email-ajay.gupta@ti.com>
References: <1290415961-21177-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43641 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab0KVIwr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 03:52:47 -0500
In-Reply-To: <1290415961-21177-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Fixes below compilation warning when musb driver is compiled for
PIO mode.
drivers/usb/musb/musb_gadget.c: In function 'musb_g_rx':
drivers/usb/musb/musb_gadget.c:840:
		warning: label 'exit' defined but not used

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
Patch created against latest Linus's tree (v2.6.37-rc3)

 drivers/usb/musb/musb_gadget.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 36cfd06..bb9f05e 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -837,7 +837,9 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 		if (!request)
 			return;
 	}
+#if defined(CONFIG_USB_INVENTRA_DMA) || defined(CONFIG_USB_TUSB_OMAP_DMA)
 exit:
+#endif
 	/* Analyze request */
 	rxstate(musb, to_musb_request(request));
 }
-- 
1.6.2.4

