From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 04/21] ARM: tegra: update DTs to expose legacy
 interrupt controller
Date: Thu, 8 Jan 2015 11:41:42 +0100
Message-ID: <20150108104141.GF1987@ulmo.nvidia.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-5-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:52996 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbbAHKlr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2015 05:41:47 -0500
Content-Disposition: inline
In-Reply-To: <1420652576-22309-5-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2015 at 05:42:39PM +0000, Marc Zyngier wrote:
> Describe the legacy interrupt controller in every tegra DTSI files,
> and make it the parent of most interrupts.
>=20
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/boot/dts/tegra114.dtsi | 16 +++++++++++++++-
>  arch/arm/boot/dts/tegra124.dtsi | 16 +++++++++++++++-
>  arch/arm/boot/dts/tegra20.dtsi  | 15 ++++++++++++++-
>  arch/arm/boot/dts/tegra30.dtsi  | 16 +++++++++++++++-
>  4 files changed, 59 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114=
=2Edtsi
> index 4296b53..f70bed0 100644
> --- a/arch/arm/boot/dts/tegra114.dtsi
> +++ b/arch/arm/boot/dts/tegra114.dtsi
> @@ -8,7 +8,7 @@
> =20
>  / {
>  	compatible =3D "nvidia,tegra114";
> -	interrupt-parent =3D <&gic>;
> +	interrupt-parent =3D <&ictlr>;

Maybe name the label "lic" because that's the more common name for this
controller? Same for the other DTSI files.

> @@ -134,6 +134,19 @@
>  		      <0x50046000 0x2000>;
>  		interrupts =3D <GIC_PPI 9
>  			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		interrupt-parent =3D <&gic>;

Is this allowed? It makes the GIC its own parent. I guess we need it to
stop a loop from GIC -> LIC -> GIC, but it doesn't look quite right.

> +	};
> +
> +	ictlr: interrupt-controller@60004000 {
> +		compatible =3D "nvidia,tegra114-ictlr", "nvidia,tegra-ictlr";

As previously discussed, I think the second string should be
"nvidia,tegra30-ictlr".

> +		reg =3D <0x60004000 64>,

I think the first entry should be 256 bytes long since there's another
block of 192 bytes of registers that's part of the interrupt controller,
albeit maybe not related to the functionality of the interrupt chip. But
they're still part of the same hardware block.

> +		      <0x60004100 64>,

According to the TRM there are 4 more registers in this block, so this
should be 80 in size.

> +		      <0x60004200 64>,
> +		      <0x60004300 64>,
> +		      <0x60004400 64>;

I'd prefer all of these to be hexadecimal.

> +		interrupt-controller;
> +		#interrupt-cells =3D <3>;
> +		interrupt-parent =3D <&gic>;
>  	};
> =20
>  	timer@60005000 {
> @@ -766,5 +779,6 @@
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>  			<GIC_PPI 10
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +		interrupt-parent =3D <&gic>;

Why does this get to have a non-default parent?

>  	};
>  };
> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124=
=2Edtsi
[...]
> @@ -190,6 +191,18 @@
>  		status =3D "disabled";
>  	};
> =20
> +	ictlr: interrupt-controller@60004000 {
> +		compatible =3D "nvidia,tegra124-ictlr", "nvidia,tegra-ictlr";

Same as for Tegra114.

> +		reg =3D <0x0 0x60004000 0x0 0x40>,
> +		      <0x0 0x60004100 0x0 0x40>,
> +		      <0x0 0x60004200 0x0 0x40>,
> +		      <0x0 0x60004300 0x0 0x40>,
> +		      <0x0 0x60004400 0x0 0x40>;

According to the TRM, entries 1-4 should be 0x100 bytes. Even the first
entry could be 0x100 bytes long since there are additional registers in
there. While they may not be directly relevant to the interrupt chip, I
think it would make sense to include them here because they are part of
the same hardware block.

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.d=
tsi
> index 8acf5d8..ab2f004 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -7,7 +7,7 @@
> =20
>  / {
>  	compatible =3D "nvidia,tegra20";
> -	interrupt-parent =3D <&intc>;
> +	interrupt-parent =3D <&ictlr>;

I wonder if we shouldn't rename the intc label to gic for consistency.
Could be in a follow-up patch though, and something that I can easily do
after this patch set.

> =20
>  	host1x@50000000 {
>  		compatible =3D "nvidia,tegra20-host1x", "simple-bus";
> @@ -142,6 +142,7 @@
> =20
>  	timer@50004600 {
>  		compatible =3D "arm,cortex-a9-twd-timer";
> +		interrupt-parent =3D <&intc>;
>  		reg =3D <0x50040600 0x20>;
>  		interrupts =3D <GIC_PPI 13
>  			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> @@ -154,6 +155,7 @@
>  		       0x50040100 0x0100>;
>  		interrupt-controller;
>  		#interrupt-cells =3D <3>;
> +		interrupt-parent =3D <&intc>;
>  	};
> =20
>  	cache-controller@50043000 {
> @@ -165,6 +167,17 @@
>  		cache-level =3D <2>;
>  	};
> =20
> +	ictlr: interrupt-controller@60004000 {
> +		compatible =3D "nvidia,tegra20-ictlr", "nvidia,tegra-ictlr";

As discussed previously, I think the second compatible should be
dropped.

> +		reg =3D <0x60004000 64>,
> +		      <0x60004100 64>,
> +		      <0x60004200 64>,
> +		      <0x60004300 64>;

Same comments as for Tegra114, except the quinary controller which
doesn't exist on Tegra20.

> +		interrupt-controller;
> +		#interrupt-cells =3D <3>;
> +		interrupt-parent =3D <&intc>;
> +	};
> +
>  	timer@60005000 {
>  		compatible =3D "nvidia,tegra20-timer";
>  		reg =3D <0x60005000 0x60>;

Why doesn't the Tegra timer get to keep the GIC as parent like for
Tegra114 and Tegra124? Instead I see that the Cortex-A9 TWD timer gets
to keep the parent instead.

> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.d=
tsi
[...]
> @@ -228,6 +228,7 @@
>  	timer@50004600 {
>  		compatible =3D "arm,cortex-a9-twd-timer";
>  		reg =3D <0x50040600 0x20>;
> +		interrupt-parent =3D <&intc>;
>  		interrupts =3D <GIC_PPI 13
>  			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  		clocks =3D <&tegra_car TEGRA30_CLK_TWD>;
> @@ -239,6 +240,7 @@
>  		       0x50040100 0x0100>;
>  		interrupt-controller;
>  		#interrupt-cells =3D <3>;
> +		interrupt-parent =3D <&intc>;
>  	};
> =20
>  	cache-controller@50043000 {
> @@ -250,6 +252,18 @@
>  		cache-level =3D <2>;
>  	};
> =20
> +	ictlr: interrupt-controller@60004000 {
> +		compatible =3D "nvidia,tegra30-ictlr", "nvidia,tegra-ictlr";

Should be "nvidia,tegra30-ictlr" only.

> +		reg =3D <0x60004000 64>,
> +		      <0x60004100 64>,
> +		      <0x60004200 64>,
> +		      <0x60004300 64>,
> +		      <0x60004400 64>;
> +		interrupt-controller;
> +		#interrupt-cells =3D <3>;
> +		interrupt-parent =3D <&intc>;
> +	};

This should be the same as for Tegra114.

> +
>  	timer@60005000 {
>  		compatible =3D "nvidia,tegra30-timer", "nvidia,tegra20-timer";
>  		reg =3D <0x60005000 0x400>;

Like for Tegra20, the Tegra timer is now switched to the LIC as parent.

Thierry

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUrl7lAAoJEN0jrNd/PrOhBPUP/A5xY3gJ9MoI79B+ShhiE1wQ
g0CMedaJ8YcPrmAD36Fd3mzR0ZU9PjWxTHhE2K4g18R0k4qCRh+rpLRYlBNh5Gru
8JMJzQTmtX9InDzv2WL5se8JDMpU8SEYz/bEhFN+asS56IMVURHVxDkg9V3UZ0YH
ylf3KxXHoEvCg/5/+PcnOUBk3dSFzBjthjj5ZkW4JbJGKVuU1xxzqCdVZvjTdFCY
Rbm4HhAg64KfB8EUv5a6tcl22SBFCaH0PxJ5GW902vU93eiJsc8WTRAguP+tXQoB
/jw4t/EowvDSJh4T3y7SI1Y+8HYiR/YawBEXM+pWOtc6cV9R1+GD1zNZkiTj3+Gy
g2owkooO8gZjXrbrrNBShMLxK1n4d7H5vDA2Wxjmk9iVQyf5MvEvBml5EBAEBVOo
xnBzUDRU4RMZBuPY6AuyCLt9RjjZqnkDRnYybyGq8BEhcQXHkYq8P8hVoelfjBES
qPOeM5qxdpG9ZYIL0P3Tb4liahmhPJOoADV/9k4gPrveKnJBjoTcnhJhzxcjsP+5
0Ef62XkBsb0QInU3FcdUKzmzydCtThROEDRaUXvrXM+WUZHlCbmYJHGzm3OfNTdX
v07/z3tjzThsujsOmqdV+6z2Dy9A9eXi4kPYyPZWsZ+RG4VhihtCbFqlNweCidSC
jrsMIFS9JnAe+f+br/0s
=qOa7
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
