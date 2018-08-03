From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-mcpdm: Mark expected switch
	fall-throughs" to the asoc tree
Date: Fri,  3 Aug 2018 18:01:31 +0100 (BST)
Message-ID: <20180803170131.EC7431123AA1@debutante.sirena.org.uk>
References: <720fbf880f4edfb57379278056f45fc639775ad3.1533312229.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <720fbf880f4edfb57379278056f45fc639775ad3.1533312229.git.gustavo@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: omap-mcpdm: Mark expected switch fall-throughs

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 85c81941d5033fc8a68646823d3157840c9de8b3 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Fri, 3 Aug 2018 11:32:52 -0500
Subject: [PATCH] ASoC: omap-mcpdm: Mark expected switch fall-throughs

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1369526 ("Missing break in switch")
Addresses-Coverity-ID: 1369529 ("Missing break in switch")
Addresses-Coverity-ID: 1451415 ("Missing break in switch")
Addresses-Coverity-ID: 115103 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap-mcpdm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 0e97360f9890..4c1be36c2207 100644
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
2.18.0
