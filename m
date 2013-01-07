From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: am33xx-hwmod: Fix wrongly terminated
 am33xx_usbss_mpu_irqs array
Date: Mon, 7 Jan 2013 12:03:38 -0800
Message-ID: <20130107200338.GD14149@atomide.com>
References: <1357252342-6166-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1357252342-6166-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Afzal Mohammed <afzal@ti.com>
List-Id: linux-omap@vger.kernel.org

* Pantelis Antoniou <panto@antoniou-consulting.com> [130103 14:35]:
> The IRQ array must be terminated by -1 and not by -1+OMAP_INTC_START
> This led to having a resource list of 100s of IRQs.

This is a bug for sure introduced with commit a2cfc509 (ARM: OMAP3+:
hwmod: Add AM33XX HWMOD data). Anybody care to ack this one?

Regards,

Tony
 
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 081c71e..e402303 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -2070,7 +2070,7 @@ static struct omap_hwmod_irq_info am33xx_usbss_mpu_irqs[] = {
>  	{ .name = "usbss-irq", .irq = 17 + OMAP_INTC_START, },
>  	{ .name = "musb0-irq", .irq = 18 + OMAP_INTC_START, },
>  	{ .name = "musb1-irq", .irq = 19 + OMAP_INTC_START, },
> -	{ .irq = -1 + OMAP_INTC_START, },
> +	{ .irq = -1, },
>  };
>  
>  static struct omap_hwmod am33xx_usbss_hwmod = {
> -- 
> 1.7.12
> 
