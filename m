From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCHv2 2/7] ASoC: Add PDM DAI format definition
Date: Fri, 25 Sep 2009 21:02:49 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90A391E0@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33563 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbZIZCCx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Sep 2009 22:02:53 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

Add DAI format definition for PDM interfaces.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 include/sound/soc-dai.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 352d7ee..9239cb0 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -30,6 +30,7 @@ struct snd_pcm_substream;
 #define SND_SOC_DAIFMT_DSP_A		3 /* L data msb after FRM LRC */
 #define SND_SOC_DAIFMT_DSP_B		4 /* L data msb during FRM LRC */
 #define SND_SOC_DAIFMT_AC97		5 /* AC97 */
+#define SND_SOC_DAIFMT_PDM		6 /* Pulse density modulation */
 
 /* left and right justified also known as MSB and LSB respectively */
 #define SND_SOC_DAIFMT_MSB		SND_SOC_DAIFMT_LEFT_J
-- 
1.5.4.3
