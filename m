From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] video/omap: suspected typo in assignment
Date: Sat, 23 Oct 2010 23:20:47 +0200
Message-ID: <20101023232047.32701ed7@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from webhosting01.bon.m2soft.com ([195.38.20.32]:47190 "EHLO
	webhosting01.bon.m2soft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751402Ab0JWVYf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 23 Oct 2010 17:24:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Imre Deak <imre.deak@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Untested, but looks like an obvious typo to me.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 drivers/video/omap/blizzard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/blizzard.c b/drivers/video/omap/blizzard.c
index 2ffb34a..87785c2 100644
--- a/drivers/video/omap/blizzard.c
+++ b/drivers/video/omap/blizzard.c
@@ -1590,7 +1590,7 @@ static int blizzard_init(struct omapfb_device *fbdev, int ext_mode,
 	blizzard.auto_update_window.width = fbdev->panel->x_res;
 	blizzard.auto_update_window.height = fbdev->panel->y_res;
 	blizzard.auto_update_window.out_x = 0;
-	blizzard.auto_update_window.out_x = 0;
+	blizzard.auto_update_window.out_y = 0;
 	blizzard.auto_update_window.out_width = fbdev->panel->x_res;
 	blizzard.auto_update_window.out_height = fbdev->panel->y_res;
 	blizzard.auto_update_window.format = 0;
-- 
1.7.2.2
