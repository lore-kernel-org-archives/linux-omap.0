From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 2/3] usb: musb: dsps: remove nop unregister
Date: Thu, 27 Sep 2012 11:13:11 +0530
Message-ID: <bbd405fb09b23f3e83bb1bbb3bfe406a2c8a8b7a.1348722157.git.afzal@ti.com>
References: <a1dd07e020850703ed5294db176ea1298d69a4ed.1348722156.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37508 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755208Ab2I0FnQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 01:43:16 -0400
In-Reply-To: <a1dd07e020850703ed5294db176ea1298d69a4ed.1348722156.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Ravi Babu <ravibabu@ti.com>, Afzal Mohammed <afzal@ti.com>

"usb: musb: dsps: remove explicit NOP device creation"
removed nop register, but not unregistering, remove nop
unregister in error and exit path.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/usb/musb/musb_dsps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 444346e..9d7ca4c 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -411,7 +411,6 @@ static int dsps_musb_init(struct musb *musb)
 	return 0;
 err0:
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
 	return status;
 }
 
@@ -431,7 +430,6 @@ static int dsps_musb_exit(struct musb *musb)
 
 	/* NOP driver needs change if supporting dual instance */
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
 
 	return 0;
 }
-- 
1.7.12

