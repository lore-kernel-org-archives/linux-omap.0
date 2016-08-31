From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH v2 0/3] drm/i2c: tda998x ASoC hdmi-codec support +
 BeagleBoneBlack audio support
Date: Wed, 31 Aug 2016 13:41:14 +0100
Message-ID: <20160831124113.GZ5783@n2100.arm.linux.org.uk>
References: <cover.1470754071.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1470754071.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 09, 2016 at 10:00:03PM +0300, Jyri Sarha wrote:
> Changes since first version [1] of this series:
> - "drm/i2c: tda998x: Improve tda998x_configure_audio() audio related pdata"
>   - Change audio in tda998x pdata to audio_params to match the naming in
>     private data struct
>   - Skip IEC958_AES2 byte when writing status bytes to registers 
>   - Turn AFMT-macros to enum
>   - include linux/hdmi.h in drm/i2c/tda998x.h
> - "drm/i2c: tda998x: Register ASoC hdmi-codec and add audio DT binding"
>   - Fix macronaming naming in dt-bindings/display/tda998x.h
>   - Turn AFMT-macros to enum
>   - Add locking to protect access to audio registers from ASoC thread
> - "dts/am335x-boneblack: SQUASH"
>   - Use corrected macros from dt-bindings/display/tda998x.h

Thanks, series queued.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
