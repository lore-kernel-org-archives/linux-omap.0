From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: ehci-omap: Update platform header file path
Date: Wed, 25 Nov 2009 10:06:27 -0800
Message-ID: <20091125180627.GF4348@atomide.com>
References: <20091125090259.GB30331@lixom.net>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC2D5A@dbde02.ent.ti.com>
 <20091125091456.GA30595@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091125091456.GA30595-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "gregkh-l3A5Bk7waGM@public.gmane.org" <gregkh-l3A5Bk7waGM@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org> [091125 01:13]:
> On Wed, Nov 25, 2009 at 02:35:56PM +0530, Gadiyar, Anand wrote:
> > Olof Johansson wrote:
> > > 
> > > The OMAP usb header file has moved, update the driver so it 
> > > will build.
> > > 
> > > Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> > > 
> > > ---
> > > 
> > > Greg, any chance you can just ack this so Tony can merge it through his
> > > tree for .33? The header files changes in question are going in through
> > > that tree.
> > > 
> > 
> > I believe it has already been taken care of in Tony's for-next?
> 
> Oh, weird. Looking at the history of the file on git.kernel.org:
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=history;f=drivers/usb/host/ehci-omap.c;hb=HEAD
> 
> It shows Tony making the change on Oct 30, and then 4 fresh merges of
> the driver? That's odd.

Yeah those duplicate commits happen when we rebuild the linux-omap
tree on a new -rc. That's when all the development and testing
branches get merged back in again.

To keep the linux-omap tree pullable all the time, we rebuild 
the linux-omap tree periodically with something like this:

$ git checkout -b tmp-rebuild-1258915893 linus
$ git merge -m "Merge omap-testing" omap-testing
$ git merge -m "Merge for-next" for-next
$ git merge -m "Merge cbus" cbus
$ git merge -s ours master
$ git checkout master
$ git merge tmp-rebuild-1258915893

What I've queued up is in for-next branch, omap-testing and
cbus are just development branches that may get rebased as
needed. And master branch is what people are using for omap
to test things, and that stays pullable.

As we currently carry the ehci-omap patch in omap-testing branch,
it shows up as a merge every time we rebuild. These duplicate
commits will disappear once the echi-omap gets merged to Linus'
tree.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
