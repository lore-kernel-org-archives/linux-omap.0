Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505223;
	b=GmbKqWLpiEkfriuWOYpCMsz9YNf+/vdBexqpLzAWSo50b7GtKFudf0eYAAWbHE/YXQlL
	 WZrxSRmPwOH8S2nCrAmO91gXAbXXNXgeLGoYyqtWxfJBeSW+MO7L80GNviWMYusleDc8f
	 AxLoo4nM+gNb/ZxEQ7klnTuF2Q4LCIrZr2JKp4txLAmmpLxzo6LCWWb/eAgZGG88+Zje5
	 3QPc2zuGTHLxqyJ+DrXdc73YIdJ2/j7zdckZHDhI1HuT9L6U2f4k/vvBMc3NpcrEnj7ay
	 SaYZBh44TkwoP/qOV/5v+0AWn8ni2wKSB3N+KAzI3kL1HeuzxUrmLrw9z0BdroziDPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505223;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=5dGUZjEznfH0dLfKGQffDX75uQ4mFGRFuloEeLaqmqs=;
	b=o250j6CLnBqYpoRBGOidcYciI+ktCVR0EtPyYzApkWYcD+QMKTAgFTaCRiOJRSkoUpS5
	 I4Db4WHyubSfaW4pCUd08dNS0wb3bv//aKItDruOjSxeKvead2n36bEqArOzvyJihVa28
	 RcYo7Lo3R+x1ZdTRfEZgM5I55DdHkFiFcvXNZHliOATP01KKa2Du+90J9YDSi7uYPoSun
	 QQS7P4eWkutnc/k0G3yWktlPYakab5DFt8Qt8uq/N5XsewhT2yUXLLgZ9+J/ScBquo2El
	 w6PXORtDfyuIUXJIyPwASlnE0t7bW14aMPEeGsraeQDUUxTJlEkizDdVlDNZCBI5H2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=cleH+rZ9;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=QkaEna25;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.179
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695AB606A33B;
	Tue, 24 Nov 2026 07:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 695AB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=cleH+rZ9;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=QkaEna25
ARC-Seal: i=1; a=rsa-sha256; t=1795505168; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ai7FTgJg+JA8P7x4Vyi9i5EIFBQ3Dk1sQHz9W2EHf4Wg+pnAnBKEnzVudp35CykrpH
    l+OnDnp8Tw2pKeCnbNCQgxaldsI1eywp/J1uPaFrlFFBS08CitFMbEN04RLTbMDXrLMM
    CRvgk7asnwqwswgkVSUVJQ09bHL2r0+TqRBqZMnadmsypa5P7bxoQaCk16deaG3wkJis
    9bZRlOLd61PEMDjNc6+oa4PuLlSo2H2mMI7teBmjAvMEekTepRSN2fe81LZQksGLkNKS
    sQAIRh8j3bB5CBqNT4z7ccQuLbXxh0o5r+fwc5IFu3QSf4s9U1AEbnbYItOdT67Fz7RO
    pLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505168;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5dGUZjEznfH0dLfKGQffDX75uQ4mFGRFuloEeLaqmqs=;
    b=NH3hClH54i45Td2WnQ5b1Zbb9K1sV4wSwIuGM6EkC2RHHfDBwhrMF7Ec1oib1drTUn
    zRL9hoq9XYeLSzZ4gvUAvpQBXCt15ZPoUPqnX8duzfbYE4wIzonf3Czm2prYH7eQNH1V
    1C5r7AsS6JkMV8OI5DIth5/iE4ZAXFwZ0xoxcw9ovZaaAEo0nWG7Et6GrUFZybCz0AEK
    CERT2D0gL7vE8+Z0as9eqqMHRgaOK/AkzATO4kxgo9yIhLCQYbLPDGxLTaXqz28MlJvR
    /g2qoG4yq8tymfmX5pbauKJw/OPxUsLlMZymO+dsWId8IxMN7wS4RreXjYfdXTF0w5r1
    ZI2w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505168;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5dGUZjEznfH0dLfKGQffDX75uQ4mFGRFuloEeLaqmqs=;
    b=cleH+rZ92rJlSb/DdCLiXDevVzQ+lNuQzPFrhTfiCxTttwCMGT3+FyEQZtT8w2KeR4
    Q2GELgTkRvRTBUTNlaTNJ+LVxLzNnN/g+TjbStGaUU3uTzbivb/EBxUJjvvdaM6h87zi
    +v6Mt6SJG7Kc5ztOy1SwnGqRTnZIqhr7CnjmmUox22S6NQsmLaCd4Mcgr26SsXzsr4FI
    zBBd46zENkCngKAUBJncD7ODjBqisy+0uK3PN4xw1yce8OauV43qYxmkGaVrM5RKdEGP
    HMe55xEEVn6ufs+vv/gGdRTv+UPSKceHFW5TiDZmCnazibkw3etYa3Rr9gMLE+x837jv
    dMaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505168;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5dGUZjEznfH0dLfKGQffDX75uQ4mFGRFuloEeLaqmqs=;
    b=QkaEna25Pynm1RaaacMHr1mARRZFDOeWWKJ/M+Qh8RfN3cIF4xfm8dtd6OWR0+8PfH
    9JbzUywVQ2LyA3ovTDCA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AO7Q71HE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 08:26:07 +0100 (CET)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	letux-kernel@openphoenux.org,
	kernel@pyra-handheld.com,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Grond <grond66@riseup.net>
