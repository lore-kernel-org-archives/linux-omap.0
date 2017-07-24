From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] USB: musb: fix external abort on suspend
Date: Mon, 24 Jul 2017 11:49:39 +0200
Message-ID: <20170724094939.21477-1-johan@kernel.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Make sure that the controller is runtime resumed when system suspending
to avoid an external abort when accessing the interrupt registers:

  Unhandled fault: external abort on non-linefetch (0x1008) at 0xd025840a
  ...
  [<c05481a4>] (musb_default_readb) from [<c0545abc>] (musb_disable_interrupts+0x84/0xa8)
  [<c0545abc>] (musb_disable_interrupts) from [<c0546b08>] (musb_suspend+0x38/0xb8)
  [<c0546b08>] (musb_suspend) from [<c04a57f8>] (platform_pm_suspend+0x3c/0x64)

This is easily reproduced on a BBB by enabling the peripheral port only
(as the host port may enable the shared clock) and keeping it
disconnected so that the controller is runtime suspended. (Well, you
would also need to the not-yet-merged am33xx-suspend patches by Dave
Gerlach to be able to suspend the BBB.)

This is a regression that was introduced by commit 1c4d0b4e1806 ("usb:
musb: Remove pm_runtime_set_irq_safe") which allowed the parent glue
device to runtime suspend and thereby exposed a couple of older issues:

Register accesses without explicitly making sure the controller is
runtime resumed during suspend was first introduced by commit
c338412b5ded ("usb: musb: unconditionally save and restore the context
on suspend") in 3.14.

Commit a1fc1920aaaa ("usb: musb: core: make sure musb is in RPM_ACTIVE on
resume") later started setting the RPM status to active during resume
without first making sure that the parent was runtime resumed. This was
also implicitly relying on the parent always being active. Since commit
71723f95463d ("PM / runtime: print error when activating a child to
unactive parent") this now also results in following warning:

  musb-hdrc musb-hdrc.0: runtime PM trying to activate child device
    musb-hdrc.0 but parent (47401400.usb) is not active

This patch has been verified on 4.13-rc2, 4.12 and 4.9 using a BBB
(the dsps glue would always be active also in 4.8).

Fixes: c338412b5ded ("usb: musb: unconditionally save and restore the context on suspend")
Fixes: a1fc1920aaaa ("usb: musb: core: make sure musb is in RPM_ACTIVE on resume")
Fixes: 1c4d0b4e1806 ("usb: musb: Remove pm_runtime_set_irq_safe")
Cc: stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>	# 4.8
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/usb/musb/musb_core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 87cbd56cc761..b67692857daf 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2671,6 +2671,13 @@ static int musb_suspend(struct device *dev)
 {
 	struct musb	*musb = dev_to_musb(dev);
 	unsigned long	flags;
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
 
 	musb_platform_disable(musb);
 	musb_disable_interrupts(musb);
@@ -2721,14 +2728,6 @@ static int musb_resume(struct device *dev)
 	if ((devctl & mask) != (musb->context.devctl & mask))
 		musb->port1_status = 0;
 
-	/*
-	 * The USB HUB code expects the device to be in RPM_ACTIVE once it came
-	 * out of suspend
-	 */
-	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
