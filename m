From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after irq_disable
Date: Thu, 04 Jun 2009 10:04:11 -0700
Message-ID: <87r5y0gcc4.fsf@deeprootsystems.com>
References: <B00E06E2766C2744B022DE9BAF3C59D5372710@zmy16exm69.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:24974 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbZFDREP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 13:04:15 -0400
Received: by wa-out-1112.google.com with SMTP id j5so193819wah.21
        for <linux-omap@vger.kernel.org>; Thu, 04 Jun 2009 10:04:16 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Sawsd-A24013 <cqwang@motorola.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, Mike Chan <mikechan@google.com>

"Wang Sawsd-A24013" <cqwang@motorola.com> writes:

> Kevin,
>
> See below for more comments/explanations:
>
>> 
>> I still think there at least a couple different problems going on and
>> I think you are addressing some symptoms but not the root cause.
>> 
> I understand that combine these two changes in one patch may cause
> Some confusion, so this time I separate into two patchs and 
> they are attached.
>
> I agree that I didn't describe the issue more in detail, but I think the
> Second patch (also the original one I intended to make) does address
> The root cause and not workaround the symptoms.
> See below for the problem in detail.
>
>> It would help if you described in more detail the problem(s) you are
>> having and which part of this patch fixes which part of your
>> problem(s).
>> 
> I met this problem when I am using a touch controller that has a
> firmware
> That does not work in a graceful way, the controller seems to report
> Touch event very frequently and seems the HW is too sensitive, this does
> not mean the issue Is caused by the controller, I think this just make
> the issue exposed more easily.
>
> The controller is using a GPIO to assert interrupt to OMAP, the
> interrupt
> Line will be dirven low until the OMAP driver reads out the data through
> I2C.
> On OMAP side, we configure the GPIO interrupt pin to be low level
> detect,

Dumb question: Why use level?  Why not use falling edge for this?

> The issue is, after the touch driver calls irq_disable, since it is
> empty unless
> Set the IRQ_DISABLED flag, so next time only the generic handler
> function
> handle_level_irq is called, this handler just ack to OMAP GPIO IRQ that
> is
> To clear the IRQ status and mask the GPIO on OMAP side, but since NO
> Touch driver IRQ action is called, so the touch Controller can not gets
> acknowledged, then the interrupt line will be always driven low by the
> external controller, 

If the GPIO is set to be edge triggered, the fact that it is still low
won't matter, the genirq layer will have noticed a pending interrupt.

> if we check the IRQ status for that GPIO pin, we
> will find
> The IRQ is always set. This will prevent PER enterring RET/OFF state
> since GPIO
> Will not acknowledge the IDLE request. The main purpose of the second
> patch
> Is to clear the level/edge detect registers for OMAP GPIO when their IRQ
> is
> Disabled, this can ensure the GPIO IRQ status will not be set and
> prevent LPM.

Thanks for the very clear explanation.  I'm pretty sure I understand
what is going on now.

I need to think some more about what you describe below, but am curious
what you think about using edge triggered GPIOs instead of level.

Kevin

