From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: usb: musb: regression since 4.9 on omap4-panda-es (caused by
 d8e5f0eca1e8)
Date: Wed, 5 Apr 2017 08:29:55 -0700
Message-ID: <20170405152954.GF13234@atomide.com>
References: <2bf73b02-6e59-627a-c370-552ed94e7795@ti.com>
 <20170404122736.GA13673@uda0271908>
 <20170404140341.GO10760@atomide.com>
 <20170405003637.GB13234@atomide.com>
 <dda7b6b0-b533-dfd6-1b12-b320bd69b623@ti.com>
 <20170405134655.GD13234@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170405134655.GD13234-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170405 06:53]:
> * Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [170405 00:15]:
> > To be precise this is what I have tried:
> > - boot w/o cable connected
> > - boot w/ board connected to PC (device mode)
> > - boot w/ OTG-A cable with USB keyboard
> > - boot w/ OTG-A cable connected to powered USB hub and the same keyboard
> > 
> > w/ and w/o this patch I have the same flood of prints in all cases.
> 
> OK interesting that it also happens with nothing connected.
> 
> > Fwiw I have checked where the is_active is set - which causes the prints:
> > musb_core.c:musb_start()
> > 
> > if (musb->port_mode != MUSB_PORT_MODE_HOST &&
> > 		musb->xceiv->otg->state != OTG_STATE_A_WAIT_BCON &&
> > 		(devctl & MUSB_DEVCTL_VBUS) == MUSB_DEVCTL_VBUS) {
> > 	musb->is_active = 1;
> > } else {
> > 	devctl |= MUSB_DEVCTL_SESSION;
> > }
> > 
> > this was the only place where the is_active was set to 1.
> 
> That seems normal in musb_start(). Will try with your .config
> here.

If the the port is configured as OTG, we should not need to
try to force any states during init. The change below will stop
the warnings with your .config, needs to be tested more though
to make sure things still work in all cases.

Regards,

Tony

8< --------------------------
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2780,10 +2780,11 @@ int musb_host_setup(struct musb *musb, int power_budget)
 	int ret;
 	struct usb_hcd *hcd = musb->hcd;
 
-	MUSB_HST_MODE(musb);
-	musb->xceiv->otg->default_a = 1;
-	musb->xceiv->otg->state = OTG_STATE_A_IDLE;
