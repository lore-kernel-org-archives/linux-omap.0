From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] IRQ: simplify OMAP2 mask_irq/unmask_irq code
Date: Wed, 21 May 2008 08:05:54 -0700
Message-ID: <20080521150554.GX23002@atomide.com>
References: <alpine.DEB.1.00.0805201915320.9463@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:49346 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbYEUPFw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 11:05:52 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805201915320.9463@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Kyungmin Park <kmpark@infradead.org>

Hi,

* Paul Walmsley <paul@pwsan.com> [080520 18:20]:
> 
> Modify mach-omap2/irq.c to simplify the IRQ number-to-IRQ register and IRQ 
> number-to-register bit calculations.

How about patching Jouni's new omap_irq_pending() for this too?

Tony

> Signed-off-by: Kyungmin Park <kmpark@infradead.org>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Acked-by: Paul Mundt <lethal@linux-sh.org>
> 
> size:
>    text    data     bss     dec     hex filename
> 3341347  170992  109008 3621347  3741e3 vmlinux.3430sdp
> 3341315  170992  109008 3621315  3741c3 vmlinux.3430sdp.patched
> ---
> 
>  arch/arm/mach-omap2/irq.c |   17 +++++++----------
>  1 files changed, 7 insertions(+), 10 deletions(-)
> 
> 
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index ac062ee..9300712 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -27,6 +27,9 @@
>  #define INTC_MIR_CLEAR0	0x0088
>  #define INTC_MIR_SET0	0x008c
>  
> +/* Number of IRQ state bits in each MIR register */
> +#define IRQ_BITS_PER_REG	32
> +
>  /*
>   * OMAP2 has a number of different interrupt controllers, each interrupt
>   * controller is identified as its own "bank". Register definitions are
> @@ -67,24 +70,18 @@ static void omap_ack_irq(unsigned int irq)
>  
>  static void omap_mask_irq(unsigned int irq)
>  {
> -	int offset = (irq >> 5) << 5;
> +	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
>  
> -	if (irq >= 64)
> -		irq %= 64;
> -	else if (irq >= 32)
> -		irq %= 32;
> +	irq &= (IRQ_BITS_PER_REG - 1);
>  
>  	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);
>  }
>  
>  static void omap_unmask_irq(unsigned int irq)
>  {
> -	int offset = (irq >> 5) << 5;
> +	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
>  
> -	if (irq >= 64)
> -		irq %= 64;
> -	else if (irq >= 32)
> -		irq %= 32;
> +	irq &= (IRQ_BITS_PER_REG - 1);
>  
>  	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_CLEAR0 + offset);
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
