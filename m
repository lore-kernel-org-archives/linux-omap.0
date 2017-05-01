From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: musb: Fix trying to suspend while active for OTG
 configurations
Date: Mon, 1 May 2017 13:09:56 -0500
Message-ID: <20170501180956.GA9203@uda0271908>
References: <20170407143528.4753-1-tony@atomide.com>
 <786d8296-e7b0-b8c7-fa5f-d9d34633ae04@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <786d8296-e7b0-b8c7-fa5f-d9d34633ae04-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 19, 2017 at 11:22:55AM +0300, Peter Ujfalusi wrote:
> 
> 
> On 2017-04-07 17:35, Tony Lindgren wrote:
> >Commit d8e5f0eca1e8 ("usb: musb: Fix hardirq-safe hardirq-unsafe
> >lock order error") caused a regression where musb keeps trying to
> >enable host mode with no cable connected. This seems to be caused
> >by the fact that now phy is enabled earlier, and we are wrongly
> >trying to force USB host mode on an OTG port. The errors we are
> >getting are "trying to suspend as a_idle while active".
> >
> >For ports configured as OTG, we should not need to do anything
> >to try to force USB host mode on it's OTG port. Trying to force host
> >mode in this case just seems to completely confuse the musb state
> >machine.
> >
> >Let's fix the issue by making musb_host_setup() attempt to force the
> >mode only if port_mode is configured for host mode.
> 
> Tested-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> 
> >
> >Fixes: d8e5f0eca1e8 ("usb: musb: Fix hardirq-safe hardirq-unsafe
> >lock order error")
> >Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >Reported-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> >Reported-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> >Tested-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> >Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Applied. Thanks.
-Bin.


> >---
> > drivers/usb/musb/musb_host.c | 9 +++++----
> > 1 file changed, 5 insertions(+), 4 deletions(-)
> >
> >diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> >--- a/drivers/usb/musb/musb_host.c
> >+++ b/drivers/usb/musb/musb_host.c
> >@@ -2780,10 +2780,11 @@ int musb_host_setup(struct musb *musb, int power_budget)
> > 	int ret;
> > 	struct usb_hcd *hcd = musb->hcd;
> >
> >-	MUSB_HST_MODE(musb);
> >-	musb->xceiv->otg->default_a = 1;
> >-	musb->xceiv->otg->state = OTG_STATE_A_IDLE;
> >-
> >+	if (musb->port_mode == MUSB_PORT_MODE_HOST) {
> >+		MUSB_HST_MODE(musb);
> >+		musb->xceiv->otg->default_a = 1;
> >+		musb->xceiv->otg->state = OTG_STATE_A_IDLE;
> >+	}
> > 	otg_set_host(musb->xceiv->otg, &hcd->self);
> > 	hcd->self.otg_port = 1;
> > 	musb->xceiv->otg->host = &hcd->self;
> >
> 
> - Péter
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
