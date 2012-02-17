From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [BUG] EHCI build dependencies broken?
Date: Fri, 17 Feb 2012 12:30:33 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1202171228180.1143-100000@iolanthe.rowland.org>
References: <20120217171203.GA3945@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44496 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752582Ab2BQRaf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Feb 2012 12:30:35 -0500
In-Reply-To: <20120217171203.GA3945@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 17 Feb 2012, Russell King - ARM Linux wrote:

> > > Looking at the Kconfig file, it seems that it's entirely possible to
> > > select EHCI_HCD without any glue selected.  It's also possible to build
> > > EHCI with two (or more) bus glues selected - eg, it's possible for
> > > both these to be selected:

> > Of course, that doesn't solve the issue of not having any bus glue
> > selected at all.  I don't know enough about Kbuild to fix this --
> > suggestions are welcome.
> > 
> > The same problem exists with OHCI and UHCI too.
> 
> A better solution would be to sort out the OHCI/UHCI/EHCI drivers so that
> they can support more than one bus glue at any one time.  I think that's
> been discussed in the past, and is certainly something that's going to be
> required for the 'single zImage' project on ARM.
> 
> I suspect that's something for later though.

Yes, that's my long-term plan.  Don't know when I'll get around to it, 
though.  Even when it has been done, I don't know how we'll protect 
against configs with no bus glue enabled.

Alan Stern

