From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-hdmi-audio: Convert to use the
	sdma-pcm instead of omap-pcm" to the asoc tree
Date: Wed,  9 May 2018 10:47:13 +0100 (BST)
Message-ID: <20180509094713.6AD5144007A@finisterre.ee.mobilebroadband>
References: <20180425061837.14145-4-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180425061837.14145-4-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: omap-hdmi-audio: Convert to use the sdma-pcm instead of omap-pcm

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

>From b1a549c6be09243f20e597d8d3fa007ec412544a Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 7 May 2018 11:49:56 +0300
Subject: [PATCH] ASoC: omap-hdmi-audio: Convert to use the sdma-pcm instead of
 omap-pcm

Use the new platform driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/Kconfig           | 2 +-
 sound/soc/omap/omap-hdmi-audio.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 2576fc92bff7..829b5515b3c5 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -20,7 +20,7 @@ config SND_OMAP_SOC_MCPDM
 
 config SND_OMAP_SOC_HDMI_AUDIO
 	tristate "HDMI audio support for OMAP4+ based SoCs"
-	depends on SND_OMAP_SOC
+	depends on SND_SDMA_SOC
 	help
 	  For HDMI audio to work OMAPDSS HDMI support should be
 	  enabled.
diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
index 8eeac7cab1c1..8a99a8837dc9 100644
--- a/sound/soc/omap/omap-hdmi-audio.c
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -26,9 +26,10 @@
 #include <sound/dmaengine_pcm.h>
 #include <uapi/sound/asound.h>
 #include <sound/asoundef.h>
-#include <sound/omap-pcm.h>
 #include <sound/omap-hdmi-audio.h>
 
+#include "sdma-pcm.h"
+
 #define DRV_NAME "omap-hdmi-audio"
 
 struct hdmi_audio_data {
@@ -352,7 +353,7 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = omap_pcm_platform_register(ad->dssdev);
+	ret = sdma_pcm_platform_register(ad->dssdev, "audio_tx", NULL);
 	if (ret)
 		return ret;
 
-- 
2.17.0
