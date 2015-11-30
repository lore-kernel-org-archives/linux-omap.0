From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 01/18] ARM: am57xx: cl-som-am57x: dts: add basic
 module support
Date: Mon, 30 Nov 2015 13:54:16 -0800
Message-ID: <20151130215415.GE23396@atomide.com>
References: <1448433590-1399-2-git-send-email-lifshitz@compulab.co.il>
 <1448893551-676-1-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448893551-676-1-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> [151130 06:27]:
> +++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
> +		tps659038_pmic {
> +			compatible = "ti,tps659038-pmic";
> +
> +			regulators {
> +				smps12_reg: smps12 {
> +					/* VDD_MPU */
> +					regulator-name = "smps12";
> +					regulator-min-microvolt = < 850000>;
> +					regulator-max-microvolt = <1250000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				smps3_reg: smps3 {
> +					/* VDD_DDR */
> +					regulator-name = "smps3";
> +					regulator-min-microvolt = <1500000>;
> +					regulator-max-microvolt = <1500000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				smps45_reg: smps45 {
> +					/* VDD_DSPEVE */
> +					regulator-name = "smps45";
> +					regulator-min-microvolt = < 850000>;
> +					regulator-max-microvolt = <1250000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				smps6_reg: smps6 {
> +					/* VDD_GPU */
> +					regulator-name = "smps6";
> +					regulator-min-microvolt = < 850000>;
> +					regulator-max-microvolt = <1250000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				smps7_reg: smps7 {
> +					/* VDD_CORE */
> +					regulator-name = "smps7";
> +					regulator-min-microvolt = < 850000>;
> +					regulator-max-microvolt = <1160000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				smps8_reg: smps8 {
> +					/* VDD_IVA */
> +					regulator-name = "smps8";
> +					regulator-min-microvolt = < 850000>;
> +					regulator-max-microvolt = <1250000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				smps9_reg: smps9 {
> +					/* PMIC_3V3 */
> +					regulator-name = "smps9";
> +					regulator-min-microvolt = <3300000>;
> +					regulator-max-microvolt = <3300000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +
> +				ldo1_reg: ldo1 {
> +					/* VDD_SD / VDDSHV8  */
> +					regulator-name = "ldo1";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <3300000>;
> +					regulator-boot-on;
> +					regulator-always-on;
> +				};
> +
> +				ldo2_reg: ldo2 {
> +					/* VDD_1V8 */
> +					regulator-name = "ldo2";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				ldo3_reg: ldo3 {
> +					/* VDDA_1V8_PHYA - supplies VDDA_SATA, VDDA_USB1/2/3 */
> +					regulator-name = "ldo3";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				ldo4_reg: ldo4 {
> +					/* VDDA_1V8_PHYB - supplies VDDA_HDMI, VDDA_PCIE/0/1 */
> +					regulator-name = "ldo4";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				ldo9_reg: ldo9 {
> +					/* VDD_RTC */
> +					regulator-name = "ldo9";
> +					regulator-min-microvolt = <1050000>;
> +					regulator-max-microvolt = <1050000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				ldoln_reg: ldoln {
> +					/* VDDA_1V8_PLL */
> +					regulator-name = "ldoln";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				ldousb_reg: ldousb {
> +					/* VDDA_3V_USB: VDDA_USBHS33 */
> +					regulator-name = "ldousb";
> +					regulator-min-microvolt = <3300000>;
> +					regulator-max-microvolt = <3300000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				/* regen1 not used */
> +			};
> +		};

Can you please put these into dra7-tps659038-common.dtsi so we don't have
multiple copies of it? Then make other boards include that..

That allows to set them up as real controllable regulators instead of all
this silly "regulator-always-on" stuff that has been going on since omap4 :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
