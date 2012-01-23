From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Mon, 23 Jan 2012 11:24:16 +0200
Message-ID: <1327310656.1916.31.camel@deskari>
References: <1327055619.1921.57.camel@deskari>
	 <CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
	 <1327060886.1921.63.camel@deskari>
	 <CAORVsuVenz_fUPp3o_x+xrN3JJXDUyreMNvqjCPGzLrQf71EnQ@mail.gmail.com>
	 <1327063256.1921.68.camel@deskari>
	 <CAORVsuVGT1AaMzo0r6T4vWe7zz7Uk=o-DydAcGdMzE+utDoUww@mail.gmail.com>
	 <1327071609.1921.82.camel@deskari> <20120122221132.32bd4d44@notabene.brown>
	 <1327308790.1916.30.camel@deskari>
	 <alpine.DEB.2.00.1201230154430.29673@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-rDJUs0ZmbtfiTuuGODmF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:50308 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752037Ab2AWJYW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 04:24:22 -0500
Received: by lags15 with SMTP id s15so1457793lag.6
        for <linux-omap@vger.kernel.org>; Mon, 23 Jan 2012 01:24:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201230154430.29673@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: NeilBrown <neilb@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, Govindraj <govindraj.ti@gmail.com>, Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, Joe Woodward <jw@terrafix.co.uk>


--=-rDJUs0ZmbtfiTuuGODmF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-01-23 at 02:04 -0700, Paul Walmsley wrote:
> On Mon, 23 Jan 2012, Tomi Valkeinen wrote:
>=20
> > Then I noticed that the DISPC's ENWAKEUP is not set. Setting ENWAKEUP
> > (with SIDLEMODE/IDLEMODE in smart mode) also removes the problem.
>=20
> Sounds like you've nailed it.
>=20
> What is perplexing is that the hwmod code should be setting this by=20
> default in omap_hwmod.c:_enable_sysc().  I wonder why that is not=20
> happening.

It seems the omap2_dispc_sysc is missing SYSC_HAS_ENAWAKEUP. I wonder if
that's a mistake or by purpose...

 Tomi


--=-rDJUs0ZmbtfiTuuGODmF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPHSdAAAoJEPo9qoy8lh71t/AQAIomFr0vyIZzY/vaYHFXgllY
/idIQ/0nOoJqw+SplYJR//k8DFoAQr351Hq4HjX/9rbORNPM5/ewT5vGJXPd6qL7
N980srX1LKNusIhv4ma0deaBoM/Y22DnJNPID9VQeUPK3a/xFgbX5m0hwFPSHNgq
aavg1qjY/wmHXvgW2aXVwhZP0no+Ja/1NKqF6WCmGA+Jf6FYLaDjmAbC5zhYEn5V
lDOXhVLvn50sRwOh8Fxw9xcXE/zT+sWBMpnYqNrZysQN6yUn/lGJdc4Gy0P5/cpG
miiYjintPpID5Pw9khS3RxWjQuFD56bc6QP9R/D3qVrf3UNYAIZ57dq33hBrEDJb
bTuK7k5+2s29P/6NuP3iaKmsYH6uNhnNs1wWEwMnKplHVsLlMmODOK3QS+bY1Sb8
M0vYX7x8xqJWiRh9fULu45ro+x4W+5//E5H0jtx4sru0Qu6M89IjXKfYv7ltgavP
uXjQFpUaLZtKhj0b+EuaBmiUyy1pUPKfqrtq5EhaDFCWSz0/3h4xgAwhYCO4bCLy
A1M9j/O/l+HION9SGl7rR/k9mBsBDi956EYC9iYard6LCWgulfQCtfsISMYm/1Fm
X6HnxHsFTLYru4HToHcEPx9fU2mGH75YtxASB4FwNPsiaukmL3Q5cvKxh9zmS9kP
3KHJVBs65fmo90pRdF8b
=Ei6R
-----END PGP SIGNATURE-----

--=-rDJUs0ZmbtfiTuuGODmF--

