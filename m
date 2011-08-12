From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Re: [PATCH] usb: musb: use put_sync_suspend instead of put_sync
Date: Fri, 12 Aug 2011 06:55:06 -0700
Message-ID: <CAFm5wm3vsOye4uMA3f5f6u5emGb2fk4n3Yc+aRUGHJM8PJ+DnA@mail.gmail.com>
References: <1312494011-18745-1-git-send-email-m-sonasath@ti.com>
 <87fwlgww0y.fsf@ti.com> <20110812090106.GH19467@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:40816 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752678Ab1HLNz3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Aug 2011 09:55:29 -0400
In-Reply-To: <20110812090106.GH19467@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Moiz Sonasath <m-sonasath@ti.com>, linux-usb@vger.kernel.org, ccross@google.com, linux-omap@vger.kernel.org, gregkh@suse.de, Axel Haslam <axelhaslam@ti.com>

On Fri, Aug 12, 2011 at 2:01 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> (sorry for top-posting)
>
> Moiz, are we going to have another set of this ?

The problem was with pm_runtime() functions getting called from atomic
context and we did a work around by calling the runtime functions from
a work queue.
That seems to fix the issue. We will post that out as an alternative
to marking the irq_safe and thus causing the parent to never idle.


>
> On Thu, Aug 04, 2011 at 05:18:37PM -0700, Kevin Hilman wrote:
>> Moiz Sonasath <m-sonasath@ti.com> writes:
>>
>> > From: Axel Haslam <axelhaslam@ti.com>
>> >
>> > As Documented in runtime documentation, drivers can call put_sync
>> > in contexts where sleep is allowed, in contexts where sleep is not
>> > possible, the drivers need to mark these as to be made interrupt
>> > safe and also use put_sync_suspend instead of put_sync as the idle
>> > callbacks will be called with interrupt enabled - which is not
>> > a good thing to happen in isr context.
>>
>> There are several things happening in this patch, and I think this n=
eeds
>> to be broken into separate fixes/features.
>>
>> Re: the put_sync_suspend change, for mainline, I posted a fix that
>> allows a "normal" _put_sync() to work from IRQ-safe context:
>>
>> https://lists.linux-foundation.org/pipermail/linux-pm/2011-July/0322=
61.html
>>
>> That will be merging for v3.2, likely for v3.1-rc and possible for
>> v3.0.stable, so while changing the driver is harmless, it's no longe=
r
>> necessary.
>>
>> [...]
>>
>> > A call to pm_runtime_irq_safe, will indefently prevent the parent =
from
>> > sleeping by doing a call to get-sync on the parent. =A0this is "to
>> > prevent a irq-safe child to wait for a non-irq safe parent." =A0Fo=
r this
>> > reason, the parent runtime-pm suspend is blocked, and we dont let =
L3
>> > and CORE enter into low power.
>>
>> First, you should describe why you need to use pm_runtime_irq_safe()=
 in
>> the first place, since the rest of the "workarounds" in this patch a=
re a
>> result of using that. =A0For those of us not intimately familar with=
 this
>> driver, a description of why IRQ-safe callbacks are needed would be =
most
>> helpful.
>>
>> It might be that a simpler solution would be switching to using
>> asynchronous runtime PM calls so that IRQ-safe mode is not required.
>>
>> > As a workaround, we call the parent runtime functions on the child
>> > runtime hooks, for this to work, the parent has to be set to igner=
e
>> > children, otherwise, even with a "timmed" autosuspend call, will
>> > return BUSY, as the child is not yet suspended.
>>
>> Hmm, why is the child not yet suspended when the parent's autosuspen=
d
>> delay expires?
>>
>> Also, It's not clear to me how the parent is eventually suspending a=
t
>> all. =A0After pm_runtime_irq_safe() is called on the child, the pare=
nt
>> should *never* runtime suspend. =A0 Not only does pm_runtime_irq_saf=
e() do
>> a get_sync() on the parent, but rpm_suspend() has an explict check f=
or
>> !dev->power.irq_safe before suspending the parent.
>>
>> Something else must be going on (actually, going wrong) in order for=
 the
>> parent device to runtime suspend.
>>
>> Is the problem with L3/CORE not runtime suspending? =A0or is it a pr=
oblem
>> with system suspend? =A0If system suspend, are you using current mai=
nline?
>> There is now support at the omap_device level[1] to ensure all devic=
es are
>> idled at the omap_device level during system suspend.
>>
>> > This patch is based off:
>> > https://lkml.org/lkml/2011/7/20/357
>> >
>> > Signed-off-by: Axel Haslam <axelhaslam@ti.com>
>> > Reported-by: Colin Cross <ccross@google.com>
>> > Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
>> > ---
>> > =A0drivers/usb/musb/musb_core.c =A0 | =A0 =A09 +++++++++
>> > =A0drivers/usb/musb/musb_gadget.c | =A0 =A02 +-
>> > =A0drivers/usb/musb/omap2430.c =A0 =A0| =A0 =A04 +++-
>> > =A03 files changed, 13 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_=
core.c
>> > index c71b037..d22bc73 100644
>> > --- a/drivers/usb/musb/musb_core.c
>> > +++ b/drivers/usb/musb/musb_core.c
>> > @@ -1941,7 +1941,11 @@ musb_init_controller(struct device *dev, in=
t nIrq, void __iomem *ctrl)
>> >
>> > =A0 =A0 pm_runtime_use_autosuspend(musb->controller);
>> > =A0 =A0 pm_runtime_set_autosuspend_delay(musb->controller, 200);
>> > + =A0 pm_runtime_use_autosuspend(musb->controller->parent);
>> > + =A0 pm_runtime_set_autosuspend_delay(musb->controller->parent, 5=
00);
>> > + =A0 pm_suspend_ignore_children(musb->controller->parent,true);
>>
>> Running checkpatch would have yelled at you on this line:
>>
>> ERROR: space required after that ',' (ctx:VxV)
>>
>> > =A0 =A0 pm_runtime_enable(musb->controller);
>> > + =A0 pm_runtime_irq_safe(musb->controller);
>> >
>> > =A0 =A0 spin_lock_init(&musb->lock);
>> > =A0 =A0 musb->board_mode =3D plat->mode;
>> > @@ -2375,6 +2379,9 @@ static int musb_runtime_suspend(struct devic=
e *dev)
>> >
>> > =A0 =A0 musb_save_context(musb);
>> >
>> > + =A0 pm_runtime_mark_last_busy(musb->controller->parent);
>> > + =A0 pm_runtime_put_autosuspend(musb->controller->parent);
>> > +
>> > =A0 =A0 return 0;
>> > =A0}
>> >
>> > @@ -2392,6 +2399,8 @@ static int musb_runtime_resume(struct device=
 *dev)
