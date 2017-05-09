From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
Date: Tue, 9 May 2017 14:53:23 +0300
Message-ID: <6f1980b1-a6ff-0d8a-dac8-9ea239ea35ef@ti.com>
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <20170508170711.GF3489@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0415817508=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170508170711.GF3489@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============0415817508==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PXuIqVDuxWVaFRDqpfHR5pRSc3WsdU6Tg"

--PXuIqVDuxWVaFRDqpfHR5pRSc3WsdU6Tg
Content-Type: multipart/mixed; boundary="tfJjP1jwT9KcMIEvUpd0mmrfO5nO03eJe";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tony Lindgren <tony@atomide.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org
Message-ID: <6f1980b1-a6ff-0d8a-dac8-9ea239ea35ef@ti.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <20170508170711.GF3489@atomide.com>
In-Reply-To: <20170508170711.GF3489@atomide.com>

--tfJjP1jwT9KcMIEvUpd0mmrfO5nO03eJe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/05/17 20:07, Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [170508 04:36]:
>> The next step is to remove the omapdss platform driver (for the virtua=
l
>> omapdss platform device, also known as core code, not to be confused w=
ith the
>> omapdss_dss driver for the DSS hardware device). Patches 21/28 to 23/2=
8 move
>> the useful features of the core to the omapdss_dss driver. Patch 24/28=
 adds
>> omapdrm platform device registration to the omapdss_dss driver to repl=
ace
>> board code, and patch 25/28 finally removes the omapdss platform drive=
r.
>>
>> Note that registering the omapdrm platform device from within the omap=
dss_dss
>> driver is a hack, but isn't worse than the current situation. Quite th=
e
>> contrary, given that the omapdrm device exists for the sole purpose of=

>> supporting the omapdrm/omapdss driver architecture, moving it out of p=
latform
>> code can be considered as (slightly) cleaner. In any case, it will be =
easier
>> to refactor the code as everything is now isolated on the driver side.=

>=20
> Good to see this happening. While at it, can you please also check that=

> the struct device entries follow what's in the hardware to avoid more
> headaches later on.

This has been the case for many years. We've just had some extra stuff
on top, due to legacy reasons (from time before hwmods).

 Tomi


--tfJjP1jwT9KcMIEvUpd0mmrfO5nO03eJe--

--PXuIqVDuxWVaFRDqpfHR5pRSc3WsdU6Tg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEa2zAAoJEPo9qoy8lh71G4cP+gNjajM/lDCJsK71/mtGn2pa
IikweY2IFCKBBspVn1P+GREC2pg+g4XtMrKrHEbPwVy7JaygyMgWo/++8vFoN51G
L3DjWTCdVxdeU2H2NXMg+x8y/9yu07a/8OgDhGbyq1XOg3PEiqzSSe5FUOjHxQhp
2HGsquKCeXSQqDZi2ixh+4/5FTpMb3sD1AL/+cCwqSqHMopZB2vXyQXl6GV0qBTH
LRJBJ/MwmJNQNFaB8TxwbIvHQHXUq/NyPsEZthb7g25fqRg5RQDFVhTGD+7MjHkh
k2rC3MoISbf4WLeIOJA2xT/S1atHyQro6z1WEmDa0iHILQCyL/uG0x2qO+z3wyL1
VUxCMpv9JDCRhsuCmQncFQacQqRrPGotIzmn5cI/JtdGf8ESuM0QRZfcE4189bKd
39ZGiTYokukijOEG23PtS4wzg4yioRSTZn+8GfQrIk4ng+NNv3c9P05451g0vKcI
jctp+fdBewI4y9A8adNFu8hXyD2JICzJpY++t250YFl1OQqJ/qbay/RUCQjB8IxR
1Tdfn7rCrNa0dZIJFlB6J3TbFvIxwEZBMIcNgka3IOSPEVF0e5zP8kZB+nXDjIHp
Pzy38j9ChVQAs26Y9JWcYTOGKzHVE5YtkXLpHopzkO8R5rTpY3nx5ujliMp+184Y
K49EsDSRotS8Gau+ppqb
=QAmj
-----END PGP SIGNATURE-----

--PXuIqVDuxWVaFRDqpfHR5pRSc3WsdU6Tg--

--===============0415817508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0415817508==--
