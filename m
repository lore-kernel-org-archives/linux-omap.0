From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3] irqchip: omap-intc: add support for spurious irq
 handling
Date: Mon, 4 Jan 2016 14:05:33 +0530
Message-ID: <568A2ED5.9060704@ti.com>
References: <9c78a6db02ac55f7af7371b417b6e414d2c3095b.1450188128.git.nsekhar@ti.com>
 <20151215152842.GR23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151215152842.GR23396@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, John Ogness <john.ogness@linutronix.de>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Thomas,

On Tuesday 15 December 2015 08:58 PM, Tony Lindgren wrote:
> * Sekhar Nori <nsekhar@ti.com> [151215 06:26]:
>> Under some conditions, irq sorting procedure used
>> by INTC can go wrong resulting in a spurious irq
>> getting reported.
>>
>> If this condition is not handled, it results in
>> endless stream of:
>>
>>     unexpected IRQ trap at vector 00
>>
>> messages from ack_bad_irq()
>>
>> Handle the spurious interrupt condition in omap-intc
>> driver to prevent this.
>>
>> Measurements using kernel function profiler on AM335x
>> EVM running at 720MHz show that after this patch
>> omap_intc_handle_irq() takes about 37.4us against
>> 34us before this patch.
>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> Looks good to me, probably should get tagged Cc stable when
> committing:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Can you please apply this if it looks good?

Thanks,
Sekhar
