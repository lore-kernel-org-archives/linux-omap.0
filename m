From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: DTS: OMAP4: Panda/SDP: twl6030: fix mux for IRQ pin
 and msecure line
Date: Fri, 24 May 2013 15:09:54 -0500
Message-ID: <20130524200954.GA2344@kahuna>
References: <1369423702-31501-1-git-send-email-khilman@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33230 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755557Ab3EXUKV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 May 2013 16:10:21 -0400
Content-Disposition: inline
In-Reply-To: <1369423702-31501-1-git-send-email-khilman@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12:28-20130524, Kevin Hilman wrote:
> Earlier commits ensured proper muxing of pins related to proper
> TWL6030 behavior: see commit 265a2bc8 (ARM: OMAP3: TWL4030: ensure
> sys_nirq1 is mux'd and wakeup enabled) and commit 1ef43369 (ARM:
> OMAP4: TWL: mux sys_drm_msecure as output for PMIC).
> 
> However these only fixed legacy boot and not DT boot.  For DT boot,
> the default mux values need to be set properly in DT.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
> Applies on v3.10-rc2
> 
>  arch/arm/boot/dts/omap4-panda-common.dtsi | 8 ++++++++
>  arch/arm/boot/dts/omap4-sdp.dts           | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
> index 03bd60d..a7a9bc0 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -59,6 +59,7 @@
>  &omap4_pmx_core {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <
> +			&twl6030_pins
>  			&twl6040_pins
>  			&mcpdm_pins
>  			&mcbsp1_pins
> @@ -66,6 +67,13 @@
>  			&tpd12s015_pins
>  	>;
>  
> +	twl6030_pins: pinmux_twl6030_pins {
> +		pinctrl-single,pins = <
> +			0x15e 0x4118	/* sys_nirq1.sys_nirq1 OMAP_WAKEUP_EN | INPUT_PULLUP | MODE0 */
I can understand this - IRQ request comes here.
verified on OMAP4460 Panda-ES.
# omapconf read 0x4A10019C
4118011B

> +			0x14 0x0	/* fref_clk0_out.sys_drm_msecure OUTPUT */
I do not understand this.
OMAP4460 TRM:
Register: CONTROL_WKUP_PAD0_FREF_CLK0_OUT_PAD1_FREF_CLK3_REQ
omapconf read 0x4A31E054
010F010F

I do not understand this configuration. mux modes for 
FREF_CLK0_OUT_MUXMODE:
0x0: Select fref_clk0_out
0x1: Select fref_clk1_req
0x2: Reserved
0x3: Select gpio_wk6
0x5: Select sdmmc2_dat7
0x6: Select hw_dbg6
0x7: Select safe_mode

Why are we setting mode 0(clk out) here?
> +		>;
> +	};
> +
>  	twl6040_pins: pinmux_twl6040_pins {
>  		pinctrl-single,pins = <
>  			0xe0 0x3	/* hdq_sio.gpio_127 OUTPUT | MODE3 */
> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
> index a35d9cd..5ad0c10 100644
> --- a/arch/arm/boot/dts/omap4-sdp.dts
> +++ b/arch/arm/boot/dts/omap4-sdp.dts
> @@ -145,6 +145,7 @@
>  &omap4_pmx_core {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <
> +			&twl6030_pins
>  			&twl6040_pins
>  			&mcpdm_pins
>  			&dmic_pins
> @@ -179,6 +180,13 @@
>  		>;
>  	};
>  
> +	twl6030_pins: pinmux_twl6030_pins {
> +		pinctrl-single,pins = <
> +			0x15e 0x4118	/* sys_nirq1.sys_nirq1 OMAP_WAKEUP_EN | INPUT_PULLUP | MODE0 */
> +			0x14 0x0	/* fref_clk0_out.sys_drm_msecure OUTPUT */
> +		>;
> +	};
> +
>  	twl6040_pins: pinmux_twl6040_pins {
>  		pinctrl-single,pins = <
>  			0xe0 0x3	/* hdq_sio.gpio_127 OUTPUT | MODE3 */
> -- 
> 1.8.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Regards,
Nishanth Menon
