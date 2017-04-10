From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] mmc: host: omap_hsmmc: checking for NULL instead of
 IS_ERR()
Date: Mon, 10 Apr 2017 19:35:00 +0530
Message-ID: <93202f3b-e3c7-1593-3395-db4123cf6329@ti.com>
References: <20170410135417.GD1918@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20170410135417.GD1918@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andreas Fenkart <afenkart@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Ravikumar Kattekola <rk@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Heiner Kallweit <hkallweit1@gmail.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Monday 10 April 2017 07:24 PM, Dan Carpenter wrote:
> devm_pinctrl_get() returns error pointers, it never returns NULL.
> 
> Fixes: 455e5cd6f736 ("mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on AM335x")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

FWIW:
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index bf64cf23aa59..8c39dccacf39 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1761,8 +1761,8 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
>  	 */
>  	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
>  		struct pinctrl *p = devm_pinctrl_get(host->dev);
> -		if (!p) {
> -			ret = -ENODEV;
> +		if (IS_ERR(p)) {
> +			ret = PTR_ERR(p);
>  			goto err_free_irq;
>  		}
>  		if (IS_ERR(pinctrl_lookup_state(p, PINCTRL_STATE_DEFAULT))) {
> 
