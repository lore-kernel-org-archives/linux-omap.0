From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: omap5-uevm: fix mcspi node pin descriptions
Date: Tue, 22 Oct 2013 16:54:03 +0200
Message-ID: <5266918B.8070109@baylibre.com>
References: <1382078554-31628-1-git-send-email-ewitcher@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:56177 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab3JVOyV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Oct 2013 10:54:21 -0400
Received: by mail-wg0-f47.google.com with SMTP id c11so7898894wgh.2
        for <linux-omap@vger.kernel.org>; Tue, 22 Oct 2013 07:54:20 -0700 (PDT)
In-Reply-To: <1382078554-31628-1-git-send-email-ewitcher@mindspring.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eric Witcher <ewitcher@mindspring.com>, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

Hi Eric,

On 18/10/2013 08:42, Eric Witcher wrote:
> Correct mcspi pin descriptions to match corresponding node name and
> add chip select number to be consistent with OMAP5 TRM.
>
> Signed-off-by: Eric Witcher <ewitcher@mindspring.com>

Applied on my tree.

Thanks,
Benoit

> ---
>   arch/arm/boot/dts/omap5-uevm.dts | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/oma=
p5-uevm.dts
> index d784b3a..90c7843 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -131,25 +131,25 @@
>   			0xbc (PIN_INPUT | MUX_MODE0)		/*  mcspi2_clk */
>   			0xbe (PIN_INPUT | MUX_MODE0)		/*  mcspi2_simo */
>   			0xc0 (PIN_INPUT_PULLUP | MUX_MODE0)	/*  mcspi2_somi */
> -			0xc2 (PIN_OUTPUT | MUX_MODE0)		/*  mcspi2_cs */
> +			0xc2 (PIN_OUTPUT | MUX_MODE0)		/*  mcspi2_cs0 */
>   		>;
>   	};
>
>   	mcspi3_pins: pinmux_mcspi3_pins {
>   		pinctrl-single,pins =3D <
> -			0x78 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_somi */
> -			0x7a (PIN_INPUT | MUX_MODE1)		/*  mcspi2_cs */
> -			0x7c (PIN_INPUT | MUX_MODE1)		/*  mcspi2_simo */
> -			0x7e (PIN_INPUT | MUX_MODE1)		/*  mcspi2_clk */
> +			0x78 (PIN_INPUT | MUX_MODE1)		/*  mcspi3_somi */
> +			0x7a (PIN_INPUT | MUX_MODE1)		/*  mcspi3_cs0 */
> +			0x7c (PIN_INPUT | MUX_MODE1)		/*  mcspi3_simo */
> +			0x7e (PIN_INPUT | MUX_MODE1)		/*  mcspi3_clk */
>   		>;
>   	};
>
>   	mcspi4_pins: pinmux_mcspi4_pins {
>   		pinctrl-single,pins =3D <
> -			0x164 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_clk */
> -			0x168 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_simo */
> -			0x16a (PIN_INPUT | MUX_MODE1)		/*  mcspi2_somi */
> -			0x16c (PIN_INPUT | MUX_MODE1)		/*  mcspi2_cs */
> +			0x164 (PIN_INPUT | MUX_MODE1)		/*  mcspi4_clk */
> +			0x168 (PIN_INPUT | MUX_MODE1)		/*  mcspi4_simo */
> +			0x16a (PIN_INPUT | MUX_MODE1)		/*  mcspi4_somi */
> +			0x16c (PIN_INPUT | MUX_MODE1)		/*  mcspi4_cs0 */
>   		>;
>   	};
>
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
