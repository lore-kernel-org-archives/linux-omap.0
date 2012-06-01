From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH] ASoC: omap-mcbsp: Add pm_runtime_get/put
	functions call for McBSP.
Date: Fri, 1 Jun 2012 22:12:52 +0200
Message-ID: <1338581572-11047-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

pm_runtime_get_sync() and put_sync() are not called by McBSP driver.
This is introducing a problem with PM and Audio Backend due to
missing get/put for McBSP IP.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 1046083..007d239 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -117,6 +117,8 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
 	int err = 0;
 
+	pm_runtime_get_sync(mcbsp->dev);
+
 	if (!cpu_dai->active)
 		err = omap_mcbsp_request(mcbsp);
 
@@ -165,6 +167,8 @@ static void omap_mcbsp_dai_shutdown(struct snd_pcm_substream *substream,
 		omap_mcbsp_free(mcbsp);
 		mcbsp->configured = 0;
 	}
+
+	pm_runtime_put_sync(mcbsp->dev);
 }
 
 static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
-- 
1.7.4.1
