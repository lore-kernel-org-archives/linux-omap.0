From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
Date: Wed, 10 May 2017 20:40:57 +0300
Message-ID: <f05cc81e-d61e-c54f-10e8-e8fba9de1719@ti.com>
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
 <20170509150550.bi4bzadesmma6ntp@earth>
 <989d9224-7f13-c091-7030-3ceb68a6c600@ti.com>
 <20170510164612.GP3489@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0965642348=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170510164612.GP3489@atomide.com>
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

--===============0965642348==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FbKpDNh1BD0W0uW1ddGbnDxlep5axeTWA"

--FbKpDNh1BD0W0uW1ddGbnDxlep5axeTWA
Content-Type: multipart/mixed; boundary="PvttVxN7j8oaqj5VhDB7p9FCPxSXR78Qv";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
Message-ID: <f05cc81e-d61e-c54f-10e8-e8fba9de1719@ti.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
 <20170509150550.bi4bzadesmma6ntp@earth>
 <989d9224-7f13-c091-7030-3ceb68a6c600@ti.com>
 <20170510164612.GP3489@atomide.com>
In-Reply-To: <20170510164612.GP3489@atomide.com>

--PvttVxN7j8oaqj5VhDB7p9FCPxSXR78Qv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/05/17 19:46, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [170510 00:26]:
>> On 09/05/17 18:05, Sebastian Reichel wrote:
>>
>>> patch 10:
>>> I think dsi pin muxing should be done by providing pinmux
>>> info via DT.
>>
>> Unfortunately there's no pinmux driver for the kind of register we hav=
e
>> for DSI. At least this was the case not that long ago.
>=20
> What are the TRM names for the registers you need to mux?

CONTROL_DSIPHY

 Tomi


--PvttVxN7j8oaqj5VhDB7p9FCPxSXR78Qv--

--FbKpDNh1BD0W0uW1ddGbnDxlep5axeTWA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZE1CpAAoJEPo9qoy8lh71INgP/1OTOfYi5fQqGwllBx5qxwnc
kboWsiy70wPiJ9mCc5y3/tfiyxMFUt4VpldDXgTDbnhH7EeL28N1rkTNvAGlTMjT
BjSuySQ84R5rxCK+LEnfT0VDqhE3PNucfoITNTHAjqo21LeOKoFT6cHzupIJfxKi
BUkDcKFssAgXyXFdwxNJvVcY6bt7xNcba/4KiyLoQu/xDUIcBKgVbtrMRIvoZoiJ
eith/QPqZVY9t/KhGeN+KPrwJpJRdeOlQUoif0T65fIWRVtvw4KPCdrznk2UxFiu
7vfYN+xXsv73I+N5FAxfiO2YAl7sxPwrVSHvK8azr3QAcDbfpgebS0ptj5IDwlcw
dndmgjAuC4To1LYOgwhMO2Rt///NhtnP6ektLzSg04RYBNgxZtdf4riGPHXlLRjj
LbiMoXHQbcpYlvVya4dRC/0+VPX0VKND0cbxc2TP4oQHC3gLEeWHU0d86vPf1NrY
WWApve6irF+O2neGu2cDmWg9DcqITne/eBeBM/1j81ikBIF2jKJ2znqQn9v49WFg
q5m4XTQfDDgRAbxz3U1SkiS5c6VGNd80n0i9h4z0sBrMUIx3Qa6+8Y5NRUroXM6o
ZgC5HT668aLMBOxcEYsRsypQ6lB4b+8ul2oCUoRhFm587/IqBGhLzwlvPM2j8SMO
T+giTSxSb9f3ZrPCUw/T
=Vj5M
-----END PGP SIGNATURE-----

--FbKpDNh1BD0W0uW1ddGbnDxlep5axeTWA--

--===============0965642348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0965642348==--
