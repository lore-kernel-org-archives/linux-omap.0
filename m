From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 7/7] ASoC: omap: Mark the omap-pcm as
	deprecated, but keep it in the tree
Date: Wed, 25 Apr 2018 09:18:37 +0300
Message-ID: <20180425061837.14145-8-peter.ujfalusi@ti.com>
References: <20180425061837.14145-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180425061837.14145-1-peter.ujfalusi@ti.com>
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

All DAI drivers are now using the new sdma-pcm platform driver. Do not
build the omap-pcm, but keep the sources for one kernel cycle for easier
comparison of omap-pcm and sdma-pcm if there is an interest to do that.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Kconfig  | 3 +--
 sound/soc/omap/Makefile | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index f3059925d498..da81f730697c 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -1,7 +1,6 @@
 config SND_OMAP_SOC
-	tristate "SoC Audio for Texas Instruments OMAP chips"
+	tristate "SoC Audio for Texas Instruments OMAP chips (deprecated)"
 	depends on (ARCH_OMAP && DMA_OMAP) || (ARM && COMPILE_TEST)
-	select SND_DMAENGINE_PCM
 	select SND_SDMA_SOC
 
 config SND_SDMA_SOC
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 0619a5b3bd9f..53eba3413485 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -1,13 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # OMAP Platform Support
-snd-soc-omap-objs := omap-pcm.o
 snd-soc-sdma-objs := sdma-pcm.o
 snd-soc-omap-dmic-objs := omap-dmic.o
 snd-soc-omap-mcbsp-objs := omap-mcbsp.o mcbsp.o
 snd-soc-omap-mcpdm-objs := omap-mcpdm.o
 snd-soc-omap-hdmi-audio-objs := omap-hdmi-audio.o
 
-obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
 obj-$(CONFIG_SND_SDMA_SOC) += snd-soc-sdma.o
 obj-$(CONFIG_SND_OMAP_SOC_DMIC) += snd-soc-omap-dmic.o
 obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
