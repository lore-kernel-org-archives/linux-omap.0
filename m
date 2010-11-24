From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2 RESEND] ASoC: Fix resource reclaim for osk5912
Date: Wed, 24 Nov 2010 22:24:01 +0800
Message-ID: <1290608641.2235.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47122 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab0KXOYE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 09:24:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Charulatha <charu@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

In current implementation, there are resources leak in the error path.
This patch properly reclaims the allocated resources in the error path.

Also adds a missing clk_put in osk_soc_exit.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/omap/osk5912.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index 18d053d..7e75e77 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -177,7 +177,8 @@ static int __init osk_soc_init(void)
 	tlv320aic23_mclk = clk_get(dev, "mclk");
 	if (IS_ERR(tlv320aic23_mclk)) {
 		printk(KERN_ERR "Could not get mclk clock\n");
-		return -ENODEV;
+		err = PTR_ERR(tlv320aic23_mclk);
+		goto err2;
 	}
 
 	/*
@@ -188,7 +189,7 @@ static int __init osk_soc_init(void)
 		if (clk_set_rate(tlv320aic23_mclk, CODEC_CLOCK)) {
 			printk(KERN_ERR "Cannot set MCLK for AIC23 CODEC\n");
 			err = -ECANCELED;
-			goto err1;
+			goto err3;
 		}
 	}
 
@@ -196,9 +197,12 @@ static int __init osk_soc_init(void)
 	       (uint) clk_get_rate(tlv320aic23_mclk), CODEC_CLOCK);
 
 	return 0;
-err1:
+
+err3:
 	clk_put(tlv320aic23_mclk);
+err2:
 	platform_device_del(osk_snd_device);
+err1:
 	platform_device_put(osk_snd_device);
 
 	return err;
@@ -207,6 +211,7 @@ err1:
 
 static void __exit osk_soc_exit(void)
 {
+	clk_put(tlv320aic23_mclk);
 	platform_device_unregister(osk_snd_device);
 }
 
-- 
1.7.2




