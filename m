From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: Fix resource reclaim for osk5912
Date: Wed, 24 Nov 2010 15:23:20 +0800
Message-ID: <1290583400.20639.3.camel@mola>
References: <1290583248.20639.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290583248.20639.1.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Arun KS <arunks@mistralsolutions.com>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
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
