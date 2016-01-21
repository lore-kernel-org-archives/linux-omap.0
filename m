From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: dts: omap3: Include missing bandgap data for
 ti-soc-thermal driver
Date: Thu, 21 Jan 2016 10:47:18 +0100
Message-ID: <20160121094718.GV7192@pali>
References: <1451086345-3340-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451086345-3340-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Saturday 26 December 2015 00:32:25 Pali Roh=C3=A1r wrote:
> Driver for omap3 with documentation is there since v4.4-rc1.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> ---
>  arch/arm/boot/dts/omap34xx.dtsi |    5 +++++
>  arch/arm/boot/dts/omap36xx.dtsi |    5 +++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap=
34xx.dtsi
> index 4f6b2d5..c3f488f 100644
> --- a/arch/arm/boot/dts/omap34xx.dtsi
> +++ b/arch/arm/boot/dts/omap34xx.dtsi
> @@ -54,6 +54,11 @@
>  				#size-cells =3D <0>;
>  			};
>  		};
> +
> +		bandgap {
> +			reg =3D <0x48002524 0x4>;
> +			compatible =3D "ti,omap34xx-bandgap";
> +		};
>  	};
>  };
> =20
> diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap=
36xx.dtsi
> index 86253de..00f98c1 100644
> --- a/arch/arm/boot/dts/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/omap36xx.dtsi
> @@ -86,6 +86,11 @@
>  				#size-cells =3D <0>;
>  			};
>  		};
> +
> +		bandgap {
> +			reg =3D <0x48002524 0x4>;
> +			compatible =3D "ti,omap36xx-bandgap";
> +		};
>  	};
>  };
> =20

PING! Who can take this patch?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