>> > =A0 =A0 =A0* Also context restore without save does not make
>> > =A0 =A0 =A0* any sense
>> > =A0 =A0 =A0*/
>> > + =A0 if (pm_runtime_suspended(dev->parent))
>>
>> Why this check?
>>
>> > + =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(dev->parent);
>> > =A0 =A0 if (!first)
>> > =A0 =A0 =A0 =A0 =A0 =A0 musb_restore_context(musb);
>> > =A0 =A0 first =3D 0;
>> > diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/mus=
b_gadget.c
>> > index 548338c..d5d8f3a 100644
>> > --- a/drivers/usb/musb/musb_gadget.c
>> > +++ b/drivers/usb/musb/musb_gadget.c
>> > @@ -1710,7 +1710,7 @@ static int musb_gadget_pullup(struct usb_gad=
get *gadget, int is_on)
>> > =A0 =A0 }
>> > =A0 =A0 spin_unlock_irqrestore(&musb->lock, flags);
>> >
>> > - =A0 pm_runtime_put(musb->controller);
>> > + =A0 pm_runtime_put_sync_suspend(musb->controller);
>> >
>> > =A0 =A0 return 0;
>> > =A0}
>> > diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap24=
30.c
>> > index c5d4c44..8b6888d 100644
>> > --- a/drivers/usb/musb/omap2430.c
>> > +++ b/drivers/usb/musb/omap2430.c
>> > @@ -471,6 +471,7 @@ static int __init omap2430_probe(struct platfo=
rm_device *pdev)
>> > =A0 =A0 }
>> >
>> > =A0 =A0 pm_runtime_enable(&pdev->dev);
>> > + =A0 pm_runtime_irq_safe(&pdev->dev);
>> >
>> > =A0 =A0 return 0;
>> >
>> > @@ -516,7 +517,8 @@ static int omap2430_runtime_resume(struct devi=
ce *dev)
>> > =A0 =A0 struct musb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *musb =
=3D glue_to_musb(glue);
>> >
>> > =A0 =A0 omap2430_low_level_init(musb);
>> > - =A0 otg_set_suspend(musb->xceiv, 0);
>> > + =A0 if (musb->xceiv)
>> > + =A0 =A0 =A0 =A0 =A0 otg_set_suspend(musb->xceiv, 0);
>>
>> This looks like an unrelated fix that should have it's own patch and
>> description.
>>
>> >
>> > =A0 =A0 return 0;
>> > =A0}
>>
>> Kevin
>>
>>
>>
>> [1] This is merged in mainline for v3.1
>>
>> commit c03f007a8bf0e092caeb6856a5c8a850df10b974
>> Author: Kevin Hilman <khilman@ti.com>
>> Date: =A0 Tue Jul 12 22:48:19 2011 +0200
>>
>> =A0 =A0 OMAP: PM: omap_device: add system PM methods for PM domain h=
andling
>>
>> =A0 =A0 In the omap_device PM domain callbacks, use omap_device idle=
/enable to
>> =A0 =A0 automatically manage device idle states during system suspen=
d/resume.
>>
>> =A0 =A0 If an omap_device has not already been runtime suspended, th=
e
>> =A0 =A0 ->suspend_noirq() method of the PM domain will use omap_devi=
ce_idle()
>> =A0 =A0 to idle the HW after calling the driver's ->runtime_suspend(=
)
>> =A0 =A0 callback. =A0Similarily, upon resume, if the device was susp=
ended during
>> =A0 =A0 ->suspend_noirq(), the ->resume_noirq() method of the PM dom=
ain will
>> =A0 =A0 use omap_device_enable() to enable the HW and then call the =
driver's
>> =A0 =A0 ->runtime_resume() callback.
>>
>> =A0 =A0 If a device has already been runtime suspended, the noirq me=
thods of
>> =A0 =A0 the PM domain leave the device runtime suspended by default.
>>
>> =A0 =A0 However, if a driver needs to runtime resume a device during=
 suspend
>> =A0 =A0 (for example, to change its wakeup settings), it may do so u=
sing
>> =A0 =A0 pm_runtime_get* in it's ->suspend() callback.
>>
>> =A0 =A0 Signed-off-by: Kevin Hilman <khilman@ti.com>
>> =A0 =A0 Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
