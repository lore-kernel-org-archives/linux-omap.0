From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Thu, 24 May 2012 15:35:02 +0300
Message-ID: <1337862902.13723.4.camel@deskari>
References: <1336033721.14378.2.camel@deskari>
	   <WC20120503084938.900446@terrafix.co.uk>
	   <1336050442.14378.10.camel@deskari>
	   <WC20120504091902.970499@terrafix.co.uk>
	 <1336139415.2552.4.camel@deskari>   <1336140072.2552.6.camel@deskari>
	 <WC20120504140943.7604D0@terrafix.co.uk>
	   <1336143281.2552.21.camel@deskari> <1336143500.2552.23.camel@deskari>
	   <1336483598.5761.45.camel@deskari>
	  <WC20120514073642.6306D7@terrafix.co.uk>
	 <1336982138.2532.32.camel@lappyti>
	  <alpine.DEB.2.00.1205151148440.16649@utopia.booyaka.com>
	 <1337159300.7692.22.camel@deskari> <4FB37CE5.1040707@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-nvYyGW0lJu9boJoIwucg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:38229 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751876Ab2EXMfJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 08:35:09 -0400
Received: by lban1 with SMTP id n1so7115199lba.24
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 05:35:06 -0700 (PDT)
In-Reply-To: <4FB37CE5.1040707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-nvYyGW0lJu9boJoIwucg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-16 at 12:09 +0200, Cousson, Benoit wrote:
> Hi Tomi,
>=20
> On 5/16/2012 11:08 AM, Tomi Valkeinen wrote:

> > Disabling DPLL3 autoidle fixes the problem. Disabling DPLL4 autoidle
> > doesn't affect the problem.
>=20
> The issues your are facing seems to be the well known DSS low power=20
> refresh mode we've been trying to use since OMAP2 :-).

Hmm, so are you saying no one has managed to get fifomerge and autoidle
working reliably? If so, no point for me to even try it =3D).

If so, I wonder which is better to have: fifomerge or autoidle...=20

> > I also suspect that this could be just a plain DSS bug. The default FIF=
O
> > low/high thresholds are 960/1023 bytes (i.e. DSS starts refilling the
> > FIFO when there are 960 or less bytes in the fifo, and stops at 1023.
> > The fifo is 1024 bytes). The values are calculated with fifo_size -
> > burst_size and fifo_size - 1.
> >
> > We are now using FIFO merge features, which combines multiple fifos int=
o
> > one when possible, making the fifo size 1024*3 =3D 3072. Using the same
> > low threshold and increasing the high threshold to 960/3071 works fine.
> > Changing the high threshold to 3008 causes underflows. Increasing the
> > low threshold to ~1600 makes DSS work again.
>=20
> That's weird, in theory what should matter is only the diff between the=
=20
> high and low. Well the low value should be as high as possible as well=
=20
> to support the wakeup latency.

Yep. That makes me think there's some kind of problem with DSS accessing
the memory with particular fifo thresholds.

 Tomi


--=-nvYyGW0lJu9boJoIwucg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPvir2AAoJEPo9qoy8lh71WzIP/0aEa48COv1rt+oYnixodh+T
LvFosvs4QF2v/Eb4gpx+OgfCBT/9rt6iTifeDxjhMyKK4G4Sj8Yn/H4mCVx/C9wC
Z8E2QKpJQWkCar2bL/jEvNrmU9b2OIPZPwyR9Qpu582WF7RasWfGZzqsApz7A66o
uQNYSNEm6S+hO0rgHUhgaOQU4ZIkzPPOqaw1XchBC/uyIq3lmnWMCzCU6fYwYhof
WK0Qna1lX10E4utcMTwRpjfpCjuHTVFTTvPlfv1f3siUnSEuxhSb1tn1d4ma4eud
TDMI3iLmOZVYkyaR9wFqhThRJG4MpiXHEH3p7cL9gCktYPcntuPrWR66iFsudMud
zuGbTlDCbsrwIK0oI9yAblb6541+UpjsPY/7MPndBxiBz7+t6eVfwB2V381PlMD7
s8M/GKU/t29eGrOBx9RtCy8MqXHhLkOd00LGccyeNJSXZ2qn7Gwk5x4zEOZfPZ/a
v+eMgJ4kBlcDvP9NOaYYslVLBsTR2P30mYsTiC7L4g5U9GI0f57OpfWzJC7sv3RS
C68XmkVI5min5cDiqsOgu0IWH/aDXYU8Dvi0WJuYCXv5Bo1zY9f+wHCttpO7+Z5y
HjU8jgBfLv9TxcTN2lkRLVBdEcR0q8dqPBARIyMMNlaeMtWNa98TZUA8VRlYvZWS
tDEqRhIwqW1AdTnSN5Eh
=g3cW
-----END PGP SIGNATURE-----

--=-nvYyGW0lJu9boJoIwucg--

