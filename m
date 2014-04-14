From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCHv2 02/11] ARM: shmobile: Armadillo 800 EVA: initialize all
 struct pwm_lookup members
Date: Tue, 15 Apr 2014 07:58:22 +0900
Message-ID: <20140414225822.GG22518@verge.net.au>
References: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1397512793-10325-3-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397512793-10325-3-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Magnus Damm <magnus.damm@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Bryan Wu <cooloney@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 14, 2014 at 11:59:44PM +0200, Alexandre Belloni wrote:
> Initializing all the struct pwm_lookup members allows to get rid of the struct
> tpu_pwm_platform_data as the polarity initialization will be taken care of by
> the PWM core.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


This looks good to me.
Please let me know when the driver code has been merged and
I'll take this patch. Likewise for the other shmobile patch in this series.

> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index 2858f380beae..1bf61dad9a35 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -31,7 +31,7 @@
>  #include <linux/gpio_keys.h>
>  #include <linux/regulator/driver.h>
>  #include <linux/pinctrl/machine.h>
> -#include <linux/platform_data/pwm-renesas-tpu.h>
> +#include <linux/pwm.h>
>  #include <linux/pwm_backlight.h>
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/gpio-regulator.h>
> @@ -399,24 +399,22 @@ static struct resource pwm_resources[] = {
>  	},
>  };
>  
> -static struct tpu_pwm_platform_data pwm_device_data = {
> -	.channels[2] = {
> -		.polarity = PWM_POLARITY_INVERSED,
> -	}
> -};
> -
>  static struct platform_device pwm_device = {
>  	.name = "renesas-tpu-pwm",
>  	.id = -1,
> -	.dev = {
> -		.platform_data = &pwm_device_data,
> -	},
>  	.num_resources = ARRAY_SIZE(pwm_resources),
>  	.resource = pwm_resources,
>  };
>  
>  static struct pwm_lookup pwm_lookup[] = {
> -	PWM_LOOKUP("renesas-tpu-pwm", 2, "pwm-backlight.0", NULL),
> +	{
> +		.provider = "renesas-tpu-pwm",
> +		.index = 2,
> +		.dev_id = "pwm-backlight.0",
> +		.con_id = NULL,
> +		.period = 33333,
> +		.polarity = PWM_POLARITY_INVERSED,
> +	},
>  };
>  
>  /* LCDC and backlight */
> -- 
> 1.8.3.2
> 
