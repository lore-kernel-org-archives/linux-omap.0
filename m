From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/3] musb: use neednop flag for nop registration
Date: Thu, 27 May 2010 12:34:48 +0530
Message-ID: <1274943888-17615-3-git-send-email-ajay.gupta@ti.com>
References: <1274943888-17615-1-git-send-email-ajay.gupta@ti.com>
 <1274943888-17615-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38286 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136Ab0E0HFD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 May 2010 03:05:03 -0400
In-Reply-To: <1274943888-17615-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, amit.kucheria@verdurent.com, khilman@deeprootsystems.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Some of the boards based on OMAP3 (like OMAP3EVM) and all the
board on OMAP4 uses nop transceiver so register and unregister
it based on '.neednop' flag passed from board files.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/omap2430.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 50591e7..2ec1bc4 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -198,6 +198,9 @@ int __init musb_platform_init(struct musb *musb)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
 #endif
 
+	if (data->neednop)
+		usb_nop_xceiv_register();
+
 	/* We require some kind of external transceiver, hooked
 	 * up through ULPI.  TWL4030-family PMICs include one,
 	 * which needs a driver, drivers aren't always needed.
@@ -323,8 +326,12 @@ static int musb_platform_resume(struct musb *musb)
 
 int musb_platform_exit(struct musb *musb)
 {
+	struct omap_musb_board_data *data = musb->board_data;
 
 	musb_platform_suspend(musb);
 
+	if (data->neednop)
+		usb_nop_xceiv_unregister();
+
 	return 0;
 }
-- 
1.6.2.4

