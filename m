From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [024/115] USB: prevent buggy hubs from crashing the USB stack
Date: Thu, 24 Feb 2011 12:57:20 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102241255100.2084-100000@iolanthe.rowland.org>
References: <20110224172327.GF3528@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110224172327.GF3528@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg KH <gregkh@suse.de>, Alexander Holler <holler@ahsoftware.de>, Michael Jones <michael.jones@matrix-vision.de>, Kernel development list <linux-kernel@vger.kernel.org>, stable@kernel.org, stable-review@kernel.org, torvalds@linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, USB list <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 24 Feb 2011, Felipe Balbi wrote:

> On Thu, Feb 24, 2011 at 09:18:14AM -0800, Greg KH wrote:
> > On Thu, Feb 24, 2011 at 11:16:38AM +0200, Felipe Balbi wrote:
> > > Hi,
> > > 
> > > On Thu, Feb 24, 2011 at 10:15:23AM +0100, Alexander Holler wrote:
> > > > >On Wed, Feb 23, 2011 at 10:26:20AM -0500, Alan Stern wrote:
> > > > >>In both cases, it appears that the problem is caused by the fact that
> > > > >>the musb host-controller driver doesn't set the hcd->has_tt flag.
> > > > >>
> > > > >>Felipe, you should know where it belongs.  It should be easy enough to
> > > > >>add.
> > > > >
> > > > >Sure Alan, it's attached to this mail. Compile tested only though.
> > > > >Michael, would you care to give your tested-by ?
> > > > 
> > > > I can do, I'm using exactly the same patch since yesterday. ;)
> > > > 
> > > > Tested-by: Alexander Holler <holler@ahsoftware.de>
> > > 
> > > Thanks a lot Alex, Greg, can you still take this to -rc ? Do you need a
> > > pull request or you can take this one patch ?
> > 
> > Wait, where does this need to go?  For the final 2.6.38 release and then
> > also for .37-stable?
> > 
> > Or just .37-stable?
> > 
> > confused.
> > 
> > And no, I don't need a pull request, I can handle one patch through
> > email :)
> 
> final .38 and .37-stable :-) Thanks Greg :-)

It's important that this patch appear in .37-stable at the same time as
the $SUBJECT patch.  If that means delaying $SUBJECT for one release, 
so be it -- it was not a very important change.

Alan Stern
