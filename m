From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] i2c: omap: implement bus recovery
Date: Wed, 6 May 2015 11:44:28 -0500
Message-ID: <20150506164428.GC12279@saruman.tx.rr.com>
References: <1424369209-26735-1-git-send-email-balbi@ti.com>
 <20150410214122.GB15596@katana>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38449 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbbEFQqN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 May 2015 12:46:13 -0400
Content-Disposition: inline
In-Reply-To: <20150410214122.GB15596@katana>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org

--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 11:41:22PM +0200, Wolfram Sang wrote:
> On Thu, Feb 19, 2015 at 12:06:49PM -0600, Felipe Balbi wrote:
> > If either SCL or SDA are stuck low, we need to
> > recover the bus using the procedure described
> > on section 3.1.16 of the I2C specification.
> >=20
> > Note that we're trying to implement the procedure
> > exactly as described by that section. First we
> > check which line is stuck low, then implement
> > one or the other procedure. If SDA recovery procedure
> > fails, we reset our IP in an attempt to make it work.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>=20
> As Grygorii already mentioned: can you convert it to the standard i2c
> bus recovery mechanism?
>=20
> And is the timeout you replace with the recovery caused by SDA stuck
> high (check the thread starting with
> http://thread.gmane.org/gmane.linux.kernel/1841371/focus=3D22435)

SDA stuck low is one reason, yes. There could be other reasons like the
far end (i2c client) just crapping out. I know of one touchscreen
controller which will just die if you continuously try to read from
unexistent registers. It will NAK for a while and later just die,
completely. The only way to recover from that today is resetting the
board. I have a feeling that resetting the touch controller might be
doable if we have a reset pin tied to a GPIO, haven't tried that yet. In
any case this is off-topic.

I'll rebase the patch and fix what you asked, then retest, and resend.

--=20
balbi

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVSkTsAAoJEIaOsuA1yqRE5gEP/3hQCjY7LrsvrkzzFjji6i6b
kWL78Bgb+sMFPvF0/wPKv/4eVXEVt+0hf/QWTdD+E8C0+EUuXjimc8sm481XeYM6
5N1OYOcZKCjyg4s83M7BXSp0XljhhlmvtuBRmR+3hYg8rGIq5HKiecNgZpay/m1g
Epgjixwmzqydgym5VqoVUfKqTwKNkBqLL853QF76cKeLQwKAfbv6JyJwL/HqWteF
Ybxnm1a24f/qPfqNZY7U+0tt3CEEpFav2yQHSNKaWXDeShwXl8Fe5ubSl+GIZQkF
ajIQc2ReeSGUqjZr/9qf4wmcG0oViFdVV837quRJVwGV1AtH0sMYUG5WjhiDb/Y1
3M7wjy8o5LDCR3nfxZqCwoPa63GjFDoKwDOqxbLiNU9xGuZMK0Jvtu2EOUpXpliS
bc+JzNiwFTPxt6fpjgti94zPzO+MW34y6RsyOj9sH39JmyY7aNLAFU+XTE3q54KA
KsJQF1/0KlDnsaDlGIpthNOayaKGreURMK3TZ2Yn2x47+n9jtO3dDIYCc1x3N2Fl
yDciBp1YJwk7LdC/whv4FDxaVTbG1jaw8AuZMGbRmMGkroQ7ef9KPlBFyZdfd21y
+ceuy5EjMKLF39wH6MFxcgozd3bSigEyBkeCs+ZcnWFDDDLB9ua1DPqzYM5HYMJb
FH93Tnq47CWoxQ7CQDSe
=qqAf
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
