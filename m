From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 14/18] ASoC: twl6040: Support other sample rates in constraints.
Date: Fri, 10 Jun 2011 14:54:32 +0300
Message-ID: <1307706876-4768-15-git-send-email-peter.ujfalusi@ti.com>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Liam Girdwood <lrg@ti.com>

Add other supported sample rates to LP and HP modes.

Signed-off-by: Liam Girdwood <lrg@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 28dc5d9..7845cdb 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1203,6 +1203,13 @@ static int twl6040_set_bias_level(struct snd_soc_codec *codec,
 /* set of rates for each pll: low-power and high-performance */
 
 static unsigned int lp_rates[] = {
+	8000,
+	11250,
+	16000,
+	22500,
+	32000,
+	44100,
+	48000,
 	88200,
 	96000,
 };
@@ -1213,6 +1220,10 @@ static struct snd_pcm_hw_constraint_list lp_constraints = {
 };
 
 static unsigned int hp_rates[] = {
+	8000,
+	16000,
+	32000,
+	48000,
 	96000,
 };
 
-- 
1.7.5.3

