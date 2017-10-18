From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] input: touchscreen: ti_am335x_tsc: Fix incorrect step
 config for 5 wire touchscreen
Date: Wed, 18 Oct 2017 07:18:11 +0200
Message-ID: <CAOf5uwmrx_AepsovxBmA5ko76tODLSc3ZLmSOj2d8jxEo-f0cg@mail.gmail.com>
References: <20170919062906.501-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20170919062906.501-1-vigneshr@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi

On Tue, Sep 19, 2017 at 8:29 AM, Vignesh R <vigneshr@ti.com> wrote:
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
>                 break;
>         case 5:
>                 config |= ts_dev->bit_xp | STEPCONFIG_INP_AN4 |
> -                               ts_dev->bit_xn | ts_dev->bit_yp;
> +                               STEPCONFIG_XNP | STEPCONFIG_YPN;
>                 break;
>         case 8:
>                 config |= ts_dev->bit_yp | STEPCONFIG_INP(ts_dev->inp_xp);
> --

Looks sane to me.

Michael

> 2.14.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
