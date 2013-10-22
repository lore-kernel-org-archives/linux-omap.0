From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: igep0033: Add mmc1 node for SDCARD support.
Date: Tue, 22 Oct 2013 10:57:25 +0200
Message-ID: <52663DF5.5020401@baylibre.com>
References: <1382216119-14125-1-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55071 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab3JVI50 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Oct 2013 04:57:26 -0400
Received: by mail-bk0-f46.google.com with SMTP id 6so1174239bkj.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Oct 2013 01:57:25 -0700 (PDT)
In-Reply-To: <1382216119-14125-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, linux-omap@vger.kernel.org

Hi Enric,

On 19/10/2013 22:55, Enric Balletbo i Serra wrote:
> Add mmc1 dt node to IGEP COM AQUILA board.

I've just applied it.

Please note that since we are already at -rc6 and since all the=20
maintainers are actually visiting Edinburgh for KS and ELCE, I doubt al=
l=20
the latest patches will reach 3.13 :-(

Thanks,
Benoit


> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> ---
>   arch/arm/boot/dts/am335x-igep0033.dtsi | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/d=
ts/am335x-igep0033.dtsi
> index 06eba07..6196244 100644
> --- a/arch/arm/boot/dts/am335x-igep0033.dtsi
> +++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
> @@ -44,6 +44,13 @@
>   		regulator-max-microvolt =3D <5000000>;
>   		regulator-boot-on;
>   	};
> +
> +	vmmc: fixedregulator@0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vmmc";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +	};
>   };
>
>   &am33xx_pinmux {
> @@ -180,6 +187,12 @@
>   	};
>   };
>
> +&mmc1 {
> +	status =3D "okay";
> +	vmmc-supply =3D <&vmmc>;
> +	bus-width =3D <4>;
> +};
> +
>   &uart0 {
>   	status =3D "okay";
>   	pinctrl-names =3D "default";
>


--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
