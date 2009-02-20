From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap_apollon_2420_defconfig
Date: Fri, 20 Feb 2009 13:06:44 -0800
Message-ID: <20090220210644.GE7414@atomide.com>
References: <20090209192614.GF19453@n2100.arm.linux.org.uk> <20090209205319.GH14200@atomide.com> <9c9fda240902091754q7f723bf2ha46206e52641297b@mail.gmail.com> <20090220205812.GA13961@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57336 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbZBTVG4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 16:06:56 -0500
Content-Disposition: inline
In-Reply-To: <20090220205812.GA13961@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kyungmin Park <kmpark@infradead.org>, David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090220 12:58]:
> On Tue, Feb 10, 2009 at 10:54:25AM +0900, Kyungmin Park wrote:
> > In the previous patch, it's only fixed host side. But apollon case, it
> > only used udc, so udc configuration should select USB_OTG_UTILS also.
> 
> So, it's 10 days later, mainline is still broken.  In fact, this is
> now the only ARM defconfig which is failing.
> 
> What's happening?  Is someone going to ack this patch?  Is it going
> to be submitted to me or is it going to be submitted via some USB
> tree?

Well it would be nice to get an ack from the USB people, here's mine:

Acked-by: Tony Lindgren <tony@atomide.com>

> Sick of chasing people about build errors.  People here need to get
> off their lazy backsides, check kautobuild regularly and submit build
> fixes.

How about automatic notifications on the failing omap builds sent to
to linux-omap list? The 34xx builds failing because of the compiler
should be filtered out until the compiler is updated though.

Tony
