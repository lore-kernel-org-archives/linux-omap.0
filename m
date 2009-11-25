From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume hang
Date: Wed, 25 Nov 2009 18:40:31 +0530
Message-ID: <1259154631-15251-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49210 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934620AbZKYNKh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 08:10:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, Anuj Aggarwal <anuj.aggarwal@ti.com>

System hang is observed While trying to do suspend. It was because
of an infinite loop in the AIC23 resume path which was trying to
restore AIC23 register values from the register cache.

This patch fixes the problem by correcting the resume path and
properly activating/deactivating the digital interface while
doing the suspend / off transitions.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 sound/soc/codecs/tlv320aic23.c |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 6b24d8b..cabe60c 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -565,13 +565,12 @@ static int tlv320aic23_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		/* everything off except vref/vmid, */
-		tlv320aic23_write(codec, TLV320AIC23_PWR, reg | 0x0040);
+		/* Activate the digital interface */
+		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x1);
 		break;
 	case SND_SOC_BIAS_OFF:
-		/* everything off, dac mute, inactive */
+		/* Deactivate the digital interface */
 		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0);
-		tlv320aic23_write(codec, TLV320AIC23_PWR, 0xffff);
 		break;
 	}
 	codec->bias_level = level;
@@ -615,7 +614,6 @@ static int tlv320aic23_suspend(struct platform_device *pdev,
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->card->codec;
 
-	tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0);
 	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
@@ -625,14 +623,6 @@ static int tlv320aic23_resume(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->card->codec;
-	int i;
-	u16 reg;
-
-	/* Sync reg_cache with the hardware */
-	for (reg = 0; reg < ARRAY_SIZE(tlv320aic23_reg); i++) {
-		u16 val = tlv320aic23_read_reg_cache(codec, reg);
-		tlv320aic23_write(codec, reg, val);
-	}
 
 	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	tlv320aic23_set_bias_level(codec, codec->suspend_bias_level);
-- 
1.6.2.4

