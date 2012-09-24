From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 7/9] OMAPDSS: DSI: Add new linebuffer size for OMAP5
Date: Mon, 24 Sep 2012 16:58:37 +0300
Message-ID: <1348495119-8262-8-git-send-email-tomi.valkeinen@ti.com>
References: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:47511 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755606Ab2IXN7F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 09:59:05 -0400
Received: by lbbgj3 with SMTP id gj3so6750328lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 06:58:57 -0700 (PDT)
In-Reply-To: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP5's DSI has a larger line buffer than earlier OMAPs. This patch adds
support for this to the DSI driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a16c8b2..0dc24f2 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2155,6 +2155,8 @@ static unsigned dsi_get_line_buf_size(struct platform_device *dsidev)
 		return 1194 * 3;	/* 1194x24 bits */
 	case 6:
 		return 1365 * 3;	/* 1365x24 bits */
+	case 7:
+		return 1920 * 3;	/* 1920x24 bits */
 	default:
 		BUG();
 		return 0;
-- 
1.7.9.5

