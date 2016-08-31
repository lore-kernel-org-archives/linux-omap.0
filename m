From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RESEND 1/2] mfd: twl6040: The chip does not support bulk
 access
Date: Wed, 31 Aug 2016 15:39:31 +0100
Message-ID: <20160831143931.GM9415@dell>
References: <20160831114621.6301-1-peter.ujfalusi@ti.com>
 <20160831114621.6301-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160831114621.6301-2-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 31 Aug 2016, Peter Ujfalusi wrote:

> Bulk access is not working with twl6040, we need to use single register
> access. Bulk access would happen when we try to sync the regcache after
> power on.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/mfd/twl6040.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> index ab328ec49353..c3ad59ef43dd 100644
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -609,6 +609,7 @@ static const struct regmap_config twl6040_regmap_config = {
>  	.writeable_reg = twl6040_writeable_reg,
>  
>  	.cache_type = REGCACHE_RBTREE,
> +	.use_single_rw = true,
>  };
>  
>  static const struct regmap_irq twl6040_irqs[] = {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
