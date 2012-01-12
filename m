From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 12 Jan 2012 11:30:36 +0200
Message-ID: <1326360636.2065.11.camel@deskari>
References: <WC20120109124643.880164@terrafix.co.uk>
	 <20120110080849.5a242adf@notabene.brown>
	 <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	 <4F0D9B15.4070803@ti.com>  <WC20120111151532.4602C0@terrafix.co.uk>
	 <1326360490.2065.10.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-2eoD3O/232fEM9UFgxpw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:39792 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753103Ab2ALJap (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jan 2012 04:30:45 -0500
Received: by lagv3 with SMTP id v3so900876lag.31
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 01:30:42 -0800 (PST)
In-Reply-To: <1326360490.2065.10.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: khilman@ti.com, Archit <a0393947@ti.com>, Paul Walmsley <paul@pwsan.com>, NeilBrown <neilb@suse.de>, linux-omap@vger.kernel.org


--=-2eoD3O/232fEM9UFgxpw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-01-12 at 11:28 +0200, Tomi Valkeinen wrote:
> Hi,
>=20
> On Wed, 2012-01-11 at 15:15 +0000, Joe Woodward wrote:
>=20
> > > The pm_runtime_get_sync() call in dss_runtime_get() is returning  a=
=20
> > > negative value, could you print out that value too?
> > >=20
> > > If the call to pm_runtime_get_sync() fails, we bail out immediately. =
So
> > > the LCD interface shouldn't have been enabled at all. I don't know wh=
y=20
> > > we get sync lost errors.
> > >=20
> > > There is a possibility that the LCD interface wasn't switched off whe=
n=20
> > > for some reason when we suspended, and switching on the clocks again=
=20
> > > tries to start the transfer without DSS being configured correctly?
>=20
> I can reproduce this on my Overo. The problem goes away if I change
> dss's and dispc'c pm_runtime_put() calls to pm_runtime_put_sync(). But
> I'm not quite sure why.

Oh, one more thing. I didn't get any sync losts, but I may just have
been lucky. So it may or may not be a separate problem.

 Tomi


--=-2eoD3O/232fEM9UFgxpw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPDqg8AAoJEPo9qoy8lh71qVgP/0LKOfdoFy+6OEuvW9LBnFeO
bFs/Ux1YQ+XYB6DicukFDJLQ3kp63q1cENRuLXSBAT2KBoSgx945L1YDn6ipkuIn
bfKwGhbxUePuWe84D0WdriPllN0JGHBk/O+eaJHLj1QniTeRyJ+nMdphfP678cg/
91RYWNjf7Lv1/E82Y1RemvwH2GHuTt/sh+cG9Lmlv8i+qsPvPWn97jFyEsmnOyfQ
lHXF2bxdf4WcTd4tT8JsVnZVsIjTESYQKFa1ER+2DAteaSJ2mWwD3RsVJC/91RMc
zK5N4iAuPM4jWE7mDyDTbyUFECeq67UiT5ArShsOiaKLu63t3/GJfdLsJrcpcQi0
sP+cI80oTwvC86vvfZk2yDQv1KA/mHAh2KmuZOSnKMh3P1JcVizkPm1S4YI+Qd1T
m8WAaF/LhDGNlX6Aa5KYUbR0A5wsH/B5b0/0WDjh8J2vMhNvDo1q04AHf71D4GRo
nBnKJUUryHtnket8rG+9+YANOZtOrRN75Jtk/1dOtujUoure+5HBts9fjIrQk7Yg
Tg8IQ9L3WBWeG9xsav58plRpMcLW0oHTJ0NHTKIZqwpuVK8Ej3MUjsfTG1RgEj1J
eEOCwBif9+U9VG90RII/qHEM01E1aMH8xnhgtW9R/L33dzzxaW32Xrup1v9+deQT
7rWJXnty3VmlE8dhbfZM
=K+iw
-----END PGP SIGNATURE-----

--=-2eoD3O/232fEM9UFgxpw--

