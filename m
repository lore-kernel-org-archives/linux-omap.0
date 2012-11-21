From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/2] OMAP: DSS: do not fail if dpll4_m4_ck is missing
Date: Wed, 21 Nov 2012 21:48:51 +0200
Message-ID: <1353527332-5216-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:55240 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818Ab2KUTtH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 14:49:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Do not fail if dpll4_m4_ck is missing. The clock is not there on omap24xx,
so this should not be a hard error.

The patch retains the functionality before the commit 185bae10 (OMAPDSS:
DSS: Cleanup cpu_is_xxxx checks).

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/video/omap2/dss/dss.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 2ab1c3e..55f2ea9 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -697,11 +697,15 @@ static int dss_get_clocks(void)
 
 	dss.dss_clk = clk;
 
-	clk = clk_get(NULL, dss.feat->clk_name);
-	if (IS_ERR(clk)) {
-		DSSERR("Failed to get %s\n", dss.feat->clk_name);
-		r = PTR_ERR(clk);
-		goto err;
+	if (dss.feat->clk_name) {
+		clk = clk_get(NULL, dss.feat->clk_name);
+		if (IS_ERR(clk)) {
+			DSSERR("Failed to get %s\n", dss.feat->clk_name);
+			r = PTR_ERR(clk);
+			goto err;
+		}
+	} else {
+		clk = NULL;
 	}
 
 	dss.dpll4_m4_ck = clk;
-- 
1.7.10.4

