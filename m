From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH v2] clocksource: ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP
 flag for non-am43 SoCs
Date: Tue, 28 Aug 2018 17:14:00 +0530
Message-ID: <12b80b5f-3dd8-793e-75b2-94d2a0248d3e@ti.com>
References: <1533734099-1398-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533734099-1398-1-git-send-email-j-keerthy@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, tglx@linutronix.de
Cc: lokeshvutla@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, baolin.wang@linaro.org, d-gerlach@ti.com, tony@atomide.com, grygorii.strashko@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On 8/8/2018 6:44 PM, Keerthy wrote:
> The 32k clocksource is NONSTOP for non-am43 SoCs. Hence
> add the flag for all the other SoCs.

A gentle ping on this one.

> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes in v2:
> 
>    * Changed am43 compatible to more generic ti,am43 to cover epos boards.
>    * Added Tony's Ack.
> 
>   drivers/clocksource/timer-ti-32k.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
> index 29e2e1a..dd09171 100644
> --- a/drivers/clocksource/timer-ti-32k.c
> +++ b/drivers/clocksource/timer-ti-32k.c
> @@ -97,6 +97,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
>   		return -ENXIO;
>   	}
>   
> +	if (!of_machine_is_compatible("ti,am43"))
> +		ti_32k_timer.cs.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
> +
>   	ti_32k_timer.counter = ti_32k_timer.base;
>   
>   	/*
> 
