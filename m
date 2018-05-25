From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] ASoC: omap: sdma-pcm: add module license
Date: Fri, 25 May 2018 18:02:31 +0200
Message-ID: <20180525160248.4135506-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

Kbuild warns that we should have a MODULE_LICENSE() tag in the new module:

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/omap/snd-soc-sdma.o

This adds both the license and author field corresponding to the information
at the top of the file.

Fixes: dde637f2daf1 ("ASoC: omap: Introduce the generic_dmaengine_pcm based sdma-pcm")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/omap/sdma-pcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/omap/sdma-pcm.c b/sound/soc/omap/sdma-pcm.c
index f7b2b5b69d27..e9981bff8bd2 100644
--- a/sound/soc/omap/sdma-pcm.c
+++ b/sound/soc/omap/sdma-pcm.c
@@ -4,6 +4,7 @@
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
+#include <linux/module.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -66,3 +67,6 @@ int sdma_pcm_platform_register(struct device *dev,
 	return devm_snd_dmaengine_pcm_register(dev, config, flags);
 }
 EXPORT_SYMBOL_GPL(sdma_pcm_platform_register);
+
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.9.0
