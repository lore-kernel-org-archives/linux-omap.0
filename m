From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/i2c: tda998x: Improve tda998x_configure_audio()
 audio related pdata
Date: Thu, 4 Aug 2016 14:31:36 +0100
Message-ID: <20160804133135.GN5783@n2100.arm.linux.org.uk>
References: <cover.1470129989.git.jsarha@ti.com>
 <5adcd94104080abcd5b072a5d6a85b85c5ea0584.1470129989.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5adcd94104080abcd5b072a5d6a85b85c5ea0584.1470129989.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 02, 2016 at 03:05:07PM +0300, Jyri Sarha wrote:
> @@ -787,19 +792,13 @@ tda998x_configure_audio(struct tda998x_priv *priv,
>  	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_CTS);
>  
>  	/* Write the channel status */
> -	buf[0] = IEC958_AES0_CON_NOT_COPYRIGHT;
> -	buf[1] = 0x00;
> -	buf[2] = IEC958_AES3_CON_FS_NOTID;
> -	buf[3] = IEC958_AES4_CON_ORIGFS_NOTID |
> -			IEC958_AES4_CON_MAX_WORDLEN_24;
> -	reg_write_range(priv, REG_CH_STAT_B(0), buf, 4);
> +	reg_write_range(priv, REG_CH_STAT_B(0), params->status, 4);

Take a close look at the code you are replacing here - the buffer
contents is not AES bytes 0, 1, 2, 3, 4, but AES bytes 0, 1, 3, 4
- byte 2 is not present in this array.  I don't think you've noticed
this as your second patch merely copies verboten the IEC status:

+       memcpy(audio.status, params->iec.status,
+              min(sizeof(audio.status), sizeof(params->iec.status)));

assuming that it is bytes 0-3.  Byte 2 is stored separately for each
I2S channel in the following registers.

> diff --git a/include/drm/i2c/tda998x.h b/include/drm/i2c/tda998x.h
> index 3e419d9..24be7aa 100644
> --- a/include/drm/i2c/tda998x.h
> +++ b/include/drm/i2c/tda998x.h
> @@ -1,6 +1,19 @@
>  #ifndef __DRM_I2C_TDA998X_H__
>  #define __DRM_I2C_TDA998X_H__
>  
> +#define AFMT_UNUSED	0
> +#define AFMT_SPDIF	1
> +#define AFMT_I2S	2

I'd prefer this to stay an enum please.

> +struct tda998x_audio_params {
> +	u8 config;
> +	u8 format;
> +	unsigned sample_width;
> +	unsigned sample_rate;
> +	struct hdmi_audio_infoframe cea;

With this addition, this file will need to include linux/hdmi.h.

> +	u8 status[4];

A comment here about the missing byte 2 would probably be a good idea.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
