From: Samreen <samreen@ti.com>
Subject: [PATCH] OMAP: DSS2: OMAPFB: Fix null pointer check
Date: Fri, 12 Nov 2010 17:17:15 +0530
Message-ID: <1289562435-8056-1-git-send-email-samreen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47793 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756705Ab0KLLw1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Nov 2010 06:52:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Samreen <samreen@ti.com>

A null pointer check added.

Signed-off-by: Samreen <samreen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 6a704f1..55bed89 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2133,6 +2133,8 @@ static int omapfb_parse_def_modes(struct omapfb2_device *fbdev)
 	int r = 0;
 
 	str = kmalloc(strlen(def_mode) + 1, GFP_KERNEL);
+	if (str == NULL)
+		return -EINVAL;
 	strcpy(str, def_mode);
 	options = str;
 
-- 
1.5.6.3

