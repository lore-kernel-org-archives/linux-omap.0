From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] davinci_emac: always build in CONFIG_OF code
Date: Thu, 7 Mar 2019 08:16:58 -0700
Message-ID: <20190307151658.GB20201@archlinux-ryzen>
References: <20190307093135.3354493-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307093135.3354493-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>, Nick Desaulniers <ndesaulniers@google.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 07, 2019 at 10:31:20AM +0100, Arnd Bergmann wrote:
> clang warns about what seems to be an unintended use of an obscure C
> language feature where a forward declaration of an array remains usable
> when the final definition is never seen:
> 
> drivers/net/ethernet/ti/davinci_emac.c:1694:34: error: tentative array definition assumed to have one element [-Werror]
> static const struct of_device_id davinci_emac_of_match[];
> 
> There is no harm in always enabling the device tree matching code here,
> and it makes the code behave in a more conventional way aside from
> avoiding the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/net/ethernet/ti/davinci_emac.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> index 840820402cd0..57450b174fc4 100644
> --- a/drivers/net/ethernet/ti/davinci_emac.c
> +++ b/drivers/net/ethernet/ti/davinci_emac.c
> @@ -2029,7 +2029,6 @@ static const struct dev_pm_ops davinci_emac_pm_ops = {
>  	.resume		= davinci_emac_resume,
>  };
>  
> -#if IS_ENABLED(CONFIG_OF)
>  static const struct emac_platform_data am3517_emac_data = {
>  	.version		= EMAC_VERSION_2,
>  	.hw_ram_addr		= 0x01e20000,
> @@ -2046,14 +2045,13 @@ static const struct of_device_id davinci_emac_of_match[] = {
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, davinci_emac_of_match);
> -#endif
>  
>  /* davinci_emac_driver: EMAC platform driver structure */
>  static struct platform_driver davinci_emac_driver = {
>  	.driver = {
>  		.name	 = "davinci_emac",
>  		.pm	 = &davinci_emac_pm_ops,
> -		.of_match_table = of_match_ptr(davinci_emac_of_match),
> +		.of_match_table = davinci_emac_of_match,
>  	},
>  	.probe = davinci_emac_probe,
>  	.remove = davinci_emac_remove,
> -- 
> 2.20.0
> 