Subject: [PATCH v2 03/20] ASoC: twl4030: Allow APLL rate selection through set_sysclk()
Date: Tue, 24 Nov 2026 08:25:43 +0100
Message-ID: <0cddcdff2c759301cbf2b11fe902e5df28ecca52.1795505160.git.hns@goldelico.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The TWL4030 APLL supplies the audio clocks used by the Pandora sound
card, including playback through an external DAC. Playback does not
necessarily execute the TWL4030 codec's hw_params() callback, which
previously provided the APLL rate selection.

Allow the machine driver to select the APLL rate through set_sysclk()
so that the clock can be configured for playback-only streams.

Suggested-by: Grond <grond66@riseup.net>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Andreas Kemnade suggested modeling the APLL as a clock provider
      to enable a generic audio card; V2 retains the ASoC set_sysclk()
      interface instead. This alternative was not implemented.
    - Clarify in the commit message why playback-only streams require an
      explicit APLL clock-selection interface.
    - Take over patch authorship because Grond cannot be reached to
      confirm a full name or Signed-off-by. Credit the historical
      contribution with Suggested-by rather than asserting code authorship
      or a DCO sign-off.
    - Historical source: commit 5497d5a29f53 (Grond, 2021-12-15),
      "ASoC: twl4030-codec: Allow setting APLL rate through the
      .set_sysclk() interface". The present patch is derived from
      this implementation, with subsequent revisions.
    - Code and commit-message review assisted by ChatGPT.

 include/linux/mfd/twl4030-audio.h |   3 +
 sound/soc/codecs/twl4030.c        | 142 +++++++++++++++++++++---------
 2 files changed, 103 insertions(+), 42 deletions(-)

diff --git a/include/linux/mfd/twl4030-audio.h b/include/linux/mfd/twl4030-audio.h
index 1c28605dfda80..4378eef97b0fc 100644
--- a/include/linux/mfd/twl4030-audio.h
+++ b/include/linux/mfd/twl4030-audio.h
@@ -244,6 +244,9 @@
 #define TWL4030_VIBRA_SEL		0x10
 #define TWL4030_VIBRA_DIR_SEL		0x20
 
