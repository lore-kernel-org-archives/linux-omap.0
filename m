From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] input: touchscreen: ti_am335x_tsc: Fix incorrect step
 config for 5 wire touchscreen
Date: Wed, 18 Oct 2017 09:28:01 +0530
Message-ID: <b810fe2a-8cbd-b440-68c8-1d0dadd97725@ti.com>
References: <20170919062906.501-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170919062906.501-1-vigneshr@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 19 September 2017 11:59 AM, Vignesh R wrote:
> From: Jeff Lance <j-lance1@ti.com>
> 
> Step config setting for 5 wire touchscreen is incorrect for Y coordinates.
> It was broken while we moved to DT. If you look close at the offending
> commit bb76dc09ddfc ("input: ti_am33x_tsc: Order of TSC wires, made
> configurable"), the change was:
> 
> - STEPCONFIG_XNP | STEPCONFIG_YPN;
> + ts_dev->bit_xn | ts_dev->bit_yp;
> 
> while bit_xn = STEPCONFIG_XNN and bit_yp = STEPCONFIG_YNN. Not quite the
> same.
> 
> Fixes: bb76dc09ddfc ("input: ti_am33x_tsc: Order of TSC wires, made configurable")
> Signed-off-by: Jeff Lance <j-lance1@ti.com>
> [vigneshr@ti.com: Rebase to v4.14-rc1]
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> 

Gentle ping...


> Tested on AM335x EVM with 5 wire tsc module. Also sanity tested
> on a 4 wire tsc as well.
> 
>  drivers/input/touchscreen/ti_am335x_tsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 7953381d939a..f1043ae71dcc 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -161,7 +161,7 @@ static void titsc_step_config(struct titsc *ts_dev)
>  		break;
>  	case 5:
>  		config |= ts_dev->bit_xp | STEPCONFIG_INP_AN4 |
> -				ts_dev->bit_xn | ts_dev->bit_yp;
> +				STEPCONFIG_XNP | STEPCONFIG_YPN;
>  		break;
>  	case 8:
>  		config |= ts_dev->bit_yp | STEPCONFIG_INP(ts_dev->inp_xp);
> 

-- 
Regards
Vignesh