>> This GPIO interrupt handling code is very sensitive to changes so we
>> need to really understand your problem before making changes here.
>> 
> I totally undersand this and I am glad to have a thorough understanding
> By everyone and maybe we can find a better solution for this issue.
> But now seems I need make you guys understand the issue first. :-)
>
>> Also it's quite possible there are bugs in your driver as well.  Is
>> there any chance you can reproduce this on a public platform such as
>> the 3430SDP using the PM branch?  
>> 
>> If I use the PM branch on SDP, enable the touchscreen and go into
>> suspend, I do not see the GPIO driver keeping the system out of
>> retention.  In addition, if I add 
>> 
>>   enable_irq_wake(gpio_to_irq(ts_gpio));
>> 
>> to the board init code, I can also use the touchscreen as a wakeup
>> source and it does not prevent retention so you should be able to
>> reproduce there.
> You can say that my touch controller is somehow buggy since it reports
> Events very frequently and will always keep the interrupt line low
> unless it is
> Acknowledged by the touch driver, but I think more important is we can
> not
> Expect and *assume* all the peripherals to work as well as we expected,
> The OMAP GPIO framework should be robust enough to handle such cases
> Since it will act as a risky hole for PM on OMAP.
>
> I understand that this will be hard to reproduce if the Touch controller
> works
> Very gracefully, even for us, we do not see the problem on some other
> HWs
> Since the controller will not report events/interupts so frequently.
>
> Enable_irq_wake and disable_irq_wake is working regardless of irq
> enabled or disabled
> Since on OMAP3, they are using IOPAD wakeup(If PER is in RET/OFF) or
> module level wakeup(if PER is ACTIVE), and the code is handled by gpio
> suspend/resume functions, see more below.
>
>> > 1: irq mask/unmask are typically used by the IRQ handling framework
>> > or CHIP IRQ handler to disable and enable IRQ during the IRQ handing
>> > procedure; 
>> 
>> The mask/unmask are also used by the lazy disable feature of the
>> generic IRQ code.  More on this below...
> I tried to figureout but didn't find any comment on what is the issue
> fixed
> By this lazy irq disable or what we can benefit from this lazy irq
> disable,
> Seems the change is mainly for x86.

The lazy disable is also used so that wakeup interrupts will not be
lost between driver suspend and actual HW suspend.  In addition, the
genirq subsystem allows interrupts between HW wakeup and driver resume
to be resent to the driver.


