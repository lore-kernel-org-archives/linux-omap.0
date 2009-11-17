From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/8] musb: Get power (mA) from board data
Date: Tue, 17 Nov 2009 20:39:50 +0530
Message-ID: <1258470596-24321-3-git-send-email-ajay.gupta@ti.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>
 <1258470596-24321-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52436 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617AbZKQPKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 10:10:40 -0500
In-Reply-To: <1258470596-24321-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, felipe.balbi@nokia.com, david-b@pacbell.net, cooloney@kernel.org, gadiyar@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Different board may have different power sourcing capability and
now with 'struct musb_hdrc_board_data' in place; pass this data
from board files and also modify musb_core.c to get 'power' data
from 'plat->board_data'.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

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

