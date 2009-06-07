From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: Re: OMAP: sporadic hard lock-up when GPIO edge-triggered interrupts
	occur too fast
Date: Mon, 8 Jun 2009 09:22:29 +1200
Message-ID: <5a7b8b7b0906071422l777fec53oa7d7f448e1784ebb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:18971 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874AbZFGVW1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Jun 2009 17:22:27 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1785841ywb.1
        for <linux-omap@vger.kernel.org>; Sun, 07 Jun 2009 14:22:29 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi OMAP people,

I've done some more debugging on this problem, and determined that
while it occurs less often, it still happens when PREMPT_RT is
completely disabled (using l-o 2.6.29-omap1 with the default set of
extra patches applied by the OE linux-omap_2.6.29 recipe, without
having applied the -rt patchset). I am therefore reposting this to the
l-o list as it seems like it could be a serious and general problem,
and I'm really out of ideas for fixing it...

Are there any known cases (however rare), whereby a race condition or
deadlock can occur with the current GPIO interrupt code? I've seen
many comments on the mailing list implying the code is quite fragile
or sensitive as it is, and wonder if this is because of hardware bugs
or limitations? The way the hardware works (multiple GPIO interrupts
combined into one bank interrupt to the MPU, where the bank can
contain both level and edge triggers) seems pretty stupid, especially
for the use-case where both edge and level triggers are used on one
bank. Does anyone by any chance have any patches that for example, fix
this problem even at the expense of performance or latency?

Many thanks,
Hugo

On Thu, Jun 4, 2009 at 11:51 AM, Hugo Vincent<hugo.vincent@gmail.com> w=
rote:
> Hi everyone,
>
> I'm trying to debug a problem with GPIO interrupts on my OMAP3503
> (Gumstix Overo) platform with kernel 2.6.29.4-rt16-omap1.
>
> While this is a sporadic lock-up, I haven't been able to reproduce it
> when PREEMPT_HARDIRQ is disabled.
>
> I think it might have something to do with this patch (which is appli=
ed BTW):
> =A0 http://patchwork.kernel.org/patch/16046/
> And see this thread:
> =A0 http://markmail.org/message/aaqpk5jztrrypsxz
>
> Sometimes, I see a spurious IRQ message like this:
> =A0 Spurious irq 95: 0xffffffdf, please flush posted write for irq 31
> that the above patch is supposed to fix, just before the system locks
> up. Is it possible that the interrupt handler is getting preempted
> between acknowledging the interrupt and the 'flush posted write', and
> meanwhile another interrupt from the same bank occurs?
>
> To check this hypothesis, I built the kernel with
> =A0 CONFIG_PREEMPT_DESKTOP=3Dy
> =A0 # CONFIG_PREEMPT_RT is not set
> =A0 CONFIG_PREEMPT=3Dy
> =A0 CONFIG_PREEMPT_SOFTIRQS=3Dy
> =A0 CONFIG_PREEMPT_HARDIRQS=3Dy
>
> which gives a /proc/irq/<irq>/<handler>/threaded flag. When I tried
> disabling threading on irqs 246-249 (which are the virtual irqs for
> the problematic GPIO interrupts), the problem still occured. I'm not
> sure how to disable threading or preemption on the intermediate ISR
> (gpio_irq_handler() at arch/arm/plat-omap/gpio.c:959) which determine=
s
> which GPIO in the bank caused the interrupt and spawns the virtual
> interrupts.
>
> Any ideas for debugging or narrowing down on the cause?
>
> Many thanks,
> Hugo
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
