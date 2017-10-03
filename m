From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [RESEND PATCH] gpio: omap: Fix lost edge interrupts
Date: Tue, 3 Oct 2017 19:22:28 +0200
Message-ID: <20171003172228.2p5ebam7cpqrhmsa@lenoch>
References: <20171003161705.23398-1-grygorii.strashko@ti.com>
 <7b8f3c6a-0f4b-98ed-3887-91a01ed6cdbb@oracle.com>
 <81906eda-58ac-38e3-bc0a-8ead2b6aa8df@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <81906eda-58ac-38e3-bc0a-8ead2b6aa8df@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 03, 2017 at 11:52:01AM -0500, Grygorii Strashko wrote:
> Hi Santosh,
> 
> On 10/03/2017 11:41 AM, Santosh Shilimkar wrote:
> > 
> > 
> > On 10/3/2017 9:17 AM, Grygorii Strashko wrote:
> >> Now acking of edge irqs happens the following way:
> >> - omap_gpio_irq_handler
> >>    - "isr" = read irq status
> >>    - omap_clear_gpio_irqbank(bank, isr_saved & ~level_mask);
> >>     ^ clear edge status, so irq can be accepted
> >>    - loop while "isr"
> >>     generic_handle_irq()
> >>      - handle_edge_irq()
> >>         - desc->irq_data.chip->irq_ack(&desc->irq_data);
> >>         - omap_gpio_ack_irq()
> >> it might be that at this moment edge IRQ was triggered again and it 
> >> will be
> >> cleared and IRQ will be lost.
> >>
> >> Use handle_simple_irq and clear edge interrupts early without 
> >> disabling them in
> >> omap_gpio_irq_handler to avoid loosing interrupts.
> >>
> >> [1] 
> >> https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Domap-26m-3D149004465313534-26w-3D2&d=DwIBAg&c=RoP1YumCXCgaWHvlZYR8PQcxBKCX5YTpkKY057SbK10&r=XBn1JQGPwR8CsE7xpP3wPlG6DQU7qw8ym65xieNZ4hY&m=-JZAaXlsRBFYNqtZ-2KOemoupa4pL7ka9D3wKn6hX9o&s=c-1XuQUl3_1uYedoNhmY70xCO3fAftWB7cmFxgyC3j4&e= 
> >>
> >> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> >> ---
> >> Resend with proper cc list.
> >>
> > This was one of the concern I was thinking when GPIO IRQ conversion
> > was done. Grygorii since you did that conversion, can you please
> > check since I see now that the irq code is becoming increasingly
> > complex.
> 
> This patch was developed in coop with Ladislav and he intensively tested it and
> this patch actually simplifies IRQ handling. Also, OMAP driver parts which
> this patch touches are ancient.

Just for a reference, testing is described here:
https://marc.info/?l=linux-omap&m=149022183102208&w=2
But there's another missing piece to make edge irqs work on OMAPs:
https://marc.info/?l=linux-omap&m=149037823114641&w=2
Tony, what is the status of your patch? Perhaps we should spin-off
separate thread for it...

Best regards,
	ladis
