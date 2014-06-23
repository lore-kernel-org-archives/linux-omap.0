From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] sound/soc/omap/mcbsp.c: remove unnecessary null test before kfree
Date: Mon, 23 Jun 2014 18:33:41 +0200
Message-ID: <1403541221-10619-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Fix checkpatch warning:
WARNING: kfree(NULL) is safe this check is probably not required

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 sound/soc/omap/mcbsp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 86c7538..68a1252 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -621,8 +621,7 @@ void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
 	mcbsp->reg_cache = NULL;
 	spin_unlock(&mcbsp->lock);
 
-	if (reg_cache)
-		kfree(reg_cache);
+	kfree(reg_cache);
 }
 
 /*
-- 
1.8.4.5
