From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/2] USB: Generalize usb initialization for omap hw
Date: Thu, 24 Apr 2008 21:27:24 +0300
Message-ID: <20080424182722.GT23350@gandalf.research.nokia.com>
References: <1209044786-9244-1-git-send-email-felipe.balbi@nokia.com> <1209044786-9244-2-git-send-email-felipe.balbi@nokia.com> <1209044786-9244-3-git-send-email-felipe.balbi@nokia.com> <010C7BAE6783F34D9AC336EE5A01A08805E777E5@dbde01.ent.ti.com> <20080424141825.GS23350@gandalf.research.nokia.com> <20080424171617.GE16834@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63176 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbYDXS24 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 14:28:56 -0400
Content-Disposition: inline
In-Reply-To: <20080424171617.GE16834@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "ext Gadiyar, Anand" <gadiyar@ti.com>, linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>, "Syed Mohammed, Khasim" <khasim@ti.com>

On Thu, Apr 24, 2008 at 10:16:18AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [080424 07:20]:
> > On Thu, Apr 24, 2008 at 07:43:16PM +0530, ext Gadiyar, Anand wrote:
> > > > -----Original Message-----
> > > > From: linux-omap-owner@vger.kernel.org 
> > > > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
> > > > Sent: Thursday, April 24, 2008 7:16 PM
> > > > To: linux-omap@vger.kernel.org; David Brownell
> > > > Cc: Tony Lindgren; Syed Mohammed, Khasim; Felipe Balbi
> > > > Subject: [PATCH 2/2] USB: Generalize usb initialization for omap hw
> > > > 
> > > > Create a generic board-file for initializing usb
> > > > on omap2430 and omap3 boards.
> > > > 
> > > > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > > > ---
> > > >  arch/arm/mach-omap2/Makefile                       |    4 +-
> > > >  arch/arm/mach-omap2/board-2430sdp-usb.c            |   96 
> > > > --------------------
> > > >  arch/arm/mach-omap2/board-2430sdp.c                |    3 +-
> > > >  arch/arm/mach-omap2/board-3430sdp.c                |    3 +-
> > > >  .../mach-omap2/{board-3430sdp-usb.c => usb-musb.c} |   32 ++++---
> > > >  include/asm-arm/arch-omap/usb-musb.h               |   35 +++++++
> > > 
> > > usb-musb.{c,h}? EHCI/OHCI has nothing to do with mentor.
> > 
> > that's true, you suggest any other name ?
> > 
> > maybe omap-usb.[ch] ?
> 
> Sorry, I missed this post. I suggested separating out EHCI stuff to
> usb-ehci.c as they can be compiled in separately.

K, I'll do it :-)

-- 
	- Balbi
