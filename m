From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/5 v4] mfd: omap: usb: Runtime PM support
Date: Mon, 29 Aug 2011 11:36:34 -0700
Message-ID: <874o10t68d.fsf@ti.com>
References: <1312899309-24067-1-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-2-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-3-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-4-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-5-git-send-email-keshava_mgowda@ti.com>
	<1312899309-24067-6-git-send-email-keshava_mgowda@ti.com>
	<20110810163142.GA10156@google.com>
	<CAP05o4L+qn4K=jLx5Jo8WsG7LnU=VniQSR+fLc=RM5mW4kP1OQ@mail.gmail.com>
	<20110812213037.GA24803@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110812213037.GA24803-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> (Todd Poynor's message of
	"Fri, 12 Aug 2011 14:30:37 -0700")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Todd Poynor <toddpoynor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, vikram.pandita-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Todd Poynor <toddpoynor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> writes:

> On Fri, Aug 12, 2011 at 12:20:21PM +0530, Munegowda, Keshava wrote:
>> On Wed, Aug 10, 2011 at 10:01 PM, Todd Poynor <toddpoynor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org=
> wrote:
>> >> @@ -913,12 +598,15 @@ static int usbhs_enable(struct device *dev)
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pdata->ehci_data->reset_gpio_po=
rt[1], 1);
>> >> =C2=A0 =C2=A0 =C2=A0 }
>> >>
>> >> -end_count:
>> >> - =C2=A0 =C2=A0 omap->count++;
>> >> + =C2=A0 =C2=A0 pm_runtime_put_sync(dev);
>> >> =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&omap->lock, flags);
>> >
>> > Is pm_runtime_irq_safe() needed (else I think runtime PM callbacks=
 may
>> > re-enable IRQs... or there's the new *_suspend runtime PM calls th=
at
>> > may avoid this)?
>>=20
>>  pm_runtime_irq_safe()  is not required; usbhs does not have a paren=
t
>> and it is the parent driver of
>> ehci and ohci drivers.
>
> But the above expects IRQs to be disabled during the
> pm_runtime_put_sync, and synchronous calls can turn IRQs back on in
> rpm_idle:
>
>         if (callback) {
>                 spin_unlock_irq(&dev->power.lock);
>
>                 callback(dev);
>
> I see other folks who know this better than me are discussing USB run
> time PM and might_sleep contexts, so I'll note this concern and let
> others chime in if they think there's a real problem here.

=46YI... The commit below fixes this mainline (merged as of v3.1-rc4).

Kevin


commit 02b26774afebb2d62695ba3230319d70d8c6cc2d
Author: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Date:   Fri Aug 5 21:45:20 2011 +0200

    PM / Runtime: Allow _put_sync() from interrupts-disabled context
   =20
    Currently the use of pm_runtime_put_sync() is not safe from
    interrupts-disabled context because rpm_idle() will release the
    spinlock and enable interrupts for the idle callbacks.  This enable=
s
    interrupts during a time where interrupts were expected to be
    disabled, and can have strange side effects on drivers that expecte=
d
    interrupts to be disabled.
   =20
    This is not a bug since the documentation clearly states that only
    _put_sync_suspend() is safe in IRQ-safe mode.
   =20
    However, pm_runtime_put_sync() could be made safe when in IRQ-safe
    mode by releasing the spinlock but not re-enabling interrupts, whic=
h
    is what this patch aims to do.
   =20
    Problem was found when using some buggy drivers that set
    pm_runtime_irq_safe() and used _put_sync() in interrupts-disabled
    context.
   =20
    Reported-by: Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
    Tested-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
    Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
    Signed-off-by: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
