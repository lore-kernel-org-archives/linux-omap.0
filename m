From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/4] OMAPDSS: DT support for N900 panel
Date: Thu, 19 Dec 2013 07:30:50 +0200
Message-ID: <52B2848A.80807@ti.com>
References: <1386958650-2404-1-git-send-email-sre@debian.org> <52AFFF3F.7020807@ti.com> <20131217171412.GA10442@earth.universe> <52B089FE.8060704@ti.com> <20131218215536.GA23674@earth.universe> <20131219005151.GA27928@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ErEBmp84TbEpKsm4D1O82SE42Lc4JjUuN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36507 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919Ab3LSFbP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 00:31:15 -0500
In-Reply-To: <20131219005151.GA27928@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

--ErEBmp84TbEpKsm4D1O82SE42Lc4JjUuN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-19 02:51, Sebastian Reichel wrote:
> On Wed, Dec 18, 2013 at 10:55:37PM +0100, Sebastian Reichel wrote:
>> On Tue, Dec 17, 2013 at 07:29:34PM +0200, Tomi Valkeinen wrote:
>>>>> I added N900 display DT support on top of my v2 series, including
>>>>> pinmuxing. Can you check if it looks right and works?
>>>>>
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/=
dss-dt
>>>>
>>>> I just tried it and it does not work. On a first look the pinmuxing
>>>> looks fishy: 0x0d4 is muxed two times.
>>>
>>> Hmm, so it is.
>>>
>>> I'm not really familiar with SDI, I just muxed all the SDI pins, exce=
pt
>>> datapair3. I previously thought that there's only the data and clock
>>> pairs for SDI, but the TRM revealed more sdi pins, so I included them=
=2E
>>> It is well possible that these can be removed:
>>>
>>> 0x0d0 (PIN_OUTPUT | MUX_MODE1)   /* dss_data18.sdi_vsync */
>>> 0x0d2 (PIN_OUTPUT | MUX_MODE1)   /* dss_data19.sdi_hsync */
>>> 0x0d4 (PIN_OUTPUT | MUX_MODE1)   /* dss_data20.sdi_den */
>>> 0x0d6 (PIN_OUTPUT | MUX_MODE1)   /* dss_data21.sdi_stp */
>>
>> Just removing the dss_data20.sdi_den pin was enough to get a working d=
isplay. I
>> don't know if the other pins are needed, because the display pins are =
already
>> muxed correctly by the bootloader.
>=20
> I just had a look in the leaked n900 schematics. According to it the
> following pins are connected to the display:
>=20
> DSS_DATA20 (E28)     GPIO 90         LCD_RST
> DSS_DATA10 (AD28)    SDI_DAT1N       CDP 0
> DSS_DATA11 (AD27)    SDI_DAT1P       CDP 1
> DSS_DATA12 (AB28)    SDI_DAT2N       CDP 2
> DSS_DATA13 (AB27)    SDI_DAT2P       CDP 3
> DSS_DATA14 (AA28)    SDI_DAT3N       CDP 4
> DSS_DATA15 (AA27)    SDI_DAT3P       CDP 5
> DSS_DATA22 (AC27)    SDI_CLKP        CDP 6
> DSS_DATA23 (AC28)    SDI_CLKN        CDP 7
>=20
> I also noticed that dss_data19.sdi_hsync is used as gpio 89 for the
> N900's proximity sensor. Thus I suggest the following SDI pin muxing:
>=20
> 	dss_sdi_pins: pinmux_dss_sdi_pins {
> 		pinctrl-single,pins =3D <
> 			0x0c0 (PIN_OUTPUT | MUX_MODE1)   /* dss_data10.sdi_dat1n */
> 			0x0c2 (PIN_OUTPUT | MUX_MODE1)   /* dss_data11.sdi_dat1p */
> 			0x0c4 (PIN_OUTPUT | MUX_MODE1)   /* dss_data12.sdi_dat2n */
> 			0x0c6 (PIN_OUTPUT | MUX_MODE1)   /* dss_data13.sdi_dat2p */
> 			0x0c8 (PIN_OUTPUT | MUX_MODE1)   /* dss_data14.sdi_dat3n */
> 			0x0ca (PIN_OUTPUT | MUX_MODE1)   /* dss_data15.sdi_dat3p */
>=20
> 			0x0d8 (PIN_OUTPUT | MUX_MODE1)   /* dss_data22.sdi_clkp */
> 			0x0da (PIN_OUTPUT | MUX_MODE1)   /* dss_data23.sdi_clkn */
> 		>;
> 	};

Thanks, I'll do the modifications. The dat3 lines are not needed, but if
they're connected to the panel, I don't see any harm in muxing them.

Although, makes me wonder. If the panel supports only 2 datalanes, why
does it have connectors for 3? And if it supports 3, why would N900 use
only 2?

Are you able to check if the bootloader muxes dat3 to SDI mode?

 Tomi



--ErEBmp84TbEpKsm4D1O82SE42Lc4JjUuN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSsoSKAAoJEPo9qoy8lh71/s4P/1CyDFirLLAUNOwUw7mQmRp9
nXv9RUoGtHpetJM0bG6dDDrasZyr9dV7oNJjsVch1fd+M2Oh2bTyPyW2v2+pPvMu
kkBxHBRhyLfPWrYx6QWqhceSOO2DLk8AmKfeN4jtDuJLJzvWTMgWiqphTvoBsb5j
bbrwq0MYKQKmEltVHO3DLMLBK6XwSUeSWAdTOqOK39DNG7rX+kYVzTfbP6on+P8q
wlfuiIqs16oQGy2zEp1866xRXNTdc5X0pjKA8yrTzdAPL7627W3l0yKKARfDMswF
0KzoS0b9BUdIwz4xnecUWr4s+0IepYQV6i7/mykK4Byh+HxRKywQVVRrwkZlbWEj
VTYUP0/bRk4klVP47HT978QDABLKLE/5xO2wIRPWGJr9w06QuyE/ltaweoIfrhfd
JN5z1ne/41CjMeTGl2ZmJRq8XGq4qAwBpDSRTBjqujZIPZu7h2uJGKQh3/BNa1Dn
nyMMnWWYpWVTRoXPtsxOVVOtgpr2pjxTCzORaCXBz8OvzJaCk41c5nt4Ndf5SdnW
eLjoPzOfkHbrQY6TeH5cUL0lMKF+iFbXhT6DhQ/445SAEI8tNzpfbIJrwXFyALps
qoQpy0u4ewdvO6u5QPoi5f5jjjTVa/w8UQMVSXAmUtR61REKGLgqfrn5dvFqqPbV
ph8mGTdw8NLlxoPBKrlp
=OBVo
-----END PGP SIGNATURE-----

--ErEBmp84TbEpKsm4D1O82SE42Lc4JjUuN--
