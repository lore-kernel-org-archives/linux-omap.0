From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: pcf857x: cleanup irq_demux_work and use threaded irq
Date: Thu, 29 Aug 2013 19:24:11 +0200
Message-ID: <CACRpkdYqHmw13t0Qj19Ko9qvus80eykjt25iXT0GP1aKETP+gQ@mail.gmail.com>
References: <1377599455-9379-1-git-send-email-george.cherian@ti.com>
	<CACRpkdbME_M8_X=5OttSFKDknqVEKSZc+7u=VLM-T-g3c_uv6Q@mail.gmail.com>
	<521F5684.3090703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <521F5684.3090703@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Nikolay Balandin <n.a.balandin@gmail.com>, Grant Likely <grant.likely@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 29, 2013 at 4:11 PM, George Cherian <george.cherian@ti.com> wrote:
> On 8/29/2013 6:27 PM, Linus Walleij wrote:

>>>          int                     irq;            /* real irq number */
>>> +       int                     irq_mapped;     /* mapped gpio irqs  */
>>
>> This seems like an u32 or atleast unsigned, and state that its one
>> bit flag per IRQ. How many GPIO lines are there?
>
> pcf857x driver supports expanders with 8 and 16 gpio lines.

OK should be an u16 then?

>>>   static int pcf857x_irq_domain_map(struct irq_domain *domain, unsigned
>>> int virq,
>>>                                   irq_hw_number_t hw)
>>>   {
>>> +       struct pcf857x  *gpio = domain->host_data;
>>>          irq_set_chip_and_handler(virq,
>>>                                   &dummy_irq_chip,
>>>                                   handle_level_irq);
>>> +       set_irq_flags(virq, IRQF_VALID);
>>> +       gpio->irq_mapped |= (1 << hw);
>>
>> I'm a bit uneasy about this. It feels like its the irqdomain's
>> responsibility to keep track of whether an IRQ is mapped
>> or not.
>
> Mainly these expanders dont have an ier sort of registers and if at all the
> initial value is not set proper
> then it gives bad irq prints only once per changed bit for which there is no
> handler.
> Should I drop this in v2?

I don't know, I mean if it's causing a problem or filling the console
with error prints it is really annoying, and if there is nothing to do
about the condition then there is not much more we can do I guess.

But please take a second look.

Yours,
Linus Walleij
