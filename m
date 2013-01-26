From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.8-rc5
Date: Sat, 26 Jan 2013 10:46:04 +0200
Message-ID: <20130126084604.GB8754@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33472 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811Ab3AZIqW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 26 Jan 2013 03:46:22 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 26, 2013 at 08:40:07AM +0000, Paul Walmsley wrote:
> Boot tests:
>=20
> * am335xbone: hangs after "Starting kernel"
>   - Cause unknown; may be due to CONFIG_EARLY_PRINTK=3Dy?
>   - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82297.html
>   - http://marc.info/?l=3Dlinux-omap&m=3D135903184512238&w=3D2

FYI, I don't think it's related to CONFIG_EARLY_PRINTK. Tested with and
without it, also removed CONFIG_DEBUG_LL completely and nothing seemed
to help my bone, no matter if I had appended DTB or not.

--=20
balbi

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRA5fMAAoJEIaOsuA1yqREI3QP/3dRB6Z0J+x6ynK5yrcBe1IK
UKV4/uHGwsZ/Hwp16YG9sOlF/YDH2e4FYUCZpwu28eK+SRy+vi8L5sUK5c56NW8S
zF5ufCpNaOrIF2AwKp2zSQv3Ydphg4ZOw8t3TDNQWGgS/VrG9ry1ch3DOZcw6Koy
I5/Ofs+iwCV+G6X5/7Ch0DBpNO1Z809upDRygoLMCMubJnKiEN8xGQX+EjwfX4Fh
iMD3dLo8Zh2SVxMpamK11rsyhL6lcpo9U2n1cul6ySZdAQgQsOQ1l4OvE/3e+HRW
W+EIS62VD2jPEDjakUQLiz6bc0xaFeakd4OqgHFIUbOZ+ajbpe1m+mnqBXs5+DMP
ug92S029oCIe00PMhPUXrkpPDRV+qHHjDPJvNah+Qn/5ZkzDqtbs9KthTMHfFW0D
dMF2jC57l5gat7dCME+IbAVT7y2bPhuw1vTYtno9IX9kJs87XK/A1AUn5oBg4JTt
zR3wVkvgJ3hTkIKWST36QCyaXAJ58VQAP4FUTLYjYNT5NDvqNaLA8sjxnAOthn8r
lzk9Nz9JVG8qm7Phsrqc0wzmPqSIFiKxKlKOEd6ttKrI8yRTdXxXdA97yZExoGaS
xFwQJHZMpS+/TW890A7heWCqLxEH5i25Z45TXjgzPVbdH0Gn7YfeRdHaMe8G9gvA
35aehxsGDOnAs7K9YjIj
=UgrQ
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
