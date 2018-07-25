From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 04/32] ARM: dts: omap3-gta04: fixes for tvout / venc
Date: Wed, 25 Jul 2018 14:31:48 +0200
Message-ID: <7FAC0538-D5AE-4DCF-9036-DAD881E957C5@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com> <73e5b1fd4cc27e3148c6bc2e8f8281f3996ccf68.1532501910.git.hns@goldelico.com> <20180725103750.4yltpfswd52fpw63@earth.universe>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_76CB1DAC-E045-4FA2-BE6A-5ED1FEE3CA78"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725103750.4yltpfswd52fpw63@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Marek Belisko <marek@goldelico.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_76CB1DAC-E045-4FA2-BE6A-5ED1FEE3CA78
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Sebastian,

> Am 25.07.2018 um 12:37 schrieb Sebastian Reichel =
<sebastian.reichel@collabora.co.uk>:
>=20
> Hi,
>=20
> On Wed, Jul 25, 2018 at 08:58:36AM +0200, H. Nikolaus Schaller wrote:
>> 			port@1 {
>> -				reg =3D <1>;
>> +				reg =3D <0>;
>=20
> You should also update the node name.

I did take another look at this and we might have the wrong fix here =
anyways.
The first indication is that a port@0 already exists soI can't simply =
rename
the node.

The opa362 is an exceptional dssdev since it has an input and an output =
port
which should be differentiated by the reg property and the node name.

Ports are apparently matched by reg number, i.e. here:

	=
https://elixir.bootlin.com/linux/v4.18-rc6/source/drivers/gpu/drm/omapdrm/=
dss/output.c#L146

The issue seems to be that the driver does not set the out->port_num of =
the endpoint to 1.

	=
https://elixir.bootlin.com/linux/v4.18-rc6/source/drivers/gpu/drm/omapdrm/=
displays/encoder-opa362.c#L205

So the <1> does not match and we were just lucky to make it working by =
choosing <0> in the DT.

I'll need a little time to test if a (one-liner) patch for the driver =
does the same/right thing.

And since it is omapdss related I've put Tomi on CC:

BR,
Nikolaus

--Apple-Mail=_76CB1DAC-E045-4FA2-BE6A-5ED1FEE3CA78
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbWG22AAoJEIl79TGLgAm6ZiMP/RhFnFf6AHORlWK28kLa3vp/
HvpLkIMcL+3r8XBWHAc0ywYj6+ns+VUIlLDMMqKAoc6BM4fkKBINGb0aoWAo99dl
qoH+0nFgj/J+6SBKmx2WKF8JkO5W7sp6bY42PanbJk/rn+3RAPvmK3Gppk4MBy/p
N1C4ZGcZ9irHP1JN3Cstamau4/L4QtngbIEQxOIwyvETYhjwcLWfcNnEywjOwMiu
oA11ptfu6zXI17/Wz27GvRSQoNcIrxCNFxsyV55JnCiUwsvqXycsVH7VSVGsrPRs
G/pRZGXV18hBrTPL8LQESOEUnKw5UhcveZZWvOK7F+VZtmLCoH256SKZAQ/zu/x/
5jy6M6vpG4ConovaJ6k1XLwV7tjq2Y9BC86JxJ9D0EHs9bEq1rbRbPZK9UX2Kviq
gHOkIIIwbMhKggXfgIE79MJWu6CCQP0bS3WuRx54DZQIO4B6oVBzBG0pB2o9HrRC
/35i7OwI7T6X/lN0MIkzFVSjwZpzTQ7qcUJlhIl/XerGlb7cEpcZtpgCkxnisK2n
ZSBvCxd0nR/o/vE5Npb6lJfqe4RNl5ePdo1YSn6KgxzFtAeaH46TJlUZ0HVwWV8V
T0tdEPkubk3rWc6/7F4TKEkxqrEoDaDD4yWkhyxP0nd7Yk7HO25BILfIR3DD6y1Y
1nSg1MqRrEiPIHKkePhB
=aGiN
-----END PGP SIGNATURE-----

--Apple-Mail=_76CB1DAC-E045-4FA2-BE6A-5ED1FEE3CA78--
