From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Anybody working on tidspbridge?
Date: Thu, 10 Jul 2014 09:11:18 -0700
Message-ID: <20140710161118.GA20239@kroah.com>
References: <53A4569B.70604@gmail.com>
 <53A45BBD.4040201@gmail.com>
 <20140629164250.GA31625@kroah.com>
 <53BBE895.4020105@gmail.com>
 <alpine.DEB.2.01.1407081452580.5181@pmeerw.net>
 <20140708143659.GB3104@kroah.com>
 <53BC3A94.4050208@ti.com>
 <20140709070726.GF28884@atomide.com>
 <53BE2A8A.5080001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57183 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbaGJQLi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jul 2014 12:11:38 -0400
Content-Disposition: inline
In-Reply-To: <53BE2A8A.5080001@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Peter Meerwald <pmeerw@pmeerw.net>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jul 10, 2014 at 08:54:18AM +0300, Ivaylo Dimitrov wrote:
> 
> 
> On  9.07.2014 10:07, Tony Lindgren wrote:
> >* Suman Anna <s-anna@ti.com> [140708 11:40]:
> >>Hi Peter,
> >>
> >>On 07/08/2014 09:36 AM, Greg KH wrote:
> >>>On Tue, Jul 08, 2014 at 03:03:58PM +0200, Peter Meerwald wrote:
> >>>>Hello,
> >>>>
> >>>>>>Given the total lack of response here, I suggest just deleting the
> >>>>>>driver.  No one has ever done the "real work" that is going to be
> >>>>>>required to get this code out of staging.  It has had build errors
> >>>>>>causing it to not even be usable for some kernel versions with no one
> >>>>>>noticing, so I doubt anyone cares about it anymore here.
> >>>>>
> >>>>>Cc'ing some more people who might be interested. If no one offers to
> >>>>>work on the driver in the next couple of days, I'll send a patch to
> >>>>>remove it.
> >>>>
> >>>>I'm using the driver (with kernel 3.7) and it works reasonably well for
> >>>>me; removing it seems a bit harsh.
> >>>
> >>>Using it is different from being able to maintain the code and move it
> >>>out of the staging tree.  Also, 3.7 is really old and obsolete, not much
> >>>we can do with that kernel version :)
> >>>
> >>>Are you able to work on the code and do the effort needed to get it out
> >>>of the staging tree?  If so, great, if not, we are going to have to
> >>>delete it, sorry.
> >>
> >>I agree with Greg here. In fact, the current TODO does not do enough
> >>justice to the amount of work required to make it even work on the
> >>latest kernel. Most of the TIers who worked on this driver have moved on
> >>as Kristina would have figured with her bounced emails. So I do suggest
> >>that this driver be deleted from the kernel tree. If there are enough
> >>number of folks using it (not sure how many are out there), it can be
> >>worked on out-of-tree and brought back in a cleaner fashion rather than
> >>keeping a broken stale driver in the kernel.
> >
> >I agree, not much has improved with this driver since it got added into
> >staging except just compile fixes.
> >
> >Regards,
> >
> >Tony
> 
> Well, recently I've sent a couple of patches which implement stuff from TODO
> [1]. However, with the migration to DT, my focus now is to have a
> kernel/userspace that boots at all and this leaves no free cycles for DSP.
> Maybe tidspbridge can be left in staging until DT migration is finished,
> that way me (and maybe other people) will have the time needed to try to
> implement what remains in TODO. Also, keep in mind there will (hopefully) be
> another omap3 end-user device released by the end of the year (Neo900),
> which most probably will gain more developers interested in fixing the DSP
> driver.

I'm really tired of people saying, "maybe sometime in the future we will
work on this" for this driver.  It's not the first time I've heard it,
and it has _never_ come true.  Honestly, I really don't believe it will
ever happen, given that TI doesn't care about this code at all.

If in the future, someone does want to work on this, a simple revert of
the patch that removes the driver will be all that is needed.  Let's do
that instead of hoping that sometime, someone, somewhere, will do this
work.

thanks,

greg k-h
