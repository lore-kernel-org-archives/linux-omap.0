From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] mfd: twl-core: Fix clock initialization
Date: Fri, 6 Apr 2018 22:38:28 +0300
Message-ID: <8a06e6f0-3350-5cb0-48fa-3fd770421aca@ti.com>
References: <20180405114636.16294-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180405114636.16294-1-peter.ujfalusi@ti.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, lee.jones@linaro.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/05/2018 02:46 PM, Peter Ujfalusi wrote:
> When looking up the clock we must use the client->dev as device since that
> is the one which is probed via DT.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: stable@vger.kernel.org
> Fixes: 7e2e6c5758de9 ("mfd: twl-core: Do not create dummy pdata when booted with DT")

This is not correct, we should only apply it to v4.16 since things worked
before that with the drivers/clk/ti/clk-3xxx.c and
drivers/clk/ti/clk-3xxx-legacy.c

Switching device to look for the fck might fail in pre 4.16.

But if this is the case then we might want to rename the fck clock to the
correct hfclk.

On top of this patch a DT patch for the affected boards will be needed after
4.16 to define the hfclk clock (or if we do not rename it, the fck).

I'll send a v2 on Monday, but would like to hear your opinion on renaming fck
to hfclk from 4.16 onwards (and update the documentation as well). The DT
lookup is broken anyways w/o a patch similar to this.

-- 
Péter


> ---
>  drivers/mfd/twl-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index d3133a371e27..c649344fd7f2 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -1177,7 +1177,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	twl_priv->ready = true;
>  
>  	/* setup clock framework */
> -	clocks_init(&pdev->dev, pdata ? pdata->clock : NULL);
> +	clocks_init(&client->dev, pdata ? pdata->clock : NULL);
>  
>  	/* read TWL IDCODE Register */
>  	if (twl_class_is_4030()) {
> 


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
