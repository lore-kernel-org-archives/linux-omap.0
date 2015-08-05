From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/8] ARM: dts: AM4372: Reorder the rtc compatible string
Date: Wed, 5 Aug 2015 10:31:48 -0500
Message-ID: <20150805153148.GB12328@saruman.tx.rr.com>
References: <1438771792-12604-1-git-send-email-j-keerthy@ti.com>
 <1438771792-12604-2-git-send-email-j-keerthy@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438771792-12604-2-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2015 at 04:19:45PM +0530, Keerthy wrote:
> Compared to da830-rtc compatibility am3352-rtc is more compatible to
> the one in am437x. Hence adding the am3352-rtc compatible to cover the
> entire feature set.
>=20
> The ti,am4372-rtc has no Documentation and not used even in the driver
> hence removing it.

why don't you do the inverse ? Document am4372-rtc and make driver use
it ?

--=20
balbi

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwixkAAoJEIaOsuA1yqREFnIP/0OAY66II01TnoWFH50xdN0D
yeyDBOonE236MYbcuu396SYan3lelXABSvbPHtRJA7JMYk48Or8xkxaO+YkCEOJZ
GD9Cj1b4GBftM+RehuBKMQjwaO6yIlzqPWa05CtbwsoHCUzOU6GLFHpxEksRl/Hz
X+fRUSxFlyphkZM7118567jaqeGqelcxzj+bY+1hkNzvmVP93D+roBpl7Kywy+5i
uPgoz2l4X6gNFxGQCW6sWvjbf3yasvVxZcPklHwi6KjxVqFiSXtxTYMH4E9OwT25
vmLeGgUvCQ8pohYfdPOmoLqIWsfoCJS8v6jMJO4najhZHc2ya5LupxedYW7i/xXD
ShV5K5iZE7VgX+VOMNXq2zbNneA+gTL56qha7A9gipHS6rA3KR0nYFyXdR0sgv9M
H1rAuFvv5ML7T4g0n+ny1q5QWmAU09GJF3NN49CRqgNbCySgtQt1YPaDYl9hR3aO
waJBM8aZchTtXRPGDqC0DpSek8+JrPoPjveCbzuz12/jnsng6xJUuk6CXvBSTabH
rBtQEsyKDbuaRFQ4E1OrZ6b9gl2xWbIsi+f16h4lFbMYhxxTKD7R/SI57H4qzwpy
t9D8vtj26qNHy7gr/rzVemwa6dyEUMKRDUI15mWMavPYgBIF62f409R8k8TOhYdf
TPJt4Ye6CDgui61GLzrX
=qvGZ
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
