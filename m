From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/12] Drop omap3 board files and make mach-omap2 boot in
 DT only mode
Date: Mon, 25 Nov 2013 19:09:22 -0600
Message-ID: <20131126010922.GA21580@saruman.home>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56536 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab3KZBKN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 20:10:13 -0500
Content-Disposition: inline
In-Reply-To: <1385424867-27243-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 25, 2013 at 04:14:15PM -0800, Tony Lindgren wrote:
> Hi all,
>=20
> We can finally make mach-omap2 to boot in device tree only mode for v3.14.
>=20
> By doing that, we can get rid of about 20000 lines of legacy code for v3.=
14
> that's no longer needed with device tree :) And that's not counting the
> additional removal of the code that comes with the pending patches to
> move clocks to drivers/clk.
>=20
> Looks like we still have some legacy boards that don't have a .dts file,
> so if you're using one, please post the .dts file. I've posted some quick
> instructions in the first patch of this series for bringing up omaps with
> device tree.
>=20
> For most omap2+ boards that are not yet supported with device tree just
> the .dts file is needed. Some boards also may need additional entries to
> pdata-quirks.c. If there are more complicated issues, please let me know
> so we can sort out those issues ASAP.
>=20
> I don't have all omap boards so I have not been able to do a .dts file
> for those. Some help would be appreciated there if you are using a
> board with no .dts file posted yet. I can naturally help too where
> possible so we get the devices working with device tree as needed :)
>=20
> These patches need v3.13-rc1 and some of the following patches
> depending on your board:
>=20
> [PATCH 0/8] Various omap device tree usability fixes for v3.13 merge wind=
ow
> [PATCH 00/11] Make omap24xx booting device tree based for v3.14 merge win=
dow
> [PATCH 0/3] Yet more fixes for booting omaps with device tree
> [PATCH 0/5] Prepare making omap3 device tree only and convert LDP
>=20
> I've also pushed all the patches into a temporary testing branch:
>=20
> omap-for-v3.14/tmp-testing-unstable-not-immutable
>=20
> Regards,
>=20
> Tony
>=20
>=20
> Tony Lindgren (12):
>   ARM: OMAP2+: Remove legacy omap3 board-*.c files and make mach-omap2
>     DT only for booting

looks like this patch didn't make it to the list, maybe it's too large ?

--=20
balbi

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk/TCAAoJEIaOsuA1yqREiTwP/iUtMbDcHOAkda1mVasD5ZD8
jPDkiLtBdykGRq2pmYKi7jVt46upE8TFo2xYtonU7HE7nJrCHvaDGYSfwJRZwjSI
qIspUSBAuywSqE/gM0shRLPMYnnTYDJgoN57h3FNkUGjqXq0Hq8RMw6USxh5kPLE
Euzd+V9Ry+7FSfiB2Api1Kts9O876xgoMvqN/9x++x6LCR7Co/KRn6CT39oBqy54
Ac1CGokQYmLhVmkEt0xsdhaKcLzHE7SGNuNRZk/ibpoQ1diabkvnHBQO+Z9bj0Be
8xF4LeMw/JUVf6tcFoYcHpMtBmkKyax9GRX/U7YoWplv2n7BTYS+U3CFcScyp1Nn
4cl+OiDoss/u7fRdztyOtrEQnhzAv7vUN1hGN+RvV4Q6rGt6n1iYeXuMXBWbHWmZ
B3/UJqa/JMCwbxOW5PDXslU7IZKgO2sP4Pp63ro4lPoS+YYVXjd5kYIRXdt0K2jY
V+aGY9PkygqE9Gfy/Rti0aUS8KWWWzt7PEE4d7J0ktW2lz/Ml/z9T/2ex+55twch
pIvk/F7wBz5y+UZP5FHSbmEyffJoiyHCzPIb6VStvQGbg+g4gYnI7Fg7eD2ZVBXr
3V4H7SU/hkgPiwhgNiRJempSrDLvbTnFSyHLD3B+99KJaFMhVaJGWPS/b9bhw9CF
TgKsaJmcYTL/x5i7Kh1W
=zokk
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
