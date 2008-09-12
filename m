From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH] ASoC: OMAP: Fix Gumstix Overo machine driver by using snd_soc_dai struct
Date: Fri, 12 Sep 2008 13:42:42 -0700
Message-ID: <5e088bd90809121342i1f7f360fk6ae6123cc54556b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.179]:45639 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167AbYILUmo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 16:42:44 -0400
Received: by el-out-1112.google.com with SMTP id z25so522522ele.1
        for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 13:42:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, alsa-devel@alsa-project.org

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
