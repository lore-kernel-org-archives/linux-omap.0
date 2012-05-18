From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 02/11] ASoC: OMAP: HDMI: Update the platform
	device names
Date: Fri, 18 May 2012 01:42:34 -0500
Message-ID: <1337323363-11449-3-git-send-email-ricardo.neri@ti.com>
References: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: x0055901@ti.com, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In order to utilize the new OMAP HDMI codec and the updated name of
the device of the CPU DAI, update the names at the drivers accordingly.

While there, also update the name of the machine driver to be more
generic and encompass more OMAP processors featuring HDMI and not
only OMAP4.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap-hdmi.c       |    2 +-
 sound/soc/omap/omap4-hdmi-card.c |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index 38e0def..0925a46 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -35,7 +35,7 @@
 #include "omap-pcm.h"
 #include "omap-hdmi.h"
 
-#define DRV_NAME "hdmi-audio-dai"
+#define DRV_NAME "omap-hdmi-audio-dai"
 
 static struct omap_pcm_dma_data omap_hdmi_dai_dma_params = {
 	.name = "HDMI playback",
diff --git a/sound/soc/omap/omap4-hdmi-card.c b/sound/soc/omap/omap4-hdmi-card.c
index 28d689b..99e96c6 100644
--- a/sound/soc/omap/omap4-hdmi-card.c
+++ b/sound/soc/omap/omap4-hdmi-card.c
@@ -27,7 +27,7 @@
 #include <asm/mach-types.h>
 #include <video/omapdss.h>
 
-#define DRV_NAME "omap4-hdmi-audio"
+#define DRV_NAME "omap-hdmi-audio"
 
 static int omap4_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params)
@@ -65,10 +65,10 @@ static struct snd_soc_ops omap4_hdmi_dai_ops = {
 static struct snd_soc_dai_link omap4_hdmi_dai = {
 	.name = "HDMI",
 	.stream_name = "HDMI",
-	.cpu_dai_name = "hdmi-audio-dai",
+	.cpu_dai_name = "omap-hdmi-audio-dai",
 	.platform_name = "omap-pcm-audio",
-	.codec_name = "omapdss_hdmi",
-	.codec_dai_name = "hdmi-audio-codec",
+	.codec_name = "hdmi-audio-codec",
+	.codec_dai_name = "omap-hdmi-hifi",
 	.ops = &omap4_hdmi_dai_ops,
 };
 
@@ -106,7 +106,7 @@ static int __devexit omap4_hdmi_remove(struct platform_device *pdev)
 
 static struct platform_driver omap4_hdmi_driver = {
 	.driver = {
-		.name = "omap4-hdmi-audio",
+		.name = DRV_NAME,
 		.owner = THIS_MODULE,
 	},
 	.probe = omap4_hdmi_probe,
-- 
1.7.5.4
