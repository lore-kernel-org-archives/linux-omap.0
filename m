From: "Kim, Milo" <milo.kim@ti.com>
Subject: Re: [PATCH 2/7] mfd: lp8788: Use devm_mfd_add_devices and
 devm_regmap_add_irq_chip
Date: Fri, 22 Apr 2016 08:15:38 +0900
Message-ID: <57195F1A.7070506@ti.com>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
 <1461241558-26983-3-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1461241558-26983-3-git-send-email-ldewangan@nvidia.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, k.kozlowski@samsung.com
Cc: lee.jones@linaro.org, cw00.choi@samsung.com, sbkim73@samsung.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Laxman,

On 4/21/2016 9:25 PM, Laxman Dewangan wrote:
> Use devm_mfd_add_devices() for adding MFD child devices and
> devm_regmap_add_irq_chip() for IRQ chip registration.

This patch doesn't include the code regarding devm_mfd_add_devices(). 
Could you check it again? Or am I missing any previous patches?

>
> This reduces the error code path and .remove callback for removing
> MFD child devices and deleting IRQ chip data.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Milo Kim <milo.kim@ti.com>
> ---
>   drivers/mfd/lp8788-irq.c | 12 +++---------
>   drivers/mfd/lp8788.c     | 10 ----------
>   2 files changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mfd/lp8788-irq.c b/drivers/mfd/lp8788-irq.c
> index 792d51b..aacd39f 100644
> --- a/drivers/mfd/lp8788-irq.c
> +++ b/drivers/mfd/lp8788-irq.c
> @@ -175,9 +175,9 @@ int lp8788_irq_init(struct lp8788 *lp, int irq)
>   	lp->irqdm = irqd->domain;
>   	mutex_init(&irqd->irq_lock);
>
> -	ret = request_threaded_irq(irq, NULL, lp8788_irq_handler,
> -				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				"lp8788-irq", irqd);
> +	ret = devm_request_threaded_irq(lp->dev, irq, NULL, lp8788_irq_handler,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					"lp8788-irq", irqd);
>   	if (ret) {
>   		dev_err(lp->dev, "failed to create a thread for IRQ_N\n");
>   		return ret;
> @@ -187,9 +187,3 @@ int lp8788_irq_init(struct lp8788 *lp, int irq)
>
>   	return 0;
>   }
> -
> -void lp8788_irq_exit(struct lp8788 *lp)
> -{
> -	if (lp->irq)
> -		free_irq(lp->irq, lp->irqdm);
> -}
> diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
> index acf6165..37fea46 100644
> --- a/drivers/mfd/lp8788.c
> +++ b/drivers/mfd/lp8788.c
> @@ -203,15 +203,6 @@ static int lp8788_probe(struct i2c_client *cl, const struct i2c_device_id *id)
>   			       ARRAY_SIZE(lp8788_devs), NULL, 0, NULL);
>   }
>
> -static int lp8788_remove(struct i2c_client *cl)
> -{
> -	struct lp8788 *lp = i2c_get_clientdata(cl);
> -
> -	mfd_remove_devices(lp->dev);
> -	lp8788_irq_exit(lp);
> -	return 0;
> -}
> -
>   static const struct i2c_device_id lp8788_ids[] = {
>   	{"lp8788", 0},
>   	{ }
> @@ -223,7 +214,6 @@ static struct i2c_driver lp8788_driver = {
>   		.name = "lp8788",
>   	},
>   	.probe = lp8788_probe,
> -	.remove = lp8788_remove,
>   	.id_table = lp8788_ids,
>   };
>
>

Best regards,
Milo
