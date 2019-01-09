From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2] arm: dts: gta04: add bluetooth serdev driver flags
Date: Wed, 9 Jan 2019 18:57:51 +0100
Message-ID: <20190109185751.3268420b@aktux>
References: <913cd7034be0d05c01148cbcedbb663454772b03.1547056071.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TaioDOt1mgAJmI9iA1fT2fy"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <913cd7034be0d05c01148cbcedbb663454772b03.1547056071.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Herring <robh@kernel.org>, =?UTF-8?B?QmVu?= =?UTF-8?B?b8OudA==?= Cousson <bcousson@baylibre.com>, devicetree <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/TaioDOt1mgAJmI9iA1fT2fy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed,  9 Jan 2019 18:47:52 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> From: Andreas Kemnade <andreas@kemnade.info>
>=20
> gta04a[34] have bluetooth chips which simply understand
> h4 protocol.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

what about upstreaming the full patch based on mainline and not your
on-top-of-other-stuff rebased version of this patch?

Regards,
Andreas

> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3=
-gta04.dtsi
> index 499e3b0e920b..ec7b1e31c07e 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -722,6 +722,8 @@
> =20
>  	bluetooth: bluetooth {
>  		compatible =3D "wi2wi,w2cbw003-bluetooth";
> +		speed =3D <3000000>;
> +		flow;
>  		vdd-supply =3D <&vaux4>;
>  	};
>  };


--Sig_/TaioDOt1mgAJmI9iA1fT2fy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlw2Nh8ACgkQfb1qx03i
kyQePQ/+Kv60fIIvUZiM0/ICT6QwC0h7u0jvd73APxMzo275d3rcML2iN5xj9jiO
VX6LwpfUP3hrUtkqOrdnKAtI95EbYlfOZctYEsV2s+RI5LN0qFN+eOrlXh6qLp6U
zYLlvhe56brMUXV9o6EVwQCB1zVK4fZ/32xQfTarPYsjb4+zTMtPh80ptFQttN/A
cyc9z4UdUFYfb5nhBFb9xjZKgnBuiv6FqcUQcIXrXwtL5fhALPSg8xCC9CkGkeh0
ejTjeMW9eKennDSX96VO57clfitB7+r/O4R5hIEOZy/ZwzfGqPmvwb9HKElix/jJ
3KEfnYQ4/7KkF/UuriJ4r0DBlK0MB40KVjNHlGAzH5vAvI3Cw2igiy1DmM4fNfCb
e0daOrMGaOpfQ9FThrnNsP5tVmTebs5fIxGGdLJNgAnj0T20gLez9LT8pcMZYmZN
52aaCzTHdu1uov7i07JDwu69NWLIM2AqUgNrEU61yHbzc50FVH8ytiihzH5AbOPR
a308K7mAOUVw8oV9jh+jkXa7sm1oWnx08AWlNWBqDpJm1ZZf9aCQFUJQUTo8WXpA
a7xJX8T0fobe9kP0WyZrkie1Zf+59PxtZ2DX54pqQLnYlVOgCLUXp33zPNaH8fcO
Qz7U1pZ72BQjignyHcLm6SDfs8z/lWVVAhTu/CtdWf/gBw1EaC8=
=bbpC
-----END PGP SIGNATURE-----

--Sig_/TaioDOt1mgAJmI9iA1fT2fy--
