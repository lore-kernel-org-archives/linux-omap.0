From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] ASoC: codec: cpcap: new codec
Date: Mon, 10 Jul 2017 10:28:03 -0500
Message-ID: <20170710152803.d6622fxxaq4d7b46@rob-hp-laptop>
References: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
 <20170707164229.5868-2-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170707164229.5868-2-sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 07, 2017 at 06:42:27PM +0200, Sebastian Reichel wrote:
> Motorola CPCAP is a PMIC with audio functionality, that can be
> found on Motorola Droid 4 and probably a few other phones from
> Motorola's Droid series.
> 
> The driver has been written from scratch using Motorola's Android
> driver, register dumps from running Android and datasheet for NXP
> MC13783UG (which is similar to Motorola CPCAP, but not the same).
> 
> The chip provides two audio interfaces, that can be muxed to two
> different audio codecs. One provides support for stereo output
> (named StDAC or HiFi), while the other only provides mono output
> (named Voice). Only the Voice codec provides a Capture interface.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> ---
>  .../bindings/sound/motorola,cpcap-audio-codec.txt  |   19 +

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  sound/soc/codecs/Kconfig                           |    3 +
>  sound/soc/codecs/Makefile                          |    2 +
>  sound/soc/codecs/cpcap.c                           | 1422 ++++++++++++++++++++
>  4 files changed, 1446 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt
>  create mode 100644 sound/soc/codecs/cpcap.c
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
