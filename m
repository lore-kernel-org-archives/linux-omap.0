From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
Date: Fri, 12 May 2017 10:29:19 +0300
Message-ID: <4b7cadc5-f32b-f97f-29c3-a2de9927df6c@ti.com>
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
 <20170509150550.bi4bzadesmma6ntp@earth>
 <989d9224-7f13-c091-7030-3ceb68a6c600@ti.com>
 <20170510164612.GP3489@atomide.com>
 <f05cc81e-d61e-c54f-10e8-e8fba9de1719@ti.com>
 <20170510182940.GQ3489@atomide.com>
 <67e56914-0075-8009-7013-f0cf69001749@ti.com>
 <20170511141632.GR3489@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1228746788=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170511141632.GR3489@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============1228746788==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UtHnNfk3s75pJ23L6QTRVTgXTUxhmxBjI"

--UtHnNfk3s75pJ23L6QTRVTgXTUxhmxBjI
Content-Type: multipart/mixed; boundary="vaLuTvQWbJHdJHhNHKSTBg7Gf8B7ACWJ4";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
Message-ID: <4b7cadc5-f32b-f97f-29c3-a2de9927df6c@ti.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
 <20170509150550.bi4bzadesmma6ntp@earth>
 <989d9224-7f13-c091-7030-3ceb68a6c600@ti.com>
 <20170510164612.GP3489@atomide.com>
 <f05cc81e-d61e-c54f-10e8-e8fba9de1719@ti.com>
 <20170510182940.GQ3489@atomide.com>
 <67e56914-0075-8009-7013-f0cf69001749@ti.com>
 <20170511141632.GR3489@atomide.com>
In-Reply-To: <20170511141632.GR3489@atomide.com>

--vaLuTvQWbJHdJHhNHKSTBg7Gf8B7ACWJ4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/05/17 17:16, Tony Lindgren wrote:

>> pinctrl-single doesn't allow to freely set the bits, but requires the
>> pins to have similar bit structure (function-mask). In CONTROL_DSIPHY,=

>> DSI1 and DSI2 have different bit structures.
>=20
> OK if the register mixes different types of controllers that
> can't be partitioned into separate 8 or 16 bit instances then
> you're out of luck with pinctrl-single. If it does not fit, no
> point trying to force it, then you need a custom pinctrl driver.

Writing a driver for a single register on a legacy SoC feels like an
overkill... But I guess a generic pinctrl driver which allows free
writes to registers would do the trick, but, then again, if so far we
have a single register in a single SoC that needs this, maybe it's not
worth the effort.

>> I don't understand why pinctrl-single tries so hard to fit things into=

>> one mold...
>=20
> Basically on many SoCs pinctrl is just the same exact control
> register repeated for each pin on the SoC:

Right, I was just wondering why it forces one to have a function mask,
versus allowing it to be left out and thus making it possible to handle
also cases where the pins require different kinds of bit masks.

 Tomi


--vaLuTvQWbJHdJHhNHKSTBg7Gf8B7ACWJ4--

--UtHnNfk3s75pJ23L6QTRVTgXTUxhmxBjI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZFWRPAAoJEPo9qoy8lh713oMQAJn/zR0P2ETf0JP7zaweM+Ie
t/W6LhDJqUzjAc6/6Zop6k9Eh44S43aEf502pB9PiXqfDPlURdbkbznoV8WV1NTy
XD7x4s13DJdmToPf+qpa4AkXc2CpHcDe/GnQhhpzg43JkOeFtaZpcLhdTJ7GnGqw
B6GLLivgQ42+bmT6uFZTpDD+RNk6VoCZhiV2mmMzT89rFVEGmJmSY6FboK7im5DX
0a9gZ7LOFgtoLl4onzPc/bNbgV5EwFzwHOWNh/rfl+Npb7eFJ7eXlPA80CgOQSML
+LM1+LXHsCB5Owj+gHit/A0GdzLFQp1uAVNakS/n17ipt5ecplLieXgG9nbfuWIG
oG246noLK71wVw2IYnpnxu1tuQ9x2sjOPGJHzjYxoUOS0++NBwJ2GHxQs0MSPIXc
2d3NmF4z7Gi2bEsdRzc/s94mApUsUxrgh+ZeXI5TnZQzIS/J8DT6RC6N5r3BrBq8
2RpOq1vUDFvHYPPhNSf4kfISPVajM2cY2D8GCvZx4Q3gdFjC3S37M9hmIG2rwvqf
uFXNJ1+Br2gl3vA1gBVjgTt0Eo8xIOlUcVS9ps42OAxWURDesN+r6fbdi7j8kzrQ
lhDEmbmeuAhAf+z+4o8R4YKCAAs9bemzMYrBBH7Ly/9OahGcBP7gMK9Ky+bebs/U
zhxb1MXxjV97Wzd+mPVD
=aqcN
-----END PGP SIGNATURE-----

--UtHnNfk3s75pJ23L6QTRVTgXTUxhmxBjI--

--===============1228746788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1228746788==--
