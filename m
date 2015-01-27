From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/14] OMAPDSS: constify port arrays
Date: Tue, 27 Jan 2015 12:50:31 +0200
Message-ID: <1422355842-11234-4-git-send-email-tomi.valkeinen@ti.com>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60759 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755410AbbA0Ku7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2015 05:50:59 -0500
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The port arrays are constant data, so set them as 'const'.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 9987154d50b4..1884c29ef482 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -70,7 +70,7 @@ struct dss_features {
 	u8 fck_div_max;
 	u8 dss_fck_multiplier;
 	const char *parent_clk_name;
-	enum omap_display_type *ports;
+	const enum omap_display_type *ports;
 	int num_ports;
 	int (*dpi_select_source)(int port, enum omap_channel channel);
 };
@@ -677,11 +677,11 @@ void dss_debug_dump_clocks(struct seq_file *s)
 #endif
 
 
-static enum omap_display_type omap2plus_ports[] = {
+static const enum omap_display_type omap2plus_ports[] = {
 	OMAP_DISPLAY_TYPE_DPI,
 };
 
-static enum omap_display_type omap34xx_ports[] = {
+static const enum omap_display_type omap34xx_ports[] = {
 	OMAP_DISPLAY_TYPE_DPI,
 	OMAP_DISPLAY_TYPE_SDI,
 };
-- 
2.2.2

