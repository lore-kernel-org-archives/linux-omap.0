From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [RESEND PATCH] gpio: omap: Fix lost edge interrupts
Date: Sat, 7 Oct 2017 19:34:14 -0700
Message-ID: <fe58a38c-6fa7-793d-ffd8-427f25c26770@oracle.com>
References: <20171003161705.23398-1-grygorii.strashko@ti.com>
 <CACRpkdYj1+_J+-EN6QQOJzWzXNB_3N6hPPfa1sqzERZb8gsdLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYj1+_J+-EN6QQOJzWzXNB_3N6hPPfa1sqzERZb8gsdLw@mail.gmail.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ladislav Michl <ladis@linux-mips.org>
List-Id: linux-omap@vger.kernel.org

On 10/7/17 4:18 AM, Linus Walleij wrote:
> On Tue, Oct 3, 2017 at 6:17 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
> 
>> Now acking of edge irqs happens the following way:
>> - omap_gpio_irq_handler
>>    - "isr" = read irq status
>>    - omap_clear_gpio_irqbank(bank, isr_saved & ~level_mask);
>>          ^ clear edge status, so irq can be accepted
>>    - loop while "isr"
>>          generic_handle_irq()
>>           - handle_edge_irq()
>>              - desc->irq_data.chip->irq_ack(&desc->irq_data);
>>                  - omap_gpio_ack_irq()
>> it might be that at this moment edge IRQ was triggered again and it will be
>> cleared and IRQ will be lost.
>>
>> Use handle_simple_irq and clear edge interrupts early without disabling them in
>> omap_gpio_irq_handler to avoid loosing interrupts.
>>
>> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Domap-26m-3D149004465313534-26w-3D2&d=DwIBaQ&c=RoP1YumCXCgaWHvlZYR8PQcxBKCX5YTpkKY057SbK10&r=XBn1JQGPwR8CsE7xpP3wPlG6DQU7qw8ym65xieNZ4hY&m=GC9UD4RPcq1Ss-JanXn4japAFhT1w4RZlq9WqDLSw_o&s=smHFYjIN3O5THK4qP413bHMnr8PaWUv4xyUbbTwXHk4&e=

This link doesn't need to be part of the changelog.

>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> 
> Patch applied for fixes.
> 
> I guess it is the right thing to do?
> 
> Other maintainers need to tell me if I should hold it back.
> 
Am fine with it after Grygorii's reasoning.

Regards,
Santosh

