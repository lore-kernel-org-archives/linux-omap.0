From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH 3/6] ARM: OMAP2+: dts: cm-t335: add support for NAND flash
Date: Wed, 11 Nov 2015 19:32:54 +0200
Message-ID: <56437BC6.5040704@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1445948100-16446-4-git-send-email-uri.mashiach@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445948100-16446-4-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, igor.grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Gentle ping

On 27/10/15 14:14, Uri Mashiach wrote:
> From: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
>
> Add pinmux configuration for NAND specific GPMC pins.
> Add description for GPMC controller. Add child node for NAND flash
> including CM-T335 specific partition table to GPMC node.
> Enable error-location module (ELM).
>
> Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Signed-off-by: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> ---
>   arch/arm/boot/dts/am335x-cm-t335.dts | 106 +++++++++++++++++++++++++++++++++++
>   1 file changed, 106 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
> index 39df3d2..9d6117a 100644
> --- a/arch/arm/boot/dts/am335x-cm-t335.dts
> +++ b/arch/arm/boot/dts/am335x-cm-t335.dts
> @@ -61,6 +61,41 @@
>   		>;
>   	};
>
> +	nandflash_pins: pinmux_nandflash_pins {
> +		pinctrl-single,pins = <
> +			/* gpmc_ad0.gpmc_ad0 */
> +			0x0 (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* gpmc_ad1.gpmc_ad1 */
> +			0x4 (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* gpmc_ad2.gpmc_ad2 */
> +			0x8 (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* gpmc_ad3.gpmc_ad3 */
> +			0xc (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* gpmc_ad4.gpmc_ad4 */
> +			0x10 (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* gpmc_ad5.gpmc_ad5 */
> +			0x14 (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* gpmc_ad6.gpmc_ad6 */
> +			0x18 (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* gpmc_ad7.gpmc_ad7 */
> +			0x1c (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* gpmc_wait0.gpmc_wait0 */
> +			0x70 (PIN_INPUT_PULLUP | MUX_MODE0)
> +			/* gpmc_wpn.gpio0_30 */
> +			0x74 (PIN_INPUT_PULLUP | MUX_MODE7)
> +			/* gpmc_csn0.gpmc_csn0  */
> +			0x7c (PIN_OUTPUT | MUX_MODE0)
> +			/* gpmc_advn_ale.gpmc_advn_ale */
> +			0x90 (PIN_OUTPUT | MUX_MODE0)
> +			/* gpmc_oen_ren.gpmc_oen_ren */
> +			0x94 (PIN_OUTPUT | MUX_MODE0)
> +			/* gpmc_wen.gpmc_wen */
> +			0x98 (PIN_OUTPUT | MUX_MODE0)
> +			/* gpmc_be0n_cle.gpmc_be0n_cle */
> +			0x9c (PIN_OUTPUT | MUX_MODE0)
> +		>;
> +	};
> +
>   	uart0_pins: pinmux_uart0_pins {
>   		pinctrl-single,pins = <
>   			/* uart0_rxd.uart0_rxd */
> @@ -97,3 +132,74 @@
>   	};
>   };
>
> +&gpmc {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nandflash_pins>;
> +	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
> +	nand@0,0 {
> +		reg = <0 0 0>; /* CS0, offset 0 */
> +		ti,nand-ecc-opt = "bch8";
> +		ti,elm-id = <&elm>;
> +		nand-bus-width = <8>;
> +		gpmc,device-width = <1>;
> +		gpmc,sync-clk-ps = <0>;
> +		gpmc,cs-on-ns = <0>;
> +		gpmc,cs-rd-off-ns = <44>;
> +		gpmc,cs-wr-off-ns = <44>;
> +		gpmc,adv-on-ns = <6>;
> +		gpmc,adv-rd-off-ns = <34>;
> +		gpmc,adv-wr-off-ns = <44>;
> +		gpmc,we-on-ns = <0>;
> +		gpmc,we-off-ns = <40>;
> +		gpmc,oe-on-ns = <0>;
> +		gpmc,oe-off-ns = <54>;
> +		gpmc,access-ns = <64>;
> +		gpmc,rd-cycle-ns = <82>;
> +		gpmc,wr-cycle-ns = <82>;
> +		gpmc,wait-on-read = "true";
> +		gpmc,wait-on-write = "true";
> +		gpmc,bus-turnaround-ns = <0>;
> +		gpmc,cycle2cycle-delay-ns = <0>;
> +		gpmc,clk-activation-ns = <0>;
> +		gpmc,wait-monitoring-ns = <0>;
> +		gpmc,wr-access-ns = <40>;
> +		gpmc,wr-data-mux-bus-ns = <0>;
> +		/* MTD partition table */
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		partition@0 {
> +			label = "spl";
> +			reg = <0x00000000 0x00200000>;
> +		};
> +		partition@1 {
> +			label = "uboot";
> +			reg = <0x00200000 0x00100000>;
> +		};
> +		partition@2 {
> +			label = "uboot environment";
> +			reg = <0x00300000 0x00100000>;
> +		};
> +		partition@3 {
> +			label = "dtb";
> +			reg = <0x00400000 0x00100000>;
> +		};
> +		partition@4 {
> +			label = "splash";
> +			reg = <0x00500000 0x00400000>;
> +		};
> +		partition@5 {
> +			label = "linux";
> +			reg = <0x00900000 0x00600000>;
> +		};
> +		partition@6 {
> +			label = "rootfs";
> +			reg = <0x00F00000 0>;
> +		};
> +	};
> +};
> +
> +&elm {
> +	status = "okay";
> +};
> +
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
