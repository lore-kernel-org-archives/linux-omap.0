From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv2 2/5] ASoC: core: soc level wrapper for
	pcm_pointer callback
Date: Wed,  3 Mar 2010 15:08:06 +0200
Message-ID: <1267621689-30337-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, tony@atomide.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, ext-eero.nurkkala@nokia.com, lrg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

Create a soc level wrapper for pcm_pointer callback.
This will facilitate the soc level handling of different
HW buffers in the audio path.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/soc-core.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 37c872e..de5223d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -797,6 +797,23 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	return 0;
 }
 
+/*
+ * soc level wrapper for pointer callback
+ */
+static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_card *card = socdev->card;
+	struct snd_soc_platform *platform = card->platform;
+	snd_pcm_uframes_t offset = 0;
+
+	if (platform->pcm_ops->pointer)
+		offset = platform->pcm_ops->pointer(substream);
+
+	return offset;
+}
+
 /* ASoC PCM operations */
 static struct snd_pcm_ops soc_pcm_ops = {
 	.open		= soc_pcm_open,
@@ -805,6 +822,7 @@ static struct snd_pcm_ops soc_pcm_ops = {
 	.hw_free	= soc_pcm_hw_free,
 	.prepare	= soc_pcm_prepare,
 	.trigger	= soc_pcm_trigger,
+	.pointer	= soc_pcm_pointer,
 };
 
 #ifdef CONFIG_PM
@@ -1331,7 +1349,6 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 	dai_link->pcm = pcm;
 	pcm->private_data = rtd;
 	soc_pcm_ops.mmap = platform->pcm_ops->mmap;
-	soc_pcm_ops.pointer = platform->pcm_ops->pointer;
 	soc_pcm_ops.ioctl = platform->pcm_ops->ioctl;
 	soc_pcm_ops.copy = platform->pcm_ops->copy;
 	soc_pcm_ops.silence = platform->pcm_ops->silence;
-- 
1.7.0
