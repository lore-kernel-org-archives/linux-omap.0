From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 2/2] ASoC: omap-hdmi-audio: Set buffer bytes
	step constraint to 128
Date: Wed, 26 Aug 2015 16:11:40 +0300
Message-ID: <041db517d2b5313648e20536a3fc0b13d4a72d09.1440594174.git.jsarha@ti.com>
References: <cover.1440594174.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <cover.1440594174.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: linux-omap@vger.kernel.org

Set buffer bytes step constraint to 128. A matching constraint has
already been set to period size. This helps PCM setup to tolerate ALSA
clients that set the PCM hw params in unusual order.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/omap/omap-hdmi-audio.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
index aeef25c..584b237 100644
--- a/sound/soc/omap/omap-hdmi-audio.c
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -81,7 +81,15 @@ static int hdmi_dai_startup(struct snd_pcm_substream *substream,
 	ret = snd_pcm_hw_constraint_step(substream->runtime, 0,
 					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 128);
 	if (ret < 0) {
-		dev_err(dai->dev, "could not apply constraint\n");
+		dev_err(dai->dev, "Could not apply period constraint: %d\n",
+			ret);
+		return ret;
+	}
+	ret = snd_pcm_hw_constraint_step(substream->runtime, 0,
+					 SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 128);
+	if (ret < 0) {
+		dev_err(dai->dev, "Could not apply buffer constraint: %d\n",
+			ret);
 		return ret;
 	}
 
-- 
1.9.1
