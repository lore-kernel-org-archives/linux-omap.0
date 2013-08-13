From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 16/22] ARM: dts: Remove '0x's from OMAP3430 SDP DTS file
Date: Tue, 13 Aug 2013 16:42:48 +0100
Message-ID: <20130813154248.GD15278@lee--X1>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-16-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374490361-25769-16-git-send-email-lee.jones@linaro.org>
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
>  arch/arm/boot/dts/omap3430-sdp.dts | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/o=
map3430-sdp.dts
> index e2249bc..281914e 100644
> --- a/arch/arm/boot/dts/omap3430-sdp.dts
> +++ b/arch/arm/boot/dts/omap3430-sdp.dts
> @@ -84,15 +84,15 @@
>  			label =3D "bootloader-nor";
>  			reg =3D <0 0x40000>;
>  		};
> -		partition@0x40000 {
> +		partition@40000 {
>  			label =3D "params-nor";
>  			reg =3D <0x40000 0x40000>;
>  		};
> -		partition@0x80000 {
> +		partition@80000 {
>  			label =3D "kernel-nor";
>  			reg =3D <0x80000 0x200000>;
>  		};
> -		partition@0x280000 {
> +		partition@280000 {
>  			label =3D "filesystem-nor";
>  			reg =3D <0x240000 0x7d80000>;
>  		};
> @@ -125,19 +125,19 @@
>  			label =3D "xloader-nand";
>  			reg =3D <0 0x80000>;
>  		};
> -		partition@0x80000 {
> +		partition@80000 {
>  			label =3D "bootloader-nand";
>  			reg =3D <0x80000 0x140000>;
>  		};
> -		partition@0x1c0000 {
> +		partition@1c0000 {
>  			label =3D "params-nand";
>  			reg =3D <0x1c0000 0xc0000>;
>  		};
> -		partition@0x280000 {
> +		partition@280000 {
>  			label =3D "kernel-nand";
>  			reg =3D <0x280000 0x500000>;
>  		};
> -		partition@0x780000 {
> +		partition@780000 {
>  			label =3D "filesystem-nand";
>  			reg =3D <0x780000 0x7880000>;
>  		};
> @@ -170,19 +170,19 @@
>  			label =3D "xloader-onenand";
>  			reg =3D <0 0x80000>;
>  		};
> -		partition@0x80000 {
> +		partition@80000 {
>  			label =3D "bootloader-onenand";
>  			reg =3D <0x80000 0x40000>;
>  		};
> -		partition@0xc0000 {
> +		partition@c0000 {
>  			label =3D "params-onenand";
>  			reg =3D <0xc0000 0x20000>;
>  		};
> -		partition@0xe0000 {
> +		partition@e0000 {
>  			label =3D "kernel-onenand";
>  			reg =3D <0xe0000 0x200000>;
>  		};
> -		partition@0x2e0000 {
> +		partition@2e0000 {
>  			label =3D "filesystem-onenand";
>  			reg =3D <0x2e0000 0xfd20000>;
>  		};

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
