From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: Disable USB interrupt in the musb_resume()
	function
Date: Mon, 23 Feb 2009 12:28:13 +0900
Message-ID: <4d34a0a70902221928y2724f776j4f4558306b01e6ff@mail.gmail.com>
References: <4d34a0a70901310021l6f42b34es24ca320e44c51ae6@mail.gmail.com>
	 <4d34a0a70902031601r5c8c3424l4cd399193142e612@mail.gmail.com>
	 <200902201830.08648.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:18236 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbZBWD2O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Feb 2009 22:28:14 -0500
In-Reply-To: <200902201830.08648.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, me@felipebalbi.com, =?EUC-KR?B?seix1L/4?= <q1.kim@samsung.com>

Hi,

On Sat, Feb 21, 2009 at 11:30 AM, David Brownell <david-b@pacbell.net> wrote:
> On Tuesday 03 February 2009, Kim Kyuwon wrote:
>> USB should be suspended with interrupt disabled[1].
>
> That text means that the sysdev.suspend() method is
> called with IRQs disabled ... just like suspend_late()
> methods do (now) for other busses.  (There is no longer
> any point to using a sysdev; platform_device can now do
> everything sysdev can do.)
>

I thought why the '/Documentation/power/devices.txt' mentioned
'disabling IRQs'. Let's look at the call-stack which is shown when the
processor resumes from 'Sleep' state.

suspend_devices_and_enter()
-- suspend_enter()
-- -- arch_suspend_disable_irqs()
-- -- suspend_ops->enter()				// Waking up from here
-- -- arch_suspend_enable_irqs()		// <A>
-- -- <Do someting..>
-- device_resume()						// <B>

As I talked in the commit message, after invoking the
arch_suspend_disable_irqs() function, some interrupt handlers would
start to be invoked again. And most interrupt handlers access each
peripheral controller register. However, each iclk, fclk and
controller are disabled until the resume() functions are called in
device_resume() function.

Therefore, Not disabling IRQs can cause kernel panics. For instance,
if an suspend function disable iclk, an IRQ handler that accesses
controller register and invoked from <A> to <B> will make the data
abort exception.

Maybe all device driver doesn't need to disable IRQs while entering
CPU sleep state but as you can see most devices that handle the
peripheral controller should disable IRQs.

>> If USB is suspended with
>> interrupt enabled and connected to host PC, a kernel panic would occur When
>> it wakes up. Because, after the arch_suspend_enable_irqs() function is called
>> in the suspend_enter() function, USB Interrupt handler is called, even though
>> USB controller is still not resumed! All devices are resumed after the
>> device_resume() is called.
>
> This change seems pretty wrong.  The first thing I noticed
> is that it could prevent remote wakeup from working.
>
> Assuming you actually observed this oops, the bug is more
> likely to be that it didn't enter the right kind of suspend
> mode.  There are at least two types of suspend that a USB
> host should be prepared to handle:
>
>  - OFF ... the lowest power mode, everything connected to
>   the host gets logically disconnected.  Wakeup involves
>   complete re-enumeration.
>
>  - SUSPEND ... with two variants, where remote wakeup is
>   (a) enabled or (b) disabled, but the USB link enters
>   the suspend state:   VBUS supplied, with low current
>   draw, and no SOFs get sent.
>
> In the wakeup-enabled case, an IRQ is often used as the
> wakeup trigger.
>
> I'm not entirely sure this driver handles suspend right..
>
> Now, the actual details of how the USB controller, its
> transceiver, and other related hardware is configured...
> can vary a lot.
>
> Are you sure you haven't broken remote wakeup by doing
> this?

Of course, this patch prevents remote wakeup, because I applied this
patch to the 'SUSPEND' function. Suspend function is invoked to
disable the USB from working not to enable the remote wakeup. The
musb_suspend() function is already disabling the USB clock. That means
that if generic_interrupt() is invoked from <A> to <B>, it also causes
oops, so USB IRQ should be disabled.

I think the 'remote wakeup' function is another issue and another
feature. the current suspend function of musb driver doesn't consider
the 'remote wakeup' enough. It can be added after my patch is applied.
But there is one thing absolutely true, "If the USB clock is disabled,
IRQ should be disabled". This patch is just for the stable musb.

Somewhat related: USB insertion and deletion can be configured as
wake-source too. As you know it is different from USB interrupt. so I
don't think waking up from the USB interrupt is still not critical :)

> - Dave
>

-- 
Kyuwon
