From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: dts: omap5-igep0050: Correct hdmi regulator
Date: Mon, 9 May 2016 11:34:38 +0300
Message-ID: <57304B9E.50201@ti.com>
References: <1461925297-9734-1-git-send-email-peter.ujfalusi@ti.com>
 <6ee9d67a-e907-715a-f3f5-d90a470314c3@ti.com>
 <20160504172634.GS5995@atomide.com> <572A38FD.9050801@ti.com>
 <20160505184609.GB5995@atomide.com>
 <a6969765-d07d-6d0e-36df-b78b485d9644@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TW65cEVHpwqomBoVaBrJow58ljupqTp5V"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a6969765-d07d-6d0e-36df-b78b485d9644@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>, =?UTF-8?Q?Agust=c3=ad_Fontquerni?= <af@iseebcn.com>, Eduard Gavin <egavin@iseebcn.com>
List-Id: linux-omap@vger.kernel.org

--TW65cEVHpwqomBoVaBrJow58ljupqTp5V
Content-Type: multipart/mixed; boundary="1OHtDBFS51bdo30A8xKbMUoR984bOu26J"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>,
 Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Enric Balletbo i Serra <eballetbo@iseebcn.com>,
 =?UTF-8?Q?Agust=c3=ad_Fontquerni?= <af@iseebcn.com>,
 Eduard Gavin <egavin@iseebcn.com>
Message-ID: <57304B9E.50201@ti.com>
Subject: Re: [PATCH] ARM: dts: omap5-igep0050: Correct hdmi regulator
References: <1461925297-9734-1-git-send-email-peter.ujfalusi@ti.com>
 <6ee9d67a-e907-715a-f3f5-d90a470314c3@ti.com>
 <20160504172634.GS5995@atomide.com> <572A38FD.9050801@ti.com>
 <20160505184609.GB5995@atomide.com>
 <a6969765-d07d-6d0e-36df-b78b485d9644@ti.com>
In-Reply-To: <a6969765-d07d-6d0e-36df-b78b485d9644@ti.com>

--1OHtDBFS51bdo30A8xKbMUoR984bOu26J
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 09/05/16 11:25, Peter Ujfalusi wrote:

> Tomi: what do you think?
>=20
> According to the OMAP5 data manual the vdda_hdmi can be in 1.5V or 1.8V=
 mode,
> 2V is not mentioned in the recommended operating conditions table.

I thought vdda_hdmi should always be 1.8V, but you're right, on omap5
1.5V is allowed according to DM. On later SoCs it's only 1.8V. I suggest
we use 1.8V on all boards, as that's what's known to work.

2V is definitely wrong.

 Tomi


--1OHtDBFS51bdo30A8xKbMUoR984bOu26J--

--TW65cEVHpwqomBoVaBrJow58ljupqTp5V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMEueAAoJEPo9qoy8lh71rPcP/i5UGj0rRYIVd9cyTQxmKm+m
0W0yJmPl3332DfCc9M8GXI2RVQCCLjgqLSeWR4+okPyUjGSJgDwSWYXc2yCWK2/6
j4TPFWnvgZHO+FsnIbw1Skj7c/Y526JHGXb/EUPTgeHZF7ngeJo9z8U8fAnkQXar
jeQVDV11LLMD09IOVb/BzyQiipHYKifPaDmAP3zJ99lemXMZjZGJ4n28fS1T8oCZ
nMY2utWKhXjgdzB2bO88TYsyMhC5LQvDS4Q/stlMLr+9L75BTchj8vsigj8eMpKr
/qExsIFdKY/l8WAv5MTvfffU0KsXEznG3sdINpveaSlUqdXxLUOk8hsZ2Evx+GLB
VwM259PTb4ORIaG8beMdKZ9NIIWwwsCZiPYr/2tbnzWIL8eYDXtiAJr+D+b9TDaC
pJg2a+KMnIZFV+x5hqpYi06V+ueThOxTYb3uHjtgNHTcpdktH4DDv/Owsn3v5o4L
Cik8Vbau0HcefMuvsDXMjImZtjhihGYi26MuoV8UlpM2g4pbkEOG33/y42keoRjP
QJomE5EEiO4BS8gHbhaBs1gOvrtUteCLBrhoVmwUpS9dfunMHT8f4pHCykVMKbed
hD20IeOormkRT3lI+Ug1hUwcEbDlzhtbmuhc8/PwGetosd9kJS5yYbgFXQpGGy3B
vKo6HiMCYamqmb+QK6Nv
=b75O
-----END PGP SIGNATURE-----

--TW65cEVHpwqomBoVaBrJow58ljupqTp5V--
