From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] sound: omap: n810: fix init with DT boot
Date: Sat,  1 Mar 2014 20:08:37 +0200
Message-ID: <1393697317-16733-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:35970 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbaCASIX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Mar 2014 13:08:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Since 3.14-rc1 only DT boot has been supported on N810. Make a minimal
fix to retain functionality. This file should be properly converted
to DT in longer term.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 sound/soc/omap/n810.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 3fde9e4..d163e18 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -305,7 +305,9 @@ static int __init n810_soc_init(void)
 	int err;
 	struct device *dev;
 
-	if (!(machine_is_nokia_n810() || machine_is_nokia_n810_wimax()))
+	if (!of_have_populated_dt() ||
+	    (!of_machine_is_compatible("nokia,n810") &&
+	     !of_machine_is_compatible("nokia,n810-wimax")))
 		return -ENODEV;
 
 	n810_snd_device = platform_device_alloc("soc-audio", -1);
-- 
1.8.3.3

