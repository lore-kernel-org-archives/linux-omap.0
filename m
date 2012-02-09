From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap: be more aggressive with pm_runtime
Date: Thu, 9 Feb 2012 08:08:37 +0200
Message-ID: <20120209060835.GA1121@legolas.emea.dhcp.ti.com>
References: <1328707614-20146-1-git-send-email-balbi@ti.com>
 <20120208135329.GJ16334@legolas.emea.dhcp.ti.com>
 <87zkcsx48j.fsf@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:39997 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750997Ab2BIGIn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 01:08:43 -0500
Received: by lagz14 with SMTP id z14so1486964lag.41
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 22:08:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87zkcsx48j.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, linus.walleij@stericsson.com, Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, tarun.kanti@ti.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2012 at 04:03:24PM -0800, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
>=20
> > Hi,
> >
> > On Wed, Feb 08, 2012 at 03:26:54PM +0200, Felipe Balbi wrote:
> >> try to keep gpio block suspended as much as possible.
> >>=20
> >> Tested with pandaboard and a sysfs exported gpio.
> >>=20
> >> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >> ---
> >>=20
> >> I couldn't see any issues with this patch. I managed to export
> >> a gpio and change the direction with a while true loop with
> >> no issues whatsoever.
> >
> > btw, I also played with gpios 7 and 8 because they have LEDs on them on
> > pandaboard and everything seems to be fine.
> >
> > I just want to be sure I can still go to OFF mode and wakeup, but on
> > vanilla 3.3-rc2 after echo mem > /sys/power/state the systems freezes on
> > panda, so I can't go any further.
>=20
> I don't think it's frozen.  I suspected it's suspended without any
> wakeups enabled.  You probably haven't enabled UART wakeups.  Try
> enabling them like this:
>=20
>   echo enabled > /sys/devices/platform/omap/omap_uart.2/tty/ttyO2/power/w=
akeup
> =20
> before going into suspend.

that did the trick. But not having UART with wakeup enabled by default
prevents us from doing suspend/resume tests during bootup, because the
system won't wakeup through console.

--=20
balbi

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPM2LjAAoJEIaOsuA1yqREqSkP/1SRbYn0I5v+/XHgQa3JL86e
uzzC9jJ2ULMCuZIlSQlxRHjXv/YbCux/7SSON49WanyRIQ0d2g1qH9BSOyIQoUX3
GLIYojkYea753pvxHFJ4c/6cIH1113I1XAYMigZdxzUFX730D/axWdM6XEljGz2l
Sm0ewfOM1GqAvbv5g1nRqoziMiggOd69W+2E7+WsU9HRkvh70JMiI7THwSqUg2H2
o7C1mMhvwd9B1RMlw+bXATgBZ3pI2Onf4j6/k6s0mPBn9eii9EnnGWVsJJZrWd61
5Vze5KskKT6Fw0VXUB4KaolDtReH2mOGAzXrfF3Z2cv6ixVo/2cXVqFboFtxMOwO
a2TLWrYM4WXPfsv4WQJGsNT1uofI58grYkieNfNTlYWJvjl3hjWcGRT3z6MmUJCk
C+eJILcUMUtkhbgm5yWoIA02kFE1seVH4FI6jrTOXwbBzn7ztvBOppoEEhDFBffC
Wb+DPNFpEP+Esjk4/NjA4TUNOYRAwpt67pXIJs7v7lUshT8qAQMU6iUkdLy6jQL/
6n+hPgXuOnuty9/lX9dXCRmXKIcGcc8BfcUqxdA7afhcg/gXVX/3lCDV+UZNkghS
4e+H3nv+wQ9X2yUHlJ6k8/dsz7w+ZxCZxFOyLpMHNeSEJX2sUz86HY1HNrG3npwQ
7zVis511MzdQuJpbN6HW
=xjry
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
