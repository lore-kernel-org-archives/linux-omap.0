From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 2/2] ASoC: davinci-mcasp: Allow best effort in selecting BCLK divider
Date: Fri, 13 Jun 2014 12:50:00 +0300
Message-ID: <6f645a7d31219c4410db31030a3ab07a4af6ae0e.1402652359.git.jsarha@ti.com>
References: <cover.1402652359.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37575 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbaFMJuN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jun 2014 05:50:13 -0400
In-Reply-To: <cover.1402652359.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Do not fail if the exact BLCK rate can not be produced, just print a
warning. Check that sysclk frequency is set before implicitly setting
the BCLK divider.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 0ee4986..e26a89d 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -676,14 +676,18 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 
 	/* If mcasp is BCLK master we need to set BCLK divider */
-	if (mcasp->bclk_master) {
+	if (mcasp->bclk_master && mcasp->sysclk_freq) {
 		unsigned int bclk_freq = snd_soc_params_to_bclk(params);
+		unsigned int div = mcasp->sysclk_freq / bclk_freq;
 		if (mcasp->sysclk_freq % bclk_freq != 0) {
-			dev_err(mcasp->dev, "Can't produce required BCLK\n");
-			return -EINVAL;
+			if (((mcasp->sysclk_freq / div) - bclk_freq) >
+			    (bclk_freq - (mcasp->sysclk_freq / (div+1))))
+				div++;
+			dev_warn(mcasp->dev,
+				 "Inaccurate BCLK: %u Hz / %u != %u Hz\n",
+				 mcasp->sysclk_freq, div, bclk_freq);
 		}
-		davinci_mcasp_set_clkdiv(
-			cpu_dai, 1, mcasp->sysclk_freq / bclk_freq);
+		davinci_mcasp_set_clkdiv(cpu_dai, 1, div);
 	}
 
 	ret = mcasp_common_hw_param(mcasp, substream->stream,
-- 
1.7.9.5

