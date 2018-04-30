From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/7] ASoC: omap-hdmi-audio: Convert to use
	the sdma-pcm instead of omap-pcm
Date: Mon, 30 Apr 2018 09:57:44 +0300
Message-ID: <20180430065748.3393-4-peter.ujfalusi@ti.com>
References: <20180430065748.3393-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180430065748.3393-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

Use the new platform driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/Kconfig           | 2 +-
 sound/soc/omap/omap-hdmi-audio.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 22e216345a94..359064cec550 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -32,7 +32,7 @@ config SND_OMAP_SOC_MCPDM
 
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
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
