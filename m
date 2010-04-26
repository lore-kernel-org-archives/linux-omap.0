From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: Fix tusb6010 for DMA API (Re: [patch-2.6.34-rc2+
 00/11] musb patches (v2))
Date: Mon, 26 Apr 2010 12:10:51 -0700
Message-ID: <20100426191051.GK7225@atomide.com>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
 <20100423210854.GA13366@kroah.com>
 <20100423212307.GY18272@atomide.com>
 <20100423220853.GA16165@kroah.com>
 <20100425133531.GB2219@gandalf>
 <20100426175324.GE7225@atomide.com>
 <20100426190246.GA8772@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100426190246.GA8772-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> [100426 12:00]:
> On Mon, Apr 26, 2010 at 10:53:24AM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org> [100425 06:30]:
> > > On Fri, Apr 23, 2010 at 03:08:53PM -0700, Greg KH wrote:
> > > > On Fri, Apr 23, 2010 at 02:23:08PM -0700, Tony Lindgren wrote:
> > > > > * Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> [100423 14:05]:
> > > > > > On Thu, Mar 25, 2010 at 01:14:22PM +0200, Felipe Balbi wrote:
> > > > > > > Hi Greg,
> > > > > > > 
> > > > > > > sorry for the last time. There was a bug in my script
> > > > > > > which caused it to rebased against the wrong branch.
> > > > > > 
> > > > > > All queued up, thanks
> > > > > 
> > > > > This compile fix still needs to be queued too. Can also
> > > > > merge via omap tree if you guys ack.
> > > > 
> > > > That's up to Felipe.  I have no objection to it, it's his call.
> > > 
> > > please Greg take it. I seem to have missed from my queue.
> > > 
> > > fwiw:
> > > 
> > > Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > 
> > Greg, here's the patch for you one more time with updated comments
> > as suggested by Anand regarding the dummy musb_platform_save and
> > restore functions. Also added Felipe's Ack there.
> 
> Now queued up.

OK, thanks!

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
