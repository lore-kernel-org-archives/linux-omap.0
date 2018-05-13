From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] ASoC: omap: add sdma-pcm.c MODULE_LICENSE
Date: Sat, 12 May 2018 18:41:51 -0700
Message-ID: <2bf2991a-da55-00a4-bc39-a0ee61bad4d0@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

ASoC: omap: add sdma-pcm.c MODULE_LICENSE

Fixes this build warning:

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/omap/snd-soc-sdma.o

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/sdma-pcm.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-next-20180510.orig/sound/soc/omap/sdma-pcm.c
+++ linux-next-20180510/sound/soc/omap/sdma-pcm.c
@@ -9,6 +9,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
+#include <linux/module.h>
 #include <linux/omap-dma.h>
 
 #include "sdma-pcm.h"
@@ -66,3 +67,5 @@ int sdma_pcm_platform_register(struct de
 	return devm_snd_dmaengine_pcm_register(dev, config, flags);
 }
 EXPORT_SYMBOL_GPL(sdma_pcm_platform_register);
+
+MODULE_LICENSE("GPL v2");
