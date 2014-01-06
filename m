From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: omap3430-sdp: add dip switch information for
 MMC operation
Date: Mon, 06 Jan 2014 23:43:23 +0100
Message-ID: <52CB318B.4030603@baylibre.com>
References: <1389047853-26375-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:45489 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933521AbaAFWn2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jan 2014 17:43:28 -0500
Received: by mail-wi0-f176.google.com with SMTP id hq4so3430648wib.15
        for <linux-omap@vger.kernel.org>; Mon, 06 Jan 2014 14:43:27 -0800 (PST)
In-Reply-To: <1389047853-26375-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Nishanth,

On 06/01/2014 23:37, Nishanth Menon wrote:
> MMC 8 bit mode operation depends on dip switch setting which is not
> obvious - The current board file has this description. However, with
> removal of the board file in the future, this information will be los=
t
> and has to be rediscovered.

Thanks for that. I've just applied it.

Regards,
Benoit


> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm/boot/dts/omap3430-sdp.dts |    4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/o=
map3430-sdp.dts
> index 281914e..cd3d047 100644
> --- a/arch/arm/boot/dts/omap3430-sdp.dts
> +++ b/arch/arm/boot/dts/omap3430-sdp.dts
> @@ -34,6 +34,10 @@
>   &mmc1 {
>   	vmmc-supply =3D <&vmmc1>;
>   	vmmc_aux-supply =3D <&vsim>;
> +	/*
> +	 * S6-3 must be in ON position for 8 bit mode to function
> +	 * Else, use 4 bit mode
> +	 */
>   	bus-width =3D <8>;
>   };

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
