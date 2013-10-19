From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap3-igep: Fix bus-width for mmc1.
Date: Sun, 20 Oct 2013 01:10:22 +0200
Message-ID: <CAAwP0s25=Mt1T8Mj1VzU9ikeAsbjxUh2Gs7GjwyPKOe_oa0fEA@mail.gmail.com>
References: <1382212448-31094-1-git-send-email-eballetbo@gmail.com> <1382212448-31094-2-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:48999 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab3JSXKn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 19:10:43 -0400
Received: by mail-ie0-f176.google.com with SMTP id u16so9236439iet.35
        for <linux-omap@vger.kernel.org>; Sat, 19 Oct 2013 16:10:43 -0700 (PDT)
In-Reply-To: <1382212448-31094-2-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Enric,

On Sat, Oct 19, 2013 at 9:54 PM, Enric Balletbo i Serra
<eballetbo@gmail.com> wrote:
> Both, IGEPv2 and IGEP COM MODULE have a bus-width of 4 not 8, so fix this and
> do not mux data pins from mmc1_data5 to mmc1_data7.
>

I guess you meant pins from mmc1_data4 instead mmc1_data5? (i.e: only
data0 to data3 have to be mux'ed for bus-width = <4>).

> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> ---
>  arch/arm/boot/dts/omap3-igep.dtsi | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
> index ba1e58b..d4fecce 100644
> --- a/arch/arm/boot/dts/omap3-igep.dtsi
> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
> @@ -65,10 +65,6 @@
>                         0x11a (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc1_dat1.sdmmc1_dat1 */
>                         0x11c (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc1_dat2.sdmmc1_dat2 */
>                         0x11e (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc1_dat3.sdmmc1_dat3 */
> -                       0x120 (PIN_INPUT | MUX_MODE0)           /* sdmmc1_dat4.sdmmc1_dat4 */
> -                       0x122 (PIN_INPUT | MUX_MODE0)           /* sdmmc1_dat5.sdmmc1_dat5 */
> -                       0x124 (PIN_INPUT | MUX_MODE0)           /* sdmmc1_dat6.sdmmc1_dat6 */
> -                       0x126 (PIN_INPUT | MUX_MODE0)           /* sdmmc1_dat7.sdmmc1_dat7 */
>                 >;
>         };
>
> @@ -114,7 +110,7 @@
>        pinctrl-0 = <&mmc1_pins>;
>        vmmc-supply = <&vmmc1>;
>        vmmc_aux-supply = <&vsim>;
> -      bus-width = <8>;
> +      bus-width = <4>;
>  };
>
>  &mmc2 {
> --
> 1.8.1.2
>

Best regards,
Javier
