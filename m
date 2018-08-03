From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 5/7] ASoC: omap-mcpdm: Mark expected switch fall-throughs
Date: Fri, 3 Aug 2018 11:32:52 -0500
Message-ID: <720fbf880f4edfb57379278056f45fc639775ad3.1533312229.git.gustavo@embeddedor.com>
References: <cover.1533312229.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533312229.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-omap@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1369526 ("Missing break in switch")
Addresses-Coverity-ID: 1369529 ("Missing break in switch")
Addresses-Coverity-ID: 1451415 ("Missing break in switch")
Addresses-Coverity-ID: 115103 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/omap/omap-mcpdm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 0e97360..4c1be36 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -310,15 +310,19 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
 			/* up to 3 channels for capture */
 			return -EINVAL;
 		link_mask |= 1 << 4;
+		/* fall through */
 	case 4:
 		if (stream == SNDRV_PCM_STREAM_CAPTURE)
 			/* up to 3 channels for capture */
 			return -EINVAL;
 		link_mask |= 1 << 3;
+		/* fall through */
 	case 3:
 		link_mask |= 1 << 2;
+		/* fall through */
 	case 2:
 		link_mask |= 1 << 1;
+		/* fall through */
 	case 1:
 		link_mask |= 1 << 0;
 		break;
-- 
2.7.4
