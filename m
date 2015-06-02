From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 01/10] arm: dra7: add DESHDCP clock
Date: Tue, 2 Jun 2015 09:56:39 +0300
Message-ID: <556D53A7.9090302@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com> <1433139798-23450-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53102 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847AbbFBG4i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jun 2015 02:56:38 -0400
In-Reply-To: <1433139798-23450-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, Nishanth Menon <nm@ti.com>

On 06/01/2015 09:23 AM, Tomi Valkeinen wrote:
> Add a new Linux clock for DRA7 based SoCs to control DESHDCP clock.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Tero Kristo <t-kristo@ti.com>

> ---
>   arch/arm/boot/dts/dra7.dtsi               |  5 +++++
>   arch/arm/boot/dts/dra7xx-clocks.dtsi      | 10 ++++++++++
>   arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  1 +
>   drivers/clk/ti/clk-7xx.c                  |  1 +
>   4 files changed, 17 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 5332b57b4950..db0890a36e96 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -131,6 +131,11 @@
>   							regulator-max-microvolt = <3000000>;
>   						};
>   					};
> +
> +					scm_conf_clocks: clocks {
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +					};
>   				};
>
>   				dra7_pmx_core: pinmux@1400 {
> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> index 3b933f74d000..470f39c4e326 100644
> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> @@ -2136,3 +2136,13 @@
>   		clocks = <&dpll_usb_ck>;
>   	};
>   };
> +
> +&scm_conf_clocks {
> +	dss_deshdcp_clk: dss_deshdcp_clk {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&l3_iclk_div>;
> +		ti,bit-shift = <0>;
> +		reg = <0x558>;
> +	};
> +};
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 0e64c2fac0b5..817dbd87ce67 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -438,6 +438,7 @@ static struct omap_hwmod_opt_clk dss_opt_clks[] = {
>   	{ .role = "video2_clk", .clk = "dss_video2_clk" },
>   	{ .role = "video1_clk", .clk = "dss_video1_clk" },
>   	{ .role = "hdmi_clk", .clk = "dss_hdmi_clk" },
> +	{ .role = "hdcp_clk", .clk = "dss_deshdcp_clk" },
>   };
>
>   static struct omap_hwmod dra7xx_dss_hwmod = {
> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
> index 5d2217ae4478..2dd956b9affa 100644
> --- a/drivers/clk/ti/clk-7xx.c
> +++ b/drivers/clk/ti/clk-7xx.c
> @@ -305,6 +305,7 @@ static struct ti_dt_clk dra7xx_clks[] = {
>   	DT_CLK("4882c000.timer", "timer_sys_ck", "timer_sys_clk_div"),
>   	DT_CLK("4882e000.timer", "timer_sys_ck", "timer_sys_clk_div"),
>   	DT_CLK(NULL, "sys_clkin", "sys_clkin1"),
> +	DT_CLK(NULL, "dss_deshdcp_clk", "dss_deshdcp_clk"),
>   	{ .node_name = NULL },
>   };
>
>

