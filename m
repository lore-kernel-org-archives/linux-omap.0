From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-pcm: Initialize DMA configuration"
	to the asoc tree
Date: Tue, 26 Apr 2016 19:24:53 +0100
Message-ID: <E1av7fJ-0007w8-AQ@debutante>
References: <1461600607-19582-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1461600607-19582-1-git-send-email-Linux.HWI@garmin.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jim Lodes <jim.lodes@garmin.com>
Cc: "J.D. Schroeder" <jay.schroeder@garmin.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, peter.ujfalusi@ti.com, broonie@kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: omap-pcm: Initialize DMA configuration

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 989ff7754a27a1fcc0c3b2794c985b31811871a0 Mon Sep 17 00:00:00 2001
From: Jim Lodes <jim.lodes@garmin.com>
Date: Mon, 25 Apr 2016 11:10:07 -0500
Subject: [PATCH] ASoC: omap-pcm: Initialize DMA configuration

Initialize the dma_slave_config for PCM DMA transfers,
instead of leaving it uninitialized. Keeps previous data on
the stack from giving us invalid values in uninitialized
members of the config structure.

Signed-off-by: Jim Lodes <jim.lodes@garmin.com>
Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 6bb623a2a4df..eb81b9a2293a 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -82,6 +82,8 @@ static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct dma_chan *chan;
 	int err = 0;
 
+	memset(&config, 0x00, sizeof(config));
+
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	/* return if this is a bufferless transfer e.g.
-- 
2.8.0.rc3
