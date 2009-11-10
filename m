From: "Romero, Felipe" <felipe.romero@ti.com>
Subject: [PATCH] Disable headset jack detection for SDP3430
Date: Tue, 10 Nov 2009 11:54:02 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A6A21602@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50628 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbZKJRxv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 12:53:51 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAAHruI3007178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 11:53:56 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAAHruHN025352
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 11:53:56 -0600 (CST)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAAHruV2029621
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 11:53:56 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Felipe Romero <felipe.romero@ti.com>

This patch Disable headset jack detection for SDP3430 boards,
to avoid CPU kernel utilization.
---
 sound/soc/omap/sdp3430.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index b719e5d..3ef489e 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -196,8 +196,8 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
 	/* SDP3430 connected pins */
 	snd_soc_dapm_enable_pin(codec, "Ext Mic");
 	snd_soc_dapm_enable_pin(codec, "Ext Spk");
-	snd_soc_dapm_disable_pin(codec, "Headset Mic");
-	snd_soc_dapm_disable_pin(codec, "Headset Stereophone");
+	snd_soc_dapm_enable_pin(codec, "Headset Mic");
+	snd_soc_dapm_enable_pin(codec, "Headset Stereophone");
 
 	/* TWL4030 not connected pins */
 	snd_soc_dapm_nc_pin(codec, "AUXL");
@@ -217,7 +217,7 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
 	ret = snd_soc_dapm_sync(codec);
 	if (ret)
 		return ret;
-
+#if 0
 	/* Headset jack detection */
 	ret = snd_soc_jack_new(&snd_soc_sdp3430, "Headset Jack",
 				SND_JACK_HEADSET, &hs_jack);
@@ -231,7 +231,7 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
 
 	ret = snd_soc_jack_add_gpios(&hs_jack, ARRAY_SIZE(hs_jack_gpios),
 				hs_jack_gpios);
-
+#endif
 	return ret;
 }
 
@@ -328,9 +328,10 @@ module_init(sdp3430_soc_init);
 
 static void __exit sdp3430_soc_exit(void)
 {
+#if 0
 	snd_soc_jack_free_gpios(&hs_jack, ARRAY_SIZE(hs_jack_gpios),
 				hs_jack_gpios);
-
+#endif
 	platform_device_unregister(sdp3430_snd_device);
 }
 module_exit(sdp3430_soc_exit);
-- 
1.6.0.4

