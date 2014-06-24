From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/15] OMAPDSS: DISPC: fix debugfs reg dump
Date: Tue, 24 Jun 2014 13:03:46 +0300
Message-ID: <1403604240-16738-2-git-send-email-tomi.valkeinen@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57825 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbaFXKEK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 06:04:10 -0400
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

DISPC reg dump prints a few registers twice. Remove the extra prints.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 7aa33b0f4a1f..d1f0dbb486b8 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -3257,13 +3257,10 @@ static void dispc_dump_regs(struct seq_file *s)
 		if (i == OMAP_DSS_CHANNEL_DIGIT)
 			continue;
 
-		DUMPREG(i, DISPC_DEFAULT_COLOR);
-		DUMPREG(i, DISPC_TRANS_COLOR);
 		DUMPREG(i, DISPC_TIMING_H);
 		DUMPREG(i, DISPC_TIMING_V);
 		DUMPREG(i, DISPC_POL_FREQ);
 		DUMPREG(i, DISPC_DIVISORo);
-		DUMPREG(i, DISPC_SIZE_MGR);
 
 		DUMPREG(i, DISPC_DATA_CYCLE1);
 		DUMPREG(i, DISPC_DATA_CYCLE2);
-- 
1.9.1

