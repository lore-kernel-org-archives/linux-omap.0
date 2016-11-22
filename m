From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/5] mfd: tps65217: Update register interrupt mask bits
 instead of writing operation
Date: Tue, 22 Nov 2016 15:46:51 +0000
Message-ID: <20161122154651.GC10134@dell.home>
References: <20161115130215.3301-1-woogyom.kim@gmail.com>
 <20161115130215.3301-4-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161115130215.3301-4-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 15 Nov 2016, Milo Kim wrote:

> TPS65217 interrupt register includes read/writeable mask bits with
> read-only status bits. (bit 4, 5, 6 are R/W, bit 0, 1, 2 are RO)
> And reserved bit is not required.
> 
> Register update operation is preferred for disabling all interrupts during
> the device initialisation.
> 
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  drivers/mfd/tps65217.c       | 7 +++----
>  include/linux/mfd/tps65217.h | 3 ++-
>  2 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 77fb812..9d76de9 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -189,10 +189,9 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
>  	tps->irq = irq;
>  
>  	/* Mask all interrupt sources */
> -	tps->irq_mask = (TPS65217_INT_RESERVEDM | TPS65217_INT_PBM
> -			| TPS65217_INT_ACM | TPS65217_INT_USBM);
> -	tps65217_reg_write(tps, TPS65217_REG_INT, tps->irq_mask,
> -			TPS65217_PROTECT_NONE);
> +	tps->irq_mask = TPS65217_INT_MASK;
> +	tps65217_set_bits(tps, TPS65217_REG_INT, TPS65217_INT_MASK,
> +			  TPS65217_INT_MASK, TPS65217_PROTECT_NONE);
>  
>  	tps->irq_domain = irq_domain_add_linear(tps->dev->of_node,
>  		TPS65217_NUM_IRQ, &tps65217_irq_domain_ops, tps);
> diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
> index 3cbec4b..35d8d64 100644
> --- a/include/linux/mfd/tps65217.h
> +++ b/include/linux/mfd/tps65217.h
> @@ -73,13 +73,14 @@
>  #define TPS65217_PPATH_AC_CURRENT_MASK	0x0C
>  #define TPS65217_PPATH_USB_CURRENT_MASK	0x03
>  
> -#define TPS65217_INT_RESERVEDM		BIT(7)
>  #define TPS65217_INT_PBM		BIT(6)
>  #define TPS65217_INT_ACM		BIT(5)
>  #define TPS65217_INT_USBM		BIT(4)
>  #define TPS65217_INT_PBI		BIT(2)
>  #define TPS65217_INT_ACI		BIT(1)
>  #define TPS65217_INT_USBI		BIT(0)
> +#define TPS65217_INT_MASK		(TPS65217_INT_PBM | TPS65217_INT_ACM | \
> +					TPS65217_INT_USBM)
>  
>  #define TPS65217_CHGCONFIG0_TREG	BIT(7)
>  #define TPS65217_CHGCONFIG0_DPPM	BIT(6)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
