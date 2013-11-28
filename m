From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: DTS: omap4-sdp: Add regulator for LCD backlight
 (pwm-backlight)
Date: Thu, 28 Nov 2013 10:35:08 +0100
Message-ID: <52970E4C.8070502@baylibre.com>
References: <1385630924-16392-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35275 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab3K1JfM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Nov 2013 04:35:12 -0500
Received: by mail-wg0-f44.google.com with SMTP id a1so5941638wgh.11
        for <linux-omap@vger.kernel.org>; Thu, 28 Nov 2013 01:35:10 -0800 (PST)
In-Reply-To: <1385630924-16392-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tomi.valkeinen@ti.com

Hi Peter,

On 28/11/2013 10:28, Peter Ujfalusi wrote:
> Since in DT booted kernel dummy regulators are no longer supported we=
 need
> to provide valid phandle for the regulator needed by the backlight.
> On the board VBAT is used to power the LCD backlight(s).
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
>
> This patch is needed for 3.13 to get the LCD backlight to work again.

OK, so this is a fix for the next -rc?

Regards,
Benoit

>
> Regards,
> Peter
>
>   arch/arm/boot/dts/omap4-sdp.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap=
4-sdp.dts
> index 5fc3f43..6f86db2 100644
> --- a/arch/arm/boot/dts/omap4-sdp.dts
> +++ b/arch/arm/boot/dts/omap4-sdp.dts
> @@ -104,6 +104,7 @@
>   				100 110 120 127
>   				>;
>   		default-brightness-level =3D <13>;
> +		power-supply =3D <&vbat>;
>   	};
>
>   	sound {
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
