From: Greg Knight <g.knight@symetrica.com>
Subject: Patches to bind the SGTL5000 chip to AM33XX McASP
Date: Thu, 19 Mar 2015 01:07:39 -0400
Message-ID: <1426741659.10003.9.camel@midgaarde>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-6YEoiG07Btkn/evehSgq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:35594 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbCSFHm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 01:07:42 -0400
Received: by qcbkw5 with SMTP id kw5so57789930qcb.2
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2015 22:07:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org


--=-6YEoiG07Btkn/evehSgq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi, Mark, Jaroslav,

I've attached a couple patches to provide support for the Freescale
SGTL5000 chip when using the McASP on the AM3359.

This adds an optional hack, "clock-to-talk" to the McASP subsystem which
can start AHCLKX/AHCLKR prior to initializing the codec. This is needed
on the SGTL5000, which depends on AHCLKX for its master clock.

These patches are based off of 3.14.31-ti-r49. What is the process for
getting these merged?

Patch #3 is a completely unrelated patch in the SPI system, will send
with different subject.

Thanks,
Greg

--=-6YEoiG07Btkn/evehSgq
Content-Disposition: attachment;
	filename*0=0001-davinci-mcasp-add-clock-to-talk-option-to-mcasp-devi.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-davinci-mcasp-add-clock-to-talk-option-to-mcasp-devi.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From fbcdbfb151d54e6b18c0e04eb5f80dd05527e06b Mon Sep 17 00:00:00 2001
From: Greg Knight <g.knight@symetrica.com>
Date: Mon, 23 Feb 2015 19:41:05 -0500
Subject: [PATCH 1/3] davinci-mcasp: add clock-to-talk option to mcasp
 device-tree which forces enable of AHCLKX/AHCLKR if set. This allows the
 AHCLKX line to operate as a main clock for chips such as the SGTL5000.

---
 include/linux/platform_data/davinci_asp.h | 14 +++++++++++++
 sound/soc/davinci/davinci-mcasp.c         | 33 +++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/platform_data/davinci_asp.h
index 85ad68f..7dee1b2 100644
--- a/include/linux/platform_data/davinci_asp.h
+++ b/include/linux/platform_data/davinci_asp.h
@@ -29,6 +29,15 @@ struct davinci_mcasp_pdata {
 	 * when compared to previous behavior.
 	 */
 	unsigned enable_channel_combine:1;
+
+	/**
+	 * If set, we can anticipate device-tree failures during boot
+	 * if the high-speed clock(s) are not running.
+	 * Bit 0: Enable AHCLKX at startup
+	 * Bit 1: Enable AHCLKR at startup
+	 */
+	unsigned clock_to_talk:2;
+
 	unsigned sram_size_playback;
 	unsigned sram_size_capture;
 	struct gen_pool *sram_pool;
@@ -102,6 +111,11 @@ enum mcbsp_clk_input_pin {
 	MCBSP_CLKS,
 };
 
+enum clock_to_talk_bits {
+	MCASP_CLOCK_TO_TALK_X = 0,
+	MCASP_CLOCK_TO_TALK_R
+};
+
 #define INACTIVE_MODE	0
 #define TX_MODE		1
 #define RX_MODE		2
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index eeb51f9..d0e6cab 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1326,6 +1326,15 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 	if (ret >= 0)
 		pdata->sram_size_capture = val;
 
+	ret = of_property_read_u32(np, "clock-to-talk", &val);
+	if (ret >= 0) {
+		if (val >= 4) {
+			ret = -EINVAL;
+			goto nodata;
+		}
+		pdata->clock_to_talk = (unsigned) val;
+	}
+
 	return  pdata;
 
 nodata:
@@ -1337,6 +1346,21 @@ nodata:
 	return  pdata;
 }
 
+int davinci_mcasp_clock_to_talk_hack(struct davinci_mcasp* mcasp, int which)
+{
+	if (which & (1 << MCASP_CLOCK_TO_TALK_R)) {
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
+		mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, RXHCLKRST);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKR);
+	}
+	if (which & (1 << MCASP_CLOCK_TO_TALK_X)) {
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
+		mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, TXHCLKRST);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
+	}
+	return 0;
+}
+
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct davinci_pcm_dma_params *dma_params;
@@ -1557,6 +1581,15 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	if (pdata->clock_to_talk != 0) {
+		ret = davinci_mcasp_clock_to_talk_hack(mcasp, pdata->clock_to_talk);
+		dev_dbg(&pdev->dev, "clock to talk: %u\n", pdata->clock_to_talk);
+		if (ret) {
+			dev_err(&pdev->dev, "clock to talk hack failed: %d\n", ret);
+			goto err;
+		}
+	}
+
 	return 0;
 
 err:
-- 
1.9.1


--=-6YEoiG07Btkn/evehSgq
Content-Disposition: attachment;
	filename*0=0002-davinci-evm-add-evm_sgtl5000_link-to-bind-the-SGTL50.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0002-davinci-evm-add-evm_sgtl5000_link-to-bind-the-SGTL50.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 0cfd020bac9053326c97d273d60864776e7850e8 Mon Sep 17 00:00:00 2001
From: Greg Knight <g.knight@symetrica.com>
Date: Mon, 23 Feb 2015 19:41:40 -0500
Subject: [PATCH 2/3] davinci-evm: add evm_sgtl5000_link to bind the SGTL5000
 chip to the davinci-evm SOM module

---
 sound/soc/davinci/davinci-evm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index b9010c9..e71975f 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -468,6 +468,15 @@ static struct snd_soc_dai_link dra7xx_evm_link = {
 		   SND_SOC_DAIFMT_IB_NF,
 };
 
+static struct snd_soc_dai_link evm_sgtl5000_link = {
+	.name           = "Freescale SGTL5000",
+	.stream_name    = "SGTL",
+	.codec_dai_name = "sgtl5000",
+	.ops            = &evm_ops,
+	.dai_fmt        = SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_I2S |
+                      SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CONT,
+};
+
 static const struct of_device_id davinci_evm_dt_ids[] = {
 	{
 		.compatible = "ti,da830-evm-audio",
@@ -481,6 +490,10 @@ static const struct of_device_id davinci_evm_dt_ids[] = {
 		.compatible = "ti,dra7xx-evm-audio",
 		.data = (void *) &dra7xx_evm_link,
 	},
+	{
+		.compatible = "ti,sgtl5000-audio",
+		.data = &evm_sgtl5000_link
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, davinci_evm_dt_ids);
-- 
1.9.1


--=-6YEoiG07Btkn/evehSgq--

