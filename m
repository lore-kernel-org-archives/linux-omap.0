From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap: n810: Correct the cpu_dai,
	platform and codec name" to the asoc tree
Date: Fri, 27 Apr 2018 11:59:43 +0100
Message-ID: <E1fC16N-00040O-FI@debutante>
References: <20180426115115.13744-5-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180426115115.13744-5-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, tony@atomide.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: omap: n810: Correct the cpu_dai, platform and codec name

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6f4a7594a6271b61f06382c0d4ec0525016edec6 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 27 Apr 2018 11:17:13 +0300
Subject: [PATCH] ASoC: omap: n810: Correct the cpu_dai, platform and codec
 name

The non DT boot is no longer supported and when booting with DT the device
names are different.

Fix them up for now, but the n810.c should be updated to support probing
via DT with proper bindings.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.17.0
