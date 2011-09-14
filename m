From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
 gic_arch_extn
Date: Wed, 14 Sep 2011 10:08:03 -0700
Message-ID: <20110914170803.GN24252@atomide.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
 <20110913203616.GG24252@atomide.com>
 <CAMQu2gyYETPZRJu=4MWX6bULgmMaJb8MRwfhvURtOuyyWhLkAQ@mail.gmail.com>
 <20110914152116.GM24252@atomide.com>
 <4E70DB33.5070501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:12675 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757082Ab1INRIH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 13:08:07 -0400
Content-Disposition: inline
In-Reply-To: <4E70DB33.5070501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, "Woodruff, Richard" <r-woodruff2@ti.com>

* Santosh <santosh.shilimkar@ti.com> [110914 09:16]:
> 
> First and foremost, I have to go with the approach here because MPUSS
> hardware team put a requirement that GIC and wakeupgen should always be
> kept in sync. If needed we can discuss this off-the list with Richard.
> 
> Below is the extract from the veyron func specs.
> -------------------------------------
> Version 1.6 of veyron spec has this.
> 
> From page 95, paragraph 2 on version 1.6:
> 
> "It is SW responsibility to program interrupt enabling/disabling
> coherently in the GIC and in the Wugen enable registers. That is, a
> given interrupt for a given CPU is either enable at both GIC and Wugen,
> or disable at both, but no mix."
> -------------------------------------
>
> The way understand this IP is, even in normal scenario's every IRQ
> will come to wakeupgen and then it will pass that to GIC. CPU clock
> domains are kept under HW supervised always and they can enter inactive
> any time without WFI. Only wakeup gen can bring the CPU out of inactive
> state.
> 
> That's requirement really lead to this design choice. Just to add
> all ARM SOC's using GIC has a gic extension interrupt controller and
> follow the same approach for the secondary IRQCHIPO.

Thanks for the clarification. It seems to me the spec is most likely
wrong as we've had the GIC working for over two years now without
doing anything with the wakeup gen registers :)

Of course the wakeup events probably don't work currently, but the
GIC interrupts certainly do. So most likely there's no need to
continuously syncronize the wakeup gen registers with the GIC
registers.
 
> Below points as such don't matter after the strict hardware
> requirement. Still .....

I think the issue is that you're assuming the spec is correct,
which does not seem to be the case here. 
 
> Let's say, we ignore the hardware recommendation and try
> to do what you are suggesting.
> 
> How will you know while entering in idle which IRQ's to be
> masked and which are to be unmasked ?
> The only way is to run though entire 1024 possible IRQ's from GIC
> and then check the state of each IRQ and set things accordingly.
> At GIC level, mask and unmask registers are different so you will
> end up reading those many registers. That also means you need to
> export some non-standard APIs from GIC driver.

When entering idle, we have plenty of time to do that. Sounds like
that could be easily implemented in a generic way.
 
> In system wide suspend, the core irq code, communicates
> the wakeup and non-wakeup functionality using standard mask/
> unmask APIs when used with IRQCHIP_MASK_ON_SUSPEND.
> With what you are suggesting it won't work
> as desired. Because that information is only passed
> to the IRQ chips. So you will still need IRQCHIP and
> mask/unmask APIs. That can be done as part of set_wake()
> handler as well though.
> 
> The wakeupgen is within CPU cluster and the accesses
> to it are not as expensive as like accessing 32 K timer or
> GP timer.

Sure, but it still causes unnecesary writes for every interrupt.
There's no technical reason to do that.

> By making the wakeupgen as an IRQCHIP, we meet the hardware
> requirement and also make use of this IP properly for the
> desired functionality using standard IRQCHIP interfaces
> No need of non-standard hacking.

Well it seems the "hardware requirement" is based on a buggy
spec considering things are currently working.
 
> It also avoid platform code monkeing with common GIC code
> and irq subsystem to hack the stuff.

What I'm suggesting can be implemented in a generic way.
 
> Btw, not exactly related here, but because of common code
> consolidation, we need to actually use GIC common
> save/restore hooks, even though OMAP has very
> optimal software save and hardware restore mechanism
> for GIC.
> 
> Hope this email summarise all previous multiple discussions
> in one place.

Thanks, but unfortunately it does not. To me it still seems
this is the wrong approach for the wakeup triggers.

Regards,

Tony
