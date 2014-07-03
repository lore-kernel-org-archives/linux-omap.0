From: Felipe Balbi <balbi@ti.com>
Subject: Re: [GIT PULL] ARM: DRA7: dts: clock data fixes
Date: Thu, 3 Jul 2014 13:41:14 -0500
Message-ID: <20140703184114.GA30919@saruman.home>
References: <53B59B22.5050903@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40622 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbaGCSlW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2014 14:41:22 -0400
Content-Disposition: inline
In-Reply-To: <53B59B22.5050903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2014 at 09:04:18PM +0300, Tero Kristo wrote:
> Hi Tony,
>=20
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b3=
8f:
>=20
>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
>=20
> are available in the git repository at:
>=20
>   git@github.com:t-kristo/linux-pm.git for-v3.16-rc/clk-dt-fixes

you might want to set separate url and pushurl on your .gitconfig.
Tony might not have permission to access your trees through ssh.

>=20
> for you to fetch changes up to dd94324b983afe114ba9e7ee3649313b451f63ce:
>=20
>   ARM: dts: dra7xx-clocks: Fix the l3 and l4 clock rates (2014-07-03
> 20:59:36 +0300)
> ----------------------------------------------------------------
>=20
> One fix for 3.16-rc. Fixes wrong dividers for l3/l4 clock nodes on DRA7.
>=20
> ----------------------------------------------------------------
> Rajendra Nayak (1):
>       ARM: dts: dra7xx-clocks: Fix the l3 and l4 clock rates
>=20
>  arch/arm/boot/dts/dra7xx-clocks.dtsi |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTtaPKAAoJEIaOsuA1yqREFmwP/j4ZiDXVsIAfAq2+0tk38aGB
y6xsGeOpQ61sXtKnRsfp5F9WJE0Mso38CxGIbzhxb6hM5eKM8lWC7TGSOuOjeJJR
ryHR8yw1zQx+K/Vquht7bggCVq4TdnQXmvNfyqP898+JmnS7aRCTnBsglqpKAjUm
dC2bhuDDGxBD7qG5OWnvQpcYhd/olcD3Z5xDnBkA9B8vL0VsYyFghKWNIjTNM6Xu
hDpopBXTt0rKD+a7SXMClA+bzb88XGyMFvEajr9As4STIBn4GWvvGMrgp0CAkeZk
7COssoBwCaQtIo4lGjen7tbYkvRi432TI2HjEtF3aH6Nck/Z9g0ZsDFxQVwejOkf
XxQjOQosFMe3nqjvMummVUw1ZucyJidc7I8PA5qlpMl3ifkkMKlVbiyOj0VTTMDX
gB4SPyri5QqUjVomngPj17Dcaa2e4VvO7gau1Jwj283FBfmTFz1Kg1X+tWqAezga
ASXGmZQa7pgO1BFKKU+Q6HJ4T5+1iB/ZUoIJLmqS1ZM7pWmZHcGoc6sHzCNTAjld
6YTi4SwA+I80c1iZoXtGe2CcedHzzjs0S+fce8Pa9xF4iNUiXYWZ5rhHtzVV5thb
RlG1bQ83AvFOl4mvWcfTHyrEzf/uSXsmfNAK0G+Py8vpDT1vXe1LqDfeKEn45sgB
MBS25UOtkDsQrWPhVvYs
=XboM
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
