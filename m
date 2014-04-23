From: Olivier Gayot <ogayot@baylibre.com>
Subject: [PATCH] usb: musb_dsps: fix the exit routine for debugfs
Date: Wed, 23 Apr 2014 17:39:43 +0200
Message-ID: <1398267583-19159-1-git-send-email-ogayot@baylibre.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:48483 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbaDWPkA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 11:40:00 -0400
Received: by mail-we0-f174.google.com with SMTP id t60so1025970wes.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Apr 2014 08:39:58 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Olivier Gayot <ogayot@baylibre.com>, Markus Pargmann <mpa@pengutronix.de>

The following commit introduced the debugfs :

40f099e32c2a06bad7d75683421e30fcc74924cd
Author: Markus Pargmann <mpa@pengutronix.de>
Date:   Fri Jan 17 10:22:35 2014 +0100

    usb: musb: dsps, debugfs files

Unfortunately, a forgotten call to a cleanup function prevents the
probing of musb in case of deferred probe.

Because musb_init_controller() often retries and creates a new debugfs
directory each time it is called, we need to remove that directory in case the
initialization fails. Otherwise, the debugfs_create_dir() fails at
subsequent calls because the directory already exists.

Fixed by calling debugfs_remove_recursive() in the exit function.

Signed-off-by: Olivier Gayot <ogayot@baylibre.com>
Cc: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/usb/musb/musb_dsps.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 3372ded..c3de0a5 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -471,6 +471,8 @@ static int dsps_musb_exit(struct musb *musb)
 
 	del_timer_sync(&glue->timer);
 
+	debugfs_remove_recursive(glue->dbgfs_root);
+
 	usb_phy_shutdown(musb->xceiv);
 	return 0;
 }
-- 
1.7.9.5

