From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: omap: Check regulator enable for DAC on Pandora
Date: Sat,  2 Mar 2013 15:49:54 +0800
Message-ID: <1362210594-17633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57960 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751185Ab3CBHub (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Mar 2013 02:50:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

This will probably never fail but it's better style.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/omap3pandora.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index 805512f..953483e 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -85,7 +85,11 @@ static int omap3pandora_dac_event(struct snd_soc_dapm_widget *w,
 	 * VCC power on/off and /PD pin high/low
 	 */
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		regulator_enable(omap3pandora_dac_reg);
+		ret = regulator_enable(omap3pandora_dac_reg);
+		if (ret != 0) {
+			dev_err(w->dapm.dev, "Failed to power DAC: %d\n", ret);
+			return ret;
+		}
 		mdelay(1);
 		gpio_set_value(OMAP3_PANDORA_DAC_POWER_GPIO, 1);
 	} else {
-- 
1.7.10.4

