From: Colin Cross <ccross@google.com>
Subject: Re: [pm-core][PATCH v3 01/21] OMAP4: PM: Add omap WakeupGen module support
Date: Sat, 2 Apr 2011 12:47:34 -0700
Message-ID: <BANLkTi=DjoDndvnhJyBSUGChdPuAKDL3mg@mail.gmail.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
	<1301304157-2466-2-git-send-email-santosh.shilimkar@ti.com>
	<BANLkTimWTX9HKhpkkjODCSEiuBNuV-rN-g@mail.gmail.com>
	<4D96EEF4.8000500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:14104 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667Ab1DBTri convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Apr 2011 15:47:38 -0400
Received: from hpaq2.eem.corp.google.com (hpaq2.eem.corp.google.com [172.25.149.2])
	by smtp-out.google.com with ESMTP id p32JlbmD008762
	for <linux-omap@vger.kernel.org>; Sat, 2 Apr 2011 12:47:37 -0700
Received: from vxc34 (vxc34.prod.google.com [10.241.33.162])
	by hpaq2.eem.corp.google.com with ESMTP id p32JlYad008298
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Sat, 2 Apr 2011 12:47:35 -0700
Received: by vxc34 with SMTP id 34so4238272vxc.13
        for <linux-omap@vger.kernel.org>; Sat, 02 Apr 2011 12:47:34 -0700 (PDT)
In-Reply-To: <4D96EEF4.8000500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

On Sat, Apr 2, 2011 at 2:40 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 4/2/2011 11:40 AM, Colin Cross wrote:
>>
>> On Mon, Mar 28, 2011 at 2:22 AM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> =A0wrote:
>>>
>>> This patch adds OMAP WakeupGen support. The WakeupGen unit is respo=
nsible
>>> for generating wakeup event from the incoming interrupts and enable=
 bits.
>>> The WakeupGen is implemented in MPU Always-On power domain. During =
normal
>>> operation, WakeupGen delivers external interrupts directly to the G=
IC.
>>> When the CPUx asserts StandbyWFI, indicating it wants to enter lowp=
ower
>>> state, the Standby Controller checks with the WakeupGen unit using =
the
>>> idlereq/idleack handshake to make sure there is no incoming interru=
pts.
>>> The GIC and WakeupGen needs to be kept in synchronisation for prope=
r
>>> interrupt functioning.
>>>
>>> Hence this patch hooks up the omap WakeupGen mask/unmask along with=
 GIC
