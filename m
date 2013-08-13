From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 15/22] ARM: dts: Remove '0x's from OMAP3 DTS file
Date: Tue, 13 Aug 2013 16:43:05 +0100
Message-ID: <20130813154305.GE15278@lee--X1>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-15-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374490361-25769-15-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linus.walleij@stericsson.com, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Tony, Benoit,

Poke

On Mon, 22 Jul 2013, Lee Jones wrote:

> Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/omap3.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.d=
tsi
> index 7d95cda..16420ae 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -111,7 +111,7 @@
>  			pinctrl-single,function-mask =3D <0x7f1f>;
>  		};
> =20
> -		omap3_pmx_wkup: pinmux@0x48002a00 {
> +		omap3_pmx_wkup: pinmux@48002a00 {
>  			compatible =3D "ti,omap3-padconf", "pinctrl-single";
>  			reg =3D <0x48002a00 0x5c>;
>  			#address-cells =3D <1>;

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
