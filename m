From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 18/22] ARM: dts: Remove '0x's from OMAP5 DTS file
Date: Tue, 13 Aug 2013 16:41:48 +0100
Message-ID: <20130813154148.GB15278@lee--X1>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-18-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:49547 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758133Ab3HMPl4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Aug 2013 11:41:56 -0400
Received: by mail-ea0-f172.google.com with SMTP id r16so4190696ead.17
        for <linux-omap@vger.kernel.org>; Tue, 13 Aug 2013 08:41:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1374490361-25769-18-git-send-email-lee.jones@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linus.walleij@stericsson.com, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Tony, Benoit,

Poke

> Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/omap5.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.d=
tsi
> index e643620..be58604 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -604,7 +604,7 @@
>  			ti,hwmods =3D "wd_timer2";
>  		};
> =20
> -		emif1: emif@0x4c000000 {
> +		emif1: emif@4c000000 {
>  			compatible	=3D "ti,emif-4d5";
>  			ti,hwmods	=3D "emif1";
>  			phy-type	=3D <2>; /* DDR PHY type: Intelli PHY */
> @@ -615,7 +615,7 @@
>  			hw-caps-temp-alert;
>  		};
> =20
> -		emif2: emif@0x4d000000 {
> +		emif2: emif@4d000000 {
>  			compatible	=3D "ti,emif-4d5";
>  			ti,hwmods	=3D "emif2";
>  			phy-type	=3D <2>; /* DDR PHY type: Intelli PHY */

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
