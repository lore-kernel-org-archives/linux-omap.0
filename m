From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: omap3-overo: Add audio support
Date: Thu, 24 Jan 2013 16:21:16 +0100
Message-ID: <5101516C.30602@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch> <1358963812-19947-3-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43233 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805Ab3AXPV3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jan 2013 10:21:29 -0500
In-Reply-To: <1358963812-19947-3-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 01/23/2013 06:56 PM, Florian Vaussard wrote:
> Add the needed sections to enable audio support on Overo.

Looks fine for me.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  arch/arm/boot/dts/omap3-overo.dtsi |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/o=
map3-overo.dtsi
> index 800be29..81341fa 100644
> --- a/arch/arm/boot/dts/omap3-overo.dtsi
> +++ b/arch/arm/boot/dts/omap3-overo.dtsi
> @@ -23,6 +23,14 @@
>  			max-brightness =3D <127>;
>  		};
>  	};
> +
> +	sound {
> +		compatible =3D "ti,omap-twl4030";
> +		ti,model =3D "overo";
> +
> +		ti,mcbsp =3D <&mcbsp2>;
> +		ti,codec =3D <&twl_audio>;
> +	};
>  };
> =20
>  &i2c1 {
> @@ -32,6 +40,12 @@
>  		reg =3D <0x48>;
>  		interrupts =3D <7>; /* SYS_NIRQ cascaded to intc */
>  		interrupt-parent =3D <&intc>;
> +
> +		twl_audio: audio {
> +			compatible =3D "ti,twl4030-audio";
> +			codec {
> +			};
> +		};
>  	};
>  };
> =20
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
