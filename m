From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: implement bus recovery
Date: Fri, 10 Apr 2015 23:41:22 +0200
Message-ID: <20150410214122.GB15596@katana>
References: <1424369209-26735-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424369209-26735-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2015 at 12:06:49PM -0600, Felipe Balbi wrote:
> If either SCL or SDA are stuck low, we need to
> recover the bus using the procedure described
> on section 3.1.16 of the I2C specification.
>=20
> Note that we're trying to implement the procedure
> exactly as described by that section. First we
> check which line is stuck low, then implement
> one or the other procedure. If SDA recovery procedure
> fails, we reset our IP in an attempt to make it work.
>=20
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

As Grygorii already mentioned: can you convert it to the standard i2c
bus recovery mechanism?

And is the timeout you replace with the recovery caused by SDA stuck
high (check the thread starting with
http://thread.gmane.org/gmane.linux.kernel/1841371/focus=3D22435)

Thanks,

   Wolfram


--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVKEOCAAoJEBQN5MwUoCm275EP/0f8zJvQlhz0JslfykVQpcbJ
1M/Y+9keP9Bfrhd/4HyWe37shydvMh96/ds/lmStzb9GCtsBZy6pse/Q+XD2mHu8
r+9SFrgn01/teFeTCHvCGlnTb1Vz21PMKDHaAo4Rc1yclhsLnOCW8pc6jLp7fBg8
bWgzHUDTqyKKMLDFl10SSZa4m88cs+eeVJG2hSe7enqKJ2XrVTLNFqzw9fG/Ai3O
hLINBJb2OriTNxq1/Gs69CLKmRRM4zAy0Rv6R3PyRDznUeaA5OVKTTEOm/uI6XSM
FJeCi16KxebuO4/MjRk7k4VsIKdP7S0gWBwwbSYMC9AbCrToTgySwrG4Lw9z9e8K
6CFArA9edy5Gr+RmN+xdqJH9xCEO+f8nQgaY80L9RvCV1DL4gFP8FD1hqGpPFXoI
0ywfehW8heIKMVgyp2oIvgCfLbi7IqXdk3EAAZGxHfpoVifRroH1o/YBcIPSj/CZ
ivcvstjK//ekdEfD0GM4ts13VhBB/LTHM2LfLzcTBfPLmFTkWrs0and0tyb6WPsG
b+TmHcNSoZW9m6FtebL++AECcSUb5qx1SXaObya10hsIk8wpdEI8ZfbCZwkuRWA4
t0/cVydiBYXx+x2NzwbGRu780a4n/3vsJhHOoKNBRMxCSO+2Id77unWg7gDXwmdn
SiccxxcceSP34imtZ5RH
=dCvj
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
