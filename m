From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/i2c: tda998x: Register ASoC hdmi-codec and add
 audio DT binding
Date: Thu, 4 Aug 2016 15:07:13 +0100
Message-ID: <20160804140712.GO5783@n2100.arm.linux.org.uk>
References: <cover.1470129989.git.jsarha@ti.com>
 <ce10548e1c28270d80ee99a525e117d0d25f5656.1470129989.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ce10548e1c28270d80ee99a525e117d0d25f5656.1470129989.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 02, 2016 at 03:05:08PM +0300, Jyri Sarha wrote:
> +	memcpy(audio.status, params->iec.status,
> +	       min(sizeof(audio.status), sizeof(params->iec.status)));

As mentioned in the other patch, the audio status does not directly
correspond with the AES bytes, so this ends up causing the driver to
write the wrong bytes to the wrong registers.

> +	ret = tda998x_configure_audio(priv,
> +				      &audio,
> +				      priv->encoder.crtc->hwmode.clock);

What happens if audio changes at the same time that the video mode
changes?  What protection is there against two threads concurrently
executing tda998x_configure_audio() ?

> +	priv->audio_pdev = platform_device_register_data(
> +		dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
> +		&codec_data, sizeof(codec_data));

I'd much prefer that this was a child of the I2C device, which will
show the relationship between this virtual platform device and the
device which it's associated with.  That can be done via
platform_device_register_full().

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
