From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/13] Revert "ARM: OMAP: Mask interrupts when disabling  interrupts, v2"
Date: Fri, 22 May 2009 11:16:38 -0700
Message-ID: <87hbzd57g9.fsf@deeprootsystems.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
	<1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
	<4A15E5D9.7090704@samsung.com> <87hbzd89xz.fsf@deeprootsystems.com>
	<4d34a0a70905220851y240a2e71w89fe82f49270a813@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:36505 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbZEVSQj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 14:16:39 -0400
Received: by pzk7 with SMTP id 7so1436618pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 22 May 2009 11:16:41 -0700 (PDT)
In-Reply-To: <4d34a0a70905220851y240a2e71w89fe82f49270a813@mail.gmail.com> (Kim Kyuwon's message of "Sat\, 23 May 2009 00\:51\:11 +0900")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: Kim Kyuwon <q1.kim@samsung.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Kim Kyuwon <chammoru@gmail.com> writes:

> On Fri, May 22, 2009 at 11:54 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Kim Kyuwon <q1.kim@samsung.com> writes:
>>
>>> Kevin Hilman wrote:
>>>> This reverts commit 5461af5af5c6a7fee78978aafe720541bf3a2f55.
>>>>
>>>> Adding a disable hook to the irq_chip is not the way to fix the
>>>> problem being addressed by this patch. =A0Instead, we need to fix
>>>> support for [enable|disable]_irq_wake().
>>>
>>> Agree with you if we can use disable_irq_wake for MPU Interrupt wit=
h
>>> not masking the IRQ. Can you explain how we can fix support for
>>> disable_irq_wake() for omap_irq_chip?
>>
>> Yes. =A0The PRCM has a wake-enable per device bit that can be set (s=
ee
>> PM_WKEN_<pwrdm>) to control device wakeup enables.
>
> PM_WKEN_<pwrdm> is not entirely matched to each MPU interrupt.

Correct.  This bit disables the module from generating any wakeup
event to the PRCM.

> If you want to use disable_irq_wake() with enabling PRCM_Interrupt,
> you should disable all PM_WKEN_<pwrdm> bits.
> And how can you make support of disable_irq_wake() for other MPU inte=
rrupts?

To control the ability of a module to wake the MPU directly, we would
need to use the PM_MPUGRPSEL_<pwrdm> regs.

>> But the implemenation of that should not hold up this revert because
>> this patch breaks *all* wakeups since the PRCM interrupt itself is
>> disabled in the suspend path.
>
> Yes, I saw the same problem. This is caused by resume_device_irqs()
> recently added by Rafael not by my patch.=20

The point is, with your patch applied, *all* OMAP wakeups are broken
upstream.

You're right, your patch didn't cause the broken wakeup problem by
itself, but your patch on top of Rafael's in combination with the new
lazy-disable support which are both already in mainline breaks *all*
OMAP wakeup capabilities.  Therefore it should be reverted and the
OMAP specific IRQ wake support fixed.

I am working on fixing the OMAP IRQ wake support, but I do not want
that to hold up this series getting upstream.

> I'm asking him that he made a right decision.

Yes, we had a long discussion on that on linux-pm and I came to the
conclusion that while his change was probably premature, it's the
right decision and platforms with wakeup capabilities should
use/fix their set_irq_wakeup() functionality.

>> As a workaround for your USB problem that this patch was initially
>> intended to fix you could manually disable USB OTG wakeups like this=
:
>>
>> =A0 =A0 =A0 =A0wken =3D prm_read_mod_reg(CORE_MOD, PM_WKEN);
>> =A0 =A0 =A0 =A0wken &=3D ~OMAP3430_EN_HSOTGUSB;
>> =A0 =A0 =A0 =A0prm_write_mod_reg(wken, CORE_MOD, PM_WKEN);
>
> Did you checked this masking prevent waking up from the interrupt of =
USB HOST?

No I did not test, nor was I able to reproduce your original problem
since the description wasn't that clear to me.

This will disable the USB OTG controller module from generating
wakeups for any reason.  If disabling the device wakeup in PM_WKEN is
still resutling in interrupts, then the powerdomain with that device
is most likely not in retention/off.

I do know that disabling PM_WKEN for UARTs in the same powerdomain as
USB OTG (CORE) will stop the UART from waking, and thus from
generating interrupts, as long as the powerdomain has actually
transitioned to retention/off.

Re: USB HOST.  The problem you reported in your original patch was
that you were waking from IRQ 92, which is the USB OTG interrupt.  If
your problem is with USBHOST, that is in a different powerdomain.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
