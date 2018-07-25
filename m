From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 04/32] ARM: dts: omap3-gta04: fixes for tvout / venc
Date: Wed, 25 Jul 2018 13:40:32 +0200
Message-ID: <1E64094B-7037-4409-A9EA-81648F8F51B4@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com> <73e5b1fd4cc27e3148c6bc2e8f8281f3996ccf68.1532501910.git.hns@goldelico.com> <20180725103750.4yltpfswd52fpw63@earth.universe>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_B017C245-8EDD-407D-AF80-B4EC89087852"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725103750.4yltpfswd52fpw63@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Marek Belisko <marek@goldelico.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_B017C245-8EDD-407D-AF80-B4EC89087852
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


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

AH, indeed. Thanks for your eagle's eyes :)

BR,
Nikolaus


--Apple-Mail=_B017C245-8EDD-407D-AF80-B4EC89087852
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbWGGxAAoJEIl79TGLgAm6CYwP/j4Nm4zbRcm/+Fjhr/VpH0kL
81ZrYN0MQ1i1YUGuRtmXgtbhewe5Pm9ZaXZmRVlTW3LO4cM6WTEZyEyAyRznL1r3
Yi4wBjzse1YXDVcSMlI6jPBKZT7DPaF16Ak7UcQYWL89z/3awMOOJR6ni1JVXceJ
WNmEzuKzOCy+Jr82/oTrbdzemCr+r9nLOLA7fNvlLiV6oF99jzPi/U7k7ZevdZZm
VJ99M83vg5fbr4Qv+DzJICbpDd5bko+ZwGeRyMeeQ1WmyYIuZzDvc1B1TYaFN1MW
47LZmJNxgLMTICDs9/q3NMiaYEh6H5TEK3fN/zPzUoRYngEl1ekZdNHudY4CR/9W
2HcUOo3dJdt3noQbduaFvt7rjLxVyDfI6f8izC+sIrUFHKySQKkVtkC80iidh3Wk
ubvQGt+FExKgao6mXDVVj6ZghmpynSw8KPf6k8THkap/K01DPo+QUbnhoax8AhZC
ZIR7y+9GRu6S48uo/CpfvpzpvEzKPiowIXladLqTs8q4PK0XzYs8nTj2NYKf9faf
4lyswMkJnZHvkx029jVYNVMVIn4WJMzkf22zcjHh5OXvLZ1Bv2Z/dgiI2Xaaql3h
UjsfRKGFAlCRN26pDfgkwz4bYQPk+Eh2BGkOaVI8JvHL04Hxkp1Pt6KCsnq2gwdw
Hm3mDB7es7V9vKZChiw9
=FDD3
-----END PGP SIGNATURE-----

--Apple-Mail=_B017C245-8EDD-407D-AF80-B4EC89087852--
