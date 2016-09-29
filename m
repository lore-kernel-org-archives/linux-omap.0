From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCHv2] usb: musb: Fix unbalanced platform_disable
Date: Thu, 29 Sep 2016 12:38:17 +0300
Message-ID: <3141427.tsfBWKPfxW@avalon>
References: <20160912153947.k4gnggur6usyujii@atomide.com> <20160920183701.nxme7yxgc6jpmgio@atomide.com> <20160928184234.zoleas3mvpxso36r@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160928184234.zoleas3mvpxso36r-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Wednesday 28 Sep 2016 11:42:35 Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160920 11:37]:
> > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160920 10:11]:
> >> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [160919 23:36]:
> >>> No, I perform the following steps:
> >>> 
> >>> - Connect the panda board to the USB through USB (which powers the
> >>> board on) - Let the board boot over NFS
> >>> - Log in as root, run 'reboot'
> >>> 
> >>> The second boot produces the warning.
> >> 
> >> Oh I was looking at the errors while shutting down things.. OK yeah I
> >> get that too along with a bunch of DSS related warnings with your
> >> .config. Probably I did not notice it earlier because of the DSS
> >> warnings. Will take a look.
> > 
> > The patch below fixes the issue for me, care to give it a try?
> > 
> > If that works for you I'll repost with a proper patch description.
> 
> Laurent, any news on when you may be able to test this one?

I just did and your patch fixes the problem for me, thanks.

Tested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> > 8< ------------------------
> > diff --git a/drivers/usb/musb/musb_gadget.c
> > b/drivers/usb/musb/musb_gadget.c --- a/drivers/usb/musb/musb_gadget.c
> > +++ b/drivers/usb/musb/musb_gadget.c
> > @@ -1255,6 +1255,7 @@ static int musb_gadget_queue(struct usb_ep *ep,
> > struct usb_request *req,
> >  	map_dma_buffer(request, musb, musb_ep);
> > 
> > +	pm_runtime_get_sync(musb->controller);
> >  	spin_lock_irqsave(&musb->lock, lockflags);
> >  	
> >  	/* don't queue if the ep is down */
> > @@ -1275,6 +1276,9 @@ static int musb_gadget_queue(struct usb_ep *ep,
> > struct usb_request *req,> 
> >  unlock:
> >  	spin_unlock_irqrestore(&musb->lock, lockflags);
> > 
> > +	pm_runtime_mark_last_busy(musb->controller);
> > +	pm_runtime_put_autosuspend(musb->controller);
> > +
> >  	return status;
> >  }

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
