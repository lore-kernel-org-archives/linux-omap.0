From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH] usb: musb: dsps: disable the otg_timer while going to sleep
Date: Tue, 8 Oct 2013 12:44:16 +0200
Message-ID: <20131008104416.GA5558@linutronix.de>
References: <1380643921-20642-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380643921-20642-1-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Testing with "freeze" I run into:

| PM: Syncing filesystems ... done.
| PM: Preparing system for freeze sleep
| Freezing user space processes ... (elapsed 0.002 seconds) done.
| Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
| PM: Entering freeze sleep
| usb usb2: usb auto-resume
| hub 2-0:1.0: hub_resume
| hub 2-0:1.0: hub_suspend
| usb usb2: bus suspend, wakeup 0
| usb usb1: usb auto-resume
| hub 1-0:1.0: hub_resume
| hub 1-0:1.0: hub_suspend
| usb usb1: bus suspend, wakeup 0
| PM: suspend of devices complete after 54.622 msecs
| PM: late suspend of devices complete after 4.782 msecs
| PM: noirq suspend of devices complete after 4.990 msecs
| Unhandled fault: external abort on non-linefetch (0x1008) at 0xf0442460
| Internal error: : 1008 [#1] ARM
| PC is at otg_timer+0x28/0x140 [musb_dsps]

This is comming from first dsps_readb() in otg_timer(). The problem is
that the device is already suspended (the clocks are off) and the timer
tries to access register which fails.
Since there is no need to keep this timer aroud while the device is
going to suspend I suggest to remove the timer in suspend and queue it
in the resume path.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
I don't have the "suspend" target in "state" just the "freezer" and with
it I get into trouble in the otg_timer(). This triggers a few seconds
after the suspend but since this depends on timming, it might trigger
just a few secs after the suspend.
What about the this?

 drivers/usb/musb/musb_dsps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index ced2b76..61b3f3e 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -659,6 +659,7 @@ static int dsps_suspend(struct device *dev)
 	glue->context.tx_mode = dsps_readl(mbase, wrp->tx_mode);
 	glue->context.rx_mode = dsps_readl(mbase, wrp->rx_mode);
 
+	del_timer_sync(&glue->timer);
 	return 0;
 }
 
@@ -679,6 +680,7 @@ static int dsps_resume(struct device *dev)
 
 	musb->port_reset_state = false;
 	schedule_work(&musb->port_reset_work);
+	mod_timer(&glue->timer, jiffies + wrp->poll_seconds * HZ);
 
 	return 0;
 }
-- 
1.8.4.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
