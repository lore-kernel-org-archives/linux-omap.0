From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] usb: musb: Fix hardirq-safe hardirq-unsafe lock order error
Date: Fri, 30 Sep 2016 11:10:09 -0700
Message-ID: <20160930181010.3829-2-tony@atomide.com>
References: <20160930181010.3829-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160930181010.3829-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

If we configure musb with 2430 glue as a peripheral, and then rmmod
omap2430 module, we'll get the following error:

[ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
...
rmmod/413 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 (&phy->mutex){+.+.+.}, at: [<c04b9fd0>] phy_power_off+0x1c/0xb8
[  204.678710]
               and this task is already holding:
 (&(&musb->lock)->rlock){-.-...}, at: [<bf3a482c>]
 musb_gadget_stop+0x24/0xec [musb_hdrc]
which would create a new lock dependency:
 (&(&musb->lock)->rlock){-.-...} -> (&phy->mutex){+.+.+.}
...

This is because some glue layers expect musb_platform_enable/disable
to be called with spinlock held, and 2430 glue layer has USB PHY on
the I2C bus using a mutex.

We could fix the glue layers to take the spinlock, but we still have
a problem of musb_plaform_enable/disable being called in an unbalanced
manner. So that would still lead into USB PHY enable/disable related
problems for omap2430 glue layer.

While it makes sense to only enable USB PHY when needed from PM point
of view, in this case we just can't do it yet without breaking things.
So let's just revert phy_enable/disable related changes instead and
reconsider this after we have fixed musb_platform_enable/disable to
be balanced.

Fixes: a83e17d0f73b ("usb: musb: Improve PM runtime and phy handling
for 2430 glue layer")
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/omap2430.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -287,6 +287,7 @@ static int omap2430_musb_init(struct musb *musb)
 	}
 	musb->isr = omap2430_musb_interrupt;
 	phy_init(musb->phy);
+	phy_power_on(musb->phy);
 
 	l = musb_readl(musb->mregs, OTG_INTERFSEL);
 
@@ -323,8 +324,6 @@ static void omap2430_musb_enable(struct musb *musb)
 	struct musb_hdrc_platform_data *pdata = dev_get_platdata(dev);
 	struct omap_musb_board_data *data = pdata->board_data;
 
-	if (!WARN_ON(!musb->phy))
-		phy_power_on(musb->phy);
 
 	switch (glue->status) {
 
@@ -361,9 +360,6 @@ static void omap2430_musb_disable(struct musb *musb)
 	struct device *dev = musb->controller;
 	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
 
-	if (!WARN_ON(!musb->phy))
-		phy_power_off(musb->phy);
