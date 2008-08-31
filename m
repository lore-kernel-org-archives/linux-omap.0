From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 16/33] add omap led drivers
Date: Mon, 1 Sep 2008 00:33:02 +0300
Message-ID: <20080831213259.GH9887@frodo>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-16-git-send-email-me@felipebalbi.com> <1220116593-862-17-git-send-email-me@felipebalbi.com> <200808311401.44554.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50091 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758210AbYHaVdW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 17:33:22 -0400
Content-Disposition: inline
In-Reply-To: <200808311401.44554.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Sun, Aug 31, 2008 at 02:01:44PM -0700, David Brownell wrote:
> On Saturday 30 August 2008, Felipe Balbi wrote:
> > +config LEDS_OMAP_DEBUG
> > +=A0=A0=A0=A0=A0=A0=A0boolean "LED Support for OMAP debug board LED=
s"
> > +=A0=A0=A0=A0=A0=A0=A0depends on LEDS_CLASS=3Dy && ARCH_OMAP
> > +=A0=A0=A0=A0=A0=A0=A0help
> > +=A0=A0=A0=A0=A0=A0=A0 =A0Enables support for the LEDs on the debug=
 board used with OMAP
> > +=A0=A0=A0=A0=A0=A0=A0 =A0reference boards like H2/H3/H4 and Perseu=
s2. =A0Up to six of these
> > +=A0=A0=A0=A0=A0=A0=A0 =A0may be claimed by the original ARM debug =
LED API.
>=20
> This stuff is ancient and should not be pushed upstream.
> Anything not using arch/arm/plat-omap/debug-leds.c should
> be converted immediately.  Ditto anything using the legacy
> ARM led framework.
>=20
>=20
> > +config LEDS_OMAP
> > +=A0=A0=A0=A0=A0=A0=A0tristate "LED Support for OMAP GPIO LEDs"
> > +=A0=A0=A0=A0=A0=A0=A0depends on LEDS_CLASS && ARCH_OMAP
> > +=A0=A0=A0=A0=A0=A0=A0help
> > +=A0=A0=A0=A0=A0=A0=A0 =A0This option enables support for the LEDs =
on OMAP processors.
>=20
> Similarly obsolete.  Use drivers/leds/leds-gpio.c ...
> Best to just remove this driver and convert its clients.
>=20
>=20
> > +config LEDS_OMAP_PWM
> > +=A0=A0=A0=A0=A0=A0=A0tristate "LED Support for OMAP PWM-controlled=
 LEDs"
> > +=A0=A0=A0=A0=A0=A0=A0depends on LEDS_CLASS && ARCH_OMAP && OMAP_DM=
_TIMER
> > +=A0=A0=A0=A0=A0=A0=A0help
> > +=A0=A0=A0=A0=A0=A0=A0 =A0This options enables support for LEDs con=
nected to GPIO lines
> > +=A0=A0=A0=A0=A0=A0=A0 =A0controlled by a PWM timer on OMAP CPUs.
>=20
> This is more plausible.  But looking -- briefly! -- at the code, I
> don't see why it needs a work_struct at all, or why it's not using
> the blink_set() method to control the hardware blink rate.

One more to drop from the series. Someone will have to take care of
these drivers.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
