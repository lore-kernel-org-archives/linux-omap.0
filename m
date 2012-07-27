From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH RESEND v2 1/2] arm/dts: Add AM33XX basic pinctrl support
Date: Fri, 27 Jul 2012 12:10:52 +0300
Message-ID: <50125B1C.8000209@ti.com>
References: <1343144719-26352-1-git-send-email-anilkumar@ti.com> <1343144719-26352-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:42569 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751565Ab2G0JKQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jul 2012 05:10:16 -0400
Received: by obqv19 with SMTP id v19so6162758obq.30
        for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 02:10:15 -0700 (PDT)
In-Reply-To: <1343144719-26352-2-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

Hi,

On 07/24/2012 06:45 PM, AnilKumar Ch wrote:
> Adds basic pinctrl support for AM33XX family of devices. This patch
> is based on the pinctrl-simple driver submitted by Tony Lindgren's
> here: http://lwn.net/Articles/496075/
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx=
=2Edtsi
> index 59509c4..9b974dc 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -40,6 +40,15 @@
>  		};
>  	};
> =20
> +	am3358_pinmux: pinmux@44E10800 {
> +		compatible =3D "pinctrl-single";
> +		reg =3D <0x44E10800 0x0338>;

I'm just curious about the size here: how it ended up as 0x0338?
While looking at the TRM of AM335x I can come up with 0x0238 (0x44e1080=
0 -
0x44e10a38), but I don't see any sings of the remaining 0x0100 to be
documented at least.

> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		pinctrl-single,register-width =3D <32>;
> +		pinctrl-single,function-mask =3D <0x7F>;
> +	};
> +
>  	/*
>  	 * XXX: Use a flat representation of the AM33XX interconnect.
>  	 * The real AM33XX interconnect network is quite complex.Since
>=20
--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