>> 
>> The driver's ISR should *never* be called after disable_irq().
>> However, the actual interrupt may still fire.  Here is what is
>> _supposed_ to happen.
>> ............snipped.................
>> You could try the patch below[1] which will warn if the triggering
>> is not setup properly for a given GPIO IRQ.  This would result
>> in a broken lazy disable.
>> 
> I can confirm, the irq actions is not called in my case after
> irq_disabled
> Is called even without my patch, but the patch is not related
> With the IRQ handling, what it tries to do is to simply find a place
> To clear the level/edge detect settings.
>
>
>> This is where I disagree.  Basically, I think things you are doing in
>> disable are either done elsewhere already, or should be.
>> 
>> IOW, you're new disable hook does the equivalent of:
>> 
>>   irq_chip->mask(irq)
>>   irq_chip->set_wake(irq, 0); /* a.k.a. disable_irq_wake() */
>>   irq_chip->ack(irq);
>> 
>> The lazy disable will take care of the mask (and ack if it's level
>> triggered).  And if you don't want your driver's IRQ to be a wakeup
>> event, you should also call disable_irq_wake() in your driver if you
>> really want wakeup events disabled.
>> 
>> Your enable hook does he equivalent of
>> 
>>   irq_chip->set_wake(irq, 1); /* a.k.a. enable_irq_wake(irq); */
>>   irq_chip->unmask(irq);
>> 
>> Which is the same as your driver doing:
>> 
>>   enable_irq_wake(irq);
>>   enable_irq(irq);
>> 
>> So your driver should be simply add enable_irq_wake() if it wants to
>> (re)enable the wakeup feature.
> I think you may ignored the most imortant change I want to make. :-)
> That is to clear the GPIO level/edge detect settings, since for OMAP,
> The GPIO module will set IRQ status based on the settings and
> External GPIO input signals and regardless of the IRQ EN settings,
> This is the main issue I want to address. Since most likely, some
> peripherals
> May drive the interrupt line to assert interrupts, there is no issue if
> the GPIO
> Is enabled by drivers, since the IRQ status will be cleared and the
> controller
> Will be also ACKed, but think about the case that the IRQ is disabled at
> The GPIO HW level which means no even generic IRQ handler will be
> Called, thus the IRQ status will be always pending there.
>
> We met more than once such issues that pending GPIO IRQ status will
> Prevent low power mode.
>
> This is what I want to address, but there is no such API combination can
> Do this unless we have the new disable_irq and enable_irq hooks. Though
> Set_irq_type may change the level/detect settings, but we can not
> Put such omap specfic hooks in the generic driver code. That is why
> I added the two new hooks.In fact, the change does not provide any
> new fundamental APIs, It just combine some existing APIs for OMAP
> GPIO special settings. 
>
>> 
>> Stated in another way, and possibly more simply, disable_irq() does
>> not imply disable_irq_wake() and enable_irq() does not imply
>> enable_irq_wake().
>> 
> I unserstand this. Wakeup is indepent of irq enable/disable. The
> _set_gpio_wakeup function just sets bank->suspend_wakeup
> Which is used in gpio suspend/resume, and specially for OMAP3,
> The code configures IOPAD wakeup.
>
>
>> There is a possible bug here in the case of edge triggered interrupts:
>> a disable_irq() will not result in an irq_chip->ack().  Therfore,
>> pending IRQs that are not wakeup-enabled should probably be ACK'd in
>> the prepare_to_idle hook, or possibly in the set_wake() hook.  In the
>> disable case of set_wake(), if the IRQ is disabled, any pending IRQs
>> should be cleared.
> I think there is no issue with edge interrupt handling since the generic
> Handler handle_edge_irq can still be called after disable_irq as long
> As the IRQ is pending in the IRQ status register. The generic handler
> will
> ACK the IRQ(means clear the IRQ status).
>
> I think current set_wake should be ok, no need try to clear IRQ status,
> Since IRQ staus will be set *ANY TIME* when the external input signal
> Meets the level/edge detect conditions. This is the key point, IRQ
> status
> Will be set even when IRQEN bit is cleared, that is why we need clear
> The level/edge detect also.
>
>> 
>> Yes, please send that part as a separate fix as it is a clear bugfix.
>> Also, it's probably better to put the TRM reference in the git
>> changelog instead of the code as those section numbers will become out
>> of date shortly.
> Done. Sent in attachement. 0001-Only........patch
>
>> 
>> So, IIUC, your drivers ISR is being called after disable_irq()?  If
>> so, something has gone horribly wrong.  This should not be possible
>> with the genirq framework.  Again, it would be nice to reproduce this
>> using the touchscreen on the SDP using the PM branch.  Please try
>> with my patch below[1] and tell me if you see any warnings.
>> 
> No, my driver action handler is not called, but the generic handler is
> called,
> But the issue is the external interupt signal will not be released
> unless
> The driver's action handler ack's the external controller.
>
>> 
>> Sorry, I said the prepare_for/resume_from idle hooks but I was
>> thinking of the suspend/resume hooks....
>> 
>> > But for OMAP3, there is no non-wakeup gpio, all the GPIOs are wakeup
>> > gpios.
>> 
>> On OMAP3, all GPIOs are wakeup capable, but by non-wakeup GPIO is
>> meant GPIOs that are not *configured* for wakeup.   
>> 
>> The suspend hook will ensure that wakeups are disabled for any non
>> wake-enabled GPIO and restore them on resume.
>> 
> My understanding is we have two majors places that related with GPIO
> WAKEUP.
> 1: suspend/resume hooks, I think this is just for the wakeup from system
> wide suspend,
> And will only enable wakeup for those GPIOs that the driver explictly
> calls
> enable_irq_wake, if driver does not call this explicitly, then no wakeup
> will happen on that pin.
> Suspend/resume hooks will not do anything else.
> 2: omap2_gpio_prepare_for_idle/omap2_gpio_resume_after_idle, for OMAP2,
> It tries to workaround the non-wakeup gpio issue which may cause
> spurious interrupts
> If we enable edge detection on those GPIOs, but for OMAP3, the hooks are
> used similarly
> To avoid any edge GPIO interrupt lossing, since once PER enters RET/OFF,
> only IOPAD
> Wakeup events can happen and only IO wakeup interrupt can be seen by
> ARM,
> After GPIO context is restored, since the external GPIO input ls already
> at a high/low level,
> There is no edge can be detected by the GPIO module any more, so we
> check the GPIO inputs
> And compare it with the input level before IDLE, if it changes, then we
> trigger a GPIO IRQ
> By setting LEVEL detect register. This is needed for OMAP3 since we also
> met the issue that
> The edge interrupt is lost during PER RET/OFF.
>
> None of the above hooks can address the issue I am facing now, since
> none of the hooks
> Will CLEAR the level/edge settings for those GPIO with IRQ disabled.
>
>> >
>> 
>> Hope this helps,
>> 
>> Kevin
>> 
