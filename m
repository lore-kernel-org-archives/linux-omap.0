From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP gic_arch_extn
Date: Wed, 14 Sep 2011 11:04:38 +0530
Message-ID: <CAMQu2gyYETPZRJu=4MWX6bULgmMaJb8MRwfhvURtOuyyWhLkAQ@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com> <20110913203616.GG24252@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:59386 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750752Ab1INFe7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 01:34:59 -0400
Received: by mail-gw0-f54.google.com with SMTP id 18so1436459gwj.41
        for <linux-omap@vger.kernel.org>; Tue, 13 Sep 2011 22:34:58 -0700 (PDT)
In-Reply-To: <20110913203616.GG24252@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com

Tony,
On Wed, Sep 14, 2011 at 2:06 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110904 06:23]:
>> OMAP WakeupGen is the interrupt controller extension used along
>> with ARM GIC to wake the CPU out from low power states on
>> external interrupts.
>>
>> The WakeupGen unit is responsible for generating wakeup event
>> from the incoming interrupts and enable bits. It is implemented
>> in MPU always ON power domain. During normal operation,
>> WakeupGen delivers external interrupts directly to the GIC.
> ...
>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Override GIC architecture specific functions to add
>> + =A0 =A0 =A0* OMAP WakeupGen interrupt controller along with GIC
>> + =A0 =A0 =A0*/
>> + =A0 =A0 gic_arch_extn.irq_mask =3D wakeupgen_mask;
>> + =A0 =A0 gic_arch_extn.irq_unmask =3D wakeupgen_unmask;
>> + =A0 =A0 gic_arch_extn.irq_set_wake =3D wakeupgen_set_wake;
>> + =A0 =A0 gic_arch_extn.flags =3D IRQCHIP_MASK_ON_SUSPEND;
>
> As I've commented before, there should not be any need to tweak
> the wakeupgen registers for each interrupt during the runtime.
>
And I gave you all the reasons why it needs to be done this way.

> AFAIK the wakeupgen registers only need to be armed every time
> before entering idle.
>
No that doesn't work and it completely hacky approach.
This problem is for all SOC's using A9 SMP and GIC and every soc
has an architecture specific interrupt controller extension. And that
was the reason the GIC arch_extn was proposed.
It's just another IRQCHIP and works seamlessly being part of the
framework.  And it will also initialized with primary IRQCHIP( GIC).

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
