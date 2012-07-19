From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH v4 09/11] usb: musb: dsps: remove explicit NOP device creation
Date: Thu, 19 Jul 2012 17:16:05 +0530
Message-ID: <1342698367-12978-10-git-send-email-ajay.gupta@ti.com>
References: <1342698367-12978-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51151 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011Ab2GSLqU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 07:46:20 -0400
In-Reply-To: <1342698367-12978-1-git-send-email-ajay.gupta@ti.com>
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
index ac9f58b..78c88fd 100644
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

