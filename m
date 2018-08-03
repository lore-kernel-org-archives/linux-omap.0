From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-dmic: Mark expected switch
	fall-throughs" to the asoc tree
Date: Fri,  3 Aug 2018 18:01:03 +0100 (BST)
Message-ID: <20180803170103.F41AD1123AA1@debutante.sirena.org.uk>
References: <e75dd38f324254c9c002b9a90b513aa8504dd639.1533312229.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <e75dd38f324254c9c002b9a90b513aa8504dd639.1533312229.git.gustavo@embeddedor.com>
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

   ASoC: omap-dmic: Mark expected switch fall-throughs

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

>From a773c3b6be185d171e2755ac715e8b1ea099ebbc Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Fri, 3 Aug 2018 11:31:48 -0500
Subject: [PATCH] ASoC: omap-dmic: Mark expected switch fall-throughs

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1468847 ("Missing break in switch")
Addresses-Coverity-ID: 1468849 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap-dmic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 51dd7c65096b..fe966272bd0c 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -213,8 +213,10 @@ static int omap_dmic_dai_hw_params(struct snd_pcm_substream *substream,
 	switch (channels) {
 	case 6:
 		dmic->ch_enabled |= OMAP_DMIC_UP3_ENABLE;
+		/* fall through */
 	case 4:
 		dmic->ch_enabled |= OMAP_DMIC_UP2_ENABLE;
+		/* fall through */
 	case 2:
 		dmic->ch_enabled |= OMAP_DMIC_UP1_ENABLE;
 		break;
-- 
2.18.0
