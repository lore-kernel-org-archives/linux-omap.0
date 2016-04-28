From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 03/10] usb: musb: Fix PM runtime handling for connected
 cable
Date: Thu, 28 Apr 2016 11:07:42 -0700
Message-ID: <20160428180741.GF5995@atomide.com>
References: <1461864800-29979-1-git-send-email-tony@atomide.com>
 <1461864800-29979-4-git-send-email-tony@atomide.com>
 <57224E1F.7040707@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57224E1F.7040707-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org> [160428 10:55]:
> Hello.
> 
> On 04/28/2016 08:33 PM, Tony Lindgren wrote:
> 
> >We may have drivers loaded but no configured gadgets
> >and MUSB may be in host mode. If gadgets are configured
> >during host mode, PM runtime will get confused.
> >
> >Disconnect PM runtime from gadget state, and do it only
> >based on the cable.
> >
> >Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> >---
> >  drivers/usb/musb/omap2430.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> >
> >diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> >index c84e0322..9d3645f 100644
> >--- a/drivers/usb/musb/omap2430.c
> >+++ b/drivers/usb/musb/omap2430.c
> >@@ -259,6 +259,13 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
> >  	struct musb_hdrc_platform_data *pdata = dev_get_platdata(dev);
> >  	struct omap_musb_board_data *data = pdata->board_data;
> >  	struct usb_otg *otg = musb->xceiv->otg;
> >+	bool cable_connected;
> >+
> >+	cable_connected = ((glue->status & MUSB_ID_GROUND) ||
> >+			   (glue->status & MUSB_VBUS_VALID));
> 
> 	cable_connected = glue->status & (MUSB_ID_GROUND |
> 					MUSB_VBUS_VALID);

Thanks, actually that's an enumeration so needs fixing.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
