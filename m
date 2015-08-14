From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH RFC v3 6/7] drm/i2c: tda998x: Register ASoC HDMI codec
 for audio functionality
Date: Fri, 14 Aug 2015 11:06:16 +0100
Message-ID: <20150814100616.GH7576@n2100.arm.linux.org.uk>
References: <cover.1439542916.git.jsarha@ti.com>
 <1e8e3215caa932dab68de8576aee81f5e1008163.1439542916.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1e8e3215caa932dab68de8576aee81f5e1008163.1439542916.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 14, 2015 at 12:30:44PM +0300, Jyri Sarha wrote:
> +static int tda998x_write_aif(struct tda998x_priv *priv,
> +			     struct hdmi_audio_infoframe *cea)
> +{
> +	uint8_t buf[HDMI_INFOFRAME_SIZE(AUDIO)];
> +	int len;
> +
> +	len = hdmi_audio_infoframe_pack(cea, buf, sizeof(buf));
> +	if (len < 0) {
> +		dev_err(&priv->hdmi->dev,
> +			"Failed to pack audio infoframe: %d\n", len);
> +		return len;
> +	}
> +
> +	/* Write the audio information packet */
> +	tda998x_write_if(priv, DIP_IF_FLAGS_IF4, REG_IF4_HB0, buf, len);
> +	return 0;
> +}
> +

I have such a function already queued up, but I can't push it out at the
moment because of too many conflicts across all my DRM work.  I'm waiting
for after 4.3-rc1 before publishing anything from or accepting anything
else into DRM branches.

>  static void
>  tda998x_write_avi(struct tda998x_priv *priv, struct drm_display_mode *mode)
>  {
> @@ -670,19 +691,24 @@ static void tda998x_audio_mute(struct tda998x_priv *priv, bool on)
>  	}
>  }
>  
> -static void
> +static int
>  tda998x_configure_audio(struct tda998x_priv *priv,
> -		struct drm_display_mode *mode, struct tda998x_encoder_params *p)
> +			int mode_clock,
> +			int ena_ap,
> +			int dai_format,
> +			int sample_width,
> +			int sample_rate,
> +			const u8 *status)

I don't think this is an improvement.

> +static int tda998x_audio_get_eld(struct device *dev, uint8_t *buf, size_t len)
> +{
> +	struct tda998x_priv *priv = dev_get_drvdata(dev);
> +	struct drm_mode_config *config = &priv->encoder->dev->mode_config;
> +	struct drm_connector *connector;
> +	int ret = -ENODEV;
> +
> +	mutex_lock(&config.mutex);
> +	list_for_each_entry(connector, &config->connector_list, head) {
> +		if (priv->encoder == connector->encoder) {
> +			memcpy(buf, connector->eld, 
> +			       min(sizeof(connector->eld), len));
> +			ret = 0;
> +		}
> +	}
> +	mutex_unlock(&config.mutex);

Obviously untested.  Should be config->mutex.

But in any case, when I kill the DRM slave encoder code in here, this
becomes unnecessary.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
