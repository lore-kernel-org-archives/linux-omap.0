From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH 01/13] Revert "ARM: OMAP: Mask interrupts when disabling
	interrupts, v2"
Date: Sat, 23 May 2009 00:51:11 +0900
Message-ID: <4d34a0a70905220851y240a2e71w89fe82f49270a813@mail.gmail.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
	<1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
	<4A15E5D9.7090704@samsung.com> <87hbzd89xz.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f122.google.com ([209.85.221.122]:41412 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbZEVPvd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 11:51:33 -0400
Received: by qyk28 with SMTP id 28so813075qyk.33
        for <linux-omap@vger.kernel.org>; Fri, 22 May 2009 08:51:34 -0700 (PDT)
In-Reply-To: <87hbzd89xz.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Kim Kyuwon <q1.kim@samsung.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, May 22, 2009 at 11:54 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Kim Kyuwon <q1.kim@samsung.com> writes:
>
>> Kevin Hilman wrote:
>>> This reverts commit 5461af5af5c6a7fee78978aafe720541bf3a2f55.
>>>
>>> Adding a disable hook to the irq_chip is not the way to fix the
>>> problem being addressed by this patch. =A0Instead, we need to fix
>>> support for [enable|disable]_irq_wake().
>>
>> Agree with you if we can use disable_irq_wake for MPU Interrupt with
>> not masking the IRQ. Can you explain how we can fix support for
>> disable_irq_wake() for omap_irq_chip?
>
> Yes. =A0The PRCM has a wake-enable per device bit that can be set (se=
e
> PM_WKEN_<pwrdm>) to control device wakeup enables.

PM_WKEN_<pwrdm> is not entirely matched to each MPU interrupt.
If you want to use disable_irq_wake() with enabling PRCM_Interrupt,
you should disable all PM_WKEN_<pwrdm> bits.
And how can you make support of disable_irq_wake() for other MPU interr=
upts?

> But the implemenation of that should not hold up this revert because
> this patch breaks *all* wakeups since the PRCM interrupt itself is
> disabled in the suspend path.

Yes, I saw the same problem. This is caused by resume_device_irqs()
recently added by Rafael not by my patch. I'm asking him that he made
a right decision.

> As a workaround for your USB problem that this patch was initially
> intended to fix you could manually disable USB OTG wakeups like this:
>
> =A0 =A0 =A0 =A0wken =3D prm_read_mod_reg(CORE_MOD, PM_WKEN);
> =A0 =A0 =A0 =A0wken &=3D ~OMAP3430_EN_HSOTGUSB;
> =A0 =A0 =A0 =A0prm_write_mod_reg(wken, CORE_MOD, PM_WKEN);

Did you checked this masking prevent waking up from the interrupt of US=
B HOST?

Regards,
Kyuwon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
