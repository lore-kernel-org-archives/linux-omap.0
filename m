From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] ASoC: omap: fix compile-test building
Date: Fri, 25 May 2018 18:02:32 +0200
Message-ID: <20180525160248.4135506-2-arnd@arndb.de>
References: <20180525160248.4135506-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180525160248.4135506-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

The newly introduced driver causes a harmless Kconfig warning when
compile-testing random configurations:

WARNING: unmet direct dependencies detected for SND_SDMA_SOC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && DMA_OMAP [=n]
  Selected by [y]:
  - SND_OMAP_SOC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (ARCH_OMAP [=y] && DMA_OMAP [=n] || ARM [=y] && COMPILE_TEST [=y])

By simply allow build testing without DMA_OMAP, we can shut up that warning.

Fixes: dde637f2daf1 ("ASoC: omap: Introduce the generic_dmaengine_pcm based sdma-pcm")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.9.0
