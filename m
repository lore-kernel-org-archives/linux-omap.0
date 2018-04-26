From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/5] ASoC: omap: n810: Correct the cpu_dai,
	platform and codec name
Date: Thu, 26 Apr 2018 14:51:14 +0300
Message-ID: <20180426115115.13744-5-peter.ujfalusi@ti.com>
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

The non DT boot is no longer supported and when booting with DT the device
names are different.

Fix them up for now, but the n810.c should be updated to support probing
via DT with proper bindings.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/n810.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index e44bb5baac41..3a2c448a26dd 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -257,9 +257,9 @@ static const struct snd_kcontrol_new aic33_n810_controls[] = {
 static struct snd_soc_dai_link n810_dai = {
 	.name = "TLV320AIC33",
 	.stream_name = "AIC33",
-	.cpu_dai_name = "omap-mcbsp.2",
-	.platform_name = "omap-mcbsp.2",
-	.codec_name = "tlv320aic3x-codec.2-0018",
+	.cpu_dai_name = "48076000.mcbsp",
+	.platform_name = "48076000.mcbsp",
+	.codec_name = "tlv320aic3x-codec.1-0018",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBM_CFM,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
