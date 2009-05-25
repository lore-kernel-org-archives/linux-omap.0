From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH 01/13] Revert "ARM: OMAP: Mask interrupts when disabling
	interrupts, v2"
Date: Mon, 25 May 2009 14:33:55 +0900
Message-ID: <4d34a0a70905242233w491160aaxc8a14a1c1345d9bb@mail.gmail.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
	 <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
	 <4A15E5D9.7090704@samsung.com> <87hbzd89xz.fsf@deeprootsystems.com>
	 <4d34a0a70905220851y240a2e71w89fe82f49270a813@mail.gmail.com>
	 <87hbzd57g9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f122.google.com ([209.85.221.122]:56074 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758701AbZEYFdy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 01:33:54 -0400
Received: by qyk28 with SMTP id 28so2259922qyk.33
        for <linux-omap@vger.kernel.org>; Sun, 24 May 2009 22:33:56 -0700 (PDT)
In-Reply-To: <87hbzd57g9.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Kim Kyuwon <q1.kim@samsung.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Sat, May 23, 2009 at 3:16 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Kim Kyuwon <chammoru@gmail.com> writes:
>
>> On Fri, May 22, 2009 at 11:54 PM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>> Kim Kyuwon <q1.kim@samsung.com> writes:
>>>
>>>> Kevin Hilman wrote:
>>>>> This reverts commit 5461af5af5c6a7fee78978aafe720541bf3a2f55.
>>>>>
>>>>> Adding a disable hook to the irq_chip is not the way to fix the
>>>>> problem being addressed by this patch. =A0Instead, we need to fix
>>>>> support for [enable|disable]_irq_wake().
>>>>
>>>> Agree with you if we can use disable_irq_wake for MPU Interrupt wi=
th
>>>> not masking the IRQ. Can you explain how we can fix support for
>>>> disable_irq_wake() for omap_irq_chip?
>>>
>>> Yes. =A0The PRCM has a wake-enable per device bit that can be set (=
see
>>> PM_WKEN_<pwrdm>) to control device wakeup enables.
>>
>> PM_WKEN_<pwrdm> is not entirely matched to each MPU interrupt.
>
> Correct. =A0This bit disables the module from generating any wakeup
> event to the PRCM.
>
>> If you want to use disable_irq_wake() with enabling PRCM_Interrupt,
>> you should disable all PM_WKEN_<pwrdm> bits.
>> And how can you make support of disable_irq_wake() for other MPU int=
errupts?
>
> To control the ability of a module to wake the MPU directly, we would
> need to use the PM_MPUGRPSEL_<pwrdm> regs.

PM_MPUGRPSEL_<pwrdm> regs can't disable irq wakeup, it is just related
wake-up dependencies.
I tested with this code:

prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
prm_write_mod_reg(0, MPU_MOD, OMAP3430_PM_MPUGRPSEL);
prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_MPUGRPSEL);
prm_write_mod_reg(0, OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);

But USB interrupt have continuously woken up the system.
I checked with my omap wakeup source driver and wake-up source was show=
n below

# cat /sys/power/omap_resume_irq
92

>>> But the implemenation of that should not hold up this revert becaus=
e
>>> this patch breaks *all* wakeups since the PRCM interrupt itself is
>>> disabled in the suspend path.
>>
>> Yes, I saw the same problem. This is caused by resume_device_irqs()
>> recently added by Rafael not by my patch.
>
> The point is, with your patch applied, *all* OMAP wakeups are broken
> upstream.
>
> You're right, your patch didn't cause the broken wakeup problem by
> itself, but your patch on top of Rafael's in combination with the new
> lazy-disable support which are both already in mainline breaks *all*
> OMAP wakeup capabilities. =A0Therefore it should be reverted and the
> OMAP specific IRQ wake support fixed.
>
> I am working on fixing the OMAP IRQ wake support, but I do not want
> that to hold up this series getting upstream.
>
>> I'm asking him that he made a right decision.
>
> Yes, we had a long discussion on that on linux-pm and I came to the
> conclusion that while his change was probably premature, it's the
> right decision and platforms with wakeup capabilities should
> use/fix their set_irq_wakeup() functionality.
>
>>> As a workaround for your USB problem that this patch was initially
>>> intended to fix you could manually disable USB OTG wakeups like thi=
s:
>>>
>>> =A0 =A0 =A0 =A0wken =3D prm_read_mod_reg(CORE_MOD, PM_WKEN);
>>> =A0 =A0 =A0 =A0wken &=3D ~OMAP3430_EN_HSOTGUSB;
>>> =A0 =A0 =A0 =A0prm_write_mod_reg(wken, CORE_MOD, PM_WKEN);

I also confirmed this code can't help disabling interrupt wakeup.

>> Did you checked this masking prevent waking up from the interrupt of=
 USB HOST?
>
> No I did not test, nor was I able to reproduce your original problem
> since the description wasn't that clear to me.
>
> This will disable the USB OTG controller module from generating
> wakeups for any reason. =A0If disabling the device wakeup in PM_WKEN =
is
> still resutling in interrupts, then the powerdomain with that device
> is most likely not in retention/off.
>
> I do know that disabling PM_WKEN for UARTs in the same powerdomain as
> USB OTG (CORE) will stop the UART from waking, and thus from
> generating interrupts, as long as the powerdomain has actually
> transitioned to retention/off.
>
> Re: USB HOST. =A0The problem you reported in your original patch was
> that you were waking from IRQ 92, which is the USB OTG interrupt. =A0=
If
> your problem is with USBHOST, that is in a different powerdomain.
>
> Kevin
>
>

Kevin,

I'm terribly sorry to hold up your work. I will not disturb you
anymore in relation to this revert patch. However, please keep in mind
that adding a disable hook to the irq_chip was the best way to fix the
problem addressed by my original patch.

Regards,
Kyuwon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
