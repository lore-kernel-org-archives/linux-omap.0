From: Sebastian Reichel <sre@debian.org>
Subject: Re: HSI: any status updates on omap_ssi?
Date: Tue, 24 Apr 2012 18:27:55 +0200
Message-ID: <20120424162754.GA9407@earth.universe>
References: <20120421105235.GA3296@earth.universe>
 <20120424152316.GH3739@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:41568 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755860Ab2DXQ2B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 12:28:01 -0400
Content-Disposition: inline
In-Reply-To: <20120424152316.GH3739@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2012 at 08:23:16AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sre@debian.org> [120421 04:26]:
> > Hi,
> >=20
> > Missing omap_ssi support is currently the most important missing
> > feature, to make the mainline kernel on the Nokia N900 useful, see
> > also [0].
> >=20
> > Can you prepare SSI inclusion into the mainline kernel, now that HSI
> > has been pulled into 3.4? Do you think we get SSI support in 3.5?
>=20
> Also FYI related to n900, you need to have bce492c0 (ARM: OMAP2+: UART: F=
ix
> incorrect population of default uart pads) applied after v3.1 if using
> CONFIG_OMAP_MUX to avoid some SSI pins getting wronly muxed to UART.

Thanks for the info.

> Then to verify, the hw floating point error you reported a while back
> with omap2plus_defconfig got resolved, right?

I have not tried again since then. The error only occured, if the
kernel has been built with OMAP2 support. It does not show up on
kernels, which support only OMAP3/OMAP4.

-- Sebastian

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPltSKAAoJENju1/PIO/qateAP/iwmdPGwtNlHR7IDEUEU0UoY
VLAZQOn/JqlHeuVk8+LGj3vWVwKEISEAxahKkhjYi6o8J5F56WHIBTD4I0QjeBps
eYQwt/QbJoL9AJFqaFFR0VZ1RvWimZwTptE3E8h99cHalPyOO71JQvu4jgWrL4zv
C9L2HVLyXv9tFvz9/j+5R5iTsby+wH+lwL9ZmJ06n0xMF+2iVjKY4eL5PeqkxKOx
ykth9FCr6nv7ioQKUFSI8paMqYiux8G9hTf4NdNY+r6DLna1u3CAxSArv7fje49t
h9IEH9QiUw+8Sx8+Vqm/nJx/sQB7uY5cH8ZwpmUTDk1leIl+OXMJB3YxTlgll6mL
VfwElJLPW62d+RSJ9MKi1dLh4xGZQpB9iZKMUGEuR86lOQspBdDSDsAObqhwqlOR
Frij3lA2LCXdq0IqTqMqLD3wBgEfOSdg7D5jTzTr7zepcyo4HIDhV+VDvva/j59m
F3JOSzbnGLeM6WaZuaHlNTllT10vnsxhcjtEz/9lDD79NV4/ThTup6np0Iivl6ao
XYleIQHegsSGFP6ApOs8YARVGPB5GVinT2nECSQ4uIj8g2z8Q1PDxw2cOyHC4aUJ
01T54lbWR1/L/R9sw6mJaM50KPLQF6+h9cm7t0nMmOlc2FS+YmpgpiP1GnnQZGbj
Zpv4FMnsRQBRbqhu8QxO
=6zH8
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
