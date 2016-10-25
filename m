From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 2/3] dts: omap5: board-common: enable twl6040 headset jack detection
Date: Tue, 25 Oct 2016 19:30:40 +0200
Message-ID: <8D54A81D-99BB-46BA-A4CE-F8B0A2C2F444@goldelico.com>
References: <cover.1477416586.git.hns@goldelico.com> <cover.1477416586.git.hns@goldelico.com> <f6a1405fabfe2f65f7fb155a42f778ab3cf91821.1477416586.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f6a1405fabfe2f65f7fb155a42f778ab3cf91821.1477416586.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Russell King <linux@armlinux.org.uk>
Cc: ldewangan@nvidia.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, marek@goldelico.com, kernel@pyra-handheld.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org


> Am 25.10.2016 um 19:29 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
> arch/arm/boot/dts/omap5-board-common.dtsi | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi =
b/arch/arm/boot/dts/omap5-board-common.dtsi
> index b04adee..91456b4 100644
> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> @@ -124,6 +124,7 @@
> 		compatible =3D "ti,abe-twl6040";
> 		ti,model =3D "omap5-uevm";
>=20
> +		ti,jack_detection;

Sorry, change got lost during commit editing.

> 		ti,mclk-freq =3D <19200000>;
>=20
> 		ti,mcpdm =3D <&mcpdm>;
> --=20
> 2.7.3
>=20