>>> using
>>> architecture specific hooks.
>>>
>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Cc: Kevin Hilman<khilman@ti.com>
>>
>> <snip>
>>
>>> +static void _wakeupgen_clear(unsigned int irq)
>>> +{
>>> + =A0 =A0 =A0 unsigned int cpu =3D smp_processor_id();
>>> + =A0 =A0 =A0 u32 val, bit_number;
>>> + =A0 =A0 =A0 u8 i;
>>> +
>>> + =A0 =A0 =A0 if (_wakeupgen_get_irq_info(irq,&bit_number,&i))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>> +
>>> + =A0 =A0 =A0 val =3D wakeupgen_readl(i, cpu);
>>> + =A0 =A0 =A0 val&=3D ~BIT(bit_number);
>>> + =A0 =A0 =A0 wakeupgen_writel(val, i, cpu);
>>> +}
>>> +
>>> +static void _wakeupgen_set(unsigned int irq)
>>> +{
>>> + =A0 =A0 =A0 unsigned int cpu =3D smp_processor_id();
>>> + =A0 =A0 =A0 u32 val, bit_number;
>>> + =A0 =A0 =A0 u8 i;
>>> +
>>> + =A0 =A0 =A0 if (_wakeupgen_get_irq_info(irq,&bit_number,&i))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>> +
>>> + =A0 =A0 =A0 val =3D wakeupgen_readl(i, cpu);
>>> + =A0 =A0 =A0 val |=3D BIT(bit_number);
>>> + =A0 =A0 =A0 wakeupgen_writel(val, i, cpu);
>>> +}
>>
>> Since you already call these from a function that takes a bool as an
>> argument, using a bool argument here instead of duplicating everythi=
ng
>> for set and clear would be simpler.
>>
> First version of this patch has this done under single function as yo=
u
> said. Kevin suggested to have separate functions for better readabili=
ty.
>
>> <snip>
>>
>>> +/*
>>> + * Architecture specific Mask extensiom
>>> + */
>>> +static void wakeupgen_mask(struct irq_data *d)
>>> +{
>>> + =A0 =A0 =A0 spin_lock(&wakeupgen_lock);
>>> + =A0 =A0 =A0 _wakeupgen_clear(d->irq);
>>> + =A0 =A0 =A0 spin_unlock(&wakeupgen_lock);
>>> +}
>>> +
>>> +/*
>>> + * Architecture specific Unmask extensiom
>>> + */
>>> +static void wakeupgen_unmask(struct irq_data *d)
>>> +{
>>> +
>>> + =A0 =A0 =A0 spin_lock(&wakeupgen_lock);
>>> + =A0 =A0 =A0 _wakeupgen_set(d->irq);
>>> + =A0 =A0 =A0 spin_unlock(&wakeupgen_lock);
>>> +}
>>> +
>>> +#ifdef CONFIG_PM
>>> +/*
>>> + * Architecture specific set_wake extension
>>> + */
>>> +static int wakeupgen_set_wake(struct irq_data *d, unsigned int on)
>>> +{
>>> + =A0 =A0 =A0 spin_lock(&wakeupgen_lock);
>>> + =A0 =A0 =A0 if (on)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _wakeupgen_set(d->irq);
>>> + =A0 =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _wakeupgen_clear(d->irq);
>>> + =A0 =A0 =A0 spin_unlock(&wakeupgen_lock);
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>> +#else
>>> +#define wakeupgen_set_wake =A0 =A0 NULL
>>> +#endif
>>
>> I don't think these are correct, and it probably only works at all d=
ue
>> to lazy disabling of interrupts during suspend.
>>
>> First, unless I'm missing some code somewhere, all interrupts are
>> still enabled during suspend. =A0Any interrupt that has had enable_i=
rq
>> on it resulted in a call to wakeupgen_unmask, but when disable_irq i=
s
>> called on all the interrupts during suspend, masking is delayed unti=
l
>> an interrupt is delivered. =A0If no interrupt is delivered, all enab=
led
>> irqs will still be enabled in the wakeupgen module in suspend, and
>> they will all wake the device out of suspend.
>>
> During suspend it's expected that the drivers disables there interrup=
ts
> as part of suspend hooks. One can used "set_wake" API's to
> enable/disable wakeups from suspend.

But because of lazy masking, disabling an interrupt is not the same as
masking.  None of the interrupts will get masked, and they will all
act as wakeup interrupts, even if enable_irq_wake was never called on
it.

>
>> Second, it is possible for a wake interrupt that should be enabled t=
o
>> end up disabled in suspend. =A0Consider the following calls that occ=
ur
>> in a driver during its suspend handler:
>>
>> enable_irq_wake
>> =A0 ...
>> =A0 wakeupgen_unmask (irq is now unmasked)
>> disable_irq (lazy disable, wakeupgen_mask is not called, irq is stil=
l
>> unmasked)
>> <irq occurs>
>> handle_level_irq
>> =A0 ...
>> =A0 wakeupgen_mask (irq is now masked)
>>
>> The irq will never get unmasked because it is marked disabled, and t=
he
>> irq will not wake the device from suspend.
>>
>> wakeupgen_set_wake needs to set or clear bits in memory, and then
>> those suspend masks need to be copied into the wakeupgen registers
>> very late in suspend, after interrupts have been disabled at the cpu=
=2E
>> I think syscore_ops is the right place.
>>
> This is a good point about lazy disabling. Copy to memory happens
> already as part of save in SAR layout.
> Will think over this one. Thanks for bringing this point here.

The key is that mask/unmask and set_wake must act on different mask
data - mask/unmask must take effect immediately, so they must write to
the mask registers, but set_wake takes effect only during suspend, so
it must write to a copy of the mask registers that gets switched in
during suspend.

> Regards
> Santosh
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
