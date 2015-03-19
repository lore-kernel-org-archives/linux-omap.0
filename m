From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 30/35] ARM: dts: omap4: add system control module node
Date: Thu, 19 Mar 2015 13:25:34 -0700
Message-ID: <20150319202533.GL31346@atomide.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
 <1426689860-17537-31-git-send-email-t-kristo@ti.com>
 <20150318213000.GX31346@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38724 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbbCSUaP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2015 16:30:15 -0400
Content-Disposition: inline
In-Reply-To: <20150318213000.GX31346@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150318 14:35]:
> * Tero Kristo <t-kristo@ti.com> [150318 07:45]:
> > --- a/arch/arm/boot/dts/omap4.dtsi
> > +++ b/arch/arm/boot/dts/omap4.dtsi
> > @@ -167,36 +167,65 @@
> > +		scm: scm@4a002000 {
> > +			compatible = "ti,omap4-ctrl", "simple-bus";
> > +			reg = <0x4a002000 0x1000>,
> > +			      <0x4a100000 0x1000>;
> > +			#address-cells = <2>;
> > +			#size-cells = <1>;
> > +			ranges = <0 0 0x4a002000 0x1000>,
> > +				 <1 0 0x4a100000 0x1000>;
> 
> Oops I still have a bit of an issue with this, sorry I should have
> been more clear last time.
> 
> Now it's hard to figure out which children belong to l4_cfg and which
> ones to l4_wkup. I suggest we set them up as completely separate blocks
> as that's what they are.
> 
> Below is an example of what I think things should look like for omap4,
> maybe take a look at that and see if that makes sense for you?
> 
> It may need to be patched in separate parts to keep the patches readable
> though :)

The example I posted has some l4_cfg vs SCM confusion as pointed out by
Tero while we chatted about it. Also l4_wkup is a child of l4_cfg on
omap4, while on omap5 they are separate.

Below are some examples of what we came up with that now follows omap4460
TRM "Figure 2-1. Interconnect Overview" and "Table 2-3. L4_CFG Memory
Space Mapping". Also an example for omap3 is included.

Tero, maybe just do the minimal changes for now as we don't need to move
all of it at once?

Regards,

Tony


Example for omap4.dtsi, which ocp being the l3 interconnect:

	ocp {
		compatible = "ti,omap4-l3-noc", "simple-bus";
		#address-cells = <1>;
		#size-cells = <1>;
		ranges;
		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
		reg = <0x44000000 0x1000>,
		      <0x44800000 0x2000>,
		      <0x45000000 0x1000>;
		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;

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

			omap4_scm_core: scm@100000 {
				compatible = "ti,omap4-scm-core", "simple-bus";
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0 0x100000 0x1000>;

				omap4_pmx_core: pinmux@40 {
					compatible = "ti,omap4-padconf", "pinctrl-single";
					reg = <0x40 0x0196>;
					#address-cells = <1>;
					#size-cells = <0>;
					#interrupt-cells = <1>;
					interrupt-controller;
					pinctrl-single,register-width = <16>;
					pinctrl-single,function-mask = <0x7fff>;
				};

				omap4_padconf_global: tisyscon@5a0 {
					compatible = "syscon";
					reg = <0x5a0 0x170>;
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

			l4_wkup: l4@300000 {
				compatible = "ti,omap4-l4-wkup", "simple-bus";
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0 0x300000 0x40000>;

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
		};
	...
	};


Example for omap3.dtsi with ocp being the l3 interconnect:

	ocp {
		compatible = "ti,omap3-l3-smx", "simple-bus";
		reg = <0x68000000 0x10000>;
		interrupts = <9 10>;
		#address-cells = <1>;
		#size-cells = <1>;
		ranges;
		ti,hwmods = "l3_main";

		...

		l4_core: l4@48000000 {
			compatible = "ti,omap3-l4-core", "simple-bus";
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <0 0x48000000 0x1000000>;

			scrm: scrm@48002000 {
				compatible = "ti,omap3-scrm", "simple-bus";
				reg = <0x2000 0x2000>;
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0 0x2000 0x2000>;

				omap3_pmx_core: pinmux@30 {
					compatible = "ti,omap3-padconf", "pinctrl-single";
					reg = <0x30 0x0238>;
					#address-cells = <1>;
					#size-cells = <0>;
					#interrupt-cells = <1>;
					interrupt-controller;
					pinctrl-single,register-width = <16>;
					pinctrl-single,function-mask = <0xff1f>;
				};

				scm_conf: tisyscon@270 {
					compatible = "syscon";
					reg = <0x270 0x2f0>;
					#address-cells = <1>;
					#size-cells = <1>;

					pbias_regulator: pbias_regulator {
						compatible = "ti,pbias-omap";
						reg = <0x2b0 0x4>;
						syscon = <&scm_conf>;
						pbias_mmc_reg: pbias_mmc_omap2430 {
							regulator-name = "pbias_mmc_omap2430";
							regulator-min-microvolt = <1800000>;
							regulator-max-microvolt = <3000000>;
						};
					};
				};

				omap3_pmx_wkup: pinmux@a00 {
					compatible = "ti,omap3-padconf", "pinctrl-single";
					reg = <0xa00 0x5c>;
					#address-cells = <1>;
					#size-cells = <0>;
					#interrupt-cells = <1>;
					interrupt-controller;
					pinctrl-single,register-width = <16>;
					pinctrl-single,function-mask = <0xff1f>;
				};

				scrm_clocks: clocks {
					#address-cells = <1>;
					#size-cells = <0>;
				};

				scrm_clockdomains: clockdomains {
				};
			};
		};
		...
	};
