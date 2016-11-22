From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/5] mfd: tps65217: Support an interrupt pin as the
 system wakeup
Date: Tue, 22 Nov 2016 15:49:19 +0000
Message-ID: <20161122154919.GE10134@dell.home>
References: <20161115130215.3301-1-woogyom.kim@gmail.com>
 <20161115130215.3301-6-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161115130215.3301-6-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 15 Nov 2016, Milo Kim wrote:

> TPS65217 INT pin is used for the system wakeup from suspend mode.
> This patch enables push button or charger input event as a wakeup source.
> 
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  drivers/mfd/tps65217.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 7376090..f769c7d 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -183,6 +183,8 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
>  		return ret;
>  	}
>  
> +	enable_irq_wake(irq);
> +
>  	return 0;
>  }
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
