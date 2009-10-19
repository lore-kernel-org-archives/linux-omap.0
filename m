From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/4] ASoC: TWL4030: Only update the needed bits
	in *set_dai_sysclk
Date: Mon, 19 Oct 2009 15:42:19 +0300
Message-ID: <1255956140-4829-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1255956140-4829-1-git-send-email-peter.ujfalusi@nokia.com>
	<1255956140-4829-2-git-send-email-peter.ujfalusi@nokia.com>
	<1255956140-4829-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1255956140-4829-3-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, broonie@opensource.wolfsonmicro.com, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

Do not rewrite the whole register, but only update the needed
bits in set_dai_sysclk functions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 4df7c6c..559e9b2 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1785,19 +1785,21 @@ static int twl4030_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct twl4030_priv *twl4030 = codec->private_data;
-	u8 infreq;
+	u8 apll_ctrl;
 
+	apll_ctrl = twl4030_read_reg_cache(codec, TWL4030_REG_APLL_CTL);
+	apll_ctrl &= ~TWL4030_APLL_INFREQ;
 	switch (freq) {
 	case 19200000:
-		infreq = TWL4030_APLL_INFREQ_19200KHZ;
+		apll_ctrl |= TWL4030_APLL_INFREQ_19200KHZ;
 		twl4030->sysclk = 19200;
 		break;
 	case 26000000:
-		infreq = TWL4030_APLL_INFREQ_26000KHZ;
+		apll_ctrl |= TWL4030_APLL_INFREQ_26000KHZ;
 		twl4030->sysclk = 26000;
 		break;
 	case 38400000:
-		infreq = TWL4030_APLL_INFREQ_38400KHZ;
+		apll_ctrl |= TWL4030_APLL_INFREQ_38400KHZ;
 		twl4030->sysclk = 38400;
 		break;
 	default:
@@ -1806,8 +1808,7 @@ static int twl4030_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	infreq |= TWL4030_APLL_EN;
-	twl4030_write(codec, TWL4030_REG_APLL_CTL, infreq);
+	twl4030_write(codec, TWL4030_REG_APLL_CTL, apll_ctrl);
 
 	return 0;
 }
@@ -1989,11 +1990,13 @@ static int twl4030_voice_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u8 infreq;
+	u8 apll_ctrl;
 
+	apll_ctrl = twl4030_read_reg_cache(codec, TWL4030_REG_APLL_CTL);
+	apll_ctrl &= ~TWL4030_APLL_INFREQ;
 	switch (freq) {
 	case 26000000:
-		infreq = TWL4030_APLL_INFREQ_26000KHZ;
+		apll_ctrl |= TWL4030_APLL_INFREQ_26000KHZ;
 		break;
 	default:
 		printk(KERN_ERR "TWL4030 voice set sysclk: unknown rate %d\n",
@@ -2001,8 +2004,7 @@ static int twl4030_voice_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	infreq |= TWL4030_APLL_EN;
-	twl4030_write(codec, TWL4030_REG_APLL_CTL, infreq);
+	twl4030_write(codec, TWL4030_REG_APLL_CTL, apll_ctrl);
 
 	return 0;
 }
-- 
1.6.5.1
