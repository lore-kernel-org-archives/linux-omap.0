From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Return proper error for omap3pandora_soc_init
Date: Wed, 24 Nov 2010 10:49:10 +0000
Message-ID: <1290595750.3332.5.camel@odin>
References: <1290583248.20639.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61887 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280Ab0KXKtO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 05:49:14 -0500
In-Reply-To: <1290583248.20639.1.camel@mola>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org

On Wed, 2010-11-24 at 15:20 +0800, Axel Lin wrote:
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
>  

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

