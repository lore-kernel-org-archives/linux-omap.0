From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Tue, 25 Jun 2013 23:39:01 +0300
Message-ID: <20130625203840.GA9748@arwen.pp.htv.fi>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
 <20130625160243.GE22312@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6973892463288365932=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: khilman@linaro.org, hvaibhav@ti.com, Felipe Balbi <balbi@ti.com>, Tom Rini <trini@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============6973892463288365932==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline

--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 25, 2013 at 06:20:51PM +0000, Paul Walmsley wrote:
> Am certainly open to the idea that there's something wrong with the way=
=20
> that I'm booting either of these.  But AFAIK no one's been able to=20
> identify exactly what it could be.  I haven't had the time recently to=20
> spend hours going through the various permutations, given all the other=
=20
> breakage :-(  BeagleBone-white has the additional complication that it is=
=20
> not easy to automate, due to the way that power is delivered to the board=
,=20
> so there is an extra dimension of difficulty there.

oh yeah, you can use something like [1] for that

[1] http://www.cleware-shop.de/epages/63698188.sf/en_US/?ObjectPath=3D/Shop=
s/63698188/Products/01

--=20
balbi

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRyf/lAAoJEIaOsuA1yqRElIsQAI3QdrzhMxN4OOZO4rSO1THg
H2htXkomVZ58oIKUJYvGnPgaIgd2RoJeUni2pSt58dShPUVPxp1wCYfI/0MwCGSf
SM82CaLqknel7utMKVjn4puYBYaKMXNKENtvwkhInsCwGX/xXPF+7Ay9KKWYBQ/j
apKk3iJGH5jC+jvapIyKY2nUQW/kZicAa8sIiHQcBLAw0uAfcT/O3QxCQ9Wh3OOL
bm4L/vZJZE3sW+WjHm8CRoApdL0+rpm5oDWo8gPyHrozejX71CNIi3NZVx07Qx1S
LhHYpVLWPLx+DLgu8iGOwFEZLbWgOye80jrlmJleFhm3EIjo2fCOqoAyR2/lgqwP
AVyGlEC+gJyBDKiN6w5sSUt9SqebHjqPMZ5FwI0aOjK+epzsxepmz1hJHfmWt8Xy
eMeQQwJssOZS+iDXbSdfkVda5Kb5ljNisTIQt9okqTD58WIcEKRo+LiA+hc4fYhs
VSNcgmsKJtD3FZaXOEj0sgZqkaDrBjin4ocJ+aDzdgL6nULo/YczP8En/nnFn/lS
ll2TVx/09nZ1CtMn/kFvHO+jI/zvTz0mpfTE4E+68b+KMU69NrLid2gk4BioidjW
OuygNcUe9ZjUbEaIKSnpNhQMfRQUYuoel2wyZSbN1fEGYPxHu3dU/TqvQJIjst3q
FnqFavO7FT5xdLrd8jjP
=Ftvv
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--


--===============6973892463288365932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6973892463288365932==--
