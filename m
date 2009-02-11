From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH omap-fixes] OMAP2/3: GPIO: remove recursion in IRQ wakeup path
Date: Tue, 10 Feb 2009 16:18:01 -0800
Message-ID: <877i3xaksm.fsf@deeprootsystems.com>
References: <1233167723-12026-1-git-send-email-khilman@deeprootsystems.com>
	<200902082039.32157.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:50360 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755728AbZBKASM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 19:18:12 -0500
Received: by qyk4 with SMTP id 4so537246qyk.13
        for <linux-omap@vger.kernel.org>; Tue, 10 Feb 2009 16:18:10 -0800 (PST)
In-Reply-To: <200902082039.32157.david-b@pacbell.net> (David Brownell's message of "Sun\, 8 Feb 2009 20\:39\:32 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

David Brownell <david-b@pacbell.net> writes:

> On Wednesday 28 January 2009, Kevin Hilman wrote:
>> Now that the generic IRQ and GPIO frameworks are used for enabling and
>> disabling GPIO IRQ wakeup sources, there is no longer a need to call
>> [enable|disable]_irq_wake() in the low-level code.  Doing so results
>> in recursive calls to [enable|disable]_irq_wake().
>
> Could you clarify what actually made that requirement go away?
>
> The recursion was introduced -- using the generic IRQ framework! -- as
> a simple way to ensure the parent IRQ was properly wake-enabled.  Is
> the issue that something changed, so that something else wake-enables
> the parent?
>

My description was not very descriptive... sorry...

>From what I can understand here, I don't see the point in
wake-enabling the parent IRQ since there is no wakeup glue for the
bank IRQs, thus these calls are actually failing and causing
'unbalanced IRQ disable' noise in the generic IRQ layer.

Here is what is happening.  Consider the gpio-keys driver.  Upon
suspend, it enables the IRQ wake for its GPIO.  The OMAP GPIO code
then calls enable_wake_irq() for the parent irq (the GPIO bank IRQ).
This call is actually failing because the bank IRQ has no 'set_wake'
method.  Because of this failure, the generic IRQ code doesn't
actually do anything, and sets the 'disable_depth' to zero for the
bank IRQ.

Then, upon resume, the resume path disables IRQ wakeups for the GPIO.
The OMAP GPIO code then tries to call disable_irq_wake() for the bank
IRQ and you get noisy 'unbalanced IRQ disable' warnings from the
generic IRQ layere because of the attempt to disable the IRQ wake of
an IRQ that was never enabled.

So the options that I see are:

1) fix the OMAP GPIO code to check the return code of the parent enable, or
2) drop the parent enable/disable

I prefer (1) since those calls will always fail AFAICT.

Does that make any sense?

If you're OK with (1), I will re-issue the patch with a better discription.

Kevin
