From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 1/2] Revert "usb: musb: dsps: remove explicit NOP device creation"
Date: Wed, 31 Oct 2012 19:54:29 +0530
Message-ID: <68a570d0e34796c3e82cb46979d3c926eb15c62e.1351691448.git.afzal@ti.com>
References: <cover.1351691448.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59867 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422911Ab2JaOYc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 10:24:32 -0400
In-Reply-To: <cover.1351691448.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Afzal Mohammed <afzal@ti.com>

This reverts commit d8c3ef256f88b7c6ecd673d03073b5645be9c5e4.

Above mentioned change was made along with multi usb phy change and
adding DT support for nop transceiver. But other two changes did not
make it to mainline. This in effect makes dsps musb wrapper unusable
even for single instance.

Hence revert it so that at least single instance can be supported.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/usb/musb/musb_dsps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 828d2a2..63128a3 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -377,7 +377,8 @@ static int dsps_musb_init(struct musb *musb)
 	/* mentor core register starts at offset of 0x400 from musb base */
 	musb->mregs += wrp->musb_core_offset;
 
-	/* Get the NOP PHY */
+	/* NOP driver needs change if supporting dual instance */
+	usb_nop_xceiv_register();
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv))
 		return -ENODEV;
-- 
1.7.12

