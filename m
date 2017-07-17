From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 3/6] ASoC: codec: cpcap: new codec
Date: Mon, 17 Jul 2017 02:29:29 -0700
Message-ID: <20170717092928.GH10026@atomide.com>
References: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
 <20170712151846.24621-4-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170712151846.24621-4-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170712 08:19]:
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 6c78b0b49b81..1615e5acc8fd 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -401,6 +401,11 @@ config SND_SOC_ALC5632
>  config SND_SOC_BT_SCO
>  	tristate "Dummy BT SCO codec driver"
>  
> +config SND_SOC_CPCAP
> +	tristate "Motorola CPCAP codec"
> +	depends on MFD_CPCAP
> +	default MFD_CPCAP
> +

Should it also have depends on SND_AUDIO_GRAPH_CARD?

Tony
