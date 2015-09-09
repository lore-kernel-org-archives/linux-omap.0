From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC 4/5] ASoC: davinci-mcasp: Get rid of bclk_lrclk_ratio in private data
Date: Wed, 9 Sep 2015 21:27:45 +0300
Message-ID: <f23dab7c68fe1cc899a8bc95cb5c3c5bd1038e18.1441806963.git.jsarha@ti.com>
References: <cover.1441806963.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1441806963.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, misael.lopez-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The slot_width is for essentially same thing. Instead of storing
bclk_lrclk_ratio, just store the slot_width. Comments has been updated
accordingly and some variable names changed to more descriptive.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 sound/soc/davinci/davinci-mcasp.c | 56 ++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index de1e3a8..25ff1fc 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -87,7 +87,6 @@ struct davinci_mcasp {
 	u8	*serial_dir;
 	u8	version;
 	u8	bclk_div;
-	u16	bclk_lrclk_ratio;
 	int	streams;
 	u32	irq_request[2];
 	int	dma_request[2];
@@ -558,8 +557,21 @@ static int __davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
 			mcasp->bclk_div = div;
 		break;
 
-	case 2:		/* BCLK/LRCLK ratio */
-		mcasp->bclk_lrclk_ratio = div;
+	case 2:	/*
+		 * BCLK/LRCLK ratio descries how many bit-clock cycles
+		 * fit into one frame. The clock ratio is given for a
+		 * full period of data (for I2S format both left and
+		 * right channels), so it has to be divided by number
+		 * of tdm-slots (for I2S - divided by 2).
+		 * Instead of storing this ratio, we calculate a new
+		 * tdm_slot width by dividing the the ratio by the
+		 * number of configured tdm slots.
+		 */
+		mcasp->slot_width = div / mcasp->tdm_slots;
+		if (div % mcasp->tdm_slots)
+			dev_warn(mcasp->dev,
+				 "%s(): BCLK/LRCLK %d is not divisible by %d tdm slots",
+				 div, mcasp->tdm_slots);
 		break;
 
 	default:
@@ -682,11 +694,13 @@ static int davinci_mcasp_set_tdm_slot(struct snd_soc_dai *dai,
 }
 
 static int davinci_config_channel_size(struct davinci_mcasp *mcasp,
-				       int word_length)
+				       int sample_width)
 {
 	u32 fmt;
-	u32 tx_rotate = (word_length / 4) & 0x7;
-	u32 mask = (1ULL << word_length) - 1;
+	u32 tx_rotate = (sample_width / 4) & 0x7;
+	u32 mask = (1ULL << sample_width) - 1;
+	u32 slot_width = sample_width;
+
 	/*
 	 * For captured data we should not rotate, inversion and masking is
 	 * enoguh to get the data to the right position:
@@ -699,31 +713,23 @@ static int davinci_config_channel_size(struct davinci_mcasp *mcasp,
 	u32 rx_rotate = 0;
 
 	/*
-	 * if s BCLK-to-LRCLK ratio has been configured via the set_clkdiv()
-	 * callback, take it into account here. That allows us to for example
-	 * send 32 bits per channel to the codec, while only 16 of them carry
-	 * audio payload.
-	 * The clock ratio is given for a full period of data (for I2S format
-	 * both left and right channels), so it has to be divided by number of
-	 * tdm-slots (for I2S - divided by 2).
+	 * Setting the tdm slot width either with set_clkdiv() or
+	 * set_tdm_slot() allows us to for example send 32 bits per
+	 * channel to the codec, while only 16 of them carry audio
+	 * payload.
 	 */
-	if (mcasp->bclk_lrclk_ratio) {
-		u32 slot_length = mcasp->bclk_lrclk_ratio / mcasp->tdm_slots;
-
+	if (mcasp->slot_width) {
 		/*
-		 * When we have more bclk then it is needed for the data, we
-		 * need to use the rotation to move the received samples to have
-		 * correct alignment.
+		 * When we have more bclk then it is needed for the
+		 * data, we need to use the rotation to move the
+		 * received samples to have correct alignment.
 		 */
-		rx_rotate = (slot_length - word_length) / 4;
-		word_length = slot_length;
-	} else if (mcasp->slot_width) {
-		rx_rotate = (mcasp->slot_width - word_length) / 4;
-		word_length = mcasp->slot_width;
+		slot_width = mcasp->slot_width;
+		rx_rotate = (slot_width - sample_width) / 4;
 	}
 
 	/* mapping of the XSSZ bit-field as described in the datasheet */
-	fmt = (word_length >> 1) - 1;
+	fmt = (slot_width >> 1) - 1;
 
 	if (mcasp->op_mode != DAVINCI_MCASP_DIT_MODE) {
 		mcasp_mod_bits(mcasp, DAVINCI_MCASP_RXFMT_REG, RXSSZ(fmt),
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
