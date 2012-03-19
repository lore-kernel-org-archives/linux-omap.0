From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: is there way to control dss output bits?
Date: Mon, 19 Mar 2012 11:18:53 +0200
Message-ID: <1332148733.2144.3.camel@deskari>
References: <CAOaPdDZw0yEXonpWkvr0Q+zNVzfC6myQPpjkE+k0Yg0ZFg7bkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-WCqF/tz46B2JoKwCVKSh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:44488 "HELO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1758495Ab2CSJS6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 05:18:58 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so4494213lbb.33
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 02:18:56 -0700 (PDT)
In-Reply-To: <CAOaPdDZw0yEXonpWkvr0Q+zNVzfC6myQPpjkE+k0Yg0ZFg7bkQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alex Tomas <bzzz.tomas@gmail.com>
Cc: linux-omap@vger.kernel.org


--=-WCqF/tz46B2JoKwCVKSh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-03-19 at 12:10 +0300, Alex Tomas wrote:
> Hi,
>=20
> I'm trying to build simple DAC to generate RGsB signal on a beagleboard.
> say, the output is filled with green, then at "green" pins I get 1 all th=
e time
> while I'd like to get 0 while hsync/vsync are active. is it possible with=
 OMAP?
> I found UNUSEDBITS in the documentation, but that seem to be related to
> RFBI and not to regular parallel output ?

I'm not aware of such functionality. Why do you care what the green pins
are during hsync/vsync? The color pins should be used only when the
data-enable pin indicates that there's valid data there.

 Tomi



--=-WCqF/tz46B2JoKwCVKSh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPZvn9AAoJEPo9qoy8lh71R/sQALE9sAlCC01pp6EFcYHd+vGK
UPP2uZ8n4rD1ilrIDPtyOotPUyy1RDhMmfaHCc31Y63Osebq1WX7JszTiS3UwF/e
TwJ8PZ8cdyKkQ0idPCfblaC2IINkAHdH7bSwvMizSxSOCiO+6OinMHiWOb/jM3vR
kmSRU0XDDcKFfx41AnO/RP/J4sAh0kACnrIyc/GIHYZ7spXf3LzfBvri6azL79M1
sRHD/z23DjR5ZdNDwlY4y/cGKJOLq3qzGy5GHugvFWOBJdoQSMh4DCqjyv7/HAIO
1RwZTpvPCzWSa5MlMgzXVJhLU4dlPMIpfFW+QiQPKgNLU7uPTzbZugjv0oUMAQns
BYIIfbUcqncxzC81UiG4oP6T6SuatPqzP8tGqumaM2S19eslX2jJ/BxKZ6Qa/1Ze
sne4JoeG8zcWBbaY8CTX1O6/bN31Ipnn/gKMug50jSYLxVm0/fbOnYlfaYsphFpB
yR3rQDHDKkYke/4HZuOz5EgeR6hlBVAQmzKDdNkXj7o3Mbp/waAE/pFAQwzb7ALD
qGpuLGIFrqSFnn/xGgNYGTJ50ZIH8s3c/bGNjOtVLxKwqE/OPoJVaOmqtRudkz1R
lwf1SYrkFfAFHd/Dw4b8f0TMYODdUM9zuq/FAKsMtLZcabwBe/YRLuxPqIfKiiqX
zaGqId5t0yJT4qp9oVRH
=BmMC
-----END PGP SIGNATURE-----

--=-WCqF/tz46B2JoKwCVKSh--

