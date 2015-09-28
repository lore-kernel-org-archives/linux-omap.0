From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH RFC v4 3/8] ASoC: hdmi-codec: Add
 hdmi-codec for external HDMI-encoders
Date: Mon, 28 Sep 2015 11:01:34 +0200
Message-ID: <560901EE.60407@st.com>
References: <mailman.310.1442574427.844.alsa-devel@alsa-project.org>
 <56057A9E.9080602@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <56057A9E.9080602@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, moinejf@free.fr, tony@atomide.com, broonie@kernel.orgJyri Sarha <jsarha@ti.com>, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

few questions/remarks
BR,
Arnaud

> +static void hdmi_codec_abort(struct device *dev)
> +{
> +    struct hdmi_codec_priv *hcp = dev_get_drvdata(dev);
> +
> +    dev_dbg(dev, "%s()\n", __func__);
> +
> +    mutex_lock(&hcp->current_stream_lock);
> +    if (hcp->current_stream && hcp->current_stream->runtime &&
> +        snd_pcm_running(hcp->current_stream)) {
> +        dev_info(dev, "HDMI audio playback aborted\n");
> +        snd_pcm_stream_lock_irq(hcp->current_stream);
> +        snd_pcm_stop(hcp->current_stream, SNDRV_PCM_STATE_DISCONNECTED);
> +        snd_pcm_stream_unlock_irq(hcp->current_stream);
> +    }
> +    mutex_unlock(&hcp->current_stream_lock);
> +}
Does driver should stop the stream in case of unplug?
This could generate unexpected behavior at application level.
Perhaps should be better if this part is managed in DRM driver. if HDMI 
master, I2S bus should be maintained ON to consume the audio stream 
until application action.

> +
> +static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
> +                struct snd_pcm_hw_params *params,
> +                struct snd_soc_dai *dai)
> +{
> +    struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
> +    struct hdmi_codec_params hp = {
> +        .iec = {
> +            .status = { 0 },
> +            .subcode = { 0 },
> +            .pad = 0,
> +            .dig_subframe = { 0 },
> +        }
> +    };
> +    int ret;
> +
> +    dev_dbg(dai->dev, "%s() width %d rate %d channels %d\n", __func__,
> +        params_width(params), params_rate(params),
> +        params_channels(params));
> +
> +    ret = snd_pcm_create_iec958_consumer_hw_params(params, hp.iec.status,
> +                               sizeof(hp.iec.status));
Tell me if i am wrong, but in case of SPDIF format, IEC status is 
managed by cpu_dai not by the codec.
To manage IEC61937 a control should be needed to update IEC status bits...

> +    if (ret < 0) {
> +        dev_err(dai->dev, "Creating IEC958 channel status failed %d\n",
> +            ret);
> +        return ret;
> +    }
> +
> +    ret = hdmi_codec_new_stream(substream, dai);
> +    if (ret)
> +        return ret;
> +
> +    hdmi_audio_infoframe_init(&hp.cea);
> +    hp.cea.channels = params_channels(params);
> +    hp.cea.coding_type = HDMI_AUDIO_CODING_TYPE_STREAM;
> +    hp.cea.sample_size = HDMI_AUDIO_SAMPLE_SIZE_STREAM;
> +    hp.cea.sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM;
> +
> +    hp.sample_width = params_width(params);
> +    hp.sample_rate = params_rate(params);
> +    hp.channels = params_channels(params);
> +
> +    return hcp->hcd.ops->hw_params(dai->dev->parent,
> &hcp->daifmt[dai->id],
> +                       &hp);
> +}
> +
