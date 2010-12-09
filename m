From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 5/8] arm: omap: sdram-nokia: improve error handling
Date: Thu,  9 Dec 2010 18:39:21 +0200
Message-ID: <1291912764-12823-6-git-send-email-aaro.koskinen@nokia.com>
References: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:32426 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435Ab0LIQin (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 11:38:43 -0500
In-Reply-To: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Actually check for errors: print an error log and return NULL.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/sdram-nokia.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
index 1171451..863586b 100644
--- a/arch/arm/mach-omap2/sdram-nokia.c
+++ b/arch/arm/mach-omap2/sdram-nokia.c
@@ -223,10 +223,14 @@ struct omap_sdrc_params *nokia_get_sdram_timings(void)
 	int err = 0;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(nokia_timings); i++)
+	for (i = 0; i < ARRAY_SIZE(nokia_timings); i++) {
 		err |= sdrc_timings(i, nokia_timings[i].rate,
 				       nokia_timings[i].data);
+		if (err)
+			pr_err("%s: error with rate %ld: %d\n", __func__,
+			       nokia_timings[i].rate, err);
+	}
 
-	return &nokia_sdrc_params[0];
+	return err ? NULL : nokia_sdrc_params;
 }
 
-- 
1.5.6.5

