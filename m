From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH RFC v5 2/8] ASoC: hdmi-codec: Add
 hdmi-codec for external HDMI-encoders
Date: Tue, 8 Mar 2016 17:59:22 +0100
Message-ID: <56DF04EA.9070101@st.com>
References: <cover.1455720381.git.jsarha@ti.com>
 <f89a49faa3f475600dd2129a7db9c8c6a55851c9.1455720381.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <f89a49faa3f475600dd2129a7db9c8c6a55851c9.1455720381.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "airlied@linux.ie" <airlied@linux.ie>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "moinejf@free.fr" <moinejf@free.fr>, "tony@atomide.com" <tony@atomide.com>, "broonie@kernel.org" <broonie@kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "rmk+kernel@arm.linux.org.uk" <rmk+kernel@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Hello Jyri,

> +
> +static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai)
> +{
> +	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
> +	struct hdmi_codec_params hp = {
> +		.iec = {
> +			.status = { 0 },
> +			.subcode = { 0 },
> +			.pad = 0,
> +			.dig_subframe = { 0 },
> +		}
> +	};
> +	int ret;
> +
> +	dev_dbg(dai->dev, "%s() width %d rate %d channels %d\n", __func__,
> +		params_width(params), params_rate(params),
> +		params_channels(params));
> +
> +	ret = snd_pcm_create_iec958_consumer_hw_params(params, hp.iec.status,
> +						       sizeof(hp.iec.status));
I ran into an issue during my test.
For I2S, an error is returned by create_iec958_consumer for 32-bits
stream (SNDRV_PCM_FMTBIT_S32_LE).
I suppose that it makes sense to handle 32-bits configuration for I2S
(but also SPDIF), to support software IEC958 formating/pre-formating...
To fix issue, just need to add 32-bits with 24-bits case in
create_iec958_consumer

Regards
Arnaud
