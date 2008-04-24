From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] USB: Generalize usb initialization for omap hw
Date: Thu, 24 Apr 2008 11:29:27 -0700
Message-ID: <200804241129.28213.david-b@pacbell.net>
References: <1209044786-9244-1-git-send-email-felipe.balbi@nokia.com> <20080424141825.GS23350@gandalf.research.nokia.com> <20080424171617.GE16834@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:33303 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751870AbYDXS3d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2008 14:29:33 -0400
In-Reply-To: <20080424171617.GE16834@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "ext Gadiyar, Anand" <gadiyar@ti.com>, linux-omap@vger.kernel.org, "Syed Mohammed, Khasim" <khasim@ti.com>

On Thursday 24 April 2008, Tony Lindgren wrote:
> > > > =A0.../mach-omap2/{board-3430sdp-usb.c =3D> usb-musb.c} | =A0 3=
2 ++++---

Good:  so some of the inappropriate sdp_*() names will vanish ...


> > > > =A0include/asm-arm/arch-omap/usb-musb.h =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 35 +++++++
> > >=20
> > > usb-musb.{c,h}? EHCI/OHCI has nothing to do with mentor.
> >=20
> > that's true, you suggest any other name ?
> >=20
> > maybe omap-usb.[ch] ?
>=20
> Sorry, I missed this post. I suggested separating out EHCI stuff to
> usb-ehci.c as they can be compiled in separately.

Sounds right to me.  Dis-entange that stuff.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
