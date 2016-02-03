From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 3/4] pwm: omap-dmtimer: round load and match values rather
 than truncate
Date: Wed, 3 Feb 2016 11:24:55 +0100
Message-ID: <56B1D577.6070808@baylibre.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
 <1454128014-22866-4-git-send-email-drivshin.allworx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1454128014-22866-4-git-send-email-drivshin.allworx@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 01/30/2016 05:26 AM, David Rivshin (Allworx) wrote:
> From: David Rivshin <drivshin@allworx.com>
> 
> When converting period and duty_cycle from nanoseconds to fclk cycles,
> the error introduced by the integer division can be appreciable, especially
> in the case of slow fclk or short period. Use DIV_ROUND_CLOSEST_ULL() so
> that the error is kept to +/- 0.5 clock cycles.
> 
> Fixes: 6604c6556db9 ("pwm: Add PWM driver for OMAP using dual-mode timers")
> Signed-off-by: David Rivshin <drivshin@allworx.com>

OK for me.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks !

> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> index 103d729..8c9953c 100644
> --- a/drivers/pwm/pwm-omap-dmtimer.c
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> @@ -49,11 +49,7 @@ to_pwm_omap_dmtimer_chip(struct pwm_chip *chip)
>  
>  static u32 pwm_omap_dmtimer_get_clock_cycles(unsigned long clk_rate, int ns)
>  {
> -	u64 c = (u64)clk_rate * ns;
> -
> -	do_div(c, NSEC_PER_SEC);
> -
> -	return c;
> +	return DIV_ROUND_CLOSEST_ULL((u64)clk_rate * ns, NSEC_PER_SEC);
>  }
>  
>  static void pwm_omap_dmtimer_start(struct pwm_omap_dmtimer_chip *omap)
> 
