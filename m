From: Tony Lindgren <tony@atomide.com>
Subject: Re: hwmod data duplication (was: Re: [RFC/NOT FOR MERGING 2/3]
 serial: omap: remove hwmod dependency)
Date: Tue, 19 Feb 2013 14:31:28 -0800
Message-ID: <20130219223128.GM5724@atomide.com>
References: <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com>
 <20130214224710.GF11362@atomide.com>
 <alpine.DEB.2.00.1302191527200.32069@utopia.booyaka.com>
 <20130219154511.GU17852@n2100.arm.linux.org.uk>
 <20130219163053.GE5724@atomide.com>
 <20130219182257.GV17852@n2100.arm.linux.org.uk>
 <20130219193122.GJ5724@atomide.com>
 <20130219194327.GB8978@arwen.pp.htv.fi>
 <20130219220932.GL5724@atomide.com>
 <20130219222215.GA12225@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:11495 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933886Ab3BSWbi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 17:31:38 -0500
Content-Disposition: inline
In-Reply-To: <20130219222215.GA12225@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [130219 14:26]:
> On Tue, Feb 19, 2013 at 02:09:33PM -0800, Tony Lindgren wrote:
> > 
> > ..that means massive amount of churn in the board-*.c files to convert
> > them to various init functions to be called from board-generic.c and
> > removing the ones that are working with DT.
> 
> why ? I meant that only what's not converted to DT today should be
> handled this way. Also, most of the "churn" is already there
> (usb_musb_init(), usb_ehci_init(), etc etc), it just needs to be called
> from a different place. We don't need to have one function for each
> board, however, maybe we could target by-soc:
> 
> if (of_is_compatible("omap3"))
> 	omap3_init_devices(); /* or whatever you wanna call it */
> 
> omap_init_devices() has initialization for everything which isn't DT
> adapted today and as we move things to DT, there's a single place to
> remove code from.

And the pdata for that comes from where? :) I think that means
converting each board-*.c to device init functions, which leads to
the churn I was mentioning..
 
> > I think we're better off making first sure things are usable with
> > DT, then just dropping the board-*.c files as we go.
> > 
> > And omap4 is the place to start as we only have blaze and panda
> > board files. Once DSS, USB and WLAN work with the .dts files, we
> > can just drop those board files and make omap4 DT only.
> 
> fair enough.
> 
> > We may be able to drop omap4 board-*.c files faster than going full
> > DT with few selected legacy init functions in board-generic.c for
> > things like LCD panel configuration etc.
> >  
> > > Only on board-files we're talking about over 13K lines:
> > >  35 files changed, 13434 deletions(-)
...

> > > If we remove all addresses and interrupts, numbers look even better.
> > 
> > Yeah. Let's start with omap4 first when DSS + USB + WLAN work.
> 
> USB is going to be ready for v3.10, likely Wlan too.

That's good news. Maybe we can then have a legacy device pdata
init for DSS, and make omap4 DT only for v3.10.

Regards,

Tony
