From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 08/18] mfd: twl4030-audio: Make it explicitly non-modular
Date: Fri, 20 Dec 2019 10:43:41 +0200
Message-ID: <b9d0151b-b2cd-c75b-f146-db00b372354c@ti.com>
References: <1576702137-25905-1-git-send-email-paul.gortmaker@windriver.com>
 <1576702137-25905-9-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1576702137-25905-9-git-send-email-paul.gortmaker@windriver.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 18/12/2019 22.48, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/mfd/Kconfig:config MFD_TWL4030_AUDIO
> drivers/mfd/Kconfig:    bool "TI TWL4030 Audio"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
> 
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/mfd/twl4030-audio.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
> index 4536d829b43e..7612997e3b86 100644
> --- a/drivers/mfd/twl4030-audio.c
> +++ b/drivers/mfd/twl4030-audio.c
> @@ -8,7 +8,7 @@
>   * Copyright:   (C) 2009 Nokia Corporation
>   */
>  
> -#include <linux/module.h>
> +#include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
> @@ -258,32 +258,17 @@ static int twl4030_audio_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int twl4030_audio_remove(struct platform_device *pdev)
> -{
> -	mfd_remove_devices(&pdev->dev);
> -	twl4030_audio_dev = NULL;
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id twl4030_audio_of_match[] = {
>  	{.compatible = "ti,twl4030-audio", },
>  	{ },
>  };
> -MODULE_DEVICE_TABLE(of, twl4030_audio_of_match);
>  
>  static struct platform_driver twl4030_audio_driver = {
>  	.driver		= {
>  		.name	= "twl4030-audio",
>  		.of_match_table = twl4030_audio_of_match,
> +		.suppress_bind_attrs = true,
>  	},
>  	.probe		= twl4030_audio_probe,
> -	.remove		= twl4030_audio_remove,
>  };
> -
> -module_platform_driver(twl4030_audio_driver);
> -
> -MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
> -MODULE_DESCRIPTION("TWL4030 audio block MFD driver");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:twl4030-audio");
> +builtin_platform_driver(twl4030_audio_driver);
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
