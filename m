From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2.6.27-rc8 1/2] drivers/mfd/twl4030-core.c
Date: Wed, 1 Oct 2008 23:53:57 -0700
Message-ID: <200810012353.57753.david-b@pacbell.net>
References: <200810011144.20510.david-b@pacbell.net> <200810011453.26699.david-b@pacbell.net> <20081002060521.GA7942@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:31800 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753434AbYJBGyA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 02:54:00 -0400
In-Reply-To: <20081002060521.GA7942@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Samuel Ortiz <sameo@openedhand.com>, lkml <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Wednesday 01 October 2008, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [081002 00:53]:
> > On Wednesday 01 October 2008, David Brownell wrote:
> > 
> > > NOTE: this is the current code from the linux-omap tree.
> > 
> > This chip being used on a whole bunch of boards:
> > 
> >  - Gumstix Overo
> >  - BeagleBoard.org
> >  - Omap ZOOM (Labrador)
> >  - OMAP 2430 and 3430 SDP,
> >  - OMAP2 and OMAP3 EVM
> >  - ... more (openpandora.org ?)

My bad.  Openpandora just opened for preorders *today* (PST)
and sold out all 3000 units.  I'm sure I mentioned it well
after most of them were sold, so it's not my fault their
server was killed.  Really ...


> > 
> > which will get much closer to "usable with mainline kernels"
> > when their power management chip works in mainline!  :)
> 
> Cool. I'll post some patches against mainline kernel
> for booting minimal omap3 boards within next few days.
> So we should get at least beagle and overo booting
> to some extent, maybe with serial and musb.

Sounds like it *should* be a nice, modest, achievable
goal, right?  Something tells me it won't be that easy!
More power to you.

- Dave

  
