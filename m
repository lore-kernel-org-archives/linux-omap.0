From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] ARM: dts: Configure omap5 AESS
Date: Tue, 14 Jan 2020 17:37:40 +0100
Message-ID: <52905C15-A2D1-4372-9781-D602D0B274B6@goldelico.com>
References: <20200114150937.18304-1-tony@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:8014 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgANQhs (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jan 2020 11:37:48 -0500
In-Reply-To: <20200114150937.18304-1-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, devicetree@vger.kernel.org, Matthijs van Duin <matthijsvanduin@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>

Hi Tony,

> Am 14.01.2020 um 16:09 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> We are missing AESS for omap5. Looks like it's similar to what we have
> for omap4, and this gets ti-sysc interconnect target module driver to
> detect it properly.
>=20
> Note that we currently have no child device driver available for it.

What I have is a non-working and no more compiling driver originally =
written by
Peter Ujfalusi and reworked by Andrej Utkin. We did have it almost =
running on
v4.14 or so except problems with firmware versions and headers...

There we used classical hwmods and I could revert them now to try your =
new patches.
Unfortunately, I could only compile-test your two patches but nothing =
with AESS.

We had tried to follow kernel API changes in the sound subsystem but =
today it is
not even compiling any more :(

So getting a working device driver is an even bigger task than SGX was.

>=20
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>=20
> Note that this depends on "[PATCH] clk: ti: omap5: Add missing AESS =
clock".
>=20
> arch/arm/boot/dts/omap5-l4-abe.dtsi | 16 ++++++++++++++--
> 1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap5-l4-abe.dtsi =
b/arch/arm/boot/dts/omap5-l4-abe.dtsi
> --- a/arch/arm/boot/dts/omap5-l4-abe.dtsi
> +++ b/arch/arm/boot/dts/omap5-l4-abe.dtsi
> @@ -426,8 +426,20 @@ target-module@c0000 {			/* =
0x401c0000, ap 30 1e.0 */
> 		};
>=20
> 		target-module@f1000 {			/* 0x401f1000, =
ap 32 20.0 */

Here its may be good to have an "aess" label.

> -			compatible =3D "ti,sysc";
> -			status =3D "disabled";
> +			compatible =3D "ti,sysc-omap4", "ti,sysc";
> +			reg =3D <0xf1000 0x4>,
> +			      <0xf1010 0x4>;
> +			reg-names =3D "rev", "sysc";
> +			ti,sysc-midle =3D <SYSC_IDLE_FORCE>,
> +					<SYSC_IDLE_NO>,
> +					<SYSC_IDLE_SMART>,
> +					<SYSC_IDLE_SMART_WKUP>;
> +			ti,sysc-sidle =3D <SYSC_IDLE_FORCE>,
> +					<SYSC_IDLE_NO>,
> +					<SYSC_IDLE_SMART>;
> +			/* Domains (V, P, C): iva, abe_pwrdm, abe_clkdm =
*/
> +			clocks =3D <&abe_clkctrl OMAP5_AESS_CLKCTRL 0>;
> +			clock-names =3D "fck";
> 			#address-cells =3D <1>;
> 			#size-cells =3D <1>;
> 			ranges =3D <0x0 0xf1000 0x1000>,
> --=20
> 2.24.1

BR and thanks,
Nikolaus=
