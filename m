From: Samreen <samreen@ti.com>
Subject: [PATCH v2] OMAP: DSS2: OMAPFB: Add null pointer check
Date: Tue, 16 Nov 2010 17:19:07 +0530
Message-ID: <1289908147-12468-1-git-send-email-samreen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46202 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933802Ab0KPLyQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 06:54:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Samreen <samreen@ti.com>

A null pointer check added. And using kstrdup()
instead of kmalloc() & strcpy()

Signed-off-by: Samreen <samreen@ti.com>
---
Version2:
   - Using kstrdup() instead of kmalloc() & strcpy()
   - Using ENOMEM as error code instead of EINVAL
   - Subject changed appropriately

The link to v1 of patch is:
https://patchwork.kernel.org/patch/319642/

 drivers/video/omap2/omapfb/omapfb-main.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 6a704f1..4fdab8e 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2132,8 +2132,9 @@ static int omapfb_parse_def_modes(struct omapfb2_device *fbdev)
 	char *str, *options, *this_opt;
 	int r = 0;
 
-	str = kmalloc(strlen(def_mode) + 1, GFP_KERNEL);
-	strcpy(str, def_mode);
+	str = kstrdup(def_mode, GFP_KERNEL);
+	if (!str)
+		return -ENOMEM;
 	options = str;
 
 	while (!r && (this_opt = strsep(&options, ",")) != NULL) {
-- 
1.5.6.3

