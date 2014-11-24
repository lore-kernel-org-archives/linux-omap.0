From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Mon, 24 Nov 2014 10:48:01 +0200
Message-ID: <5472F0C1.6030707@ti.com>
References: <cover.1415803064.git.jsarha@ti.com> <20141112222344.GU3815@sirena.org.uk> <54646648.5030807@ti.com> <546DC9A0.8060700@ti.com> <20141121112317.GQ3815@sirena.org.uk> <546F2BA3.9050203@ti.com> <20141121163815.GT3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aPTDb4JClJ34mL2OSiEtVU5XCECwUufPq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48739 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbaKXIsX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Nov 2014 03:48:23 -0500
In-Reply-To: <20141121163815.GT3815@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com

--aPTDb4JClJ34mL2OSiEtVU5XCECwUufPq
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 21/11/14 18:38, Mark Brown wrote:
> On Fri, Nov 21, 2014 at 02:10:11PM +0200, Jyri Sarha wrote:
>=20
>> OMAP HDMI audio is fundamentally different to the case on Armada or on=
 BBB.
>> In omap the whole HDMI IP is integrated to the SoC and there really is=
 no
>> codec in the ASoC sense. The the cpu-dai transmits the audio directly =
to
>> hdmi wire and there is no i2s bus involved. So this case should not be=
 mixed
>> with the patches Jean-Francois working on. The code is also orthogonal=
 in
>> that sense that the latest omap-hdmi-audio uses the generic dymmy code=
c.
>=20
> The discussion seemed to be about what to do with unplugged connections=

> which isn't what you're talking about there and does seem like an area
> where we should at least be aiming for common behaviour even if not a
> common implementation.
>=20
> There's also all the stuff about parsing EDIDs for capabilities which
> would seem to be related to that but seems to have gone off into the
> weeds.

I agree all these should be studied and worked further. However, I would
still like to merge this series in the next merge window:

a) The series does fix the OMAP HDMI audio, so that users can actually
use it.

b) The series does make the driver model much better, so that I can
actually be bothered to keep it enabled (earlier, even when it more or
less worked, it was too much hassle when doing development using modules)=
=2E

 Tomi



--aPTDb4JClJ34mL2OSiEtVU5XCECwUufPq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcvDBAAoJEPo9qoy8lh71krkP/2uPrWy2ZUoTHtGz9YlSTYoi
hbjwXRtpYrmYqwT1RwGYEE5DVJWsZJ0osYprs3ILJoGTB5hJDAPDXWASxMRVjhd2
1XHu/6eEP5hFpT4GxCnjYuxLbaVVHd4nSTuNffSO42ktzUVV2VvFIm3mptLFey1W
GzaaT3ufFyr7wT3z5IKPzWJ/OVCBi7S3yEEGvHbH3X9TeWY1dBqHI+2fW8cX/j9S
G0SEHKSyBWVw4fEXVdJfZt3wLbrt+zdhRMhfr96Xo0VETLqfo0iG90c5WctGpMwN
CEitNfLF1UKyqu/CUZjtfuCEYENP2YUod9FUFW5oZ9PsphvWLUpJN2/zVLaFwZiF
Fj5770mrYPmYtkWo9Rs7RzsBVJeEGlPmtslm6zq1vZ2WtGdKPYDeZbDHkTULqQtJ
1uiL5MPWK0ffnDplf1XsQn6+gchMwesQKpg+3+4f8o3gQqcSKL9JYTtyEYMo+62Y
eR3QMPTloZi0tt3cV4tPy8rmFFc4YTgjyBbuxExOu4x3Nb+kkcHNNMshLWNJv/1d
lql2ZidwVwFz9WFDDbDmkwXumItIUTp/0a6/KwYud7+uOSC3c6LPomFYW/Hr2gFk
ZKqTMHr1dR3nUQ7tEyuEIXgSagp/5/8AiOnaoKEYQ9qg82V1jrv6cjB4IsQPfk0H
3wRddb4Bvf/zuj58IetD
=KyuB
-----END PGP SIGNATURE-----

--aPTDb4JClJ34mL2OSiEtVU5XCECwUufPq--
