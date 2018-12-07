From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v2] tps65218: Use devm_regmap_add_irq_chip and clean up
 error path in probe
Date: Fri, 7 Dec 2018 08:15:10 +0100
Message-ID: <20181207071510.GA3465@lenoch>
References: <1544143788-22606-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544143788-22606-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, lee.jones@linaro.org, sebastian.reichel@collabora.com, Christian.Hohnstaedt@wago.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 07, 2018 at 06:19:48AM +0530, Keerthy wrote:
> Use devm_regmap_add_irq_chip and clean up error path in probe.
> Hence clean up the probe error path and the remove function.
> 
> Reported-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>   * Cleaned up remove function as well.

v3: Remove remove function? :)

>  drivers/mfd/tps65218.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 910f569..d2d4e3a 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -235,9 +235,9 @@ static int tps65218_probe(struct i2c_client *client,
>  
>  	mutex_init(&tps->tps_lock);
>  
> -	ret = regmap_add_irq_chip(tps->regmap, tps->irq,
> -			IRQF_ONESHOT, 0, &tps65218_irq_chip,
> -			&tps->irq_data);
> +	ret = devm_regmap_add_irq_chip(&client->dev, tps->regmap, tps->irq,
> +				       IRQF_ONESHOT, 0, &tps65218_irq_chip,
> +				       &tps->irq_data);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -253,23 +253,11 @@ static int tps65218_probe(struct i2c_client *client,
>  			      ARRAY_SIZE(tps65218_cells), NULL, 0,
>  			      regmap_irq_get_domain(tps->irq_data));
>  
> -	if (ret < 0)
> -		goto err_irq;
> -
> -	return 0;
> -
> -err_irq:
> -	regmap_del_irq_chip(tps->irq, tps->irq_data);
> -
>  	return ret;
>  }
>  
>  static int tps65218_remove(struct i2c_client *client)
>  {
> -	struct tps65218 *tps = i2c_get_clientdata(client);
> -
> -	regmap_del_irq_chip(tps->irq, tps->irq_data);
> -
>  	return 0;
>  }
>  
> -- 
> 1.9.1
