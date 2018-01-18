From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH v3] usb: ehci-omap: don't complain on -EPROBE_DEFER when
 no PHY found
Date: Thu, 18 Jan 2018 13:50:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1801181346290.1280-100000@iolanthe.rowland.org>
References: <20180118152613.GA22493@lenoch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180118152613.GA22493@lenoch>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 18 Jan 2018, Ladislav Michl wrote:

> On Thu, Jan 18, 2018 at 10:18:41AM -0500, Alan Stern wrote:
> > On Thu, 18 Jan 2018, Ladislav Michl wrote:
> > 
> > > Don't complain on -EPROBE_DEFER when no PHY found, the driver
> > > probe will be retried later.
> > > 
> > > Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> > > Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > > Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> > > ---
> > >  Changes:
> > >  - v2: None, just added Tony's ack
> > >  - v3: Fixed commit message typo spotted by Jaejoong Kim, added Roger's ack
> > 
> > Although there's nothing wrong with making this change, people don't 
> > like to see character strings broken up just to avoid long lines.  Can 
> > you redo the patch without breaking the error message string?
> 
> Sure I could, but I broke that long line intentionaly. Line lenght rule is
> normally broken for string just to allow people grepping for error message in
> source files and I guess everyone sane would grep for "Can't get PHY device for
> port" which is on single line. So this way we:
> 1) respect 80 chars limit
> 2) have error message grepable.
> 
> Do you still insist on making this one long line? (I have no problem sending
> v4, just wanted to give some rationale before I eventually do so)

I don't have hard, set-in-stone views on this.  And I have broken quite 
a few printk strings in my time -- but that was before people reached a 
consensus on whether it should be done.

Even with the rationale, it's quite likely that somebody will complain
if we merge a patch that splits the string.  And it's good practice to
make sure that checkpatch.pl doesn't complain, in any case.

So yes, please do resubmit the patch with one long line.  When you do,
you may add

Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
