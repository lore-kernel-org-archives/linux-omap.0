From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: Disable USB interrupt in the musb_resume()  function
Date: Fri, 20 Feb 2009 18:30:08 -0800
Message-ID: <200902201830.08648.david-b@pacbell.net>
References: <4d34a0a70901310021l6f42b34es24ca320e44c51ae6@mail.gmail.com> <4d34a0a70902031601r5c8c3424l4cd399193142e612@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4d34a0a70902031601r5c8c3424l4cd399193142e612-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, =?utf-8?q?=EA=B9=80=EA=B7=9C=EC=9B=90?= <q1.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 03 February 2009, Kim Kyuwon wrote:
> USB should be suspended with interrupt disabled[1].

That text means that the sysdev.suspend() method is
called with IRQs disabled ... just like suspend_late()
methods do (now) for other busses.  (There is no longer
any point to using a sysdev; platform_device can now do
everything sysdev can do.)


> If USB is suspended with 
> interrupt enabled and connected to host PC, a kernel panic would occur When
> it wakes up. Because, after the arch_suspend_enable_irqs() function is called
> in the suspend_enter() function, USB Interrupt handler is called, even though
> USB controller is still not resumed! All devices are resumed after the
> device_resume() is called.

This change seems pretty wrong.  The first thing I noticed
is that it could prevent remote wakeup from working.

Assuming you actulaly observed this oops, the bug is more
likely to be that it didn't enter the right kind of suspend
mode.  There are at least two types of suspend that a USB
host should be prepared to handle:

 - OFF ... the lowest power mode, everything connected to
   the host gets logically disconnected.  Wakeup involves
   complete re-enumeration.

 - SUSPEND ... with two variants, where remote wakeup is
   (a) enabled or (b) disabled, but the USB link enters
   the suspend state:   VBUS supplied, with low current
   draw, and no SOFs get sent.

In the wakeup-enabled case, an IRQ is often used as the
wakeup trigger.

I'm not entirely sure this driver handles suspend right..

Now, the actual details of how the USB controller, its
transceiver, and other related hardware is configured...
can vary a lot.

Are you sure you haven't broken remote wakeup by doing
this?

- Dave


> [1] /Documentation/power/devices.txt: 412 line
> 
> Signed-off-by: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/musb/musb_core.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 2cc34fa..0dfe15e 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2151,6 +2151,8 @@ static int musb_suspend(struct platform_device
> *pdev, pm_message_t message)
> 
>        spin_lock_irqsave(&musb->lock, flags);
> 
> +       disable_irq(musb->nIrq);
> +
>        if (is_peripheral_active(musb)) {
>                /* FIXME force disconnect unless we know USB will wake
>                 * the system up quickly enough to respond ...
> @@ -2184,6 +2186,8 @@ static int musb_resume(struct platform_device *pdev)
>        else
>                clk_enable(musb->clock);
> 
> +       enable_irq(musb->nIrq);
> +
>        /* for static cmos like DaVinci, register values were preserved
>         * unless for some reason the whole soc powered down and we're
>         * not treating that as a whole-system restart (e.g. swsusp)
> --
> Kim Kyuwon
> 
> 


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
