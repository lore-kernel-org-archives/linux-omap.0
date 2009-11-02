From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 4/5] ASoC: TWL4030: Make sure,
	that the codec is powered on startup
Date: Mon,  2 Nov 2009 14:34:54 +0200
Message-ID: <1257165295-9352-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1257165295-9352-1-git-send-email-peter.ujfalusi@nokia.com>
	<1257165295-9352-2-git-send-email-peter.ujfalusi@nokia.com>
	<1257165295-9352-3-git-send-email-peter.ujfalusi@nokia.com>
	<1257165295-9352-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1257165295-9352-4-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, sameo@linux.intel.com
Cc: tony@atomide.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Set the codec->bias_level to SND_SOC_BIAS_OFF before changing
the initial bias level to STANDBY.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index f9121ef..c0b47df 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2234,6 +2234,7 @@ static int __devinit twl4030_codec_probe(struct platform_device *pdev)
 
 	/* Set the defaults, and power up the codec */
 	twl4030_init_chip(codec);
+	codec->bias_level = SND_SOC_BIAS_OFF;
 	twl4030_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	ret = snd_soc_register_codec(codec);
-- 
1.6.5.2
