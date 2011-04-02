From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [pm-core][PATCH v3 01/21] OMAP4: PM: Add omap WakeupGen module
 support
Date: Sat, 02 Apr 2011 15:10:04 +0530
Message-ID: <4D96EEF4.8000500@ti.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>	<1301304157-2466-2-git-send-email-santosh.shilimkar@ti.com> <BANLkTimWTX9HKhpkkjODCSEiuBNuV-rN-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:45908 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752704Ab1DBJkV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Apr 2011 05:40:21 -0400
Received: by gyg8 with SMTP id 8so1566011gyg.10
        for <linux-omap@vger.kernel.org>; Sat, 02 Apr 2011 02:40:20 -0700 (PDT)
In-Reply-To: <BANLkTimWTX9HKhpkkjODCSEiuBNuV-rN-g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

On 4/2/2011 11:40 AM, Colin Cross wrote:
> On Mon, Mar 28, 2011 at 2:22 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> This patch adds OMAP WakeupGen support. The WakeupGen unit is responsible
>> for generating wakeup event from the incoming interrupts and enable bits.
>> The WakeupGen is implemented in MPU Always-On power domain. During normal
>> operation, WakeupGen delivers external interrupts directly to the GIC.
>> When the CPUx asserts StandbyWFI, indicating it wants to enter lowpower
>> state, the Standby Controller checks with the WakeupGen unit using the
>> idlereq/idleack handshake to make sure there is no incoming interrupts.
>> The GIC and WakeupGen needs to be kept in synchronisation for proper
>> interrupt functioning.
>>
>> Hence this patch hooks up the omap WakeupGen mask/unmask along with GIC using
>> architecture specific hooks.
>>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>
> <snip>
>
>> +static void _wakeupgen_clear(unsigned int irq)
>> +{
>> +       unsigned int cpu = smp_processor_id();
>> +       u32 val, bit_number;
>> +       u8 i;
>> +
>> +       if (_wakeupgen_get_irq_info(irq,&bit_number,&i))
>> +               return;
>> +
>> +       val = wakeupgen_readl(i, cpu);
>> +       val&= ~BIT(bit_number);
>> +       wakeupgen_writel(val, i, cpu);
>> +}
>> +
>> +static void _wakeupgen_set(unsigned int irq)
>> +{
>> +       unsigned int cpu = smp_processor_id();
>> +       u32 val, bit_number;
>> +       u8 i;
>> +
>> +       if (_wakeupgen_get_irq_info(irq,&bit_number,&i))
>> +               return;
>> +
>> +       val = wakeupgen_readl(i, cpu);
>> +       val |= BIT(bit_number);
>> +       wakeupgen_writel(val, i, cpu);
>> +}
> Since you already call these from a function that takes a bool as an
> argument, using a bool argument here instead of duplicating everything
> for set and clear would be simpler.
>
First version of this patch has this done under single function as you
said. Kevin suggested to have separate functions for better readability.

> <snip>
>
>> +/*
>> + * Architecture specific Mask extensiom
>> + */
>> +static void wakeupgen_mask(struct irq_data *d)
>> +{
>> +       spin_lock(&wakeupgen_lock);
>> +       _wakeupgen_clear(d->irq);
>> +       spin_unlock(&wakeupgen_lock);
>> +}
>> +
>> +/*
>> + * Architecture specific Unmask extensiom
>> + */
>> +static void wakeupgen_unmask(struct irq_data *d)
>> +{
>> +
>> +       spin_lock(&wakeupgen_lock);
>> +       _wakeupgen_set(d->irq);
>> +       spin_unlock(&wakeupgen_lock);
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +/*
>> + * Architecture specific set_wake extension
>> + */
>> +static int wakeupgen_set_wake(struct irq_data *d, unsigned int on)
>> +{
>> +       spin_lock(&wakeupgen_lock);
>> +       if (on)
>> +               _wakeupgen_set(d->irq);
>> +       else
>> +               _wakeupgen_clear(d->irq);
>> +       spin_unlock(&wakeupgen_lock);
>> +
>> +       return 0;
>> +}
>> +
>> +#else
>> +#define wakeupgen_set_wake     NULL
>> +#endif
>
> I don't think these are correct, and it probably only works at all due
> to lazy disabling of interrupts during suspend.
>
> First, unless I'm missing some code somewhere, all interrupts are
> still enabled during suspend.  Any interrupt that has had enable_irq
> on it resulted in a call to wakeupgen_unmask, but when disable_irq is
> called on all the interrupts during suspend, masking is delayed until
> an interrupt is delivered.  If no interrupt is delivered, all enabled
> irqs will still be enabled in the wakeupgen module in suspend, and
> they will all wake the device out of suspend.
>
During suspend it's expected that the drivers disables there interrupts
as part of suspend hooks. One can used "set_wake" API's to
enable/disable wakeups from suspend.


> Second, it is possible for a wake interrupt that should be enabled to
> end up disabled in suspend.  Consider the following calls that occur
> in a driver during its suspend handler:
>
> enable_irq_wake
>    ...
>    wakeupgen_unmask (irq is now unmasked)
> disable_irq (lazy disable, wakeupgen_mask is not called, irq is still unmasked)
> <irq occurs>
> handle_level_irq
>    ...
>    wakeupgen_mask (irq is now masked)
>
> The irq will never get unmasked because it is marked disabled, and the
> irq will not wake the device from suspend.
>
> wakeupgen_set_wake needs to set or clear bits in memory, and then
> those suspend masks need to be copied into the wakeupgen registers
> very late in suspend, after interrupts have been disabled at the cpu.
> I think syscore_ops is the right place.
>
This is a good point about lazy disabling. Copy to memory happens
already as part of save in SAR layout.
Will think over this one. Thanks for bringing this point here.

Regards
Santosh
