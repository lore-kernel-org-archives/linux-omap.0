From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/2] USB: Generalize usb initialization for omap hw
Date: Thu, 24 Apr 2008 21:32:40 +0300
Message-ID: <20080424183240.GU23350@gandalf.research.nokia.com>
References: <1209044786-9244-1-git-send-email-felipe.balbi@nokia.com> <20080424141825.GS23350@gandalf.research.nokia.com> <20080424171617.GE16834@atomide.com> <200804241129.28213.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35910 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762213AbYDXSgB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 14:36:01 -0400
Content-Disposition: inline
In-Reply-To: <200804241129.28213.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, "ext Gadiyar, Anand" <gadiyar@ti.com>, linux-omap@vger.kernel.org, "Syed Mohammed, Khasim" <khasim@ti.com>

On Thu, Apr 24, 2008 at 11:29:27AM -0700, David Brownell wrote:
> On Thursday 24 April 2008, Tony Lindgren wrote:
> > > > > =A0.../mach-omap2/{board-3430sdp-usb.c =3D> usb-musb.c} | =A0=
 32 ++++---
>=20
> Good:  so some of the inappropriate sdp_*() names will vanish ...
>=20
>=20
> > > > > =A0include/asm-arm/arch-omap/usb-musb.h =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 35 +++++++
> > > >=20
> > > > usb-musb.{c,h}? EHCI/OHCI has nothing to do with mentor.
> > >=20
> > > that's true, you suggest any other name ?
> > >=20
> > > maybe omap-usb.[ch] ?
> >=20
> > Sorry, I missed this post. I suggested separating out EHCI stuff to
> > usb-ehci.c as they can be compiled in separately.
>=20
> Sounds right to me.  Dis-entange that stuff.

How about the header, introduce usb-musb.h and usb-ehci.h or usb.h is
enough ??

--=20
	- Balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
