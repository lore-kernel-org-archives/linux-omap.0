From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: tps65217: fix nonstandard declaration
Date: Wed, 14 Sep 2016 09:37:48 +0100
Message-ID: <20160914083748.GB638@dell>
References: <20160914081402.802116-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160914081402.802116-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Marcin Niestroj <m.niestroj@grinn-global.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 14 Sep 2016, Arnd Bergmann wrote:

> The tps65217 gained a new warning when building with W=1:
> 
> drivers/mfd/tps65217.c:85:1: error: 'inline' is not at beginning of declaration [-Werror=old-style-declaration]
> 
> This fixes it by putting the 'inline' modifier before 'const'.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 262d5cc6ceb2 ("mfd: tps65217: Add support for IRQs")
> ---
>  drivers/mfd/tps65217.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

FYI: I plan to fix all W=1 and look at W=2 warnings today anyway.

> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 57c87412106f..9a4d8684dd32 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -82,7 +82,7 @@ static void tps65217_irq_sync_unlock(struct irq_data *data)
>  	mutex_unlock(&tps->irq_lock);
>  }
>  
> -static const inline struct tps65217_irq *
> +static inline const struct tps65217_irq *
>  irq_to_tps65217_irq(struct tps65217 *tps, struct irq_data *data)
>  {
>  	return &tps65217_irqs[data->hwirq];

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
