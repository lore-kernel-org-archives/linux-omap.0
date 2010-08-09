From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: Issues with calling pm_runtime functions in
 platform_pm_suspend_noirq/IRQ disabled context.
Date: Mon, 9 Aug 2010 21:09:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6553186@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E7ED0FDF@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1008061305360.5732@utopia.booyaka.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E800BD63@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1008082350130.8958@utopia.booyaka.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E800C34D@dbde02.ent.ti.com>
 <871va7n6pe.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33175 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379Ab0HIPkH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 11:40:07 -0400
In-Reply-To: <871va7n6pe.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Basak, Partha" <p-basak2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kalliguddi, Hema" <hemahk@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Monday, August 09, 2010 9:01 PM
> To: Basak, Partha
> Cc: Paul Walmsley; linux-omap@vger.kernel.org; Kalliguddi, Hema; Raja,
> Govindraj; Varadarajan, Charulatha
> Subject: Re: Issues with calling pm_runtime functions in
> platform_pm_suspend_noirq/IRQ disabled context.
> 
> "Basak, Partha" <p-basak2@ti.com> writes:
> 
> >> Finally, we have omap_sram_idle():
> >>
> >> > In particular, for USB, while executing SRAM_Idle, is we use
> pm_runtime
> >> > functions, we see spurious IO-Pad interrupts.
> >>
> >> Your message doesn't specify what PM runtime functions you are
> executing.
> >> But if those functions are calling mutex_lock(), then they obviously
> must
> >> not be called from omap_sram_idle() in interrupt context.
> >>
> >> It's not clear from your message why you need to call PM runtime
> functions
> >> from the idle loop.  I'd suggest that you post the problematic code in
> >> question to the list.
> >>
> >
> > USB issue:
> >
> > Please refer to the USB patch attached (will be sent to the list as well
> in a few minutes)
> > As I mentioned previously, few drivers like GPIO, USB & UART have clock-
> disable/enable + context save/restore in Idle path(omap_sram_idle()).
> >
> > In particular, I am referring to calling of the functions
> pm_runtime_put_sync() & pm_runtime_get_sync() for USB around wfi.
> >
> > Now, the following call sequence from omap_sram_idle()will enable IRQs:
> > pm_runtime_put_sync-->
> > 	__pm_runtime_put-->
> > 		pm_runtime_idle-->
> > 			spin_unlock_irq(),
> > 			__pm_runtime_idle(),-->
> > 			 spin_unlock_irq,
> > 				spin_unlock_irq
> >
> > The functions pm_runtime_idle() & __ pm_runtime_idle() do not use
> > spin_lock_irqsave & spin_unlock_irqrestore. This leads to enabling of
> > the interrupts in omap_sram_idle unconditionally, which for USB in
> > particular is leading to IO-pad interrupt being triggered which does
> > not come otherwise.
> 
> You seem to have correctly identified the problem.  Can you try the
> patch below (untested) which attempts to address the root cause you've
> identified?
> 
> Kevin
> 
> > To work around this problem, instead of using Runtime APIs, we are using
> omap_device_enable/disable, which in-turn call to __omap_hwmod_enable/idle
> >
> > Simply put, I am not talking about grabbing a mutex when interrupts are
> disabled, rather of a scenario where interrupts are getting enabled as a
> side-effect of calling these functions in   omap_sram_idle().
> 
> From be3aeea5f8d29c8ce2fa278f48aef849eb682282 Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@deeprootsystems.com>
> Date: Mon, 9 Aug 2010 08:12:39 -0700
> Subject: [PATCH] PM: allow runtime PM get/put from interrupts-disabled
> context
> 
> When using runtime PM in combination with CPUidle, the runtime PM
> transtions of some devices may be triggered during the idle path.
> Late in the idle sequence, interrupts may already be disabled when
> runtime PM for these devices is initiated (using the _sync versions of
> the runtime PM API.)
> 
> Currently, the runtime PM core assumes methods are called with
> interrupts enabled.  However, if it is called with interrupts
> disabled, the internal locking unconditionally enables interrupts, for
> example:
> 
> pm_runtime_put_sync()
>     __pm_runtime_put()
>         pm_runtime_idle()
>             spin_lock_irq()
>             __pm_runtime_idle()
>                 spin_unlock_irq()   <--- interrupts unconditionally
> enabled
>                 dev->bus->pm->runtime_idle()
>                 spin_lock_irq()
>              spin_unlock_irq()
> 
> To fix, use the save/restore versions of the spinlock API.
>
Similar thing was thought when this problem was encountered but 
there was a concern that it may lead to interrupts are being disable
for longer times

Are all run time PM APIs are short enough to keep interrupts
disabled without impacting interrupt latency?
 
