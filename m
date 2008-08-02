From: Greg KH <greg@kroah.com>
Subject: Re: USB driver issue
Date: Sat, 2 Aug 2008 11:37:46 -0700
Message-ID: <20080802183746.GB12051@kroah.com>
References: <20080801063024.GE8634@kroah.com> <604137.34126.qm@web53204.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:46743 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108AbYHBSkV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Aug 2008 14:40:21 -0400
Content-Disposition: inline
In-Reply-To: <604137.34126.qm@web53204.mail.re2.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Emanoil Kotsev <deloptes@yahoo.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On Sat, Aug 02, 2008 at 01:51:59AM -0700, Emanoil Kotsev wrote:
> 
> > Why are you needing to download new drivers?  Is not
> > everything you need
> > already in the main kernel tree?  What is missing?
> 
> I am using a dell notebook. I also support my father and wife who have
> also notebooks (toshiba and fujitsu).  We all have pretty a like set
> of hardware (from different vendors and in different versions of
> course) but in general it is
> 
> modem, wireless, video (intel, Nvidia, ATI), pcmcia, MMS/SD slot,
> firewire, irda, bluetooth.  I'm using a hybrid tv usb stick and uvc
> webcam.
> 
> - the modem is not working

Did it ever work?  :)

> - wireless (ipw3945) is not included in the mainstream kernel (after
> compile and isntall it works)

It's included in the main kernel tree, has for a while now.

> - uvcvideo driver is included in the latest kernel version and is
> working (thanks)

Good.

> - analog/dvb tv stick is not working as I see it has been included in
> recent version (2.6.26) but it is looking for the wrong firmware or it
> is simply a code with the same name meant to support the HVR-950
> instead of HVR-900 stick.

Talk to the dvb developers, they should be able to fix this quite
easily.

> - I forgot to mention that I'm not able to sync my phones, so there is
> a chaos in my contacts since I gave up my Palm III and lost my Siemens
> S55 that was working somehow

That should have nothing to do with the kernel.

> I also have a pentium III machine that works as a server where all our
> data is stored and backuped, but this is a different issue I mention
> it only to underline the fact that it is practically impossible to
> compile and test there

Build on a faster machine and copy over the image to it.  That's what I
do for my firewalls.

> My father and my wife have a big trouble with the (ATI,NVidia) drivers
> for their video output and I have a big trouble with dual screen, 3D
> and intel chip

Intel drivers should "just work", but that's an xorg issue, not a kernel
issue most likely.  Have you filed a bug with those developers?  They
are usually very quick to respond.

As for ATI and Nvidia, you are on your own there, sorry, nothing anyone
in the community can do to help you out here, sorry.

> Talking about such companies I don't see the point to use linux at
> all, because getting payed support for instance from SuSE brings me to
> the idea that I could buy an Apple PC with more benefit at the end.

Why?   SuSE offers great support, and so does Red Hat.  Heck, even
Ubuntu offers paid support these days if you are liking Debian-based
systems.  And if you have something else, IBM will support it as well,
they support anything.

If you are using Linux only because you get free support, well, then you
need to use the latest releases as the community is not set up at all to
support older releases, it is impossible.

> Hence the question, also having the presentation about kernel
> development in mind, are you developing the kernel as a kind of sport
> ... or are you developing it so that someone can use it for something?

I'm developing it for use by people.  Somehow it seems to be working :)

> > Minor (2.6.x.y) releases happen with only bugfixes every
> > few weeks.  Perhaps you should use them.  But realize that they are
> > only supported for about 3-4 months, then you are expected to move
> > to the next major release.
> 
> This is the issue 3-4 months are enough for ATI or NVidia to bring a new driver
> Either change the policy or find a solution!

How can I have any influence on what ATI or nvidia does?  They know our
release schedule.  They can look at and run our development releases.
But I have no way of seeing their code or running it.

You should be upset at them, not us.

> > That's how the community works, it is insane for us to
> > do otherwise,
> > just for the overhead alone.
> 
> May be I put another question: what are the plans for moving to 2.7 or
> 2.8 kernel then the 2.6. tree will be open only for bug fixes. The
> changes compared to 2.4 are extreem so if I would like to take
> advantage of features in 2.6 kernel I should live with bug fixes and
> support denial in any 2.6 version

Switching the number means nothing, sorry.

See the presentation I liked to for reasons why we will not be switching
the development model any time soon.

In short, this one works _way_ better than the old one.

> > Given the rate of change in the Linux kernel (faster than any other
> > software project known to man), how do you really expect us to do
> > that?  It's pretty impossible.
> 
> The question is - what are you doing this for? What's your goal - I'm
> going to give up linux soon if it goes this way

No one is forcing you to use Linux.  If you don't like it, how it is
developed, the license for it, or how it works, feel free to switch to
something else.  It will not bother me at all.

We'll still be here waiting when you come back :)

> > Again, if you are stuck with such hardware, there is _nothing_ that
> > I or any other kernel developer can do about it.  It is physically
> > impossible.
> 
> The problem is, that ATI, NVidia and a lot of other hardware producers
> are willing to support linux, but can not afford it to bring up
> drivers for the latest stable kernel in the terms you consider it as
> stable - and this was my original point.

No, it's not a matter of "affording" to do anything by these companies.
The community has offered to develop and support drivers for ANY
hardware from ANY company, FOR FREE.  ATI has taken us up on this offer,
and they are getting new drivers because of that.  nvidia does not, and
that is their own issue, not ours.

See www.linuxdriverproject.org for details about this program if you are
curious.

> > With the exception of kernel modules, it should all
> > "just work".  If not, please let us know and we will fix it.
> 
> Then fix the hfs modem for my dell notebook  (oh ... it is closed
> driver by connexant - but they are willing to help me and .... oh,
> they suggest I use the 2.6.24 kernel) And also please fix the em28*
> driver to work with my hybrid HVR-900 properly as it does with the
> v4l-dvb tree in 2.6.24

Please file bugs, these issues will and should be quickly fixed.

As for the hfs modem, I think that should work just fine with the open
drivers we have for them in the kernel tree.

> > We do that already with the -stable release.
> Where are patches for 2.6.26?

Was released yesterday on kernel.org.

> > If anyone wants to step up and maintain a specific kernel release
> > longer than the current -stable team does so, they are more than
> > willing to do so.  2 people have done this in the past quite well.
> 
> I want to know more about it

What specifically do you want to know?

thanks,

greg k-h
