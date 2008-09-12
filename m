From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH] ASoC: OMAP: Fix Gumstix Overo machine
	driver by using snd_soc_dai struct (rev 2)
Date: Fri, 12 Sep 2008 13:52:19 -0700
Message-ID: <5e088bd90809121352h561618d0r3dbe46ecb8f7dcdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Structs snd_soc_codec_dai and snd_soc_cpu_dai are obsolete and are merged to
snd_soc_dai by the commit 8687eb8bded8c3c5842a85bd0c30e43fc5a3e0e0.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Acked-by: Steve Sakoman <steve@sakoman.com>
---
 sound/soc/omap/overo.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
index 542ff6b..1a086ce 100644
--- a/sound/soc/omap/overo.c
+++ b/sound/soc/omap/overo.c
@@ -39,8 +39,8 @@ static int overo_hw_params(struct snd_pcm_substream
*substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	int ret;

 	/* Set codec DAI configuration */
-- 
1.5.6.5
