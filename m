From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC PATCH v1 1/2] ARM: dts: AM43xx-clocks: Entries added for
 ti-usim
Date: Mon, 3 Mar 2014 09:15:46 +0200
Message-ID: <53142C22.4020700@ti.com>
References: <1389010351-17320-1-git-send-email-satish.patel@ti.com> <1389010351-17320-2-git-send-email-satish.patel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40596 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbaCCHQS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Mar 2014 02:16:18 -0500
In-Reply-To: <1389010351-17320-2-git-send-email-satish.patel@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Satish Patel <satish.patel@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

On 01/06/2014 02:12 PM, Satish Patel wrote:
> Clock  entries support for TI's USIM - Smart card controller of AM43xx platform
> USIM controller has multiple sources for debounce and functional clock.Entry
> for each source has been added.

This patch is using unsupported/old version of DT data layout for mux 
and gate clocks, and as such does not work at all (probably causes a 
hang during boot.) Please update against latest kernel.

>
> Signed-off-by: Satish Patel <satish.patel@ti.com>
> ---
>   arch/arm/boot/dts/am43xx-clocks.dtsi |   34 ++++++++++++++++++++++++++++++++++
>   drivers/clk/ti/clk-43xx.c            |    4 ++++
>   2 files changed, 38 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
> index c127e7b..7ccfa75 100644
> --- a/arch/arm/boot/dts/am43xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
> @@ -420,6 +420,40 @@ wdt1_fck: wdt1_fck@44df422c {
>   	bit-mask = <0x1>;
>   };
>
> +usim0_fck: usim0_fck@44df4254 {
> +	#clock-cells = <0>;
> +	compatible = "mux-clock";
> +	clocks = <&sys_clkin_ck>, <&dpll_core_m4_ck>;
> +	reg = <0x44df4254 0x4>;
> +	bit-mask = <0x1>;
> +};
> +
> +usim_dbck: usim_dbck@44df425c {
> +	#clock-cells = <0>;
> +	compatible = "mux-clock";
> +	clocks = <&clk_rc32k_ck>, <&clk_32k_mosc_ck>, <&clkdiv32k_ick>;
> +	reg = <0x44df425c 0x4>;
> +	bit-mask = <0x3>;
> +};
> +
> +usim0_opt_fck: usim0_opt_fck@44df8da8 {
> +	#clock-cells = <0>;
> +	compatible = "gate-clock";
> +	clocks = <&usim0_fck>;
> +	reg = <0x44df8da8 0x4>;
> +	bit-shift = <8>;
> +	bit-mask = <0x1>;
> +};
> +
> +usim0_opt_fck32: usim0_opt_fck32@44df8da8 {
> +	#clock-cells = <0>;
> +	compatible = "gate-clock";
> +	clocks = <&usim_dbck>;
> +	bit-shift = <9>;
> +	bit-mask = <0x1>;
> +	reg = <0x44df8da8 0x4>;
> +};
> +
>   l3_gclk: l3_gclk {
>   	#clock-cells = <0>;
>   	compatible = "fixed-factor-clock";
> diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
> index ff3ad1b..8ed05f2 100644
> --- a/drivers/clk/ti/clk-43xx.c
> +++ b/drivers/clk/ti/clk-43xx.c
> @@ -66,6 +66,10 @@ static struct omap_dt_clk am43xx_clks[] = {
>   	DT_CLK(NULL, "timer6_fck", "timer6_fck"),
>   	DT_CLK(NULL, "timer7_fck", "timer7_fck"),
>   	DT_CLK(NULL, "wdt1_fck", "wdt1_fck"),
> +	DT_CLK(NULL, "usim0_fck", "usim0_fck"),
> +	DT_CLK(NULL, "usim_dbck", "usim_dbck"),
> +	DT_CLK(NULL, "usim0_opt_fck", "usim0_opt_fck"),
> +	DT_CLK(NULL, "usim0_opt_fck32", "usim0_opt_fck32"),

Do you need to add these aliases? Please avoid if possible.

-Tero

>   	DT_CLK(NULL, "l3_gclk", "l3_gclk"),
>   	DT_CLK(NULL, "dpll_core_m4_div2_ck", "dpll_core_m4_div2_ck"),
>   	DT_CLK(NULL, "l4hs_gclk", "l4hs_gclk"),
>

