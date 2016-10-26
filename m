From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/7] mfd: tps65217: Fix mismatched interrupt number
Date: Wed, 26 Oct 2016 14:56:31 +0100
Message-ID: <20161026135631.GC13127@dell>
References: <20161021140106.21531-1-woogyom.kim@gmail.com>
 <20161021140106.21531-8-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161021140106.21531-8-woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 21 Oct 2016, Milo Kim wrote:

> Enum value of 'tps65217_irq_type' is not matched with DT parsed hwirq
> number[*].
> 
> The MFD driver gets the IRQ data by referencing hwirq, but the value is
> different. So, irq_to_tps65217_irq() returns mismatched IRQ data.
> Eventually, the power button driver enables not PB but USB interrupt
> when it is probed.
> 
> According to the TPS65217 register map[**], USB interrupt is the LSB.
> This patch synchronizes TPS65217 IRQ index.
> 
> [*]  include/dt-bindings/mfd/tps65217.h
> [**] http://www.ti.com/lit/ds/symlink/tps65217.pdf
> 
> Signed-off-by: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  include/linux/mfd/tps65217.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
> index 4ccda89..75a3a5f 100644
> --- a/include/linux/mfd/tps65217.h
> +++ b/include/linux/mfd/tps65217.h
> @@ -235,9 +235,9 @@ struct tps65217_bl_pdata {
>  };
>  
>  enum tps65217_irq_type {
> -	TPS65217_IRQ_PB,
> -	TPS65217_IRQ_AC,
>  	TPS65217_IRQ_USB,
> +	TPS65217_IRQ_AC,
> +	TPS65217_IRQ_PB,
>  	TPS65217_NUM_IRQ
>  };

This is why using enum for these types of assignments is sometimes
dangerous.  It's probably best to be explicit.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
