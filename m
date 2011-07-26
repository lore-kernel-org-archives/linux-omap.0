From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Tue, 26 Jul 2011 18:06:57 +0300
Message-ID: <20110726150655.GK32582@legolas.emea.dhcp.ti.com>
References: <1311138718-5072-1-git-send-email-vikram.pandita@ti.com>
 <CABb+yY3E69J6vbHNP92k-b6ScFMcU2LY71rqEZMY_9+E+vx=fA@mail.gmail.com>
 <CAFm5wm3zZyMgScH6OqmVVW32mLUJ6OGcmDy+Wz9Gc7EBjsswJQ@mail.gmail.com>
 <CABb+yY0QsO-rh6Q9nffmPp=4sYi=6Csor1VPdhLvAXd5LJVeRg@mail.gmail.com>
 <CAFm5wm2ng-fs0OgUG+h1JaF3_LBp93fHw2Vap2oD_j7Ok0NNnw@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dyTp/pkqtoagvozp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:58070 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752153Ab1GZPHC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jul 2011 11:07:02 -0400
Content-Disposition: inline
In-Reply-To: <CAFm5wm2ng-fs0OgUG+h1JaF3_LBp93fHw2Vap2oD_j7Ok0NNnw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Anand Gadiyar <gadiyar@ti.com>, "Balbi, Felipe" <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Moiz Sonasath <m-sonasath@ti.com>


--dyTp/pkqtoagvozp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 20, 2011 at 09:48:53AM -0700, Pandita, Vikram wrote:
> > This *today happens to be only UMS* is my exact point here.
> > Can you guarantee no other function driver will ever expect only
> > full packet xfers and treat short as errors ?
> >
>=20
> We are trying to test if short_not_ok may not be needed at all. But
> all gadgets need to be tested on MUSB for that.
> We will need wider help from MUSB maintainer/author(anand g) to
> determine if removing short_not_ok is fine on MUSB for _all_ gadgets.
>=20
> To be safe we only enable for UMS use case today that is definitely
> working fine.
>=20
> Time for Maintainer/author to pitch in !!

I'm thinking on allowing this patch to go in if nobody has really strong
arguments against it. The real fix, though, would need a bigger re-write
of the endpoint IRQ handling and that would need more time to write and
stabilize. Together with the huge amount of HW issues MUSB has, it's
quite a task (been there, done that).

--=20
balbi

--dyTp/pkqtoagvozp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOLtgPAAoJEAv8Txj19kN1oA4H/RgAyWXaoNP1T9qexfiBlcFG
RL/9K2Q76neRU1Zmua1nT9rfXAwOyFVVmyD3kZ4JmPM70WWxMtbmXNGq8j3PwtPm
seQhmCG0ay4NNH0gfRBRiAf93RAO/yfXE/d4PbqNVBgI3u16duSy/lNQajD9A9O/
aRZplS9sU030AhovYhP0kmlJVUdlVv1gbihO/jvcPaEwu0gaCuv77QumoMkqwFjv
ppWE+HlqrN797KdzqjOHrzXBhPbItkqxJWrgAoa6cAADTzxsgHpauI9T1/qXP3Gc
6imz+9JzQj8xl1FJ9l5BWQRR2iTi3Pyhgh75BTHfbUeUMie9abFW2JPfwW5rwdk=
=xnQq
-----END PGP SIGNATURE-----

--dyTp/pkqtoagvozp--
