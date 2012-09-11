From: Ravi Babu <ravibabu@ti.com>
Subject: [PATCH v10 5/5] usb: musb: dsps: remove explicit NOP device creation
Date: Tue, 11 Sep 2012 21:43:19 +0530
Message-ID: <1347379999-26061-6-git-send-email-ravibabu@ti.com>
References: <1347379999-26061-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56337 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109Ab2IKQNb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 12:13:31 -0400
In-Reply-To: <1347379999-26061-1-git-send-email-ravibabu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

As NOP device node is now added in am33xx tree so remove the call
which creates the NOP platform_device.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/musb_dsps.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index b8aecbb..2785e28 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -376,8 +376,7 @@ static int dsps_musb_init(struct musb *musb)
 	/* mentor core register starts at offset of 0x400 from musb base */
 	musb->mregs += wrp->musb_core_offset;
 
-	/* NOP driver needs change if supporting dual instance */
-	usb_nop_xceiv_register();
+	/* Get the NOP PHY */
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv))
 		return -ENODEV;
-- 
1.7.0.4

