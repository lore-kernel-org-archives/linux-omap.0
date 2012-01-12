From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 12 Jan 2012 11:51:26 +0200
Message-ID: <1326361887.2065.16.camel@deskari>
References: <WC20120109124643.880164@terrafix.co.uk>
	 <20120110080849.5a242adf@notabene.brown>
	 <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	 <4F0D9B15.4070803@ti.com>  <WC20120111151532.4602C0@terrafix.co.uk>
	 <1326360490.2065.10.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-qDeWXIDzDxp8nPh8YncS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:45678 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752055Ab2ALJvd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jan 2012 04:51:33 -0500
Received: by lahc1 with SMTP id c1so1075662lah.37
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 01:51:30 -0800 (PST)
In-Reply-To: <1326360490.2065.10.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: khilman@ti.com, Archit <a0393947@ti.com>, Paul Walmsley <paul@pwsan.com>, NeilBrown <neilb@suse.de>, linux-omap@vger.kernel.org


--=-qDeWXIDzDxp8nPh8YncS
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

(I seem to have not waken up today...)

I also forgot to mention that the fail happens in
drivers/base/power/runtime.c:rpm_resume(), where the check
"dev->power.disable_depth > 0" causes the function to return EACCES.

I'm not sure what disable_depth > 0 means.

 Tomi


--=-qDeWXIDzDxp8nPh8YncS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPDq0eAAoJEPo9qoy8lh71UR8P/0eMNjfuyGf6TvILsIfsXN91
ej3SIpKuka0c8QjPZ7B6joVkhBotdQwhKIKV53IGp7BDGM3eKB+TB8FhJXJ8gS2s
gunbSGorKs2ZFK5UgNqhwpDfsfIMarpaIg+dKF7JH1RhJas+3rtN7n+x9VN9/8vJ
YcLVUB5El9SCIK/+PXaedtX92fIxZJg7gFwPo43weyJ9zzciUJA6c3nXyy+Z0Q/h
EDDB09zkuuNRaIonacFjquPP8wI2CHM4R9WDAzD0yXPTe7O8y8Px2lK6aaAHfd+O
ZqxolAH1w3i3GMAneodCVPI8iE257TJJTZSq4fumLr+mKnh6oDarLu/0XfX3lX6c
6qsB/YxHh3HmOYvdg5BKos1eZkQQiW55Z91WuG+PULPziGnY31JdaFRuwVSmGCvE
60t3ViASOlpMRThm77B1+wtmxcsj3j9VcP3/mT14UVwQ+7VLZ05XIjYI1Zk8wMwD
sHESjq12YDnOejONI75WRcFIcypu9zfcGbk3NOrwVM3ACT/RaJ9WbjGXgZvHxf0N
cWX2YhCgZGx09QdeYa65S1QkICoR/eMiHBjtHMnLbT2cLeznoMMHW40zd8fACY9/
ql5crte8DCW75bbPtQMx1Sp3TuKjAOkQiMs7IyK04UqTX40ZH//qBOQYJKLKL1mL
A/vbMfHkWiZx6zRjfFGf
=EJam
-----END PGP SIGNATURE-----

--=-qDeWXIDzDxp8nPh8YncS--

