Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55AD31E823;
	Sat, 11 Jul 2026 06:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.223
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749919; cv=pass; b=FC35RLmjWYIXPK9de2sKpxllkrPt4YCrz96EzZgG/+MKGMM+QUEBmYezIAMPLO6k/PWewkhgAtgKvaZhngRUiWT3w35u4K8P2ypBDvSc2u+GqaVOszSmm8EcY3xzurtvWBu5Bk4vUtmX9JR2UTatxenNgao/8ctZdReeZgdfvA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749919; c=relaxed/simple;
	bh=IBSi1g75ivspH4eP9Pu0ikYEr/rygHyfZXeqS42xw7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3o0+uhiGFKlswhXmxgPKOZ8ZNxFaCYxIYzdGilqp7howYNlf8CS1HwzWjl/Sh8IGdd7MFCkYdS2fFfZiQNAWEghyO0K7gK8zGVW5x4lcNCHLt6q3lmre3uhKpETqVdsPAk4E5aWpdjjPB6zhcm/b9eKY0TsCnOi0W9/wx0mkYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=tGm8GsIi; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=ESnVmjxn; arc=pass smtp.client-ip=81.169.146.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="tGm8GsIi";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="ESnVmjxn"
ARC-Seal: i=1; a=rsa-sha256; t=1783749734; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=run2BEMDp+5YV1CDxFqVxZHbYrBhva5ty1Lt5W1KMBhyIhadJrk/IgIjRwc4ItpWRi
    w6MqH1bVYccVsx9C1ImD57XA2y4Yrdsd+2APuMsxyR5XeBLQSPVxbd0445Fwz5j6Hdon
    ztO3z6HIyTopjdAgk7IoSbeBZt5RKGA6JbdZ9W00uw4WiRRylTe1fId73ldnirAL6UUJ
    is29XgkdqOulFS7M5e+1X4qHP6wJiREt9KED03+NjQs7OqRBOez7KL6xy4eB1GnLE1dt
    7lv3PLSi8PRUsBiO7vCdnq6l2pJ5likz9XySt8guabB5L2shv0Y8Ev9BY2b3oyh5Rix3
    a09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749734;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HPdy4LPPlxugHv+cSwsCrzTGTCfohShFJc3owzkw44A=;
    b=U+W+qUiN1/+3Pe4OYHvPhCSB12YJINyO2qvSEfWcDMAP8ITZhJVwaEXZU7oy9QPD15
    QkmlP7sZAIzIc8EI16ykCpQAJ0xQf27qFF6bXTL7/qoJRO98DjHJAxrRSHsQ9PWKIUrM
    cSQi9487ViNEYBpDOvGTIsxqVfe8DzQz6alYDmLk53+a4v3o7Ha7TTz1dSvkY5FVF8Gw
    7L8Iuo5jigCGJouPU0pf+psxXrYIfMmmW3qojpj0EFZijcLEHJSt6vm1xawns7QjDNBb
    +3JhhijJyebeuqv8KIkAIvSyt6Q3MJ2V8T/wHEHJNDRJkxHZ0RqyJLSp9CXPXpsCo1HN
    Syzw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749734;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HPdy4LPPlxugHv+cSwsCrzTGTCfohShFJc3owzkw44A=;
    b=tGm8GsIi8+gfLmYMR0PE1GN8GrJoMxACv6xGhuA/AyiEep3bM76z6IxxcNo2a4K4a1
    SNv5tjRXP/78yaa6sf2jgmnlOBd0vlMm0VWjqbBTVJDKgOpywUyfrXAaSPRRZDKg5ysv
    DbbPBuYwsm/TFowoAZkQzpjbN2yW+wo0sbMPtuRuI9lcEKM5eVT9Q80iNRcvO7x+5bNp
    o8q+5Qvik8cEPmNJ8jRmwiYXQFCuXtPXZ1xCEHS/Zs+nctosKG0QzzepJEmfyQG42QkM
    nqHbqleuMBfH95ohBaO6s80PPlrkAVevlMkbu7SfR5FgDsqyI2G0kjA7eKr7EQQFALjY
    95cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783749734;
    s=strato-dkim-0003; d=goldelico.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HPdy4LPPlxugHv+cSwsCrzTGTCfohShFJc3owzkw44A=;
    b=ESnVmjxnmU6AyUjpn0uHweO4UfrbSQPCI6U3IeNAK0XEfgNHZa1ZjUb5q0aI90RWX3
    RpF9J9kKa+swzVF8U1Cg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT35oLmciNszeF4HOToVDOd6S1gdjuILE2MKVd"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426B62DGhr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 11 Jul 2026 08:02:13 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Grond <grond66@riseup.net>,
	Stefan Leichter <sle85276@gmx.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Grazvydas Ignotas <notasas@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andreas Kemnade <andreas@kemnade.info>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sen Wang <sen@ti.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Niranjan H Y <niranjan.hy@ti.com>
Cc: letux-kernel@openphoenux.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	kernel@pyra-handheld.com,
	mfd@lists.linux.dev
Subject: [PATCH 06/16] ASoC: twl4030-codec: Allow setting APLL rate through the .set_sysclk() interface
Date: Sat, 11 Jul 2026 08:01:53 +0200
Message-ID: <7ea589f951baf1e217c7169ae21c0bf510672ecf.1783749722.git.hns@goldelico.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Grond <grond66@riseup.net>

On the Pandora, the APLL is actually what drives all of the audio clocks on
the board. Since the TWL4030 is only used for capture, we need some way of
setting the correct rate for playback streams, since they will not go
through the TWL4030's .hw_params() code path (which is normally how APLL
rate is set).

Signed-off-by: Grond <grond66@riseup.net>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 include/linux/mfd/twl4030-audio.h |   3 +
 sound/soc/codecs/twl4030.c        | 140 +++++++++++++++++++++---------
 2 files changed, 101 insertions(+), 42 deletions(-)

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
index 9476cdfd4dde9..ff36679166e20 100644
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
+	int reboot_codec = twl4030->codec_powered;
+	unsigned int i;
+	int ret;
+
+	if (reboot_codec)
+		twl4030_codec_enable(component, 0);
+
+	for (i = 0; i < n; ++i) {
+		ret = twl4030_write(component, regs[i], vals[i]);
+		if (ret)
+			return ret;
+	}
+
+	if (reboot_codec)
+		twl4030_codec_enable(component, 1);
+
+	return 0;
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
@@ -1690,38 +1722,16 @@ static void twl4030_shutdown(struct snd_pcm_substream *substream,
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
@@ -1753,11 +1763,50 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
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
+	int s;
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
@@ -1775,20 +1824,12 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
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
+		twl4030_perform_writes(component, regs, vals, ARRAY_SIZE(regs));
 	}
 
 	/* Store the important parameters for the DAI configuration and set
@@ -1813,6 +1854,21 @@ static int twl4030_set_dai_sysclk(struct snd_soc_dai *codec_dai, int clk_id,
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
2.50.1 (Apple Git-155)

