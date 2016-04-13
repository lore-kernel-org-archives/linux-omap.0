From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v9 4/7] ASoC: hdmi-codec: Add audio abort()
 callback for video side to use
Date: Wed, 13 Apr 2016 10:31:24 +0200
Message-ID: <570E03DC.6030707@st.com>
References: <cover.1459431292.git.jsarha@ti.com>
 <36a4881da9400908b2e033cb2d931daf0d59bac9.1459431292.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <36a4881da9400908b2e033cb2d931daf0d59bac9.1459431292.git.jsarha@ti.com>
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
Cc: "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "tony@atomide.com" <tony@atomide.com>, "broonie@kernel.org" <broonie@kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "rmk+kernel@arm.linux.org.uk" <rmk+kernel@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org



On 03/31/2016 03:36 PM, Jyri Sarha wrote:
> Add audio abort() callback, that is provided at audio stream start,
> for video side. This is for video side to use in case there is a
> pressing need to tear down the audio playback for some reason.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  include/sound/hdmi-codec.h    |  8 ++++++--
>  sound/soc/codecs/hdmi-codec.c | 20 +++++++++++++++++++-
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> index fc3a481..15fe70f 100644
> --- a/include/sound/hdmi-codec.h
> +++ b/include/sound/hdmi-codec.h
> @@ -55,10 +55,14 @@ struct hdmi_codec_params {
>  
>  struct hdmi_codec_ops {
>  	/*
> -	 * Called when ASoC starts an audio stream setup.
> +	 * Called when ASoC starts an audio stream setup. The call
> +	 * provides an audio abort callback for stoping an ongoing
stopping
> +	 * stream from video side driver if the HDMI audio becomes
> +	 * unavailable.
>  	 * Optional
>  	 */
> -	int (*audio_startup)(struct device *dev);
> +	int (*audio_startup)(struct device *dev,
> +			     void (*abort_cb)(struct device *dev));
>  
>  	/*
>  	 * Configures HDMI-encoder for audio stream.
> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index b46b8ed..35151a4 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -47,6 +47,23 @@ enum {
>  	DAI_ID_SPDIF,
>  };
>  
> +static void hdmi_codec_abort(struct device *dev)
> +{
> +	struct hdmi_codec_priv *hcp = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "%s()\n", __func__);
> +
> +	mutex_lock(&hcp->current_stream_lock);
> +	if (hcp->current_stream && hcp->current_stream->runtime &&
> +	    snd_pcm_running(hcp->current_stream)) {
> +		dev_info(dev, "HDMI audio playback aborted\n");
> +		snd_pcm_stream_lock_irq(hcp->current_stream);
> +		snd_pcm_stop(hcp->current_stream, SNDRV_PCM_STATE_DISCONNECTED);
> +		snd_pcm_stream_unlock_irq(hcp->current_stream);
> +	}
> +	mutex_unlock(&hcp->current_stream_lock);
> +}
> +
still not understand the need... i can not find a use case that
justifies it.
As example, in case of HDMI plug/unplug i would not want that audio
stream is stopped (live playback). From my point of view this should be
a decision from user.
But as it is optional, I'm ok if need is justified.

>  static int hdmi_codec_new_stream(struct snd_pcm_substream *substream,
>  				 struct snd_soc_dai *dai)
>  {
> @@ -78,7 +95,8 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
>  		return ret;
>  
>  	if (hcp->hcd.ops->audio_startup) {
> -		ret = hcp->hcd.ops->audio_startup(dai->dev->parent);
> +		ret = hcp->hcd.ops->audio_startup(dai->dev->parent,
> +						  hdmi_codec_abort);
>  		if (ret) {
>  			mutex_lock(&hcp->current_stream_lock);
>  			hcp->current_stream = NULL;
> 
