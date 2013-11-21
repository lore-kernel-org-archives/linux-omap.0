From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: phy: am335x: Prevent GPIO reset line request
Date: Thu, 21 Nov 2013 07:01:55 -0600
Message-ID: <20131121130155.GC24559@saruman.home>
References: <1384984714-19860-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131120220212.GA12776@localhost>
 <528DC168.7090204@linutronix.de>
 <20131121113025.GA2942@localhost>
 <528DF233.40502@linutronix.de>
 <20131121115519.GC2942@localhost>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53304 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218Ab3KUNCc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Nov 2013 08:02:32 -0500
Content-Disposition: inline
In-Reply-To: <20131121115519.GC2942@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roger Quadros <rogerq@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Tony Lindgren <tony@atomide.com>

--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2013 at 08:55:20AM -0300, Ezequiel Garcia wrote:
> On Thu, Nov 21, 2013 at 12:44:51PM +0100, Sebastian Andrzej Siewior wrote:
> > On 11/21/2013 12:30 PM, Ezequiel Garcia wrote:
> > > Ah, good to know. That patch should be picked ASAP, without it the USB
> > > in AM335x is broken. Is it already too late to -rc1?
> > Yes.
> >=20
> > > Who is supposed to merge that? Greg?
> >=20
> > Felipe will start collecting fixes once -rc1 is out [0] so it should be
> > part of -rc2.
> >=20
>=20
> OK, fine by me. Please note that Felipe's commit is a much bigger (and
> nicer) rework of the code, and that it doesn't clearly state it fixes
> the current code.
>=20
> Felipe: Maybe you should add some message stating it fixes a regression?

sure, makes sense. Sebastian had already mentioned it sounded too nice
of a commit log ;-)

--=20
balbi

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSjgRDAAoJEIaOsuA1yqREtxoP/iNEuNuTINRHaYZnYhvCw6ck
TwgzxkV3cGGUvpPnPLC73x3/VXH163+7wKOxaB/w4OlmgqzgQcVSeeLnNNf3buLP
mfizlXP+CRGqk77mTD5FgfNn8t7zDF6SrfvRzeDWFxQyRXvaOZdecUd+q8NaRwpv
huiBJCZ88H2BPgmXZLgeYpYiixkEjbCJPgio0BxcFmaaLQpHNsdgsmm+5VMpzYJu
ich7QAJfrY1HEzn3hEUk4hMLGUU17+ICNSCveacp+/OCglr4Cjey1pnNfR5uE6Tm
mo6OjmFu4Ao9wI7GVgGJdLj/58yhKI7MedhqFcm4RAIqd9MjbCDCd37T9r7wWgsi
wckx7UjtRG6RgHWY34ZHgkiBZzRgVg8ckufKefbhWxTM/41A9dXDA6gKbQXa3puo
ktnsbtbPlae8bLQ/Myt2gjYvXhGLUAriiarWagSkB0z0ljFrRik/Cd9Abne8/DEH
H42z/bK3dAn4dHcRJYR0d+yVmwqmmy0FMgYgKXu1AnabsXLjs4C8Xp0rbJ/ZkD0+
QWUoZ7Om5VTDrguNSmazy+yZCcALF202BLAW6Cm9EzDGW1wXQ75dnXq7ZBuGxVQ1
Fq9FZ/HSQOiFqhPPPMrW+89iWECtQlrGbHAq3Bh2h0DUi/iPk50zHRVjyXk9FUDa
YgqGD1WicbVQ+5gmIIBz
=Picu
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
