From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: omap: abolish variable name confusion
Date: Fri, 10 Jul 2015 12:27:01 -0500
Message-ID: <20150710172701.GB20408@saruman.tx.rr.com>
References: <1435260890-32335-1-git-send-email-balbi@ti.com>
 <1435260890-32335-2-git-send-email-balbi@ti.com>
 <20150709194941.GH4744@katana>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150709194941.GH4744@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 09, 2015 at 09:49:41PM +0200, Wolfram Sang wrote:
> On Thu, Jun 25, 2015 at 02:34:49PM -0500, Felipe Balbi wrote:
> > struct device pointers are usually called
> > dev. Calling our struct omap_i2c_dev pointers
> > also dev has caused enough confusion.
> >=20
> > This is the result of a few simple sed rules
> > to convert all struct omap_i2c_dev pointers
> > to be called omap instead.
> >=20
> > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>=20
> I couldn't apply this one. On what was it based?

it was v4.1 at the time, IIRC. I'll rebase again once I'm back in the
office.

--=20
balbi

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVoABlAAoJEIaOsuA1yqREQi0P/jnmWcalXi6TRoiEn8egg4g3
kcTMQlvDqKU/p3TjmXzoQx6y18WEGPu99uuHIlWPoW4dnze113yANq2+PSD8VMHK
61xtlT45zvblTkxnvh6AgO4v2YxsRVBaAugontfSeNPg0bJPxE1vwqPFncD+Z4Wa
IRVkJA8WecU5sx6isYsZ2QA7AP+iqtU2EBhz5dIbtN8oECII+j/jeSr1l0skvFin
MZeplWn5Jq+iXECUC0iNF5oEuBwQs61nbPdFhdYrG+eXh2MNOFK1eV7zVSSnCcxI
7y+MwUoIZa+BGj1PRBmbDMtxZ/NVIkzc0j/4P2xDJRiUs+K5frchVPqFZ3m0AYrR
fUJw7eDcSKrwMj4Ebx0CNZgQXtQp7DeZdJSi+elHUBZErq3C9FAjOHJfb3vZ1WRp
QAkaNurPo+MlWrB0FInebN7Mhtw+KdTwGfp44nC9oGYSKY9geVT6NJDyY6ZKQztz
YEaSqGfoaNXrnStnPt+qhepeVGpRj3U64jZa8tsTaX4tcpQXrx6yYzTjuu3C5qAm
QaYXNmJOOaO1lCOCbIJhf4gLc+1wOLnkiPrwA2u5YGWq2PMS7g/W9DFHo1lvbGCM
2C3j4AHySWwcXqWX9h5OLItxNbMXkTm6iYSZYFr+whz9iEqAm7uNcDzRR2bBZye5
4HvjojWWtE83qfUC0IiC
=+GZ8
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
