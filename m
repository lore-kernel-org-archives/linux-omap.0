From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 30/35] ARM: dts: omap4: add system control module node
Date: Wed, 18 Mar 2015 14:30:01 -0700
Message-ID: <20150318213000.GX31346@atomide.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
 <1426689860-17537-31-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38491 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756933AbbCRVeo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 17:34:44 -0400
Content-Disposition: inline
In-Reply-To: <1426689860-17537-31-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150318 07:45]:
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -167,36 +167,65 @@
> +		scm: scm@4a002000 {
> +			compatible = "ti,omap4-ctrl", "simple-bus";
> +			reg = <0x4a002000 0x1000>,
> +			      <0x4a100000 0x1000>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x4a002000 0x1000>,
> +				 <1 0 0x4a100000 0x1000>;

Oops I still have a bit of an issue with this, sorry I should have
been more clear last time.

Now it's hard to figure out which children belong to l4_cfg and which
ones to l4_wkup. I suggest we set them up as completely separate blocks
as that's what they are.

Below is an example of what I think things should look like for omap4,
maybe take a look at that and see if that makes sense for you?

It may need to be patched in separate parts to keep the patches readable
though :)

Regards,

Tony


	ocp {
		...

		l4_cfg: l4@4a000000 {
			compatible = "ti,omap4-l4-cfg", "simple-bus";
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <0 0x4a000000 0x1000000>;

			cm1: cm1@4000 {
				compatible = "ti,omap4-cm1";
				reg = <0x4000 0x2000>;

				cm1_clocks: clocks {
					#address-cells = <1>;
					#size-cells = <0>;
				};

				cm1_clockdomains: clockdomains {
				};
			};

			cm2: cm2@8000 {
				compatible = "ti,omap4-cm2";
				reg = <0x8000 0x3000>;

				cm2_clocks: clocks {
					#address-cells = <1>;
					#size-cells = <0>;
				};

				cm2_clockdomains: clockdomains {
				};
			};

			omap4_pmx_core: pinmux@100040 {
				compatible = "ti,omap4-padconf", "pinctrl-single";
				reg = <0x100040 0x0196>;
				#address-cells = <1>;
				#size-cells = <0>;
				#interrupt-cells = <1>;
				interrupt-controller;
				pinctrl-single,register-width = <16>;
				pinctrl-single,function-mask = <0x7fff>;
			};

			omap4_padconf_global: tisyscon@1005a0 {
				compatible = "syscon";
				reg = <0x1005a0 0x170>;
				#address-cells = <1>;
				#size-cells = <1>;

				pbias_regulator: pbias_regulator {
					compatible = "ti,pbias-omap";
					reg = <0x60 0x4>;
					syscon = <&omap4_padconf_global>;
					pbias_mmc_reg: pbias_mmc_omap4 {
						regulator-name = "pbias_mmc_omap4";
						regulator-min-microvolt = <1800000>;
						regulator-max-microvolt = <3000000>;
					};
				};
			};
		};

		l4_wkup: l4@4a300000 {
			compatible = "ti,omap4-l4-wkup", "simple-bus";
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <0 0x4a300000 0x40000>;

			counter32k: counter@4000 {
				compatible = "ti,omap-counter32k";
				reg = <0x4000 0x20>;
				ti,hwmods = "counter_32k";
			};

			prm: prm@6000 {
				compatible = "ti,omap4-prm";
				reg = <0x6000 0x3000>;
				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;

				prm_clocks: clocks {
					#address-cells = <1>;
					#size-cells = <0>;
				};

				prm_clockdomains: clockdomains {
				};
			};

			scrm: scrm@a000 {
				compatible = "ti,omap4-scrm";
				reg = <0xa000 0x2000>;
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0 0xa000 0x2000>;

				scrm_clocks: clocks {
					#address-cells = <1>;
					#size-cells = <0>;
				};

				scrm_clockdomains: clockdomains {
				};
			};

			omap4_pmx_wkup: pinmux@1e040 {
				compatible = "ti,omap4-padconf", "pinctrl-single";
				reg = <0x1e040 0x0038>;
				#address-cells = <1>;
				#size-cells = <0>;
				#interrupt-cells = <1>;
				interrupt-controller;
				pinctrl-single,register-width = <16>;
				pinctrl-single,function-mask = <0x7fff>;
			};
		};
		...
	};
