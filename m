From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 0/9] Generic PHY Framework
Date: Tue, 18 Jun 2013 12:49:42 +0300
Message-ID: <20130618094942.GY5461@arwen.pp.htv.fi>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <51BEE203.6090103@samsung.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6044934518017205951=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51BEE203.6090103-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============6044934518017205951==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8a48p4KKsB+A/3VY"
Content-Disposition: inline

--8a48p4KKsB+A/3VY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 17, 2013 at 12:16:35PM +0200, Sylwester Nawrocki wrote:
> I have already used this API for our MIPI CSI-2/DSIM DPHYs driver,
> the RFC patch series can be found at [1].
>=20
> Thanks,
> Sylwester
>=20
> [1] http://www.spinics.net/lists/arm-kernel/msg251666.html

one comment to that series:

let's make the phy names standardized, how about phy-exynos-video-mipi.c
or phy-mipi-csi-dsim.c ?

--=20
balbi

--8a48p4KKsB+A/3VY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwC02AAoJEIaOsuA1yqREr1gP+wUX4ATtRcf9e6UYNWg22b87
GzL13FHHyH6O1mj+Qs3BfDYPMDHZNDfnwBBhxgBB+DlhgeyyCn0Ry3zeneA188wz
OCXsD3pVWqZA4REcXF38+aZQr/fB54TYsF7DiKkqYid8IzbjFunKVn1KFJUZRemA
yqr9DZNH4h44nvcB+/+k+G7tu11gbipklbq94cEr4FzRX5rTGWyXoxvl+N7WM7hU
O9XLhvuAsIMwzSAIq7iFxq0ZhSUzG1Gx9bWh73M1Yhbg/5zaGw36Q+GXJ2Gm1eYm
/dLWiKDfD8N1VDlLjfH/7kAMcCCaGVDtvOU2GA35RP9h4mSF/2EeaxoCqcZDgUHQ
ieSverpduDO2/Kq9ppDlYHs/9bLfPKi8kDwNgKdpN8mRls61+u0MdSe/tCHzrnZ9
B0lVpvzYiPPo20ldNb6Yqm5vM97RoLgNjPGbsSuAZbDo2VC/Y5U/qnqls1fa6LaF
XTyMuZFbN52QYa2ls1or8d6pXKcsKA1kQFwZpQ2uCA5gmCtb0D4EfcITbU827/U9
KMk9dLH8Wwzics97vraM7v27DQjoeBTzbMb7AIu7VQYNyOgNJ+NLDvZN8cumdkd1
Fomw/4+ASxRS7b4gRzRcxHMmN8LDSafHGeXCtXYR/B3kyb3TW0UoH4kRgWDUlPPI
Iv/HxD9vQzbKyKpYQtPw
=5awi
-----END PGP SIGNATURE-----

--8a48p4KKsB+A/3VY--

--===============6044934518017205951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6044934518017205951==--
