From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/9] OMAP4: 4430sdp: Register platform device for
 OMAP4 audio
Date: Thu, 22 Dec 2011 11:37:36 -0800
Message-ID: <20111222193736.GR24444@atomide.com>
References: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com>
 <1324582474-18181-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19931 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753561Ab1LVThn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Dec 2011 14:37:43 -0500
Content-Disposition: inline
In-Reply-To: <1324582474-18181-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [111222 11:03]:
> To avoid breakage in audio support with the coming change
> in ASoC machine driver (conversion to platfrom device).
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/board-4430sdp.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 21b62bd..394cbab 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -41,6 +41,7 @@
>  #include <video/omap-panel-nokia-dsi.h>
>  #include <video/omap-panel-picodlp.h>
>  #include <linux/wl12xx.h>
> +#include <linux/platform_data/omap-abe-twl6040.h>
>  
>  #include "mux.h"
>  #include "hsmmc.h"
> @@ -377,12 +378,38 @@ static struct platform_device sdp4430_dmic_codec = {
>  	.id	= -1,
>  };
>  
> +static struct omap_abe_twl6040_data sdp4430_abe_audio_data = {
> +	.card_name = "SDP4430",
> +	.has_hs		= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
> +	.has_hf		= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
> +	.has_ep		= 1,
> +	.has_aux	= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
> +	.has_vibra	= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
> +
> +	.has_dmic	= 1,
> +	.has_hsmic	= 1,
> +	.has_mainmic	= 1,
> +	.has_submic	= 1,
> +	.has_afm	= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
> +
> +	.jack_detection = 1,
> +};
> +
> +static struct platform_device sdp4430_abe_audio = {
> +	.name		= "omap-abe-twl6040",
> +	.id		= -1,
> +	.dev = {
> +		.platform_data = &sdp4430_abe_audio_data,
> +	},
> +};
> +
>  static struct platform_device *sdp4430_devices[] __initdata = {
>  	&sdp4430_gpio_keys_device,
>  	&sdp4430_leds_gpio,
>  	&sdp4430_leds_pwm,
>  	&sdp4430_vbat,
>  	&sdp4430_dmic_codec,
> +	&sdp4430_abe_audio,
>  };
>  
>  static struct omap_musb_board_data musb_board_data = {
> -- 
> 1.7.8.1
> 
