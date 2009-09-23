From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH] ASoC: OMAP3EVM: Use the twl4030_setup_data for headset pop-removal
Date: Wed, 23 Sep 2009 12:40:31 +0530
Message-ID: <1253689831-2996-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49871 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156AbZIWHKd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Sep 2009 03:10:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>

The pop-removal specific values are configured for TWL4030 codec
for OMAP3EVM through this patch.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 sound/soc/omap/omap3evm.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap3evm.c b/sound/soc/omap/omap3evm.c
index 9114c26..8deb59b 100644
--- a/sound/soc/omap/omap3evm.c
+++ b/sound/soc/omap/omap3evm.c
@@ -93,10 +93,17 @@ static struct snd_soc_card snd_soc_omap3evm = {
 	.num_links = 1,
 };
 
+/* twl4030 setup */
+static struct twl4030_setup_data twl4030_setup = {
+	.ramp_delay_value = 4,
+	.sysclk = 26000,
+};
+
 /* Audio subsystem */
 static struct snd_soc_device omap3evm_snd_devdata = {
 	.card = &snd_soc_omap3evm,
 	.codec_dev = &soc_codec_dev_twl4030,
+	.codec_data = &twl4030_setup,
 };
 
 static struct platform_device *omap3evm_snd_device;
-- 
1.6.2.4

