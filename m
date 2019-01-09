From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH v2] arm: dts: gta04: add bluetooth serdev driver flags
Date: Wed, 9 Jan 2019 18:55:08 +0100
Message-ID: <43B99E33-B38A-4275-A639-EA96F63ED509@goldelico.com>
References: <913cd7034be0d05c01148cbcedbb663454772b03.1547056071.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <913cd7034be0d05c01148cbcedbb663454772b03.1547056071.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Herring <robh@kernel.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, devicetree <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Ops,
that was the wrong one...
Please ignore.

> Am 09.01.2019 um 18:47 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> From: Andreas Kemnade <andreas@kemnade.info>
>=20
> gta04a[34] have bluetooth chips which simply understand
> h4 protocol.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> arch/arm/boot/dts/omap3-gta04.dtsi | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 499e3b0e920b..ec7b1e31c07e 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -722,6 +722,8 @@
>=20
> 	bluetooth: bluetooth {
> 		compatible =3D "wi2wi,w2cbw003-bluetooth";
> +		speed =3D <3000000>;
> +		flow;
> 		vdd-supply =3D <&vaux4>;
> 	};
> };
> --=20
> 2.19.1
>=20
> _______________________________________________
> http://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel@openphoenux.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel
