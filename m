From: Archit Taneja <archit@ti.com>
Subject: [PATCH 09/11] omapdss: OMAP4: HDMI: remove unnecessary edid macros
Date: Tue, 17 Sep 2013 12:36:35 +0530
Message-ID: <1379401597-27222-10-git-send-email-archit@ti.com>
References: <1379401597-27222-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33463 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260Ab3IQHH5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Sep 2013 03:07:57 -0400
In-Reply-To: <1379401597-27222-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The hdmi4 driver has edid macros that aren't used at all. Remove them.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/hdmi4.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi4.c b/drivers/video/omap2/dss/hdmi4.c
index 324ecd0..ab43069 100644
--- a/drivers/video/omap2/dss/hdmi4.c
+++ b/drivers/video/omap2/dss/hdmi4.c
@@ -38,14 +38,6 @@
 #include "dss.h"
 #include "dss_features.h"
 
-/* HDMI EDID Length move this */
-#define HDMI_EDID_MAX_LENGTH			256
-#define EDID_TIMING_DESCRIPTOR_SIZE		0x12
-#define EDID_DESCRIPTOR_BLOCK0_ADDRESS		0x36
-#define EDID_DESCRIPTOR_BLOCK1_ADDRESS		0x80
-#define EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR	4
-#define EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR	4
-
 static struct {
 	struct mutex lock;
 	struct platform_device *pdev;
-- 
1.8.1.2

