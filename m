From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc7
Date: Tue, 2 Jul 2013 21:16:47 +0300
Message-ID: <20130702181647.GA9216@arwen.pp.htv.fi>
References: <alpine.DEB.2.02.1307011946180.4358@utopia.booyaka.com>
 <20130701204236.GA805@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52937 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227Ab3GBSRS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jul 2013 14:17:18 -0400
Content-Disposition: inline
In-Reply-To: <20130701204236.GA805@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 01, 2013 at 11:42:36PM +0300, Felipe Balbi wrote:
> On Mon, Jul 01, 2013 at 07:48:50PM +0000, Paul Walmsley wrote:
> > Boot to userspace:
> >     FAIL ( 2/12): 37xxevm, am335xbonelt
>=20
> <quoting part of [1]>
> | U-Boot# tftp 0x82000000 am335x-boneblack.dtb
> | link up on port 0, speed 100, full duplex
> | Using cpsw device
> | TFTP from server 192.168.57.1; our IP address is 192.168.57.138
> | Filename 'am335x-boneblack.dtb'.
>=20
> Where are you taking am335x-boneblack.dtb from ? It's not in mainline
> v3.10-rc7 kernel:
>=20
> $ ls arch/arm/boot/dts/am33*.dts
> arch/arm/boot/dts/am335x-bone.dts  arch/arm/boot/dts/am335x-evm.dts
> arch/arm/boot/dts/am335x-evmsk.dts
> $ git grep -e boneblack arch/arm/
> $ echo $
> 1
> $ git show
> commit 9e895ace5d82df8929b16f58e9f515f6d54ab82d
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sat Jun 22 09:47:31 2013 -1000
>=20
>     Linux 3.10-rc7
>=20
> diff --git a/Makefile b/Makefile
> index c6863b5..0142c93 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,7 +1,7 @@
>  VERSION =3D 3
>  PATCHLEVEL =3D 10
>  SUBLEVEL =3D 0
> -EXTRAVERSION =3D -rc6
> +EXTRAVERSION =3D -rc7
>  NAME =3D Unicycling Gorilla
> =20
>  # *DOCUMENTATION*
>=20
> [1] http://www.pwsan.com/omap/testlogs/test_v3.10-rc7/20130630191558/boot=
/am335xbonelt/am335x-bone/am335xbonelt_log.txt

just a gentle ping here, wondering if you still have some garbage DTBs
left in your tree.


--=20
balbi

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR0xkPAAoJEIaOsuA1yqREI9UQALWe1Xlk5mj4PmzjBhyjECG7
WqGDnErqGG2GsGZLPeL9seC41zKDUtUQIeTiaVhKPu6/LGTXvIfnzdP3cI3evEXB
Ndy+Ls2/6CD1CK6PXjSdao9g2IZElpdODJcBriBsvJBRftMLak9Du7JY2tquYUTO
9WeoMNSL4CG1scAkh70Z18bjlV4RxdC4XKiPR5R98NOXNopZHiNVjCQQaFQNDqTW
5oRESgY2EM5gC39M0y23YVCxMRFbCR+PEn9+U7DfyaR21Ixf+erMb9UKI9gf6E8x
DErWvY8ZcrViU3arXLbRJ0G7ZVmAQucvMjy2etXFw7YqnDnKKYhqc6vXHB7t5rn/
OJp4VGUwt1fllX33i/mdh/18ozXgjSS+aeG44uijm3ysDjoJLCauEzkmOwcY1DC5
fwChpvAOeD+aI0QLqVhwdXgBg0iMhBN7QG4RRW5UGgtn8WtAIQOj7l+ENVhaPDUT
PYKvF8WnvuSyAFW3E/4JzRFSrkawgh8N8vFLUy+u7cNwVo3skXInt0J722xskhpP
pxaAqDqEnA8MlHarR7RwbpOB9QLq9qP4tbXyvKCElChpTH/pTJYZQaWn9Pnj7yC0
Jx5asHjNDqAQDI1mmVQyfi1t3XQjK1BsZrbh0MoZOvhd0pn7xPNV6UxaI91CVuXT
q+AgSoGqrrmvyALqJc7k
=ZhPd
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
