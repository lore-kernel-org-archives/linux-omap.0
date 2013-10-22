From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: am33xx, change usb ctrl module label
Date: Tue, 22 Oct 2013 16:25:47 +0200
Message-ID: <52668AEB.8000201@baylibre.com>
References: <1381754961-3252-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:35645 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab3JVOZu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Oct 2013 10:25:50 -0400
Received: by mail-wg0-f52.google.com with SMTP id f12so8044846wgh.7
        for <linux-omap@vger.kernel.org>; Tue, 22 Oct 2013 07:25:49 -0700 (PDT)
In-Reply-To: <1381754961-3252-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Hi Markus,

On 14/10/2013 14:49, Markus Pargmann wrote:
> Control module is not usb specific. This patch changes the label to
> usb_ctrl_mod.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

I've just applied it.

Thanks,
Benoit

> ---
>   arch/arm/boot/dts/am33xx.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx=
=2Edtsi
> index f9c5da9..14510ee 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -346,7 +346,7 @@
>   			ti,hwmods =3D "usb_otg_hs";
>   			status =3D "disabled";
>
> -			ctrl_mod: control@44e10000 {
> +			usb_ctrl_mod: control@44e10000 {
>   				compatible =3D "ti,am335x-usb-ctrl-module";
>   				reg =3D <0x44e10620 0x10
>   					0x44e10648 0x4>;
> @@ -359,7 +359,7 @@
>   				reg =3D <0x47401300 0x100>;
>   				reg-names =3D "phy";
>   				status =3D "disabled";
> -				ti,ctrl_mod =3D <&ctrl_mod>;
> +				ti,ctrl_mod =3D <&usb_ctrl_mod>;
>   			};
>
>   			usb0: usb@47401000 {
> @@ -407,7 +407,7 @@
>   				reg =3D <0x47401b00 0x100>;
>   				reg-names =3D "phy";
>   				status =3D "disabled";
> -				ti,ctrl_mod =3D <&ctrl_mod>;
> +				ti,ctrl_mod =3D <&usb_ctrl_mod>;
>   			};
>
>   			usb1: usb@47401800 {
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
