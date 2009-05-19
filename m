From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/11] OMAP2/3: PM: push core PM code from linux-omap
Date: Mon, 18 May 2009 17:23:26 -0700
Message-ID: <87ws8e7xfl.fsf@deeprootsystems.com>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>
	<1242412851-16606-2-git-send-email-khilman@deeprootsystems.com>
	<20090518133241.GH3067@n2100.arm.linux.org.uk>
	<878wku8hkb.fsf@deeprootsystems.com>
	<13B9B4C6EF24D648824FF11BE8967162038BED5CA9@dlee02.ent.ti.com>
	<20090518202431.GM7042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:36798 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZESAX1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 20:23:27 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1161338wah.21
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 17:23:28 -0700 (PDT)
In-Reply-To: <20090518202431.GM7042@n2100.arm.linux.org.uk> (Russell King's message of "Mon\, 18 May 2009 21\:24\:31 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jouni Hogander <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, May 18, 2009 at 02:04:19PM -0500, Woodruff, Richard wrote:
>> cpu_init() is not yet accessible at the point this code is running.
>
> Not at that _exact_ point, but there's no need what so ever for it
> to be at that exact point.  There's nothing stopping a call to
> cpu_init() happening later.  Much later.
>
>> You could reduce the context perhaps trying to optimize to what the
>> Linux-ARM implementation is today or do a more generic save like is
>> there now.
>> 
>> This code is copied into place from the .S code into SRAM.  Its
>> position independent and is not linked for this address.  If you want
>> to call functions outside of it you need to manually setup linkage.
>
> I wouldn't want to.
>
>> Calling functions on the way _UP_ from wake is NOT easy (like the one
>> you propose) as the MMU is not yet enabled.  The MMU is enabled only
>> below this.  Calling cpu_init() is not do able here.  Even if you
>> dress up the calling pointer to the physical address, it won't work
>> as cpu_init() makes a global variable dereferences (smp_processor_id
>> & stacks[]).
>
> As long as IRQs and FIQs are disabled, you are in a 100% predictable
> environment.
>
> 1. No IRQ or FIQ will be entered; if they are the CPU is buggy.
> 2. No data or prefetch abort will be entered _unless_ you purposely
>    access some non-present memory (and you're not exactly going to
>    start paging memory in with IRQs disabled.)
>
> So restoring the abort and IRQ mode register state is just plain not
> necessary in your SRAM code.
>
> Let's look at the code.  Here are the pertinent bits from Kevin's patch:
>
> static void omap3_pm_idle(void)
> {
>         local_irq_disable();
>         local_fiq_disable();
>
>         omap_sram_idle();
>
>         local_fiq_enable();
>         local_irq_enable();
> }
>
> static void omap_sram_idle(void)
> {
>         _omap_sram_idle(NULL, save_state);
> }
>
>         _omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
>                                          omap34xx_cpu_suspend_sz);
>         pm_idle = omap3_pm_idle;
>
> _omap_sram_idle() is the assembly code we're discussing, and here we're
> referring to its version in SRAM.  From the above code, we can clearly
> see that this is entered with FIQs and IRQs disabled.  So everything
> inside omap_sram_idle() is running in a well defined environment provided
> prefetch and data aborts don't happen.
>
> There is nothing stopping this from becoming:
>
> static void omap3_pm_idle(void)
> {
>         local_irq_disable();
>         local_fiq_disable();
>
>         omap_sram_idle();
> +	cpu_init();
>
>         local_fiq_enable();
>         local_irq_enable();
> }
>
> and having the saving of IRQ, FIQ and abort mode registers removed
> from the SRAM code.

I did some quick experiments on a kernel that includes full OFF-mode
support and this and this is working fine.

For it to work for both idle and suspend, I put the cpu_init()
immediately after the return from SRAM (IOW, right after the call to
_omap_sram_idle() inside omap_sram_idle()).

Now I can totally drop all the sp/lr/spsr save/restore code from the
asm code. Nice!

> Other SoCs do precisely this - let's look at PXA:
>
>         pxa_cpu_pm_fns->enter(state);
>         cpu_init();
>
> The call to the enter method essentially calls the core specific suspend
> function (eg, pxa25x_cpu_suspend()), which is an assembly function which
> ultimately ends up powering down the core resulting in full loss of state
> in the CPU.  We seem to be able to avoid having to save the exception mode
> registers there.
>
> The same thing is done with sa11x0 and Samsung SoCs.
>
> I don't see any reason for OMAP to be "special" in this regard.

Neither do I.  Thanks for the review and the suggestion.

Kevin
