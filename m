From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/4] usb: musb: OMAP4430: Remove incorrect call to
 omap4430_phy_init()
Date: Fri, 12 Aug 2011 12:48:27 +0300
Message-ID: <20110812094824.GQ19467@legolas.emea.dhcp.ti.com>
References: <CAFULf_xEyAzJjxm6U+eVbdidSa3soVmn8J9NcJ=w8Fhf65yQaw@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mpb+VUhBqKoEsre9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:37505 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751786Ab1HLJsa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Aug 2011 05:48:30 -0400
Received: by mail-bw0-f48.google.com with SMTP id t2so2397258bka.35
        for <linux-omap@vger.kernel.org>; Fri, 12 Aug 2011 02:48:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFULf_xEyAzJjxm6U+eVbdidSa3soVmn8J9NcJ=w8Fhf65yQaw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bjarne Steinsbo <bsteinsbo@gmail.com>
Cc: linux-omap@vger.kernel.org


--mpb+VUhBqKoEsre9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 04, 2011 at 08:02:18PM +0200, Bjarne Steinsbo wrote:
> Don't call omap4430_phy_init(dev) before dev is initialized.
> The real omap4430_phy_init(dev) call is done at the end of
> this function.

you're missing your's Signed-off-by line.

--=20
balbi

--mpb+VUhBqKoEsre9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJORPboAAoJEAv8Txj19kN1hKoH/2AmUxN0OYOR6cZV+pl8pjGI
SUEo7gOkWlNu/c1WZaAl07tCziZ5qL3dAb5czK4h2UA08SxSNGkkSolrcBamAeK8
FuII6jH+6SDCIw/l68WX0PmITBwe/HNs1jX2bsJXY/5BGXvGMeoBIpDFC0f5hBQn
Rha2mXpF/3rnR12RTn7xdEu0dCyXYImLSbcOXr9+7VaBNt62fnggQ5W36fDBqLJ1
IPYV7Bwmhej4deNDAKfO+o63XIbIvN8lpmNW4DYjrR1YvffMWOIpDUbaZook27Ws
N9IHuHlPQqOMb+WIMrVEEA7Z/LmLJ2AsFeK4+dhwM4Yik1Vh462/Fz+UA8G1F0I=
=oLYN
-----END PGP SIGNATURE-----

--mpb+VUhBqKoEsre9--
