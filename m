From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after irq_disable
Date: Fri, 05 Jun 2009 14:34:48 -0700
Message-ID: <87ljo68ivb.fsf@deeprootsystems.com>
References: <B00E06E2766C2744B022DE9BAF3C59D5372EFA@zmy16exm69.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:10160 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbZFEVet (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 17:34:49 -0400
Received: by wf-out-1314.google.com with SMTP id 26so795468wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 14:34:51 -0700 (PDT)
In-Reply-To: <B00E06E2766C2744B022DE9BAF3C59D5372EFA@zmy16exm69.ds.mot.com> (Wang Sawsd-A's message of "Sat\, 6 Jun 2009 03\:06\:40 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Sawsd-A24013 <cqwang@motorola.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, Mike Chan <mikechan@google.com>

"Wang Sawsd-A24013" <cqwang@motorola.com> writes:

>> Could you try this patch with your TS GPIO configured as 
>> level-triggered?
>> 
>
> I tried the below patch, it can solve the issue also.
>

Thanks for testing.

This whole time, you're probably wondering... "why doesn't Kevin just
add the disable and enable hooks and be done with it."  I don't think
I've explained myself there yet so let me try to explain so I don't
come across as refusing your original idea for no good reason other
than being stubborn.

We basically have the option of doing it in my proposed patch, which
adds additional overhead to the mask/unmask hooks or we can just add
disable/enable hooks as you did in your original patch.

The reason I prefer not to add disable/enable hooks is to take
advantage of the lazy disable feature.  With lazy disable, by waiting
to actually disable, it allows us to handle potentially lost
interrupts and this is especially important for wakeup interrupts.  An
interesting example this is interrupts that are lazy disabled during
suspend/resume.

For example, if a wakeup interrupt happens between the drivers
disable_irq(), what you want is for this interrupt to cancel suspend.
If you you implement a ->disable hook, and thus mask interrupts in HW
immediately, you will loose this interrupt.  With lazy disable, the
drivers ISR will not be called, but genirq will see this interrupt and
set IRQ_PENDING.  Late in the suspend path, IRQs that are IRQ_WAKEUP
and IRQ_PENDING will cancel suspend (see
kernel/irq/pm.c:check_wakeup_irqs())

Another possible scenario is an interrupt that happens between HW
resume and the drivers enable_irq() hook.  With lazy disable, this
interrupt will be IRQ_PENDING when enable_irq() gets called and be
triggered/handled immedately.

Hope that helps explain my stubborness, ;)

Of course this doesn't mean it's an absolute decision.  As always, I'm
certainly open to being pursuaded that there are other better reasons
for doing it differently.

Kevin
