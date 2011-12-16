From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 1/4] ASoC: OMAP: HDMI: Introduce driver data for audio codec
Date: Fri, 16 Dec 2011 01:03:10 -0600
Message-ID: <1324018993-31466-2-git-send-email-ricardo.neri@ti.com>
References: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44901 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755997Ab1LPHDo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 02:03:44 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBG73iuY005384
	for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 01:03:44 -0600
In-Reply-To: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: linux-omap@vger.kernel.org, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, Ricardo Neri <ricardo.neri@ti.com>

Under the new DSS architecture for HDMI, there is a clear separation
between general DSS code and HDMI IP-specific data. Functions
that require access to the HDMI driver IP-specific data receive an
hdmi_ip_data structure. The ASoC codec require access to such
IP-specific data. Then, instead of accessing it directly, it will be
passed as codec driver data. This also helps to have a clear separation
between DSS and ASoC portions of the code.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index c56378c..bd56a8a 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -698,7 +698,16 @@ static int hdmi_audio_startup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int hdmi_audio_codec_probe(struct snd_soc_codec *codec)
+{
+	struct hdmi_ip_data *priv = &hdmi.ip_data;
+
+	snd_soc_codec_set_drvdata(codec, priv);
+	return 0;
+}
+
 static struct snd_soc_codec_driver hdmi_audio_codec_drv = {
+	.probe = hdmi_audio_codec_probe,
 };
 
 static struct snd_soc_dai_ops hdmi_audio_codec_ops = {
-- 
1.7.0.4

