From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap_apollon_2420_defconfig
Date: Fri, 20 Feb 2009 13:40:59 -0800
Message-ID: <20090220214059.GF7414@atomide.com>
References: <20090209192614.GF19453@n2100.arm.linux.org.uk> <20090209205319.GH14200@atomide.com> <9c9fda240902091754q7f723bf2ha46206e52641297b@mail.gmail.com> <20090220205812.GA13961@n2100.arm.linux.org.uk> <20090220210644.GE7414@atomide.com> <20090220212433.GB13961@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52084 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbZBTVlH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 16:41:07 -0500
Content-Disposition: inline
In-Reply-To: <20090220212433.GB13961@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kyungmin Park <kmpark@infradead.org>, David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090220 13:25]:
> On Fri, Feb 20, 2009 at 01:06:44PM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090220 12:58]:
> > > On Tue, Feb 10, 2009 at 10:54:25AM +0900, Kyungmin Park wrote:
> > > > In the previous patch, it's only fixed host side. But apollon case, it
> > > > only used udc, so udc configuration should select USB_OTG_UTILS also.
> > > 
> > > So, it's 10 days later, mainline is still broken.  In fact, this is
> > > now the only ARM defconfig which is failing.
> 
> Really, it's actually almost one month later.  I checked.  I brought
> this issue up 27th January and then again on 9th February and here we
> are *three* *and* *a* *half* *weeks* later no further forward.
> 
> This is plain and simple not acceptable.
> 
> > > What's happening?  Is someone going to ack this patch?  Is it going
> > > to be submitted to me or is it going to be submitted via some USB
> > > tree?
> > 
> > Well it would be nice to get an ack from the USB people, here's mine:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Right, so one ack which is progress.  That still leaves the question
> about how the patch gets into mainline.
> 
> > > Sick of chasing people about build errors.  People here need to get
> > > off their lazy backsides, check kautobuild regularly and submit build
> > > fixes.
> > 
> > How about automatic notifications on the failing omap builds sent to
> > to linux-omap list? The 34xx builds failing because of the compiler
> > should be filtered out until the compiler is updated though.
> 
> Well, 17 days ago, the compiler was upgraded and the OMAP34xx builds
> started to complete.  So your statement tells me that you've not looked
> at kautobuild for at least the last 17 days.

Great, I wonder what other fabulous websites I've forgotten!

> If you want any features, please talk to the kautobuild people.  I've
> nothing to do with kautobuild other than seemingly being the *sole*
> person who checks the kautobuild website and chases people when things
> get broken.
> 
> Having done some research by reading through the kautobuild site, if you
> want to be mailed the results, kautobuild has its own mailing list.  See
> http://armlinux.simtec.co.uk/kautobuild/

OK, I'll take a look at getting some automated warnings from there to
linux-omap list at some point when I get around to it.

Tony
