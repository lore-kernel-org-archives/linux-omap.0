From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 12/22] ARM: dts: Remove '0x's from OMAP2420 H4 DTS file
Date: Tue, 13 Aug 2013 16:44:25 +0100
Message-ID: <20130813154425.GH15278@lee--X1>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-12-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374490361-25769-12-git-send-email-lee.jones@linaro.org>
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
>  arch/arm/boot/dts/omap2420-h4.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/om=
ap2420-h4.dts
> index 224c08f..34cdecb 100644
> --- a/arch/arm/boot/dts/omap2420-h4.dts
> +++ b/arch/arm/boot/dts/omap2420-h4.dts
> @@ -50,15 +50,15 @@
>  			label =3D "bootloader";
>  			reg =3D <0 0x20000>;
>  		};
> -		partition@0x20000 {
> +		partition@20000 {
>  			label =3D "params";
>  			reg =3D <0x20000 0x20000>;
>  		};
> -		partition@0x40000 {
> +		partition@40000 {
>  			label =3D "kernel";
>  			reg =3D <0x40000 0x200000>;
>  		};
> -		partition@0x240000 {
> +		partition@240000 {
>  			label =3D "file-system";
>  			reg =3D <0x240000 0x3dc0000>;
>  		};

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
