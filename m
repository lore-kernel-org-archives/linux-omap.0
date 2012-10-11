From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/3] usb: xhci: Add the suspend/resume functionality
Date: Thu, 11 Oct 2012 10:35:11 +0300
Message-ID: <20121011073511.GG10030@arwen.pp.htv.fi>
References: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
 <1349877949-18872-3-git-send-email-vikas.sajjan@linaro.org>
 <20121010175816.GP18378@xanatos>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:60492 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757451Ab2JKHke (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Oct 2012 03:40:34 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1069159lbo.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Oct 2012 00:40:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121010175816.GP18378@xanatos>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Vikas C Sajjan <vikas.sajjan@linaro.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2012 at 10:58:16AM -0700, Sarah Sharp wrote:
> On Wed, Oct 10, 2012 at 07:35:48PM +0530, Vikas C Sajjan wrote:
> > From: Vikas Sajjan <vikas.sajjan@linaro.org>
> >=20
> > Adding the suspend and resume functionality for the XHCI driver
> >=20
> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
> > CC: Doug Anderson <dianders@chromium.org>
>=20
> Acked-by: Sarah Sharp <sarah.a.sharp@linux.intel.com>
>=20
> Felipe, you want to take this?

I can, will get to these patches in a while.

--=20
balbi

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQdnavAAoJEIaOsuA1yqREuB0P/iuSo8INnePj2FsxyKppbd3r
68W2P2pw+mTgqKoU7p8FK2EtV+QEE2HR1Dm6YICWEb5SvSEd7lMnO8+JTJJYKtS3
7fBILp3CEwBhxV4DqrWAaY0JwlTcbpUAHKdv4k9GPL7ml8VwTUCPsveyXUctghGV
scF/oR0jAVfwsXcFb49QQOiQAdRpKvjP1+b7ynP50mIcI4EqtEwItIA3/RzM2Iu9
MSYkJPiIlV5YMJmKt5an8xXWbuPmT7wvo7s1kykNkH+YWjGIdWHVW/s5nDM1hw2Z
9gZ5dWa39gaLRDpdTR1xdedFm3AOyZPh77hNwjAQJhIr+lnUbTlGRiUP9+umy/qB
WqAwalHXiOcXaUmpWCTxWlEBfphcgGW4H+PFAlphTywQD8gLHJxbnbuvClQfRl6E
sM36ejgs/Kq7cllcGhIbQce+AcMoqnztPPfuze1az0MEe6LJ0gzFfuRLKoUPzdr2
cb+UdKgmgVm1ulyciB7lXHs5m+J+I8L/K2RDsL2L8syH6Vhr+V3xRsBabwKL5cKb
fKHm4RxPgQd+EdN4LcSITXlPQmO+4GhGh8sjNpPjtzR8ioY6mA2s/ItKeHhYmuIV
4RBdixhDoSgxl4TIoSjEtBrdZAcQI4ZFXo7FAky5+ci9tYHpUgqCBo18IoUT7joc
LxUxpEmbK/aygaIM6XAZ
=RCwA
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
