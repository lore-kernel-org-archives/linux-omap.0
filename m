From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RESEND PATCH] gpio: omap: Fix lost edge interrupts
Date: Sat, 7 Oct 2017 13:18:22 +0200
Message-ID: <CACRpkdYj1+_J+-EN6QQOJzWzXNB_3N6hPPfa1sqzERZb8gsdLw@mail.gmail.com>
References: <20171003161705.23398-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171003161705.23398-1-grygorii.strashko@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ladislav Michl <ladis@linux-mips.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 3, 2017 at 6:17 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> Now acking of edge irqs happens the following way:
> - omap_gpio_irq_handler
>   - "isr" = read irq status
>   - omap_clear_gpio_irqbank(bank, isr_saved & ~level_mask);
>         ^ clear edge status, so irq can be accepted
>   - loop while "isr"
>         generic_handle_irq()
>          - handle_edge_irq()
>             - desc->irq_data.chip->irq_ack(&desc->irq_data);
>                 - omap_gpio_ack_irq()
> it might be that at this moment edge IRQ was triggered again and it will be
> cleared and IRQ will be lost.
>
> Use handle_simple_irq and clear edge interrupts early without disabling them in
> omap_gpio_irq_handler to avoid loosing interrupts.
>
> [1] https://marc.info/?l=linux-omap&m=149004465313534&w=2
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Patch applied for fixes.

I guess it is the right thing to do?

Other maintainers need to tell me if I should hold it back.

Yours,
Linus Walleij
