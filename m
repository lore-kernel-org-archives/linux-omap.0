From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
Date: Thu, 11 May 2017 11:34:42 +0300
Message-ID: <67e56914-0075-8009-7013-f0cf69001749@ti.com>
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
 <20170509150550.bi4bzadesmma6ntp@earth>
 <989d9224-7f13-c091-7030-3ceb68a6c600@ti.com>
 <20170510164612.GP3489@atomide.com>
 <f05cc81e-d61e-c54f-10e8-e8fba9de1719@ti.com>
 <20170510182940.GQ3489@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1700778830=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170510182940.GQ3489@atomide.com>
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

--===============1700778830==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eKF8RKpjU80bT7rt8m6ALIOmuLX2UfqOF"

--eKF8RKpjU80bT7rt8m6ALIOmuLX2UfqOF
Content-Type: multipart/mixed; boundary="6htBg94OvajtltNgIFAKVV88m5ccSmHD2";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
Message-ID: <67e56914-0075-8009-7013-f0cf69001749@ti.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
 <20170509150550.bi4bzadesmma6ntp@earth>
 <989d9224-7f13-c091-7030-3ceb68a6c600@ti.com>
 <20170510164612.GP3489@atomide.com>
 <f05cc81e-d61e-c54f-10e8-e8fba9de1719@ti.com>
 <20170510182940.GQ3489@atomide.com>
In-Reply-To: <20170510182940.GQ3489@atomide.com>

--6htBg94OvajtltNgIFAKVV88m5ccSmHD2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/05/17 21:29, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [170510 10:44]:
>>
>>
>> On 10/05/17 19:46, Tony Lindgren wrote:
>>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [170510 00:26]:
>>>> On 09/05/17 18:05, Sebastian Reichel wrote:
>>>>
>>>>> patch 10:
>>>>> I think dsi pin muxing should be done by providing pinmux
>>>>> info via DT.
>>>>
>>>> Unfortunately there's no pinmux driver for the kind of register we h=
ave
>>>> for DSI. At least this was the case not that long ago.
>>>
>>> What are the TRM names for the registers you need to mux?
>>
>> CONTROL_DSIPHY
>=20
> Oh just one register with few bits? That should be doable in
> dts with pinctrl-single,bit-per-mux and pinctrl-single,bits.

No, I don't think it works. Or at least I can't figure out how.

pinctrl-single doesn't allow to freely set the bits, but requires the
pins to have similar bit structure (function-mask). In CONTROL_DSIPHY,
DSI1 and DSI2 have different bit structures.

I don't understand why pinctrl-single tries so hard to fit things into
one mold...

 tomi


--6htBg94OvajtltNgIFAKVV88m5ccSmHD2--

--eKF8RKpjU80bT7rt8m6ALIOmuLX2UfqOF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZFCIiAAoJEPo9qoy8lh71HmsQAKHG/7dty8FZE0r34QBRufgQ
OSXOG50CYSPuIMpqTVf8xtSI72iZ2p7X2UcV/89A12i7ptxSDIRro6ObXBr128sz
ZejhNPuwkogpRTz2h/6MVuhIg11+5onU6O20vONDznwjzrb8vx4f7H9hIrpyp2ip
YlzL+bO8lkjmXmuhfK1Uev0UZbk4tLfmFp+IsVr1ua39n2OKaW7RNFxolxlpgu7j
GNaa9L1LgRMonXJ3HM27mMpLU6sq+guCnZsk53oWtiUSK8bfDYLYlQQGT0CrDHwc
0m6b7RPOuSjexdq5/Mb7fauKMBPAxG8pq+myYi3suupUEoeJ5LyE57oH3G0NcPCG
b78EAbSJsMan6+r+HXHlVYRfQjAmdeS9EGid9MJLqUKknShvbql2Ptw7nlWeGqn7
TZ0qeOLu+PMCtQ9vvsi6rl00CRHnD2zV925OqVKWN6ZemGrmoGr2Lr4zCgCuZPlc
58Oqt+cFR8OZZDeuGDsn63H4TNaU7OuhQQ6Sw/SubQU/ITbWkwiLRqOY3RJGkaoT
TicmHqC8O+QTe7WCrHegEZ5crLHI3rVhnKd925nd3MGa/CBc3AcWQ5/aXtP4Yo/c
zRpZVJWOS0odltQfp5PGWIzrlThuk+yba+x5PlYpMHcvio2KJKQ60ba6ZFRqysla
nov9GypHwxwXAQRgvKzY
=0Siv
-----END PGP SIGNATURE-----

--eKF8RKpjU80bT7rt8m6ALIOmuLX2UfqOF--

--===============1700778830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1700778830==--
