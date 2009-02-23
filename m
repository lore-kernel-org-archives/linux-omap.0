From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: Disable USB interrupt in the musb_resume()  function
Date: Sun, 22 Feb 2009 21:50:29 -0800
Message-ID: <200902222150.29454.david-b@pacbell.net>
References: <4d34a0a70901310021l6f42b34es24ca320e44c51ae6@mail.gmail.com> <200902201830.08648.david-b@pacbell.net> <4d34a0a70902221928y2724f776j4f4558306b01e6ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4d34a0a70902221928y2724f776j4f4558306b01e6ff-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, =?utf-8?q?=EA=B9=80=EA=B7=9C=EC=9B=90?= <q1.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sunday 22 February 2009, Kim Kyuwon wrote:
> Hi,
> 
> On Sat, Feb 21, 2009 at 11:30 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > On Tuesday 03 February 2009, Kim Kyuwon wrote:
> >> USB should be suspended with interrupt disabled[1].
> >
> > That text means that the sysdev.suspend() method is
> > called with IRQs disabled ... just like suspend_late()
> > methods do (now) for other busses.  (There is no longer
> > any point to using a sysdev; platform_device can now do
> > everything sysdev can do.)
> >
> 
> I thought why the '/Documentation/power/devices.txt' mentioned
> 'disabling IRQs'. Let's look at the call-stack

That can't matter, because the USB controller isn't
implemented using the "sysdev" infrastructure.


> which is shown when the 
> processor resumes from 'Sleep' state.
> 
> suspend_devices_and_enter()
> -- suspend_enter()
> -- -- arch_suspend_disable_irqs()
> -- -- suspend_ops->enter()				// Waking up from here
> -- -- arch_suspend_enable_irqs()		// <A>
> -- -- <Do someting..>
> -- device_resume()						// <B>

It doesn't enable IRQs until after it's resumed sysdev
nodes and done resume_early() for all other devices.
That's before your <A>.


> As I talked in the commit message, after invoking the
> arch_suspend_disable_irqs() function, some interrupt handlers would
> start to be invoked again. And most interrupt handlers access each
> peripheral controller register. However, each iclk, fclk and
> controller are disabled until the resume() functions are called in
> device_resume() function.

That blanket rule is wrong ... and creates confusion.

First, remember that system-wide suspend isn't really
the best model for most OMAP systems.  I won't revisit
those discussions here.  Just remember that the goals
include having:

 - normal system run states put everything that's
   not in active use in a low power state;

 - system idle states do the same, leveraging some
   extra mechanisms available when the CPU, and maybe
   DMA, are inactive;

 - wake events only reactivate a bare minimum of hardware.

That is, the C1/C2/.../C6/... idle states, combined
with device low power states, supplant global states
like "suspend to RAM", which are exited by wasting
power issuing resume() to *every* device.  There's a
whole spectrum of low power states.  The poor starved
trio of states that can be entered by writing to the
/sys/power/state file is only a small subset, with a
big drawback of needing a user choice/action.

Second, suspend() doesn't always put everything into
an OFF state.  Even a system-wide "suspend to RAM"
state is expected to support various wake events.
That requires various hardware resources being left
partially active in suspend().

Consider for example "echo standby > /sys/power/state".
It's quite normal for a suspend() method running in
that context leave resources active that wouldn't stay
that way with "echo mem > /sys/power/state"; ditto
with "echo disk > ...".


> Therefore, Not disabling IRQs can cause kernel panics. For instance,
> if an suspend function disable iclk, an IRQ handler that accesses
> controller register and invoked from <A> to <B> will make the data
> abort exception.

If a suspend() leaves IRQs enabled and disables iclk, the
IRQ handler obviously needs to be know to re-enable iclk.

Better might be to disable the iclk in suspend_late() and
enable it in resume_early().

When suspend() is told that its device should be able to
wake the system, that may well mean leaving the fclk active
and IRQ enabled.  Details are device-specific ... I've not
looked at that issue with respect to MUSB.


> Maybe all device driver doesn't need to disable IRQs while entering
> CPU sleep state but as you can see most devices that handle the
> peripheral controller should disable IRQs.

CPU sleep state != device sleep state; as I've already
commented, various device low power states need to be
able to wake the system.

Plus of course, "system sleep state" != "CPU sleep state".
And when a driver needs to keep some infrastructure active
to serve as a wake event source, that tends to cascade.

It may not be possible to enter the deepest sleep states
with certain devices being wake-active, since they may
require certain clocks to stay enabled.

 
> > Are you sure you haven't broken remote wakeup by doing
> > this?
> 
> Of course, this patch prevents remote wakeup,

So this patch is clearly broken.  NAK.


> because I applied this 
> patch to the 'SUSPEND' function. Suspend function is invoked to
> disable the USB from working not to enable the remote wakeup.

Wrong.  To repeat myself:  there are two variants of suspend,
with remote wakeup (a) enabled or else (b) disbled.  Plus
there's a pseudo-suspend, with VBUS power disabled so that
all USB device sessions are broken ... that psuedo-suspend
will normally be mapped to an OFF state.

Compare to PCs.  USB remote wakeup routinely works from
the "standby" state; mostly works from "suspend-to-RAM",
except on laptops which happen to prioritize battery power
over functionality; and sometimes works from "hibernation".

You are asserting it should never work in any of those
cases ... which is obviously wrong, which means there's
something wrong with your logic.


> The 
> musb_suspend() function is already disabling the USB clock. That means
> that if generic_interrupt() is invoked from <A> to <B>, it also causes
> oops, so USB IRQ should be disabled.

See above.  In other systems, the answer is trivial:  the
early_resume() method can enable the interface clock.
Wouldn't that work here?

 
> I think the 'remote wakeup' function is another issue and another
> feature. the current suspend function of musb driver doesn't consider
> the 'remote wakeup' enough.

That's probably true.  Power management in general for
this driver has mostly been ignored.  But that's no
excuse for doing something that's clearly wrong.


> It can be added after my patch is applied. 
> But there is one thing absolutely true, "If the USB clock is disabled,
> IRQ should be disabled". This patch is just for the stable musb.

Try coming up with a better patch though.  The simple
case may be just disabling the interface clock, and
having completely functional remote wakeup.  Trickier
cases will involve disabling more clocks, or even
entering OFF mode (and then completely re-initializing
the hardware).

 
> Somewhat related: USB insertion and deletion can be configured as
> wake-source too. As you know it is different from USB interrupt. so I
> don't think waking up from the USB interrupt is still not critical :)

Acatually, those events *DO* map to interrupts from the MUSB
state machine.

- Dave


 
> > - Dave
> >
> 
> -- 
> Kyuwon
> 
> 



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
