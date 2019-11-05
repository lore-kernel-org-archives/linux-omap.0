From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH -next] thermal: ti-soc-thermal: Remove dev_err() on
 platform_get_irq() failure
Date: Tue, 5 Nov 2019 11:38:35 +0530
Message-ID: <655d95c2-20d2-e03f-539e-32fbe69da9fc@ti.com>
References: <20191102075654.36700-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191102075654.36700-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, edubezval@gmail.com, rui.zhang@intel.com, daniel.lezcano@linaro.org, amit.kucheria@verdurent.com
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 02/11/19 1:26 PM, YueHaibing wrote:
> platform_get_irq() will call dev_err() itself on failure,
> so there is no need for the driver to also do this.
> This is detected by coccinelle.

Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/thermal/ti-soc-thermal/ti-bandgap.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index 2fa78f7..89c3ba7 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -787,10 +787,9 @@ static int ti_bandgap_talert_init(struct ti_bandgap *bgp,
>   	int ret;
>   
>   	bgp->irq = platform_get_irq(pdev, 0);
> -	if (bgp->irq < 0) {
> -		dev_err(&pdev->dev, "get_irq failed\n");
> +	if (bgp->irq < 0)
>   		return bgp->irq;
> -	}
> +
>   	ret = request_threaded_irq(bgp->irq, NULL,
>   				   ti_bandgap_talert_irq_handler,
>   				   IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> 
