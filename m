From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC v5 4/8] drm/i2c: tda998x: Add support of a DT graph
 of ports
Date: Thu, 18 Feb 2016 08:35:30 -0600
Message-ID: <20160218143530.GB9654@rob-hp-laptop>
References: <cover.1455720381.git.jsarha@ti.com>
 <842e221030a0b14bc862790eb2f5bc97bb29c012.1455720381.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <842e221030a0b14bc862790eb2f5bc97bb29c012.1455720381.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 17, 2016 at 04:49:05PM +0200, Jyri Sarha wrote:
> From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> 
> Two kinds of ports may be declared in a DT graph of ports: video and audio.
> This patch accepts the port value from a video port as an alternative
> to the video-ports property.
> It also accepts audio ports in the case the transmitter is not used as
> a slave encoder.
> The new file include/sound/tda998x.h prepares to the definition of
> a tda998x CODEC.
> 
> Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/display/bridge/tda998x.txt | 51 ++++++++++++
>  drivers/gpu/drm/i2c/tda998x_drv.c                  | 90 +++++++++++++++++++---
>  include/sound/tda998x.h                            |  8 ++
>  3 files changed, 140 insertions(+), 9 deletions(-)
>  create mode 100644 include/sound/tda998x.h
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/tda998x.txt b/Documentation/devicetree/bindings/display/bridge/tda998x.txt
> index e9e4bce..35f6a80 100644
> --- a/Documentation/devicetree/bindings/display/bridge/tda998x.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/tda998x.txt
> @@ -16,6 +16,35 @@ Optional properties:
>  
>    - video-ports: 24 bits value which defines how the video controller
>  	output is wired to the TDA998x input - default: <0x230145>
> +	This property is not used when ports are defined.
> +
> +Optional nodes:
> +
> +  - port: up to three ports.
> +	The ports are defined according to [1].
> +
> +    Video port.
> +	There may be only one video port.
> +	This one must contain the following property:
> +
> +	- port-type: must be "rgb"

This should be implied from the port unit address. In other words, 
port@0 is defined to be the rgb port. Now, if this is one of several 
modes for the video port, then that is a different story.

> +	and may contain the optional property:
> +
> +	- reg: 24 bits value which defines how the video controller
> +		output is wired to the TDA998x input (video pins)
> +		When absent, the default value is <0x230145>.

This is not really how reg is intended to be used. Can you explain how 
this value is determined?

> +    Audio ports.
> +	There may be one or two audio ports.
> +	These ones must contain the following properties:
> +
> +	- port-type: must be "i2s" or "spdif"
> +
> +	- reg: 8 bits value which defines how the audio controller
> +		output is wired to the TDA998x input (audio pins)

Same here.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
