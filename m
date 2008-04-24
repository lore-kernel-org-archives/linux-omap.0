From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] USB: Generalize usb initialization for omap hw
Date: Thu, 24 Apr 2008 10:12:02 -0700
Message-ID: <20080424171202.GD16834@atomide.com>
References: <1209044786-9244-1-git-send-email-felipe.balbi@nokia.com> <1209044786-9244-2-git-send-email-felipe.balbi@nokia.com> <1209044786-9244-3-git-send-email-felipe.balbi@nokia.com> <010C7BAE6783F34D9AC336EE5A01A08805E777E5@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63772 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224AbYDXRMI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 13:12:08 -0400
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08805E777E5@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>, "Syed Mohammed, Khasim" <khasim@ti.com>

* Gadiyar, Anand <gadiyar@ti.com> [080424 07:17]:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
> > Sent: Thursday, April 24, 2008 7:16 PM
> > To: linux-omap@vger.kernel.org; David Brownell
> > Cc: Tony Lindgren; Syed Mohammed, Khasim; Felipe Balbi
> > Subject: [PATCH 2/2] USB: Generalize usb initialization for omap hw
> > 
> > Create a generic board-file for initializing usb
> > on omap2430 and omap3 boards.
> > 
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> >  arch/arm/mach-omap2/Makefile                       |    4 +-
> >  arch/arm/mach-omap2/board-2430sdp-usb.c            |   96 
> > --------------------
> >  arch/arm/mach-omap2/board-2430sdp.c                |    3 +-
> >  arch/arm/mach-omap2/board-3430sdp.c                |    3 +-
> >  .../mach-omap2/{board-3430sdp-usb.c => usb-musb.c} |   32 ++++---
> >  include/asm-arm/arch-omap/usb-musb.h               |   35 +++++++
> 
> usb-musb.{c,h}? EHCI/OHCI has nothing to do with mentor.

This is all musb stuff, no? If not, there should be a separate
usb-ehci.c.

Tony


> >  6 files changed, 61 insertions(+), 112 deletions(-)
> >  delete mode 100644 arch/arm/mach-omap2/board-2430sdp-usb.c
> >  rename arch/arm/mach-omap2/{board-3430sdp-usb.c => usb-musb.c} (91%)
> >  create mode 100644 include/asm-arm/arch-omap/usb-musb.h
> > 
