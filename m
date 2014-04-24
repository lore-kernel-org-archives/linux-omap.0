From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/23] OMAPDSS: DSS & DISPC DT support for OMAP5
Date: Thu, 24 Apr 2014 13:17:09 +0300
Message-ID: <1398334639-14172-14-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58183 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908AbaDXKUY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 06:20:24 -0400
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add omap5 entries to dispc's and dss's of_device_id tables.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 1 +
 drivers/video/fbdev/omap2/dss/dss.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index f18397c33e8f..82a6ee9930a0 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -3829,6 +3829,7 @@ static const struct of_device_id dispc_of_match[] = {
 	{ .compatible = "ti,omap2-dispc", },
 	{ .compatible = "ti,omap3-dispc", },
 	{ .compatible = "ti,omap4-dispc", },
+	{ .compatible = "ti,omap5-dispc", },
 	{},
 };
 
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index d55266c0e029..ae870a569ddf 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -946,6 +946,7 @@ static const struct of_device_id dss_of_match[] = {
 	{ .compatible = "ti,omap2-dss", },
 	{ .compatible = "ti,omap3-dss", },
 	{ .compatible = "ti,omap4-dss", },
+	{ .compatible = "ti,omap5-dss", },
 	{},
 };
 
-- 
1.9.1

