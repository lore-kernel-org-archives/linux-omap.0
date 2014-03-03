From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH RESEND] sound: omap: n810: fix init with DT boot
Date: Tue,  4 Mar 2014 00:45:18 +0200
Message-ID: <1393886718-1817-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:33637 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951AbaCCWoj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Mar 2014 17:44:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

Since 3.14-rc1 only DT boot has been supported on N810, so this
file fails to init. Make a minimal fix to retain functionality.
This file should be properly converted to DT in longer term.

There seems to be still other unresolved issues with N810 audio support,
but this patch is needed at minimum as otherwise the machine driver
probing would completely fail.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---

	Previous discussion:
	http://marc.info/?l=linux-omap&m=139387208426122&w=2

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
1.9.0

