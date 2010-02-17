From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 2/4] OMAP: DSS2: fix driver probe error handling
Date: Wed, 17 Feb 2010 13:57:17 +0200
Message-ID: <1266407839-14713-2-git-send-email-tomi.valkeinen@nokia.com>
References: <1266407839-14713-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:44374 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228Ab0BQLy3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 06:54:29 -0500
In-Reply-To: <1266407839-14713-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

If driver's probe failed, the uninit was not called.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 967cbda..39b1a20 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -778,6 +778,7 @@ static int dss_driver_probe(struct device *dev)
 
 	if (r) {
 		DSSERR("driver probe failed: %d\n", r);
+		dss_uninit_device(core.pdev, dssdev);
 		return r;
 	}
 
-- 
1.6.5

