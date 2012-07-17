From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH v2 09/11] usb: musb: dsps: remove explicit NOP device creation
Date: Tue, 17 Jul 2012 14:43:25 +0530
Message-ID: <1342516407-16515-10-git-send-email-ajay.gupta@ti.com>
References: <1342516407-16515-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49830 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329Ab2GQJNj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jul 2012 05:13:39 -0400
In-Reply-To: <1342516407-16515-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

As NOP device node is now added in am33xx tree so remove the call
which creates the NOP platform_device.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_dsps.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 18a16dd..4c59809 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -425,8 +425,7 @@ static int dsps_musb_init(struct musb *musb)
 	/* mentor core register starts at offset of 0x400 from musb base */
 	musb->mregs += wrp->musb_core_offset;
 
-	/* Register NOP driver */
-	usb_nop_xceiv_register(musb->id);
+	/* Get the NOP PHY */
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv))
 		return -ENODEV;
-- 
1.7.0.4

