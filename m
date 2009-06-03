From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after irq_disable
Date: Tue, 02 Jun 2009 18:43:09 -0700
Message-ID: <874ouyay8i.fsf@deeprootsystems.com>
References: <B00E06E2766C2744B022DE9BAF3C59D532D5DE@zmy16exm69.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:42028 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbZFCBnL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 21:43:11 -0400
Received: by wf-out-1314.google.com with SMTP id 26so3038301wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 02 Jun 2009 18:43:12 -0700 (PDT)
In-Reply-To: <B00E06E2766C2744B022DE9BAF3C59D532D5DE@zmy16exm69.ds.mot.com> (Wang Sawsd-A's message of "Wed\, 3 Jun 2009 01\:18\:15 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Sawsd-A24013 <cqwang@motorola.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, Mike Chan <mikechan@google.com>

"Wang Sawsd-A24013" <cqwang@motorola.com> writes:

>> "Wang Sawsd-A24013" <cqwang@motorola.com> writes:
>> 
>> > Resend because of the content format issues in last mail---sorry for
>> > inconvenience.
>> 
>> This version is line-wrapped and otherwise confusing as well so does
>> not apply cleanly.  Could you try using 'git format-patch' to generate
>> your patch?  It looks like you may have used 'git diff' and then
>> appended them together?
>> 
>
> I did use git-format-patch command, seems the issue is caused 
> our mail server, this time I attached the whole patch in the mail,

Attached version applies fine, but still has problems.  More below.

In the future, you should also include the description/justifiction in
the git changelog so it shows up in the patch, and in the git history.

If you're having problems with your mailer or mail server, you might
try to bypass the mailer and use 'git send-email' to send directly to
an SMTP server.

> and I didn't separate the change into sub-patchs, see explanation below.

I still think there at least a couple different problems going on and
I think you are addressing some symptoms but not the root cause.

It would help if you described in more detail the problem(s) you are
having and which part of this patch fixes which part of your
problem(s).

This GPIO interrupt handling code is very sensitive to changes so we
need to really understand your problem before making changes here.

Also it's quite possible there are bugs in your driver as well.  Is
there any chance you can reproduce this on a public platform such as
the 3430SDP using the PM branch?  

If I use the PM branch on SDP, enable the touchscreen and go into
suspend, I do not see the GPIO driver keeping the system out of
retention.  In addition, if I add 

  enable_irq_wake(gpio_to_irq(ts_gpio));

to the board init code, I can also use the touchscreen as a wakeup
source and it does not prevent retention so you should be able to
reproduce there.

>> In addition, the many uses of "also" in this description suggest that
>> that it could be broken up in to several patches with more clear
>> descriptions/justifications..  Some are fixes, some are new
>> functionality.
>
> Yes, "also" is abused in my description, too spoken. :-) 
> But the whole change is actually for the same issue which is 
> OMAP GPIO IRQ/WAKEUP issue and I think they are all fixes
> but not new functionality.
>
>> 
>> > This patch adds irq_enable and irq_disable for OMAP GPIO IRQ chip, 
>> 
>> Please elaborate on why you chose to implement the enable/disable
>> hooks instead of using the mask/unmask hooks.
>> 
> 1: irq mask/unmask are typically used by the IRQ handling framework
> or CHIP IRQ handler to disable and enable IRQ during the IRQ handing
> procedure; 

The mask/unmask are also used by the lazy disable feature of the
generic IRQ code.  More on this below...

> While still many drivers are using irq_disable and irq_disable in
> their code especially in the case of suspend/resume and IOCTL to
> turn on/off the peripherals, without the irq_disable in IRQ CHIP,
> the default_disable Is used but it is just an empty function
> now. This will cause an issue that The IRQ may still happen after
> irq_disable which may cause unexpected behavior in driver since they
> are not expecting any IRQ after irq_disable.

The driver's ISR should *never* be called after disable_irq().
However, the actual interrupt may still fire.  Here is what is
_supposed_ to happen.

