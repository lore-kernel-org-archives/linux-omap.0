From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [4.4-rc][PATCH] gpio: omap: drop omap1 mpuio specific
 irq_mask/unmask callbacks
Date: Fri, 20 Nov 2015 22:03:28 +0200
Message-ID: <20151120200328.GI18138@blackmetal.musicnaut.iki.fi>
References: <1448026514-21294-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448026514-21294-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, tony@atomide.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Nov 20, 2015 at 03:35:14PM +0200, Grygorii Strashko wrote:
> Originally OMAP MPUIO GPIO irqchip was implemented using Generic irq
> chip, but after set of reworks Generic irq chip code was replaced by
> common OMAP GPIO implementation and finally removed by
> commit d2d05c65c40e ("gpio: omap: Fix regression for MPUIO interrupts").
> Unfortunately, above commit left .irq_mask/unmask callbacks assigned
> as below for MPUIO GPIO case:
> 	irqc->irq_mask = irq_gc_mask_set_bit;
> 	irqc->irq_unmask = irq_gc_mask_clr_bit;
> 
> This now causes boot failure on OMAP1 platforms, after
> commit 450fa54cfd66 ("gpio: omap: convert to use generic irq handler")
> which forces these callbacks to be called during GPIO IRQs mapping
> from gpiochip_irq_map:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 75 [#1] ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.4.0-rc1-e3-los_afe0c+-00002-g25379c0-dirty #1
> Hardware name: Amstrad E3 (Delta)
> task: c1836000 ti: c1838000 task.ti: c1838000
> PC is at irq_gc_mask_set_bit+0x1c/0x60
> LR is at __irq_do_set_handler+0x118/0x15c
> pc : [<c004848c>]    lr : [<c0047d4c>]    psr: 600000d3
> sp : c1839c90  ip : c1862c64  fp : c1839c9c
> r10: 00000000  r9 : c0411950  r8 : c0411bbc
> r7 : 00000000  r6 : c185c310  r5 : c00444e8  r4 : c185c300
> r3 : c1854b50  r2 : 00000000  r1 : 00000000  r0 : c185c310
> Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
> Control: 0000317f  Table: 10004000  DAC: 00000057
> Process swapper (pid: 1, stack limit = 0xc1838190)
> Stack: (0xc1839c90 to 0xc183a000)
> 
> [...]
> 
> Backtrace:
> [<c0048470>] (irq_gc_mask_set_bit) from [<c0047d4c>] (__irq_do_set_handler+0x118/0x15c)
> [<c0047c34>] (__irq_do_set_handler) from [<c0047dd4>] (__irq_set_handler+0x44/0x5c)
>  r6:00000000 r5:c00444e8 r4:c185c300
> [<c0047d90>] (__irq_set_handler) from [<c0047e1c>] (irq_set_chip_and_handler_name+0x30/0x34)
>  r7:00000050 r6:00000000 r5:c00444e8 r4:00000050
> [<c0047dec>] (irq_set_chip_and_handler_name) from [<c01b345c>] (gpiochip_irq_map+0x3c/0x8c)
>  r7:00000050 r6:00000000 r5:00000050 r4:c1862c64
> [<c01b3420>] (gpiochip_irq_map) from [<c0049670>] (irq_domain_associate+0x7c/0x1c4)
>  r5:c185c310 r4:c185cb00
> [<c00495f4>] (irq_domain_associate) from [<c0049894>] (irq_domain_add_simple+0x98/0xc0)
>  r8:c0411bbc r7:c185cb00 r6:00000050 r5:00000010 r4:00000001
> [<c00497fc>] (irq_domain_add_simple) from [<c01b3328>] (_gpiochip_irqchip_add+0x64/0x10c)
>  r7:c1862c64 r6:c0419280 r5:c1862c64 r4:c1854b50
> [<c01b32c4>] (_gpiochip_irqchip_add) from [<c01b79f4>] (omap_gpio_probe+0x2fc/0x63c)
>  r5:c1854b50 r4:c1862c10
> [<c01b76f8>] (omap_gpio_probe) from [<c01fcf58>] (platform_drv_probe+0x2c/0x64)
>  r10:00000000 r9:c03e45e8 r8:00000000 r7:c0419294 r6:c0411984 r5:c0419294
>  r4:c0411950
> [<c01fcf2c>] (platform_drv_probe) from [<c01fb668>] (really_probe+0x160/0x29c)
> 
> Hence, fix it by remove obsolete callbacks assignment. After this
> change 	omap_gpio_mask_irq()/omap_gpio_unmask_irq() will be used
> for MPUIO IRQs masking, but this now happens anyway from
> omap_gpio_irq_startup/shutdown().
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Fixes: commit d2d05c65c40e ("gpio: omap: Fix regression for MPUIO interrupts")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

> ---
>  drivers/gpio/gpio-omap.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 56d2d02..f7fbb46 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1122,8 +1122,6 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
>  	/* MPUIO is a bit different, reading IRQ status clears it */
>  	if (bank->is_mpuio) {
>  		irqc->irq_ack = dummy_irq_chip.irq_ack;
> -		irqc->irq_mask = irq_gc_mask_set_bit;
> -		irqc->irq_unmask = irq_gc_mask_clr_bit;
>  		if (!bank->regs->wkup_en)
>  			irqc->irq_set_wake = NULL;
>  	}
> -- 
> 2.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
