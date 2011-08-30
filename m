From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] ASoC: tpa6130a2: Model support cleanup
Date: Tue, 30 Aug 2011 14:39:52 +0300
Message-ID: <1314704394-31298-2-git-send-email-peter.ujfalusi@ti.com>
References: <1314704394-31298-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54128 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752877Ab1H3Lj7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Aug 2011 07:39:59 -0400
In-Reply-To: <1314704394-31298-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

Use the device name and driver_data to identify
the TPA model supported by the driver.
Board files should use either "tpa6130a2" or
"tpa6140a2" as device name to specify the model
in used on the specific board.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tpa6130a2.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 239e0c4..0c0fcb3 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -383,7 +383,7 @@ static int __devinit tpa6130a2_probe(struct i2c_client *client,
 
 	pdata = client->dev.platform_data;
 	data->power_gpio = pdata->power_gpio;
-	data->id = pdata->id;
+	data->id = id->driver_data;
 
 	mutex_init(&data->mutex);
 
@@ -405,7 +405,7 @@ static int __devinit tpa6130a2_probe(struct i2c_client *client,
 	switch (data->id) {
 	default:
 		dev_warn(dev, "Unknown TPA model (%d). Assuming 6130A2\n",
-			 pdata->id);
+			 data->id);
 	case TPA6130A2:
 		regulator = "Vdd";
 		break;
@@ -470,7 +470,8 @@ static int __devexit tpa6130a2_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tpa6130a2_id[] = {
-	{ "tpa6130a2", 0 },
+	{ "tpa6130a2", TPA6130A2 },
+	{ "tpa6140a2", TPA6140A2 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tpa6130a2_id);
-- 
1.7.6.1

