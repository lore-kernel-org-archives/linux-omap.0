From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/2] ARM: omap: timers: reduce rating of gp_timer
 clocksource
Date: Tue, 29 Nov 2016 10:43:06 -0600
Message-ID: <d3a71d3d-3015-bb1f-80a4-4bb9adecaa4c@ti.com>
References: <1479968355-18860-1-git-send-email-j-keerthy@ti.com>
 <1479968355-18860-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479968355-18860-2-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, tony@atomide.com
Cc: t-kristo@ti.com, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org



On 11/24/2016 12:19 AM, Keerthy wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
>
> Now ARM Global timer (rating 300) will not be selected as clocksource,
> because it's initialized after OMAP GP Timer (rating 300) and
> Timekeeping core will not allow to replace clocksource with new one if
> both of them have the same rating.
>
> Reduce rating of OMAP GP Timer (300->290) when it's used as
> clocksource device - this will allow to select ARM Global timer (300)
> as clocksource when enabled.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Unfortunately, this patch has dependency [1] and can't be used alone as
it will cause ARM Global timer to be selected as clocksource
always on am437x and this will kill cpuidle, because ARM Global timer
is not in always_on domain.

The intention of enabling ARM Global timer is only for non-pm aware use
cases for RT-kernel latency improvement - where deep cpuidle states are 
not enabled.

[1] https://patchwork.kernel.org/patch/8940051/

> ---
>  arch/arm/mach-omap2/timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index b2f2448..a0dbb0b 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -376,7 +376,7 @@ static cycle_t clocksource_read_cycles(struct clocksource *cs)
>  }
>
>  static struct clocksource clocksource_gpt = {
> -	.rating		= 300,
> +	.rating		= 290,
>  	.read		= clocksource_read_cycles,
>  	.mask		= CLOCKSOURCE_MASK(32),
>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>

-- 
regards,
-grygorii
