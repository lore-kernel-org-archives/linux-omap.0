From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: phy: twl4030-usb: Fix lost interrupts after ID pin
 goes down
Date: Fri, 22 Aug 2014 09:39:18 -0700
Message-ID: <20140822163918.GG10066@atomide.com>
References: <20140821164803.GB10066@atomide.com>
 <CANOLnOM_5VXDAstbQN45wRyYq9k26PWM0z9uZ+C2VmhOqzCuEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANOLnOM_5VXDAstbQN45wRyYq9k26PWM0z9uZ+C2VmhOqzCuEw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [140822 06:21]:
> Hi,
> 
> On Thu, Aug 21, 2014 at 7:48 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > Commit 249751f22380 ("usb: phy: twl4030-usb: poll for ID disconnect")
> > added twl4030_id_workaround_work() to deal with lost interrupts
> > after ID pin goes down. However, this currently only works for the
> > insertion. The PHY interrupts are not working after disconnecting
> > an USB-A device from the board, and the deeper idle states for
> > omap are blocked as the USB controller stays busy.
> >
> > The issue can be solved by calling delayed work from twl4030_usb_irq()
> > when ID pin is down and the PHY is not asleep like we already do
> > in twl4030_id_workaround_work().
> 
> The way it is supposed to work is that after plugging in the cable
> twl4030_phy_power_on() sees ID_GROUND and kicks off id_workaround_work
> every second. When cable is unplugged, twl4030_id_workaround_work()
> sees changes in STS_HW_CONDITIONS register and triggers events.
> Doesn't that work for you, why do you need to trigger it from
> twl4030_usb_irq() too?

Not any longer because we are currently call schedule_delayed_work()
only from twl4030_phy_power_on(). That function got renamed, it used
to be twl4030_phy_resume() before the generic phy framework
changes.

So looking at the v3.12 code, you're right, it seems to behave as
you describe. That however changed with the generic phy framework
changes for v3.13, and looks like the correct breaking commit is
f1ddc24c9e33 ("usb: phy: twl4030-usb: remove *set_suspend* and
*phy_init* ops") instead.

So it won't currently work after unplugging and replugging as all
connect and disconnect interrupts go unnoticed after ID_GROUND.
So we need to poll whenever ID_GROUND and PHY is not asleep.

> > But as both twl4030_usb_irq() and twl4030_id_workaround_work()
> > already do pretty much the same thing, let's call twl4030_usb_irq()
> > from twl4030_id_workaround_work() instead of adding some more
> > duplicate code.
> 
> The difference is the sysfs_notify() call, so now every time
> id_workaround_work triggers (around once per second while the cable is
> plugged) userspace will now get useless uevent. Haven't actually
> checked if it really happens though, so I might be wrong.

Good point. That can be avoided by doing calling it only if we have
an irq and not from delayed work. Updated patch below, I've updated
the description for the proper regression causing commit and
added a check when to call the sysfs_notify. Kept Felipe's ack,
hope that works.

Regards,

Tony

8< ---------------------
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Thu, 21 Aug 2014 08:59:43 -0700
Subject: [PATCH] usb: phy: twl4030-usb: Fix lost interrupts after ID pin goes down

Commit 249751f22380 ("usb: phy: twl4030-usb: poll for ID disconnect")
added twl4030_id_workaround_work() to deal with lost interrupts
after ID pin goes down. Looks like commit f1ddc24c9e33 ("usb: phy:
twl4030-usb: remove *set_suspend* and *phy_init* ops") changed
things around for the generic phy framework, and delayed work no
longer got called except initially during boot.

The PHY connect and disconnect interrupts for twl4030-usb are not
working after disconnecting a USB-A cable from the board, and the
deeper idle states for omap are blocked as the USB controller
stays busy.

The issue can be solved by calling delayed work from twl4030_usb_irq()
when ID pin is down and the PHY is not asleep like we already do
in twl4030_id_workaround_work().

But as both twl4030_usb_irq() and twl4030_id_workaround_work()
already do pretty much the same thing, let's call twl4030_usb_irq()
from twl4030_id_workaround_work() instead of adding some more
duplicate code. We also must call sysfs_notify() only when we have
an interrupt and not from the delayed work as notified by
Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>.

Fixes: f1ddc24c9e33 ("usb: phy: twl4030-usb: remove *set_suspend* and *phy_init* ops")
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v3.13+
Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -560,7 +560,15 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 		 */
 		omap_musb_mailbox(status);
 	}
-	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
+
+	/* don't schedule during sleep - irq works right then */
+	if (status == OMAP_MUSB_ID_GROUND && !twl->asleep) {
+		cancel_delayed_work(&twl->id_workaround_work);
+		schedule_delayed_work(&twl->id_workaround_work, HZ);
+	}
+
+	if (irq)
+		sysfs_notify(&twl->dev->kobj, NULL, "vbus");
 
 	return IRQ_HANDLED;
 }
@@ -569,29 +577,8 @@ static void twl4030_id_workaround_work(struct work_struct *work)
 {
 	struct twl4030_usb *twl = container_of(work, struct twl4030_usb,
 		id_workaround_work.work);
-	enum omap_musb_vbus_id_status status;
-	bool status_changed = false;
-
-	status = twl4030_usb_linkstat(twl);
-
-	spin_lock_irq(&twl->lock);
-	if (status >= 0 && status != twl->linkstat) {
-		twl->linkstat = status;
-		status_changed = true;
-	}
-	spin_unlock_irq(&twl->lock);
