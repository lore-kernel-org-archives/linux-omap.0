From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: musb: core: Fix handling of the phy
 notifications
Date: Mon, 7 Dec 2015 07:56:47 -0800
Message-ID: <20151207155647.GQ23396@atomide.com>
References: <1448948233-31804-1-git-send-email-tony@atomide.com>
 <1448948233-31804-2-git-send-email-tony@atomide.com>
 <56652F15.4040007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56652F15.4040007-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [151206 23:03]:
> On Tuesday 01 December 2015 11:07 AM, Tony Lindgren wrote:
> > We currently can't unload omap2430 MUSB platform glue driver module and
> > this cause issues for fixing the MUSB code further. The reason we can't
> > remove omap2430 is because it uses the PHY functions and also exports the
> > omap_musb_mailbox function that some PHY drivers are using.
> > 
> > Let's fix the issue by exporting a more generic musb_mailbox function
> > from the MUSB core and allow platform glue layers to register phy_callback
> > function as needed.
> > 
> > And now we can now also get rid of the include/linux/musb-omap.h.
> > 
> > Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
> > Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> > Cc: NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>
> > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> 
> Reviewed-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> > 
> > Probably best that Felipe merges this patch via the USB tree after
> > comments if that works for Kishon? I have another two fixes for the
> 
> That should be okay.

OK thanks!

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
