From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [RESEND PATCH] gpio: omap: Fix lost edge interrupts
Date: Tue, 3 Oct 2017 09:41:38 -0700
Message-ID: <7b8f3c6a-0f4b-98ed-3887-91a01ed6cdbb@oracle.com>
References: <20171003161705.23398-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171003161705.23398-1-grygorii.strashko@ti.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>
List-Id: linux-omap@vger.kernel.org



On 10/3/2017 9:17 AM, Grygorii Strashko wrote:
> Now acking of edge irqs happens the following way:
> - omap_gpio_irq_handler
>    - "isr" = read irq status
>    - omap_clear_gpio_irqbank(bank, isr_saved & ~level_mask);
> 	^ clear edge status, so irq can be accepted
>    - loop while "isr"
> 	generic_handle_irq()
> 	 - handle_edge_irq()
> 	    - desc->irq_data.chip->irq_ack(&desc->irq_data);
> 		- omap_gpio_ack_irq()
> it might be that at this moment edge IRQ was triggered again and it will be
> cleared and IRQ will be lost.
> 
> Use handle_simple_irq and clear edge interrupts early without disabling them in
> omap_gpio_irq_handler to avoid loosing interrupts.
> 
> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Domap-26m-3D149004465313534-26w-3D2&d=DwIBAg&c=RoP1YumCXCgaWHvlZYR8PQcxBKCX5YTpkKY057SbK10&r=XBn1JQGPwR8CsE7xpP3wPlG6DQU7qw8ym65xieNZ4hY&m=-JZAaXlsRBFYNqtZ-2KOemoupa4pL7ka9D3wKn6hX9o&s=c-1XuQUl3_1uYedoNhmY70xCO3fAftWB7cmFxgyC3j4&e=
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
> Resend with proper cc list.
> 
This was one of the concern I was thinking when GPIO IRQ conversion
was done. Grygorii since you did that conversion, can you please
check since I see now that the irq code is becoming increasingly
complex.

Regards,
Santosh

