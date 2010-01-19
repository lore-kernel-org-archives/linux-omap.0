From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 16/16] USB: musb: don't dereference NULL tusb_dma in dma_controller_destroy()
Date: Tue, 19 Jan 2010 15:14:15 +0200
Message-ID: <1263906855-28341-17-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36087 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab0ASNPF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:15:05 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

From: Roel Kluin <roel.kluin@gmail.com>

Test whether tusb_dma is not NULL before dereferencing

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/musb/tusb6010_omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index e13c770..1c86809 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -648,7 +648,7 @@ void dma_controller_destroy(struct dma_controller *c)
 		}
 	}
 
-	if (!tusb_dma->multichannel && tusb_dma && tusb_dma->ch >= 0)
+	if (tusb_dma && !tusb_dma->multichannel && tusb_dma->ch >= 0)
 		omap_free_dma(tusb_dma->ch);
 
 	kfree(tusb_dma);
-- 
1.6.6.rc0

