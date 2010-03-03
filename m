From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv2 3/5] ASoC: core: Add delay operation to snd_soc_dai_ops
Date: Wed,  3 Mar 2010 15:08:07 +0200
Message-ID: <1267621689-30337-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32536 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab0CCNIf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 08:08:35 -0500
In-Reply-To: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, tony@atomide.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, jhnikula@GMAIL.COM, ext-eero.nurkkala@nokia.com

The delay callback can be used by the core to query the delay
on the dai caused by FIFO or delay in the platform side.
In case if both CPU and CODEC dai has FIFO the delay reported
by each will be added to form the full delay on the chain.
If none of the dai has FIFO, than the delay will be kept as
zero.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/soc-dai.h |    6 ++++++
 include/sound/soc.h     |    7 +++++++
 sound/soc/soc-core.c    |   18 ++++++++++++++++++
 3 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 061f16d..be9cd47 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -182,6 +182,12 @@ struct snd_soc_dai_ops {
 		struct snd_soc_dai *);
 	int (*trigger)(struct snd_pcm_substream *, int,
 		struct snd_soc_dai *);
+	/*
+	 * For hardware based FIFO caused delay reporting.
+	 * Optional.
+	 */
+	snd_pcm_sframes_t (*delay)(struct snd_pcm_substream *,
+		struct snd_soc_dai *);
 };
 
 /*
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5d234a8..c010824 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -469,6 +469,13 @@ struct snd_soc_platform {
 		struct snd_pcm *);
 	void (*pcm_free)(struct snd_pcm *);
 
+	/*
+	 * For platform caused delay reporting.
+	 * Optional.
+	 */
+	snd_pcm_sframes_t (*delay)(struct snd_pcm_substream *,
+		struct snd_soc_dai *);
+
 	/* platform stream ops */
 	struct snd_pcm_ops *pcm_ops;
 };
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index de5223d..e9c2dc1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -799,6 +799,8 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 
 /*
  * soc level wrapper for pointer callback
+ * If cpu_dai, codec_dai, platform driver has the delay callback, than
+ * the runtime->delay will be updated accordingly.
  */
 static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 {
@@ -806,11 +808,27 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_card *card = socdev->card;
 	struct snd_soc_platform *platform = card->platform;
+	struct snd_soc_dai_link *machine = rtd->dai;
+	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
+	struct snd_soc_dai *codec_dai = machine->codec_dai;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t offset = 0;
+	snd_pcm_sframes_t delay = 0;
 
 	if (platform->pcm_ops->pointer)
 		offset = platform->pcm_ops->pointer(substream);
 
+	if (cpu_dai->ops->delay)
+		delay += cpu_dai->ops->delay(substream, cpu_dai);
+
+	if (codec_dai->ops->delay)
+		delay += codec_dai->ops->delay(substream, codec_dai);
+
+	if (platform->delay)
+		delay += platform->delay(substream, codec_dai);
+
+	runtime->delay = delay;
+
 	return offset;
 }
 
-- 
1.7.0

