From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap2: n8x0: move i2c devices to DT
Date: Wed, 17 Sep 2014 10:02:05 -0500
Message-ID: <20140917150205.GB6903@saruman.home>
References: <1410899500-21323-1-git-send-email-balbi@ti.com>
 <20140916203337.GI19010@saruman.home>
 <20140917145131.GB7987@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48598 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754363AbaIQPDA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2014 11:03:00 -0400
Content-Disposition: inline
In-Reply-To: <20140917145131.GB7987@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>

--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2014 at 07:51:32AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140916 13:34]:
> > On Tue, Sep 16, 2014 at 03:31:40PM -0500, Felipe Balbi wrote:
> > > By moving i2c devices to DT we can clean up
> > > i2c_board_info and fix a problem with moving
> > > INTC to irq domain where IRQs can be renumbered
> > > on each boot.
> > >=20
> > > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> >=20
> > note that this only causes problem for N8x0 because it boots in kinda of
> > a hybrid way, where it uses DT but not all peripherals are created
> > through DT.
>=20
> Thanks applying this into omap-for-v3.18/intc-v2.

it might be better to apply this on your DT branch and merge DT before
intc-v2, that might avoid a bisection problem.

--=20
balbi

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUGaJtAAoJEIaOsuA1yqRErGwP+gJp1m4TNZjltzIQ+rkLaPoa
bFw94hf8RuwMMu6TgmnrmYCeoL3gWALVHQLwmfYfCLkZqrU8OBktSBNSfZSrSayk
gRxdDsE7kuhD/nKoVdiQOrzAKhxbfvF4q6ZnhvC5RVoKE9hOw5PSVN/4eztbh8va
CgbSBLF5eDiWD37OfgC4m6+zWBpFLbbmiYy7V4bYFZypy/IPGnC4UqCvdTYv1ODy
NMbY6vDRRLqzaI+pqo+CzeOdLFMc0FdPr97Jm0c/9xZPCAo/Qqoz02dh8ewdOSdQ
ytQxplrhkil//cdK36a4iEohQF8738tUMoJ2ByuyEALH92jCddBVBHQmEd17san3
2Ubzg00GixmEttXbH+ziywuVpgpLE7A5Nz5F0MGz5vJqtorOOoksKUY0zsKMidBx
6z88zIzLXrwSMpsygpl2epfbUhFQk5my0vTdHl24KNx+Il/IOsG8XRFh0fH3mpgw
VIv5CJW2Wpn8JISYfEyZLdEthfcFcuL2AXTdQI5mQUhIWI/zdCj4TH3DdL98tH00
iEYKFKFbKT4hNfwM/FTTbf5/mLBTg3dcLKtW74pDjJXAFx77ncIx3H5N6RdA12ma
WWedhOYzoWhSatjfc3CmO/eLxtw0ynedWWeq2hOXeAZGXwvD4hjIUA4HX2awP3Ak
Xa+fha33P4gGSQNyqr1h
=/X9O
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
