From: Sebastian Reichel <sre@kernel.org>
Subject: Re: 4.5-rc0: n900 battery charging reverts to 100mA, indicator turns
 back on
Date: Thu, 21 Jan 2016 22:14:48 +0100
Message-ID: <20160121211447.GA4984@earth>
References: <20160121184234.GA17679@amd>
 <20160121191525.GA26215@earth>
 <20160121194126.GB13448@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160121194126.GB13448@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 21, 2016 at 08:41:26PM +0100, Pavel Machek wrote:
> Hmm. It looks like 7fdec82af6a does not yet contain 88025632515a. Let
> me try to add that fix, instead...

Right, your checkout does not contain the power supply
pull request. I think it's unlikely, that the patch will
fix your issue.

Since there are no other power supply changes between 4.4 and your
checkout, the next most likely candidate is the usb tree (which has
been merged before the commit you mentioned).

> > P.S.: No need to Cc me two times and when you update your
> > script/contacts, please use sre@kernel.org :)
>=20
> Address book updated :-)

Thanks.

-- Sebastian

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWoUpDAAoJENju1/PIO/qaH+gQAIpymGPD2EwFjWju3TZ8y0rs
CsdX0Z5hBgkH2LIhciJNvSatdiggzD0I4/q566oHu8gZ0zx4yV+BvGt7m715fqZx
mtWmusjbZb7jAd4vJ8KxOK3pKzWyOebMINZ4KsPCKlu2FECog1wrAgKGBs7Niex6
U3OI1o6tDxkmmUzouK7NpZo26hi6VPip5tt0M3lEaKfteNZLfxlfCQGSy5dVBc2V
GbBkOPJ4Kt9u4vsiczBG33KKJMJOFXQabjuNUm64iC6SgmBs6kdp44GyzY8ADjMF
YNHHw2t0O44oV6XgxfIzWwDfLD5Ihmn0vKuaySBurK6DxSm/t1IlV28+p3Ac2tRu
eFbAamK2biS1LsH6gpx5ifdOHq812H/dizxRd2A7Ky63wPjs4dlH5hCSYonpuePK
w4g/2Cb/L3+5gC2gqAyePN7Y4i/hAakgwGJlauNAIFu/ugLll+jBnTeVdjY+1Z3E
wpQ+ObemS1kd/Bm/dFTOkm41LtI60VcleQTflbJGto5e/YoTYhD7LddZ4hocNGFo
T7Y5lyD1IyuC9MdUPF5oDUMEqqtRkW4Sw/QJQmQAOa0Yl7J9WEG+LRssZaBKlR1y
sDNsf+mApVI8h+fWDmZrxFD/l5lkREhGWjQadmOC9OywpFlt2Kv3c7aLA0V6vFnY
XnrGz4pQPXnlhwB2B52J
=kenH
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
