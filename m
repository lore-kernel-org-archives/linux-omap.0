From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi/omap2: Let device core handle pinctrl
Date: Fri, 10 May 2013 10:56:29 +0100
Message-ID: <20130510095629.GM3200@sirena.org.uk>
References: <1367868998-12667-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EBE473A@DBDE04.ent.ti.com>
 <20130507085535.GN7478@sirena.org.uk>
 <1BAFE6F6C881BF42822005164F1491C33EBE4E07@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2YJj5f1P6Th4nBRw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EBE4E07@DBDE04.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--2YJj5f1P6Th4nBRw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2013 at 10:47:31AM +0000, Hebbar, Gururaja wrote:
> On Tue, May 07, 2013 at 14:25:35, Mark Brown wrote:

> > There's also been some discussion about factoring out the suspend/resume
> > code since it's going to get equally repetitive.

> Really. Any link/referenceso that I can follow.
> But I think each module will have its own work to do. May be I can confir=
m once=20
> I look at the factoring-out discussion.

It was part of the threads where the idea of adding the helper for the
boilerplate stuff to the core was discussed initially IIRC.

> > > I will be submitting a patch to enhance the existing pinctrl support =
for=20
> > > spi omap2 shortly which does above work.

> > How soon is shortly?

> Since I am adding this Pinctrl PM mode support to many other drivers (i2c=
,=20
> cpsw, da8xx-fb, hsmmc, ti-pwm, usb ...), I would say Shortly =3D 1 week -=
 10 days.

Well, I guess I'll keep the patch for now and drop it when you send out
the PM code.

--2YJj5f1P6Th4nBRw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjMRKAAoJELSic+t+oim9ZS0QAIn43m48yW11NEHJAuRGVsh3
+rtkMNjhE1oR8ShV8Qmo03fs6Ky1c0d5sJP/xRP4tQE4VArFrEN/CoPAnXk9GOmS
g7DfOUE/Q6V79NFpX+AO/+s6dBsHMu90/jJtGH2tZTz0mz5G5uYFgWm4ydzC/f4y
Ag0ur3j0N1v+l9luaZCp07mEw0WyHHqShEHA/z184CfQssTDieLfMckQtqfEzk+s
6Lg8+DDvv1VjMOGxg0D8dPAAKOmkBklslpLdJVXcQHzKtDAzIZnjX+K+vaWU8Lsy
8Hg2hWsLc6EYDVxLRDxHKjdh3PRvhDfvYwBFMQaKEhguKJIHtISjKC4iQUVm9dd6
NRg+RLzsTnAdmAgXkc2+l2JtRpynVn59bTv3mA5j8WSSINxtj9w3CiRSCijRRFdv
jhriqeo30qoTdTF8dStrBR0+v4XikOnq7UStK+IseBnVsvgwK4txaeKNCk4Ft6PI
WSt5Uhl8HeMYcRlvuqrlmJFcRSnUPWqhVAIui/SBYul+RxizJPiKXGn14F8JCZTZ
g7q1WfvXbPcWzEvmOGQq3zb6PRfPZhq5fTq5QqN5e88C8nP+IMB+P4SPRr6F5+xF
02PS0/+5uuQlDpd8+kJ5f48YEu4RWCfvAUx4uEMDOBvEF8WjizPsxThZSI4e5+Z/
uDeQI4J0vLETEoDvgKls
=RGoy
-----END PGP SIGNATURE-----

--2YJj5f1P6Th4nBRw--