+/* clock ID used for setting APLL rate */
+#define TWL4030_CLOCK_APLL		0xffff
+
 /* TWL4030 codec resource IDs */
 enum twl4030_audio_res {
 	TWL4030_AUDIO_RES_POWER = 0,
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index e207721b99414..3c9ed38004783 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -198,6 +198,38 @@ static void twl4030_codec_enable(struct snd_soc_component *component, int enable
 	udelay(10);
 }
 
+static int twl4030_perform_writes(struct snd_soc_component *component,
+				  const unsigned int *regs,
+				  const unsigned int *vals,
+				  unsigned int n)
+{
+	struct twl4030_priv *twl4030 = snd_soc_component_get_drvdata(component);
+	bool reboot_codec = twl4030->codec_powered;
+	unsigned int i;
+	int ret = 0;
+
+	if (reboot_codec)
+		twl4030_codec_enable(component, 0);
+
+	for (i = 0; i < n; ++i) {
+		ret = twl4030_write(component, regs[i], vals[i]);
+		if (ret)
+			break;
+	}
+
+	if (reboot_codec)
+		twl4030_codec_enable(component, 1);
+
+	return ret;
+}
+
+static inline int
+twl4030_perform_single_write(struct snd_soc_component *component,
+			     unsigned int reg, unsigned int val)
+{
+	return twl4030_perform_writes(component, &reg, &val, 1);
+}
+
 static void
 twl4030_get_board_param_values(struct twl4030_board_params *board_params,
 			       struct device_node *node)
@@ -1697,38 +1729,16 @@ static void twl4030_shutdown(struct snd_pcm_substream *substream,
 		twl4030_tdm_enable(component, substream->stream, 0);
 }
 
-static int twl4030_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params,
-			     struct snd_soc_dai *dai)
+static int twl4030_get_codec_mode_for_apll_rate(struct snd_soc_component *component,
+						unsigned int rate, u8 *res)
 {
-	struct snd_soc_component *component = dai->component;
-	struct twl4030_priv *twl4030 = snd_soc_component_get_drvdata(component);
-	u8 mode, old_mode, format, old_format;
-
-	 /* If the substream has 4 channel, do the necessary setup */
-	if (params_channels(params) == 4) {
-		format = twl4030_read(component, TWL4030_REG_AUDIO_IF);
-		mode = twl4030_read(component, TWL4030_REG_CODEC_MODE);
-
-		/* Safety check: are we in the correct operating mode and
-		 * the interface is in TDM mode? */
-		if ((mode & TWL4030_OPTION_1) &&
-		    ((format & TWL4030_AIF_FORMAT) == TWL4030_AIF_FORMAT_TDM))
-			twl4030_tdm_enable(component, substream->stream, 1);
-		else
-			return -EINVAL;
-	}
-
-	if (twl4030->configured)
-		/* Ignoring hw_params for already configured DAI */
-		return 0;
+	u8 old_mode, mode;
 
-	/* bit rate */
 	old_mode = twl4030_read(component,
 				TWL4030_REG_CODEC_MODE) & ~TWL4030_CODECPDZ;
 	mode = old_mode & ~TWL4030_APLL_RATE;
 
-	switch (params_rate(params)) {
+	switch (rate) {
 	case 8000:
 		mode |= TWL4030_APLL_RATE_8000;
 		break;
@@ -1760,11 +1770,50 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 		mode |= TWL4030_APLL_RATE_96000;
 		break;
 	default:
-		dev_err(component->dev, "%s: unknown rate %d\n", __func__,
-			params_rate(params));
+		dev_err(component->dev, "%s: unknown rate %u\n", __func__,
+			rate);
 		return -EINVAL;
 	}
 
+	*res = mode;
+
+	return mode != old_mode ? 1 : 0;
+}
+
+static int twl4030_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct twl4030_priv *twl4030 = snd_soc_component_get_drvdata(component);
+	u8 mode, format, old_format;
+	int s, ret;
+	unsigned int regs[2], vals[2];
+
+	 /* If the substream has 4 channel, do the necessary setup */
+	if (params_channels(params) == 4) {
+		format = twl4030_read(component, TWL4030_REG_AUDIO_IF);
+		mode = twl4030_read(component, TWL4030_REG_CODEC_MODE);
+
+		/* Safety check: are we in the correct operating mode and
+		 * the interface is in TDM mode?
+		 */
+		if ((mode & TWL4030_OPTION_1) &&
+		    ((format & TWL4030_AIF_FORMAT) == TWL4030_AIF_FORMAT_TDM))
+			twl4030_tdm_enable(component, substream->stream, 1);
+		else
+			return -EINVAL;
+	}
+
+	if (twl4030->configured)
+		/* Ignoring hw_params for already configured DAI */
+		return 0;
+
+	s = twl4030_get_codec_mode_for_apll_rate(component,
+						 params_rate(params), &mode);
+	if (s < 0)
+		return s;
+
 	/* sample size */
 	old_format = twl4030_read(component, TWL4030_REG_AUDIO_IF);
 	format = old_format;
@@ -1782,20 +1831,14 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	if (format != old_format || mode != old_mode) {
-		if (twl4030->codec_powered) {
-			/*
-			 * If the codec is powered, than we need to toggle the
-			 * codec power.
-			 */
-			twl4030_codec_enable(component, 0);
-			twl4030_write(component, TWL4030_REG_CODEC_MODE, mode);
-			twl4030_write(component, TWL4030_REG_AUDIO_IF, format);
-			twl4030_codec_enable(component, 1);
-		} else {
-			twl4030_write(component, TWL4030_REG_CODEC_MODE, mode);
-			twl4030_write(component, TWL4030_REG_AUDIO_IF, format);
-		}
+	if (format != old_format || s) {
+		regs[0] = TWL4030_REG_CODEC_MODE;
+		vals[0] = mode;
+		regs[1] = TWL4030_REG_AUDIO_IF;
+		vals[1] = format;
+		ret = twl4030_perform_writes(component, regs, vals, ARRAY_SIZE(regs));
+		if (ret)
+			return ret;
 	}
 
 	/* Store the important parameters for the DAI configuration and set
@@ -1820,6 +1863,21 @@ static int twl4030_set_dai_sysclk(struct snd_soc_dai *codec_dai, int clk_id,
 {
 	struct snd_soc_component *component = codec_dai->component;
 	struct twl4030_priv *twl4030 = snd_soc_component_get_drvdata(component);
+	int s;
+	u8 mode;
+
+	if (clk_id == TWL4030_CLOCK_APLL) {
+		s = twl4030_get_codec_mode_for_apll_rate(component,
+							 freq, &mode);
+		if (s < 0)
+			return s;
+
+		if (s)
+			return twl4030_perform_single_write(component,
+					TWL4030_REG_CODEC_MODE, mode);
+
+		return 0;
+	}
 
 	switch (freq) {
 	case 19200000:
-- 
2.56.0

