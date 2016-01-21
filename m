From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/5] HSI: nokia-modem: add n950 and n9 support
Date: Thu, 21 Jan 2016 13:30:37 +0100
Message-ID: <20160121123037.GA25193@earth>
References: <1453045749-22642-1-git-send-email-sre@kernel.org>
 <1453045749-22642-4-git-send-email-sre@kernel.org>
 <20160120164919.GA29749@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160120164919.GA29749@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Wed, Jan 20, 2016 at 10:49:19AM -0600, Rob Herring wrote:
> On Sun, Jan 17, 2016 at 04:49:07PM +0100, Sebastian Reichel wrote:
> > The Nokia N950 and Nokia N9 also have a SSI connected
> > modem, which use the same protocols as the Nokia N900,
> > but with slightly other GPIO setup and increased link
> > speed (96000 kbps instead of 55000 kbps).
>=20
> "slightly other" does not make sense.

I meant to write "slightly different", but how about:

The Nokia N950 and Nokia N9 also have a SSI connected
modem, which use the same protocols as the Nokia N900,
but with increased link speed (96000 kbps instead of
55000 kbps) and with less GPIOs.

> > Since it's unclear, if the N950 and the N9 use exactly
> > the same modem, each of them gets their own compatible
> > string.
> >=20
> > Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/hsi/nokia-modem.txt | 12 +++++++-----
> >  drivers/hsi/clients/nokia-modem.c                     |  2 ++
> >  2 files changed, 9 insertions(+), 5 deletions(-)
>=20
> Otherwise,
>=20
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks for the review.

-- Sebastian

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWoM9qAAoJENju1/PIO/qaZ0wQAInwZaKXtSAV748FQiOZH4LA
cUVAjHziAhzldtwxkYBEaIKFkOgwgwplJ8IkF6MbhqEUUuhT1sCNTvGVaWXgpLUG
ZK7e7JfnHigc83NZrJPkANhus+vQU64F/GwEys5aSq0Q5SxOVYOHbjfRIjfOqGXM
gilxO+Mr1mUOjRxnwCQNg4QFhm3hCQMavA4n/QltdP7owxEX9WNwn2iZE8jwWTdX
ZipBYjq01XYeYoPRsI6VKtpYsr1lFnQ5ir2WRGr1jL1z2SeBThCOHuCmEZqpLjJv
efZA4kOXo0NWuuzsXYV2pQPrmPnC/l7CEC1UOfXkRNvGkcef7Lu6zp4M4iX2gUZP
Dqy3ilJ8sJY+LlOMyiDhuHSkXj6xjWXHLvcwpG+qcowypYcItVPcjt1BRtW0pkvF
ZAowDd5Ifhfw1n/arFmTpWTk6TcA94M9+YxUWQk+DAD74YeMpXWelUmrWOCbCpal
uz0/PZsDEeYODt75N5Pi8YJ+Y2lHp6dgggkHiHbZin33E2uPVHVMAMn6nXl+dcY0
ICt6QwDbw3+UzA7epEdJABRABlh+TsVJnp+2IBVQRBzU1iDXIiHNxxfB8pDpFI0W
roOibzumEqXfHHvOCo16zYO5VZEsg9xh6KbkVDVQYqPApKKxPLMZMJOIMBGxESrQ
P8cjX7gi3Q9NsYKhSnna
=4Zta
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