The generic IRQ infrastructure was recently changed to use a "lazy
disable" which means the default disable_irq() (when no disable hook
is installed) doesn't actually disable the interrupt immediately.
Rather, it simply sets the IRQ_DISABLED flag.  Then, upon the next
interrupt the generic handler notices the flag, masks (and acks if
it's level triggered) the IRQ and does not call the interrupt handler.
Thus an extra interrupt happens, but the drivers ISR should not be
called.  If the drivers' ISR is being called after disable_irq() then
something bad is going on not related to GPIOs.

Now, that's what is "supposed" to happen.  That's not to say you
haven't found a real bug somewhere.  It's just not clear yet
because I still don't understand the bug you're trying to fix.

The chained handler for GPIOs is supposed to demux and than calls
either handle_edge_irq() or handle_level_irq() (via
generic_handle_irq()), the handler is set when the IRQ type is set.
Eiter of these handlers will handle the lazy disable and result
in a call to irq_chip->mask() on the next interrupt.

You could try the patch below[1] which will warn if the triggering
is not setup properly for a given GPIO IRQ.  This would result
in a broken lazy disable.

> 2: I noticed that we have the mask and unmask already, but why I didn't
> choose to use them directly for irq_disable and irq_enable is because
> we need something special in irq_disable for OMAP. 

This is where I disagree.  Basically, I think things you are doing in
disable are either done elsewhere already, or should be.

IOW, you're new disable hook does the equivalent of:

  irq_chip->mask(irq)
  irq_chip->set_wake(irq, 0); /* a.k.a. disable_irq_wake() */
  irq_chip->ack(irq);

The lazy disable will take care of the mask (and ack if it's level
triggered).  And if you don't want your driver's IRQ to be a wakeup
event, you should also call disable_irq_wake() in your driver if you
really want wakeup events disabled.

Your enable hook does he equivalent of

  irq_chip->set_wake(irq, 1); /* a.k.a. enable_irq_wake(irq); */
  irq_chip->unmask(irq);

Which is the same as your driver doing:

  enable_irq_wake(irq);
  enable_irq(irq);

So your driver should be simply add enable_irq_wake() if it wants to
(re)enable the wakeup feature.

Stated in another way, and possibly more simply, disable_irq() does
not imply disable_irq_wake() and enable_irq() does not imply
enable_irq_wake().

There is a possible bug here in the case of edge triggered interrupts:
a disable_irq() will not result in an irq_chip->ack().  Therfore,
pending IRQs that are not wakeup-enabled should probably be ACK'd in
the prepare_to_idle hook, or possibly in the set_wake() hook.  In the
disable case of set_wake(), if the IRQ is disabled, any pending IRQs
should be cleared.

> Since irq_disable typically means the driver wants to deactive the
> peripherals for a long period of time and may allow System going
> into low power state, but for OMAP GPIO the IRQ status bit may still
> be set even when IRQEN bit is cleared, that's why we need also clear
> the level detect and edge detect Configuration register to ensure
> after irq_disable, no IRQ status bit is set, since once the IRQ
> status bit is set while IRQ is disabled, then this will prevent GPIO
> module acknowledge IDLE request from PRCM, so PER and CORE will fail
> entering RET state. We are facing this issue now, that is why I made
> this patch.
>
>
>> > and also only enable WAKEUPEN When GPIO edge detection is enabled,
>> 
>> Can you send this fixa separate patch.  It is a bug fix that is
>> separate from the new stuff you're adding here.
>> 
> This issue is also related with the OMAP GPIO IRQ wakeup configuration
> So it is not a separate issue. But I can send it as separate patch if
> the community
> Think the rest of this patch is not applicable.

Yes, please send that part as a separate fix as it is a clear bugfix.
Also, it's probably better to put the TRM reference in the git
changelog instead of the code as those section numbers will become out
of date shortly.

>> > also clear the gpio event triggering configurations to avoid Pending
>> > interrupt status which is generated regardless of the IRQEN and
>> > WKUPEN bit, the pending IRQ status may prevent GPIO module
>> > acknowledge IDLE request and prevent PER and thus CORE RETENTION.
>> 
>> Have you tested the PM branch code?
>> 
> Yes, I have verified the patch on the kernel which is based on
> google omap GIT which is based on linux-omap PM branch, and it does
> resolve the issue.  The issue I am facing is the Touch controller on
> my HW will continously report Input interrupts fastly, so without
> the patch, the IRQ staus will be pending there Even after the touch
> driver calls irq_disable and prevents PER and CORE going into
> RETENTION In suspend mode.

So, IIUC, your drivers ISR is being called after disable_irq()?  If
so, something has gone horribly wrong.  This should not be possible
with the genirq framework.  Again, it would be nice to reproduce this
using the touchscreen on the SDP using the PM branch.  Please try
with my patch below[1] and tell me if you see any warnings.

>> I'm not sure I quite follow your description here, but IIUC, we are
>> already doing this in the [prepare|resume]_idle() hooks.
>> 
> The code in GPIO prepare/resume for idle functions are made to
> address another different issue for OMAP2, since on OMAP2 there are
> some silicon bugs that causes some GPIO to be non-wakeupable, so the
> workaround was made to not enable edge detection for those GPIOs and
> manually trigger IRQs using level detect based on input GPIO levels
> after idle. 

Sorry, I said the prepare_for/resume_from idle hooks but I was
thinking of the suspend/resume hooks....

> But for OMAP3, there is no non-wakeup gpio, all the GPIOs are wakeup
> gpios.

On OMAP3, all GPIOs are wakeup capable, but by non-wakeup GPIO is
meant GPIOs that are not *configured* for wakeup.   

The suspend hook will ensure that wakeups are disabled for any non
wake-enabled GPIO and restore them on resume.

> This patch is needed for both OMAP2 and OMAP3 since the GPIO module has
> The similar silicon architecture, that is IRQ status will be set
> regardless of IRQEN bit.
>

Hope this helps,

Kevin

[1]  Against current PM branch


diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 3b2054b..079f8a6 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1098,9 +1098,15 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 		gpio_irq = bank->virtual_irq_start;
 		for (; isr != 0; isr >>= 1, gpio_irq++) {
+			struct irq_desc *desc;
+
 			if (!(isr & 1))
 				continue;
 
+			desc = irq_to_desc(gpio_irq);
+			WARN_ONCE(!(desc->status & IRQ_TYPE_SENSE_MASK),
+				  "%s: IRQ %d/%d has no triggering\n",
+				  __func__, irq, gpio_irq);
 			generic_handle_irq(gpio_irq);
 		}
 	}
