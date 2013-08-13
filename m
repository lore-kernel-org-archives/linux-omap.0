From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 17/22] ARM: dts: Remove '0x's from OMAP4 DTS file
Date: Tue, 13 Aug 2013 16:42:29 +0100
Message-ID: <20130813154229.GC15278@lee--X1>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-17-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:39745 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758233Ab3HMPmg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Aug 2013 11:42:36 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so4243856eek.16
        for <linux-omap@vger.kernel.org>; Tue, 13 Aug 2013 08:42:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1374490361-25769-17-git-send-email-lee.jones@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linus.walleij@stericsson.com, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Tony, Benoit,

Poke

On Mon, 22 Jul 2013, Lee Jones wrote:

> Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/omap4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.d=
tsi
> index 22d9f2b..45708e1 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -56,7 +56,7 @@
>  		cache-level =3D <2>;
>  	};
> =20
> -	local-timer@0x48240600 {
> +	local-timer@48240600 {
>  		compatible =3D "arm,cortex-a9-twd-timer";
>  		reg =3D <0x48240600 0x20>;
>  		interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_H=
IGH)>;

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
