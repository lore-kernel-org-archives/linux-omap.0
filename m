From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] irqchip: omap-intc: improve IRQ handler
Date: Fri, 2 Jan 2015 15:39:17 -0600
Message-ID: <20150102213917.GH4920@saruman>
References: <1420224433-27001-1-git-send-email-balbi@ti.com>
 <20150102213250.GG3298@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47130 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbbABVk3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jan 2015 16:40:29 -0500
Content-Disposition: inline
In-Reply-To: <20150102213250.GG3298@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2015 at 01:32:51PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150102 10:50]:
> > as it turns out the current IRQ number will
> > *always* be available from SIR register which
> > renders the reads of PENDING registers as plain
> > unnecessary overhead.
> >=20
> > In order to catch any situation where SIR reads
> > as zero, we're adding a WARN() to turn it into
> > a very verbose error and users actually report
> > it.
> >=20
> > With this patch average running time of
> > omap_intc_handle_irq() reduced from about 28.5us
> > to 19.8us as measured by the kernel function
> > profiler.
>=20
> That's a nice improvment for an interrupt controller :)
> =20
> > Tested with BeagleBoneBlack Rev A5C.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >=20
> > Before applying, it would be very nice to get reports
> > from other folks on different platforms, specially OMAP2/3
> > ones which I don't have (easy) access.
>=20
> Seems to behave just fine on omap2 and 3 here, gave it
> a quick try on n800, n900, omap3-ldp and 37xx-evm:
>=20
> Tested-by: Tony Lindgren <tony@atomide.com>

cool, thanks

--=20
balbi

--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUpxAFAAoJEIaOsuA1yqRET1kP/3UEqjBsDp8SiWYh10vdz8lQ
WIw1ykkhSsDixSKY4IfGD8/5rWpxoe9nlz5/YtVvq7neyN5/hkndgQS01Ez05zUm
q5Dl8Bre/KYncyvthZLK7UNmw6jZ6v3+gP8W/O7rm2K32+cl8EbGEo+0Uou8In6F
+oyAjTuTcjSSHyhj7sCQIPI9olCjaHAXwet6WWQw4KrCM081Dj66+e63q2I7TP7N
LdKU0Jfwzm2wRqONy3uQYUki9EbMwTj8wpEP8KHTOMxN/f5pz7esvVKwn2tn2AGF
+ek2dLY4QJ3OacLKmKnX4xFM1/7fC1juNCGhRyREYylFO9TL03GS2ZXVkB+BXLba
hpwABsuWsKVtwbGJRUSESR0sgf6dMtqlltSbkaEmiN49YhSV1R5TxjIRsfs0PO7Z
03UpdOPQCqeXwwwEP3PDYnQRAqjOusctD+QRYSzrsXqYj+dosQ85AvLibOoo5Sg/
0eD7lFlotsMjoQFdEhk2hLSvd6mXcwtDW+jYabdLPkm+ugC/XfeZ725jK6OOtg6M
oOOGovRUiXBnTRjG60hTaS1gzeYo3ntNySkEh7F8MONIPk5brJsBctRw5CBpOmj7
aCKy2YzuuqYFDpN85W1VATVLvXr5WqXfl+pQ0NcqqqK3XeI4MxFKYzeCBF2PAPnt
UUZcZoAK6RtzX4J8Y8pd
=8WMM
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--
