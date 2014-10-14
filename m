From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 08/18] ASoC: codecs/hdmi: HDMI codec doesn't benefit from pmdown delay
Date: Tue, 14 Oct 2014 20:29:27 +0300
Message-ID: <aa7ad47271e780b75b608382a8830cdc22c4193a.1413306131.git.jsarha@ti.com>
References: <cover.1413306131.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36079 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbaJNR35 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2014 13:29:57 -0400
In-Reply-To: <cover.1413306131.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Adds .ignore_pmdown_time = true to codec driver struct.

HDMI codec is currently a dummy codec and doesn't benefit from pmdown
delay. Even if in the future the codec would controll HDMI encoder, it
would still be a digital to digital interface that should have no need
for pmdown delay.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/codecs/hdmi.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/hdmi.c b/sound/soc/codecs/hdmi.c
index 2a52b90..1391ad5 100644
--- a/sound/soc/codecs/hdmi.c
+++ b/sound/soc/codecs/hdmi.c
@@ -76,6 +76,7 @@ static struct snd_soc_codec_driver hdmi_codec = {
 	.num_dapm_widgets = ARRAY_SIZE(hdmi_widgets),
 	.dapm_routes = hdmi_routes,
 	.num_dapm_routes = ARRAY_SIZE(hdmi_routes),
+	.ignore_pmdown_time = true,
 };
 
 static int hdmi_codec_probe(struct platform_device *pdev)
-- 
1.7.9.5

