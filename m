From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: Return proper error for omap3pandora_soc_init
Date: Wed, 24 Nov 2010 10:33:38 +0200
Message-ID: <20101124103338.76d4b5f5.jhnikula@gmail.com>
References: <1290583248.20639.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290583248.20639.1.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 24 Nov 2010 15:20:48 +0800
Axel Lin <axel.lin@gmail.com> wrote:

> Return PTR_ERR(omap3pandora_dac_reg) instead of 0 if regulator_get failed.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/omap/omap3pandora.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
> index bff9864..8047c52 100644
> --- a/sound/soc/omap/omap3pandora.c
> +++ b/sound/soc/omap/omap3pandora.c
> @@ -307,6 +307,7 @@ static int __init omap3pandora_soc_init(void)
>  		pr_err(PREFIX "Failed to get DAC regulator from %s: %ld\n",
>  			dev_name(&omap3pandora_snd_device->dev),
>  			PTR_ERR(omap3pandora_dac_reg));
> +		ret = PTR_ERR(omap3pandora_dac_reg);
>  		goto fail3;
>  	}

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
