From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] usb: Fix tusb6010 for DMA API (Re: [patch-2.6.34-rc2+
 00/11] musb patches (v2))
Date: Fri, 23 Apr 2010 15:08:53 -0700
Message-ID: <20100423220853.GA16165@kroah.com>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
 <20100423210854.GA13366@kroah.com>
 <20100423212307.GY18272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100423212307.GY18272-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 23, 2010 at 02:23:08PM -0700, Tony Lindgren wrote:
> * Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> [100423 14:05]:
> > On Thu, Mar 25, 2010 at 01:14:22PM +0200, Felipe Balbi wrote:
> > > Hi Greg,
> > > 
> > > sorry for the last time. There was a bug in my script
> > > which caused it to rebased against the wrong branch.
> > 
> > All queued up, thanks
> 
> This compile fix still needs to be queued too. Can also
> merge via omap tree if you guys ack.

That's up to Felipe.  I have no objection to it, it's his call.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
