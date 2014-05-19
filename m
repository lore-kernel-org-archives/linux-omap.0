From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 resend 04/11] ARM: OMAP3: Beagle: initialize all the
 struct pwm_lookup members
Date: Mon, 19 May 2014 13:49:54 -0700
Message-ID: <20140519204954.GD11945@atomide.com>
References: <1400532162-29483-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1400532162-29483-5-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400532162-29483-5-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Bryan Wu <cooloney@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Alexandre Belloni <alexandre.belloni@free-electrons.com> [140519 13:44]:
> This will allow to get rid of the .pwm_period_ns member of struct led_pwm as the
> period will be set by the PWM core.

This should not conflict with anything I have:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index d6ed819ff15c..f27e1ec90b5e 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -61,7 +61,14 @@
>  
>  static struct pwm_lookup pwm_lookup[] = {
>  	/* LEDB -> PMU_STAT */
> -	PWM_LOOKUP("twl-pwmled", 1, "leds_pwm", "beagleboard::pmu_stat"),
> +	{
> +		.provider = "twl-pwmled",
> +		.index = 1,
> +		.dev_id = "leds_pwm",
> +		.con_id = "beagleboard::pmu_stat",
> +		.period = 7812500,
> +		.polarity = PWM_POLARITY_NORMAL,
> +	},
>  };
>  
>  static struct led_pwm pwm_leds[] = {
> -- 
> 1.9.1
> 
