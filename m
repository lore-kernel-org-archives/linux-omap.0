From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Tue, 8 May 2012 09:24:36 -0700
Message-ID: <20120508162436.GA10200@kroah.com>
References: <Pine.LNX.4.44L0.1205071046350.1602-100000@iolanthe.rowland.org>
 <4FA8D108.7090004@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FA8D108.7090004-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 08, 2012 at 10:53:44AM +0300, Igor Grinberg wrote:
> On 05/07/12 17:48, Alan Stern wrote:
> > On Mon, 7 May 2012, Igor Grinberg wrote:
> > 
> >> On 05/07/12 17:04, Alan Stern wrote:
> >>> On Sun, 6 May 2012, Igor Grinberg wrote:
> >>>
> >>>> Hi Alan,
> >>>
> >>> ...
> >>>
> >>>> Sorry, for being jumpy...
> >>>> Samuel has not answered yet (it has been more then two weeks already)
> >>>> and I'd like this to go into 3.5.
> >>>> Also, the dependency patch is already in Linus' tree. It has been merged with
> >>>> fixes (I thought it will happen only during the merge window...).
> >>>>
> >>>> Can you, please take this one?
> >>>
> >>> No, I can't, sorry.  It has to be accepted by Greg KH.
> >>
> >> Hmm... I don't mind it be that way, but I'd like to understand:
> >>
> >> # scripts/get_maintainer.pl -f drivers/usb/host/ehci-omap.c
> >> Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> (maintainer:USB EHCI DRIVER)
> >> Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> (maintainer:OMAP USB SUPPORT)
> >> Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org> (supporter:USB SUBSYSTEM)
> >> linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:USB EHCI DRIVER)
> >> linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:OMAP USB SUPPORT)
> >> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
> >>
> >> This makes you the USB EHCI maintainer, right?
> > 
> > Right.
> > 
> >> I just want to understand...
> >> Do you need also ack from Greg to take something to your tree
> >> for being applied in the next merge window?
> > 
> > No.  I don't takes patches at all, and in fact I don't even have a git
> > directory or a login account at kernel.org.  All my work goes through
> > Greg; I submit or acknowledge patches and he merges them.
> 
> Ah, I see. Thanks for the explanation.
> So currently, I need to do something like this:
> 
> Greg,
> 
> This patch has been acked by Alan and Felipe, can you please apply it
> for the merge window (which is close as I understand from Linus':
> "We've never been closer to a 3.4 release").

Ok, but it's fallen out of my email archive (I only keep the past month
around), so can you please resend it, with Alan and Felipe's acks, so I
can apply it?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
