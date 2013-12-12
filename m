From: Nishanth Menon <nm@ti.com>
Subject: Re: need help to configure IRQ on gpio 139 pandaboard using device
 tree
Date: Thu, 12 Dec 2013 08:49:15 -0600
Message-ID: <52A9CCEB.3050308@ti.com>
References: <52A8768C.5070103@st.com> <CAGo_u6p9D_rkzte_nxy9EsNyW1ouDPt2eP4zhrYBRjmd8+VHUA@mail.gmail.com> <52A89206.8080605@st.com> <52A8A1A1.9090104@ti.com> <52A9BC8E.9090007@st.com> <52A9C7B6.3020905@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59235 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267Ab3LLOtT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 09:49:19 -0500
In-Reply-To: <52A9C7B6.3020905@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Denis CIOCCA <denis.ciocca@st.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 12/12/2013 08:27 AM, Denis CIOCCA wrote:
> Maybe, this is more correctly but still doesn't work...
> 
> 
>  From 9f6e524fa86834c3ab9a5f710021620a103019b2 Mon Sep 17 00:00:00 2001
> From: Denis Ciocca <denis.ciocca@st.com>
> Date: Thu, 12 Dec 2013 14:52:39 +0100
> Subject: [PATCH] device tree
> 
> ---
>   arch/arm/boot/dts/omap4-panda-es.dts |   22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap4-panda-es.dts 
> b/arch/arm/boot/dts/omap4-panda-es.dts
> index 816d1c9..82c3eb7 100644
> --- a/arch/arm/boot/dts/omap4-panda-es.dts
> +++ b/arch/arm/boot/dts/omap4-panda-es.dts
> @@ -41,6 +41,12 @@
>               0xb6 (PIN_OUTPUT | MUX_MODE3)    /* gpio_110 */
>           >;
>       };
> +
> +    lsm6db0_pins: lsm6db0_pins {
> +        pinctrl-single,pins = <
> +            0xf6 (PIN_INPUT | MUX_MODE3) /*  mcspi1_simo.gpio_136 */
> +        >;
> +    };
>   };
> 
>   &led_wkgpio_pins {
> @@ -49,6 +55,22 @@
>       >;
>   };
> 
> +&i2c4 {
> +    pinctrl-names = "default";
> +    pinctrl-0 = <&i2c4_pins>;
> +
> +    clock-frequency = <400000>;
> +
> +    lsm6db0@03 {
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&lsm6db0_pins>;
> +        compatible = "st,lsm6db0";
> +        reg = <0x03>;
> +        interrupts = <&mcspi1 136 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-parent = <&mcspi1>;
why is mcspi1 your interrupt parent when you did a padconf for GPIO?
you want GPIO136, so you need the right gpio block as the interrupt
parent and map interrupts in the correct map.
see [1] for an example (omap2).
> +    };
> +};
> +
>   &leds {
>       pinctrl-0 = <
>           &led_gpio_pins
> 

[1]
https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/tree/arch/arm/boot/dts/omap2430-sdp.dts?id=omap-for-v3.14/omap3-board-removal-wl1251#n42
-- 
Regards,
Nishanth Menon
