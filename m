From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap: fix compile-test building" to the asoc tree
Date: Fri, 25 May 2018 18:36:43 +0100
Message-ID: <E1fMGdv-00083T-H7@debutante>
References: <20180525160248.4135506-2-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525160248.4135506-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: omap: fix compile-test building

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

>From 500413c5097d981b1b6e639bf2183abc1db6c24a Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 25 May 2018 18:02:32 +0200
Subject: [PATCH] ASoC: omap: fix compile-test building

The newly introduced driver causes a harmless Kconfig warning when
compile-testing random configurations:

WARNING: unmet direct dependencies detected for SND_SDMA_SOC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && DMA_OMAP [=n]
  Selected by [y]:
  - SND_OMAP_SOC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (ARCH_OMAP [=y] && DMA_OMAP [=n] || ARM [=y] && COMPILE_TEST [=y])

By simply allow build testing without DMA_OMAP, we can shut up that warning.

Fixes: dde637f2daf1 ("ASoC: omap: Introduce the generic_dmaengine_pcm based sdma-pcm")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index f1d6799e08a9..6dccea6fdaeb 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -5,7 +5,7 @@ config SND_OMAP_SOC
 
 config SND_SDMA_SOC
 	tristate "SoC Audio for Texas Instruments chips using sDMA"
-	depends on DMA_OMAP
+	depends on DMA_OMAP || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_OMAP_SOC_DMIC
-- 
2.17.0
