From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RESEND PATCH v3 11/11] ARM/dts: am335x-evm: Add
 audio support for am335x-evm.dts
Date: Mon, 7 Oct 2013 23:02:45 +0100
Message-ID: <20131007220245.GE2976@kartoffel>
References: <cover.1379590035.git.jsarha@ti.com>
 <cd7271a46f1c6937039b749ed105afa8057b9770.1379590036.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <cd7271a46f1c6937039b749ed105afa8057b9770.1379590036.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "joelf@ti.com" <joelf@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, Darren Etheridge <detheridge@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 26, 2013 at 08:18:36PM +0100, Jyri Sarha wrote:
> From: Darren Etheridge <detheridge@ti.com>
> 
> Adds sound, tlv320aic3x, mcasp1, and am335x_evm_audio_pin nodes.
> 
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  arch/arm/boot/dts/am335x-evm.dts |   56 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 3aee1a4..4a49229 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -149,6 +149,16 @@
>  				0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
>  			>;
>  		};
> +
> +		am335x_evm_audio_pins: am335x_evm_audio_pins {
> +			pinctrl-single,pins = <
> +				0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rx_dv.mcasp1_aclkx */
> +				0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_txd3.mcasp1_fsx */
> +				0x108 (PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* mii1_col.mcasp1_axr2 */
> +				0x144 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
> +			>;
> +		};
> +
>  	};
>  
>  	ocp {
> @@ -215,6 +225,19 @@
>  				compatible = "ti,tmp275";
>  				reg = <0x48>;
>  			};
> +
> +			tlv320aic3x: tlv320aic3x@1b {
> +				compatible = "ti,tlv320aic3x";
> +				reg = <0x1b>;
> +				status = "okay";
> +
> +				/* Regulators */
> +				AVDD-supply = <&vaux2_reg>;
> +				IOVDD-supply = <&vaux2_reg>;
> +				DRVDD-supply = <&vaux2_reg>;
> +				DVDD-supply = <&vbat>;
> +			};
> +
>  		};
>  
>  		elm: elm@48080000 {
> @@ -311,6 +334,20 @@
>  				};
>  			};
>  		};
> +
> +		sound {
> +			compatible = "ti,da830-evm-audio";
> +			ti,model = "DA830 EVM";
> +			ti,audio-codec = <&tlv320aic3x>;
> +			ti,mcasp-controller = <&mcasp1>;
> +			ti,codec-clock-rate = <12000000>;
> +			ti,audio-routing =
> +				"Headphone Jack",       "HPLOUT",
> +				"Headphone Jack",       "HPROUT",
> +				"LINE1L",               "Line In",
> +				"LINE1R",               "Line In";
> +		};
> +
>  	};
>  
>  	vbat: fixedregulator@0 {
> @@ -378,6 +415,25 @@
>  
>  #include "tps65910.dtsi"
>  
> +&mcasp1 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&am335x_evm_audio_pins>;

I didn't see mention of pinctrl added to the binding. It should be.

Thanks,
Mark.

> +
> +		status = "okay";
> +
> +		op-mode = <0>;          /* MCASP_IIS_MODE */
> +		tdm-slots = <2>;
> +		num-serializer = <16>;
> +		serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
> +			0 0 1 2
> +			0 0 0 0
> +			0 0 0 0
> +			0 0 0 0
> +		>;
> +		tx-num-evt = <1>;
> +		rx-num-evt = <1>;
> +};
> +
>  &tps {
>  	vcc1-supply = <&vbat>;
>  	vcc2-supply = <&vbat>;
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
