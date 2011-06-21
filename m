From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v6 16/18] ASoC: twl6040: set default constraints.
Date: Tue, 21 Jun 2011 16:39:14 +0300
Message-ID: <1308663556-29120-17-git-send-email-peter.ujfalusi@ti.com>
References: <1308663556-29120-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308663556-29120-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Liam Girdwood <lrg@ti.com>

Set default sysclk constraints to high performance mode.

Signed-off-by: Liam Girdwood <lrg@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl6040.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index c8f7fc2..39ecf2f 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1502,6 +1502,7 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	priv->codec = codec;
 	codec->control_data = dev_get_drvdata(codec->dev->parent);
 
+	priv->sysclk_constraints = &hp_constraints;
 	priv->workqueue = create_singlethread_workqueue("twl6040-codec");
 	if (!priv->workqueue) {
 		ret = -ENOMEM;
-- 
1.7.5.3
