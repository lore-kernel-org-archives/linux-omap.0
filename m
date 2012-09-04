From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/4] can: c_can: Adopt pinctrl support
Date: Tue, 04 Sep 2012 09:42:17 +0200
Message-ID: <5045B0D9.6060003@pengutronix.de>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com> <1346673139-14540-2-git-send-email-anilkumar@ti.com> <5045161C.4000100@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA2630A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig05B8C759479B4874C71169B0"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA2630A@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "tony@atomide.com" <tony@atomide.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig05B8C759479B4874C71169B0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/04/2012 08:14 AM, AnilKumar, Chimata wrote:
> Hi Marc,
>=20
> On Tue, Sep 04, 2012 at 02:12:04, Marc Kleine-Budde wrote:
>> On 09/03/2012 01:52 PM, AnilKumar Ch wrote:
>>> Adopt pinctrl support to c_can driver based on c_can device
>>> pointer, pinctrl driver configure SoC pins to d_can mode
>>> according to definitions provided in .dts file.
>>>
>>> In device specific device tree file 'pinctrl-names =3D "default";'
>>> and 'pinctrl-0 =3D <&d_can1_pins>;' needs to add to configure pins
>>> from c_can driver. d_can1_pins node contains the pinmux/config
>>> details of d_can L/H pins.
>>
>> Looks good, is the pinctrl property documented in the dt bindings alre=
ady?
>>
>=20
> Yes, its here Documentation/devicetree/bindings/pinctrl/pinctrl-single.=
txt

Sorry, I meant not the generic pinctrl, but the c_can/d_can bindings
documentation (Documentation/devicetree/bindings/net/can/).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig05B8C759479B4874C71169B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBFsNkACgkQjTAFq1RaXHOk5QCffZ7bz1Gy33PbXwha7GRCCzNB
jmkAn1Lp1wY1vLFAqWGz6JOaZsme7mcJ
=+wCM
-----END PGP SIGNATURE-----

--------------enig05B8C759479B4874C71169B0--
