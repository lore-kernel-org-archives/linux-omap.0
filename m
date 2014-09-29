From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v3 5/5] ARM: dts: am335x-boneblack: Add HDMI audio support
Date: Mon, 29 Sep 2014 09:41:59 +0300
Message-ID: <5428FF37.1020104@ti.com>
References: <cover.1410898073.git.jsarha@ti.com> <1af922a485e8084aff33eaeafa30d4698d1cc886.1410898073.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54489 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbaI2GmM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2014 02:42:12 -0400
In-Reply-To: <1af922a485e8084aff33eaeafa30d4698d1cc886.1410898073.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org
Cc: tony@atomide.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, t-kristo@ti.com

This patch is invalid now that Mike Turquette took the generic 
clk-gpio-gate in. The other patches in the series are still Ok.

I'll mail a new dts patch shortly.

Best regards,
Jyri

On 09/16/2014 11:40 PM, Jyri Sarha wrote:
> Adds mcasp0_pins, clk_mcasp0_fixed, clk_mcasp0, mcasp0, hdmi_audio,
> and sound nodes.
>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>   arch/arm/boot/dts/am335x-boneblack.dts |   52 ++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
> index 305975d..1487f7c 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -59,12 +59,35 @@
>   			0x1b0 0x03      /* xdma_event_intr0, OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
>   		>;
>   	};
> +
> +	mcasp0_pins: mcasp0_pins {
> +		pinctrl-single,pins = <
> +			0x1ac (PIN_INPUT_PULLUP | MUX_MODE0)	/* mcasp0_ahclkx.mcasp0_ahclkx */
> +			0x19c (PIN_OUTPUT_PULLDOWN | MUX_MODE2) /* mcasp0_ahclkr.mcasp0_axr2 */
> +			0x194 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
> +			0x190 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
> +			0x06c (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a11.GPIO1_27 */
> +		>;
> +	};
>   };
>
>   &lcdc {
>   	status = "okay";
>   };
>
> +&mcasp0	{
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcasp0_pins>;
> +	status = "okay";
> +	op-mode = <0>;	/* MCASP_IIS_MODE */
> +	tdm-slots = <2>;
> +	serial-dir = <	/* 0: INACTIVE, 1: TX, 2: RX */
> +			0 0 1 0
> +		>;
> +	tx-num-evt = <1>;
> +	rx-num-evt = <1>;
> +};
> +
>   / {
>   	hdmi {
>   		compatible = "ti,tilcdc,slave";
> @@ -74,4 +97,33 @@
>   		pinctrl-1 = <&nxp_hdmi_bonelt_off_pins>;
>   		status = "okay";
>   	};
> +
> +	clk_mcasp0_fixed: clk_mcasp0_fixed {
> +	      #clock-cells = <0>;
> +	      compatible = "fixed-clock";
> +	      clock-frequency = <24576000>;
> +	};
> +
> +	clk_mcasp0: clk_mcasp0 {
> +	      #clock-cells = <0>;
> +	      compatible = "ti,gpio-gate-clock";
> +	      clocks = <&clk_mcasp0_fixed>;
> +	      enable-gpios = <&gpio1 27 0>; /* BeagleBone Black Clk enable on GPIO1_27 */
> +	};
> +
> +	hdmi_audio: hdmi_audio@0 {
> +	       compatible = "linux,hdmi-audio";
> +	       status = "okay";
> +	};
> +
> +	sound {
> +		compatible = "ti,beaglebone-black-audio";
> +		ti,model = "TI BeagleBone Black";
> +		ti,audio-codec = <&hdmi_audio>;
> +		ti,mcasp-controller = <&mcasp0>;
> +		ti,audio-routing =
> +			"HDMI Out",	"TX";
> +		clocks = <&clk_mcasp0>;
> +		clock-names = "mclk";
> +	};
>   };
>

