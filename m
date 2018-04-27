From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap: n810: Correct the card level
	dapm_route" to the asoc tree
Date: Fri, 27 Apr 2018 11:59:49 +0100
Message-ID: <E1fC16T-000423-Nh@debutante>
References: <20180426115115.13744-4-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180426115115.13744-4-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, tony@atomide.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: omap: n810: Correct the card level dapm_route

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

>From 9395b0042c4675c7f6d67c6c8c2f96e8e02e2a41 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 27 Apr 2018 11:17:12 +0300
Subject: [PATCH] ASoC: omap: n810: Correct the card level dapm_route

Fix the capture DAPM route due to core changes regarding to mic bias.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/n810.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 71e5f31fa306..e44bb5baac41 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -231,8 +231,8 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Ext Spk", NULL, "LLOUT"},
 	{"Ext Spk", NULL, "RLOUT"},
 
-	{"DMic Rate 64", NULL, "Mic Bias"},
-	{"Mic Bias", NULL, "DMic"},
+	{"DMic Rate 64", NULL, "DMic"},
+	{"DMic", NULL, "Mic Bias"},
 };
 
 static const char *spk_function[] = {"Off", "On"};
-- 
2.17.0
