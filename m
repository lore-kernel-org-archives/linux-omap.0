From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/5] ASoC: omap: n810: Correct the card level
	dapm_route
Date: Thu, 26 Apr 2018 14:51:13 +0300
Message-ID: <20180426115115.13744-4-peter.ujfalusi@ti.com>
References: <20180426115115.13744-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180426115115.13744-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com, tony@atomide.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

Fix the capture DAPM route due to core changes regarding to mic bias.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/n810.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 71e5f31fa306..e44bb5baac41 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -231,8 +231,8 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Ext Spk", NULL, "LLOUT"},
 	{"Ext Spk", NULL, "RLOUT"},
 
-	{"DMic Rate 64", NULL, "Mic Bias"},
-	{"Mic Bias", NULL, "DMic"},
+	{"DMic Rate 64", NULL, "DMic"},
+	{"DMic", NULL, "Mic Bias"},
 };
 
 static const char *spk_function[] = {"Off", "On"};
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
