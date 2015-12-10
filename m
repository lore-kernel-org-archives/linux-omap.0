From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2] irqchip: omap-intc: add support for spurious irq
 handling
Date: Thu, 10 Dec 2015 20:46:50 +0530
Message-ID: <56699762.1030501@ti.com>
References: <0958510b69cf679fef64ccf535b1cdc43c5ffccc.1449572109.git.nsekhar@ti.com>
 <87mvtlm4ts.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87mvtlm4ts.fsf@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: John Ogness <john.ogness@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Tuesday 08 December 2015 07:15 PM, Felipe Balbi wrote:
> Sekhar Nori <nsekhar@ti.com> writes:

>> +	/*
>> +	 * A spurious IRQ can result if interrupt that triggered the
>> +	 * sorting is no longer active during the sorting (10 INTC
>> +	 * functional clock cycles after interrupt assertion). Or a
>> +	 * change in interrupt mask affected the result during sorting
>> +	 * time. There is no special handling required except ignoring
>> +	 * the SIR register value just read and retrying.
>> +	 * See section 6.2.5 of AM335x TRM Literature Number: SPRUH73K
>> +	 *
>> +	 * Many a times, a spurious interrupt situation has been fixed
>> +	 * by adding a flush for the posted write acking the IRQ in
>> +	 * the device driver. Typically, this is going be the device
>> +	 * driver whose interrupt was handled just before the spurious
>> +	 * IRQ occurred. Pay attention to those device drivers if you
>> +	 * run into hitting the spurious IRQ condition below.
>> +	 */
>> +	if ((irqnr & SPURIOUSIRQ_MASK) == SPURIOUSIRQ_MASK) {
> 
> sounds like unlikely() wouldn't hurt here.

I can add, but looks like it does not make a big difference. See below.

> 
>> +		pr_err_once("%s: spurious irq!\n", __func__);
>> +		irq_err_count++;
>> +		omap_ack_irq(NULL);
>> +		return;
>> +	}
>> +
>>  	irqnr &= ACTIVEIRQ_MASK;
>> -	WARN_ONCE(!irqnr, "Spurious IRQ ?\n");
>>  	handle_domain_irq(domain, irqnr, regs);
> 
> care to run kernel function profiler against omap_intc_handle_irq()
> before and after this patch ?

Before this patch I see average running time time of 34us. That
increases to 37.8us after this patch. With unlikely() the number I got
was 37.4us. So the benefit with unlikely() is in the noise range.

This was using AM335x EVM at 720 MHz.

Thanks,
Sekhar
