From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 15/15] tty: serial: 8250: omap: add dma support
Date: Fri, 29 Aug 2014 10:55:51 -0500
Message-ID: <20140829155551.GD2620@saruman.home>
References: <20140815210211.GD9239@atomide.com>
 <53F5AF0D.5060409@linutronix.de>
 <20140821184416.GF10066@atomide.com>
 <53FE3779.5090908@linutronix.de>
 <20140827202313.GF16006@atomide.com>
 <20140828082348.GA5413@linutronix.de>
 <20140828164645.GG16006@atomide.com>
 <53FF84DF.7080406@linutronix.de>
 <20140828225454.GM16006@atomide.com>
 <540048B4.7010807@linutronix.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <540048B4.7010807@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, balbi@ti.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2014 at 11:32:36AM +0200, Sebastian Andrzej Siewior wrote:
> On 08/29/2014 12:54 AM, Tony Lindgren wrote:
> > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140828 12:37]:
> >> On 08/28/2014 06:46 PM, Tony Lindgren wrote:
> >>>
> >>> Sounds like there should be some way to clear that state.. I wonder
> >>> if omap-serial.c had something before it's DMA support was removed?
> >>
> >> Its DMA was removed? Like there was DMA support?
> >=20
> > Yeah see commit 494574304711a333386e7dd5fd3ebbc3b7024994...
>=20
> Interesting. I've been browsing that file and checking other trees and
> never noticed that it was there at some point. I only saw the pieces
> which looked it was there.

it was known to be broken and unused. There was no way to even enable
that code.

--=20
balbi

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUAKKHAAoJEIaOsuA1yqREzfUQALWVbKSaIJYBGKkiE4FEl1t+
qKYF+nnn1hvwqUiJ0vrj9toK74OcQy/wtcf+LEwvu0sAFCdC6UzoudpRFgLUt5Hm
Lzf/eqYu0z1i4Yd+KRqo7HD9U0Mkpj1egtecuLPMUKfu0RI17xZrB2bze76hXhv6
DRuHR4VSCiF94je6OGohlP195b33EoLFOw/qutnVULQWfVWh5xgH4PK2WZTGQAWG
/uRsPmQxYJTWDDukiyjCUOHzjcrKvjSSIpnM4hPzEhulPUp+KTbVXW1pq+Fq9n6+
7I61gnz03HqQXaPScztyxJpMZh4/1niLA+Qz2ip5Zx3jbYEGcpD5Vs5uwCbPkVKd
KCqkj7al9icEJgTyJKiFeNNw87y+QPxGcP0cZ2IIJTyOcOQ/Mo+ng9AcXJMX0VUI
iISMH26N9LKdEHb97MALwoQ/luDjtCzoRAQM73qAZkVDfQadOOHNevkBRGr0mLfJ
XqQvuV5h8WOKBEB35i0ZHpnSv7GWsatvpNQHTQ+vnaDPczY2Efp8K9eByXboS2C/
3Kyy0wWN6zzgjXafqtVpENeXwuKTIW27hf+1RMoP8yRF1OgmF6nlJQhSy94MubHa
mitIkskf5hugXQiQ1kBnweL/lN6N3cxAO0w4zdSv/3HxY4Z+rHe+6cAu5ZLOW2zR
JOmXy/vrZYgKuHWUBwWx
=VVLh
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
