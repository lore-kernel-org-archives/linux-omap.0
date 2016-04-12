From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] of: Add generic handling for hardware incomplete fail
 state
Date: Tue, 12 Apr 2016 19:22:35 -0400
Message-ID: <20160412232235.GW13577@bill-the-cat>
References: <1460486275-12256-1-git-send-email-tony@atomide.com>
 <570D56FE.2070408@gmail.com>
 <570D7922.5020206@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mEvYxaKTQdy27sIr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <570D7922.5020206@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


--mEvYxaKTQdy27sIr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2016 at 03:39:30PM -0700, Frank Rowand wrote:
> On 4/12/2016 1:13 PM, Frank Rowand wrote:
> > Hi Tony,
>=20
> < snip >
>=20
> > With that change, the bulk of your patch looks good, with
> > minor changes:
> >=20
> >   __of_device_is_available() would not need to change.
> >=20
> >   __of_device_is_incomplete() would change to check the new
> >   boolean property.  (And I would suggest renaming it to
> >   something that conveys it is ok to power manage the
> >   device, but do not do anything else to the device.)
> >=20
> > -Frank
>=20
> One more thought...
>=20
> Are there multiple drivers that need to follow this
> pattern, or just one at the moment?  If just one driver,
> then I would suggest open-coding accessing the property
> in the probe routine instead of adding the helper
> functions.  If more drivers appear with the same
> pattern then the helper functions could be added.

This is a many problem.  I was trying to describe this at the BoF but
it's something more along the lines of:

SoC family ABxx supports 20 IP blocks which will always be present on
the physical chip but depending on the exact 'xx' many of those 20
blocks will be powered but 100% unusable.  Based on the 'xx' we will
know this, and know that we must turn them off.

I'm under the impression that it's not just "turn them off for power
saving" but "turn them off so they don't break PM".

--=20
Tom

--mEvYxaKTQdy27sIr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDYM7AAoJEIf59jXTHXZSH2YP/jBAlm55yyT+H2khEA/6RSqz
bOMuRTwus4fwwCOfYxLY0SCxvv4qNGqj276OllZYTJ8XGKzKWf9boRd42/y7zCrI
NZ/ghtuKHtf2QH43qP/ugKjKsn6toQ2D3RriPaQKQahJVExPKjesRaWyzz0MeL5S
h15woYgrMYV/5nNJn6TyPeh0ObWBPhLQer4k9B+Fbf0X3Tk6NFfpcKz65p3s1QQ3
vHpL1Xo+YJ0v3czrPjw5KIhzQC1u7OuIVL0nOnVLSKh3x0x4iHpA/2cbI3SzCdla
lugydZ4k+B9/dbIr+KaI0xR/5MSCqRtjb6/eXGu5CBIF77n2w2TAdb7YmqFL2RNE
nyp8Loa4AmoSwjxCxafw3apwnIPNQ/ug2H3ouPs+JNG9y4gyhgDpTMbybzBEaY1a
PUXBUya1x56x280WHLSvVR8rAqk5k65QN8L9qfbOa/gq/Peim4jj9VK3JjpBoAFE
3ETDai+oemjQGgC0+XVnbj1BYKn1HSCAna1XNh6a7qrCIYZkD+s9F7PKi26cdMa3
sTJjC80cwTeVGU5xp+QUXiE8RNzOJ8M2/qJ109friQjF8OTUUSKpKhL8tjHENBEB
hUNY6eD/dIuVHhTBjRYTMJgQOfNnvt8eqrWaXD3y0j8eEmDMSvG1xJdC4m5hsrd9
aEQQQ+wm1RkQ8BIur1U3
=rxOy
-----END PGP SIGNATURE-----

--mEvYxaKTQdy27sIr--
