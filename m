From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6] ASoC: tlv320aic31xx: Fix unused variable warning from aic31xx_clk_off
Date: Thu, 13 Mar 2014 17:37:52 +0200
Message-ID: <1394725072-10584-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50215 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822AbaCMPiD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Mar 2014 11:38:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@kernel.org, Jyri Sarha <jsarha@ti.com>

Fix "warning: unused variable 'aic31xx'" from function 'aic31xx_clk_off'.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index e626b56..c9f6989 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -945,7 +945,6 @@ static void aic31xx_clk_on(struct snd_soc_codec *codec)
 
 static void aic31xx_clk_off(struct snd_soc_codec *codec)
 {
-	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
 	u8 mask = AIC31XX_PM_MASK;
 	u8 off = 0;
 
-- 
1.7.9.5

