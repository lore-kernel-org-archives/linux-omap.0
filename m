From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/1] usb: Include generic_interrupt for OMAP2_PLUS
Date: Mon, 24 Sep 2012 15:16:30 +0300
Message-ID: <20120924121629.GA5288@arwen.pp.htv.fi>
References: <1348487604-7202-1-git-send-email-philippe.deswert@jollamobile.com>
 <20120924121538.GH2892@arwen.pp.htv.fi>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:42047 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754475Ab2IXMVY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 08:21:24 -0400
Received: by lbbgj3 with SMTP id gj3so6597917lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 05:21:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120924121538.GH2892@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: philippedeswert@gmail.com, Philippe De Swert <philippe.deswert@jollamobile.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2012 at 03:15:39PM +0300, Felipe Balbi wrote:
> Hi,
>=20
> On Mon, Sep 24, 2012 at 02:53:24PM +0300, philippedeswert@gmail.com wrote:
> > From: Philippe De Swert <philippe.deswert@jollamobile.com>
> >=20
> > Unless generic_interrupt is defined the irq setup
> > in musb_init_controller fails for the omap2430 driver
> > since that one does not set it's own interrupt handler.
> > Which leaves usb non-functional.
> >=20
> > Tested on N950/N9.
> >=20
> > Signed-off-by: Philippe De Swert <philippedeswert@gmail.com>
>=20
> SoB's mail doesn't From mail.

doesn't 'match'.

--=20
balbi

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQYE8dAAoJEIaOsuA1yqREf2MP/i/OsfuSfh9YXUvr3R6+VNgG
BnZ2u/i9yVX4QRQXj+8IggxgeGu4TPSy3gaB2JesJx54O0tGaVbRJXJ0mDpUX3DF
p1hzVOFXfYtq5w/YzwA+lniEeSkxNHP3Iayi6sDNG2OyccHPebgflyJo3KzEjJE2
ilqtrrBWdwn7ZgmV2SYuR6UMAiMD/TKwdAVr3xXV8hk+BDNChEWoWaxhDgI24ySD
EeY1IQm5ceVy6rEyVkenN8GHK8ZUaCNdypnZvVkebZRWz0TTvfi5FLKzXyfE6d5U
diQnyF9KpLxdaotIy+at+wJvQuS3VXmFDhYmUvQCiq1BORDhRKAku8VvW5AA92ho
9/hqRVswjEOXUAJBfcDXxa8RdiRVGVOq1aei5q0/k87//oXt5Fx+yPL/zXTleZNu
vHnFxczn1ojvaCndLFrcQwDngKy6cW3bsNPJc4n8nzXYiv4hYZ2se3GHO72N1YxV
vSQ30s3m1y6jLb0AZwh1SjjMjZpUS7eOwB5GkVC3DrexRAiSnvjs+mjSMtX9A6Jv
4CwLq2wsXhQve0Os7aNuI8F5Uxc4oR3rUZfYRfQYjJEMYOcQ3KSANRryQzvN0uxB
8e7fGwkGhTTJCCkDnq8Y5N9uYBYpG/oDNqYu8l9HdMCZYJF6IknoXE3wPKxcpntf
divrxanEWxuJCx2mS6/d
=/Pyq
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
