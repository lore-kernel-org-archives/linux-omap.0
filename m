From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 1/4] arm: omap: use hwmod to create a dwc3 device
Date: Mon, 15 Aug 2011 19:12:13 +0300
Message-ID: <20110815161212.GJ32750@legolas.emea.dhcp.ti.com>
References: <1313423845-2288-1-git-send-email-balbi@ti.com>
 <1313423845-2288-2-git-send-email-balbi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Q7FmPuhIbtiu4EM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:45014 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750790Ab1HOQMQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Aug 2011 12:12:16 -0400
Content-Disposition: inline
In-Reply-To: <1313423845-2288-2-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>


--/Q7FmPuhIbtiu4EM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 15, 2011 at 06:57:22PM +0300, Felipe Balbi wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile          |    3 ++
>  arch/arm/mach-omap2/usb-dwc3.c        |   49 +++++++++++++++++++++++++++=
++++++
>  arch/arm/plat-omap/include/plat/usb.h |    6 ++++
>  3 files changed, 58 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/usb-dwc3.c

this won't be merged ever. It's just for testing purposes. Since we're
moving to DT, all of this will be achieved via DT.

--=20
balbi

--/Q7FmPuhIbtiu4EM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOSUVcAAoJEAv8Txj19kN1fpcH/2qOXrOFow++7FAWPWYdWmw0
02/aUPloRt40JyzMi+Hd2MtphfO0dmVvzksMRktVVdAhA7jFrvQ4Bs3RwsfutYHM
YpjHjvunAJXFRL6F0V0rSPBRfP1tVcE7fddP/K3+f//+IGspv7DIth6gsGF4LrVu
MdruPc2AoKRtUwvilKwLMmekj/ECeS4ycVBt2GJngvRBRgYvtMhC+s2VRqzNu4Dz
0JDGYlfeM0zsx0N6OaKzJmjYWvZZ4y5SnhagmiIVihOZ2OA4ZVvL2Rv+4FvLTct5
5nYnnAQYU4Vq0N2KXihZm6P3iS8ckxCHe12+E4ymmghhPkyecwgu1WJ4saUkkNM=
=D/7K
-----END PGP SIGNATURE-----

--/Q7FmPuhIbtiu4EM--
