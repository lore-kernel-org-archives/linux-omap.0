From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/7] musb: Get power (mA) from board data
Date: Sun, 15 Nov 2009 14:29:33 +0530
Message-ID: <1258275578-1773-3-git-send-email-ajay.gupta@ti.com>
References: <1258275578-1773-1-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53846 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371AbZKOI7q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 Nov 2009 03:59:46 -0500
In-Reply-To: <1258275578-1773-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: felipe.balbi@nokia.com, khilman@deeprootsystems.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Different board may have different power sourcing capability and
now with 'struct musb_hdrc_board_data' in place; pass this data
from board files and also modify musb_core.c to get 'power' data
from 'plat->board_data'.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |    6 ------
 drivers/usb/musb/musb_core.c   |    4 +++-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index a80441d..e89c6b1 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -124,12 +124,6 @@ static struct musb_hdrc_platform_data musb_plat = {
 	/* .clock is set dynamically */
 	.set_clock	= musb_set_clock,
 	.config		= &musb_config,
-
-	/* REVISIT charge pump on TWL4030 can supply up to
-	 * 100 mA ... but this value is board-specific, like
-	 * "mode", and should be passed to usb_musb_init().
-	 */
-	.power		= 50,			/* up to 100 mA */
 };
 
 static u64 musb_dmamask = DMA_BIT_MASK(32);
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 3a61ddb..818ccda 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2033,7 +2033,9 @@ bad_config:
 		if (is_otg_enabled(musb))
 			hcd->self.otg_port = 1;
 		musb->xceiv->host = &hcd->self;
-		hcd->power_budget = 2 * (plat->power ? : 250);
+		if (plat->board_data)
+			hcd->power_budget =
+				2 * (plat->board_data->power ? : 250);
 	}
 
 	/* For the host-only role, we can activate right away.
-- 
1.6.2.4

