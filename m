From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH] ARM: dts: omap3-gta04: declare backlight in lcd node
Date: Mon, 11 Feb 2019 19:14:12 +0100
Message-ID: <E556C766-1B1D-4352-9D64-D18B631ADB7D@goldelico.com>
References: <20190211162007.15626-1-andreas@kemnade.info>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211162007.15626-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org


> Am 11.02.2019 um 17:20 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> The lcd display of the gta04 has a backlight but the backlight
> was not referenced in the lcd node, so screen blanking did
> not turn off the backlight. Fix that.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Works fine.

Tested-by: H. Nikolaus Schaller <hns@goldelico.com>

> ---
> the backlight property for the driver was accepted here:
> =
https://lore.kernel.org/lkml/a54e7427-ff84-d105-aab7-c5eab42e6df9@ti.com/
>=20
> arch/arm/boot/dts/omap3-gta04.dtsi | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 8c55d33ff694..3b88eb5f1a72 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -142,6 +142,7 @@
> 			spi-cpol;
> 			spi-cpha;
>=20
> +			backlight=3D <&backlight>;
> 			label =3D "lcd";
> 			port {
> 				lcd_in: endpoint {
> @@ -151,7 +152,7 @@
> 		};
> 	};
>=20
> -	backlight {
> +	backlight: backlight {
> 		compatible =3D "pwm-backlight";
> 		pwms =3D <&pwm11 0 12000000 0>;
> 		pwm-names =3D "backlight";
> --=20
> 2.11.0
>=20
> _______________________________________________
> http://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel@openphoenux.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel
