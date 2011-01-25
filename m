From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH 03/14] ARM: v6k: remove CPU_32v6K dependencies in asm/spinlock.h
Date: Tue, 25 Jan 2011 17:33:14 +0000
Message-ID: <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk>
	<AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com>
	<20110125165919.GD17286@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59299 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab1AYRdQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 12:33:16 -0500
Received: by eye27 with SMTP id 27so21189eye.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 09:33:15 -0800 (PST)
In-Reply-To: <20110125165919.GD17286@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Jan 25, 2011 at 4:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 25, 2011 at 04:43:52PM +0000, Dave Martin wrote:
>> A couple of questions on this:
>>
>> 1) I notice these spinlock functions are generally marked inline.
>>
>> Is that likely to happen in modules? =A0If so, there would be a need=
 to
>> do SMP_ON_UP fixups at module load time -- I don't think that's
>> currently implemented.
>
> No one should be using the arch_* spinlocks directly. =A0The spinlock=
s
> are implemented in out of line code in kernel/spinlock.c

OK--- do think this is something we need a sanity-check for, or does
this fall into to a category of bad driver implementation which will
get thrown out during peer review?

>
>> 2) When building with this patch and CONFIG_SMP_ON_UP=3Dy, I've seen
>> vmlinux link errors like this:
>>
>> =A0 LD =A0 =A0 =A0.tmp_vmlinux1
>> `.exit.text' referenced in section `.alt.smp.init' of
>> drivers/built-in.o: defined in discarded section `.exit.text' of
>> drivers/built-in.o
>> make: *** [.tmp_vmlinux1] Error 1
>>
>> I don't know whether this is caused by the patch directly or as a
>> side-effect -- I've only noticed it in the linaro-2.6.37 tree so far=
=2E
>> git bisect indentified this above patch as the first one with the
>> error in that case.
>>
>> I don't understand the section discarding logic too well, so I'm not
>> sure how to fix it for now...
>
> Hmm. =A0I don't see how that could happen, unless some driver is goin=
g
> behind the spinlock APIs, or using our dsb_sev() directly.
>
> I think you need to first track down what's responsible for inserting
> architecture spinlock code into drivers.
>

OK, I'll try and do a bit more digging.  I think I have a better idea
of what to look for now, anyhow.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
