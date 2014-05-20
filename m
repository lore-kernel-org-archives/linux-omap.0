From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv2] arm: dts: am33xx-clock: Fix ehrpwm tbclk data.
Date: Tue, 20 May 2014 08:22:55 -0700
Message-ID: <20140520152255.9521.63826@quantum>
References: <1398760460-10539-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:65216 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbaETPXG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 11:23:06 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so424965pbc.2
        for <linux-omap@vger.kernel.org>; Tue, 20 May 2014 08:23:04 -0700 (PDT)
In-Reply-To: <1398760460-10539-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com
Cc: Sourav Poddar <sourav.poddar@ti.com>

Quoting Sourav Poddar (2014-04-29 01:34:20)
> tbclk does not need to be a composite clock, we can simply
> use gate clock for this purpose.
> 
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>

Looks good.

Regards,
Mike

> ---
> v1->v2:
> change compatible string according to mainline.
>  arch/arm/boot/dts/am33xx-clocks.dtsi |   30 ++++++------------------------
>  1 file changed, 6 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx-clocks.dtsi b/arch/arm/boot/dts/am33xx-clocks.dtsi
> index 9ccfe50..712edce 100644
> --- a/arch/arm/boot/dts/am33xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/am33xx-clocks.dtsi
> @@ -96,47 +96,29 @@
>                 clock-div = <1>;
>         };
>  
> -       ehrpwm0_gate_tbclk: ehrpwm0_gate_tbclk {
> +       ehrpwm0_tbclk: ehrpwm0_tbclk@44e10664 {
>                 #clock-cells = <0>;
> -               compatible = "ti,composite-no-wait-gate-clock";
> +               compatible = "ti,gate-clock";
>                 clocks = <&dpll_per_m2_ck>;
>                 ti,bit-shift = <0>;
>                 reg = <0x0664>;
>         };
>  
> -       ehrpwm0_tbclk: ehrpwm0_tbclk {
> -               #clock-cells = <0>;
> -               compatible = "ti,composite-clock";
> -               clocks = <&ehrpwm0_gate_tbclk>;
> -       };
> -
> -       ehrpwm1_gate_tbclk: ehrpwm1_gate_tbclk {
> +       ehrpwm1_tbclk: ehrpwm1_tbclk@44e10664 {
>                 #clock-cells = <0>;
> -               compatible = "ti,composite-no-wait-gate-clock";
> +               compatible = "ti,gate-clock";
>                 clocks = <&dpll_per_m2_ck>;
>                 ti,bit-shift = <1>;
>                 reg = <0x0664>;
>         };
>  
> -       ehrpwm1_tbclk: ehrpwm1_tbclk {
> -               #clock-cells = <0>;
> -               compatible = "ti,composite-clock";
> -               clocks = <&ehrpwm1_gate_tbclk>;
> -       };
> -
> -       ehrpwm2_gate_tbclk: ehrpwm2_gate_tbclk {
> +       ehrpwm2_tbclk: ehrpwm2_tbclk@44e10664 {
>                 #clock-cells = <0>;
> -               compatible = "ti,composite-no-wait-gate-clock";
> +               compatible = "ti,gate-clock";
>                 clocks = <&dpll_per_m2_ck>;
>                 ti,bit-shift = <2>;
>                 reg = <0x0664>;
>         };
> -
> -       ehrpwm2_tbclk: ehrpwm2_tbclk {
> -               #clock-cells = <0>;
> -               compatible = "ti,composite-clock";
> -               clocks = <&ehrpwm2_gate_tbclk>;
> -       };
>  };
>  &prcm_clocks {
>         clk_32768_ck: clk_32768_ck {
> -- 
> 1.7.9.5
> 
