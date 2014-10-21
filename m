From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/4] ARM: dts: dra72-evm: Add NAND support
Date: Tue, 21 Oct 2014 11:43:21 -0500
Message-ID: <54468D29.4070706@ti.com>
References: <1413888080-2669-1-git-send-email-rogerq@ti.com> <1413888080-2669-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41490 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932304AbaJUQnp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Oct 2014 12:43:45 -0400
In-Reply-To: <1413888080-2669-2-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: balbi@ti.com, nsekhar@ti.com, george.cherian@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Roger,

On 10/21/2014 05:41 AM, Roger Quadros wrote:
> DRA72-evm has a 256MB 16-bit wide NAND chip. Add
> pinmux and NAND node.
> 
> The NAND chips 'Chip select' and 'Write protect' can be
> controlled using DIP Switch SW5. To use NAND,
> the switch must be configured like so:
> 
> SW5.1 (NAND_SELn) = ON (LOW)
> SW5.9 (GPMC_WPN) = OFF (HIGH)

Could we move this description to the dts as a comment? it would be
little more easier to refer to than figuring it out from git log. I
recollect trying to figure this out while attempting to test out NAND
previously, never actually thought to check in git log. just a
suggestion..

> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  arch/arm/boot/dts/dra72-evm.dts | 115 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
> index 4107428..6f5417a 100644
> --- a/arch/arm/boot/dts/dra72-evm.dts
> +++ b/arch/arm/boot/dts/dra72-evm.dts
> @@ -26,6 +26,33 @@
>  			0x404 (PIN_INPUT | MUX_MODE0) /* i2c1_scl.i2c1_scl */
>  		>;
>  	};
> +
> +	nand_default: nand_default {
> +		pinctrl-single,pins = <
> +			0x0	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad0 */
> +			0x4	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad1 */
> +			0x8	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad2 */
> +			0xc	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad3 */
> +			0x10	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad4 */
> +			0x14	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad5 */
> +			0x18	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad6 */
> +			0x1c	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad7 */
> +			0x20	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad8 */
> +			0x24	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad9 */
> +			0x28	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad10 */
> +			0x2c	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad11 */
> +			0x30	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad12 */
> +			0x34	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad13 */
> +			0x38	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad14 */
> +			0x3c	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad15 */
> +			0xb4	(PIN_OUTPUT | MUX_MODE0) /* gpmc_cs0 */
> +			0xc4	(PIN_OUTPUT | MUX_MODE0) /* gpmc_advn_ale */
> +			0xcc	(PIN_OUTPUT | MUX_MODE0) /* gpmc_wen */
> +			0xc8	(PIN_OUTPUT | MUX_MODE0) /* gpmc_oen_ren */
> +			0xd0	(PIN_OUTPUT | MUX_MODE0) /* gpmc_ben0 */
> +			0xd8	(PIN_INPUT  | MUX_MODE0) /* gpmc_wait0 */
> +		>;
> +	};
>  };
>  
>  &i2c1 {
> @@ -142,3 +169,91 @@
>  &uart1 {
>  	status = "okay";
>  };
> +
> +&elm {
> +	status = "okay";
> +};
> +
> +&gpmc {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nand_default>;
> +	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
> +	nand@0,0 {
> +		/* To use NAND, DIP switch SW5 must be set like so:
> +		 * SW5.1 (NAND_SELn) = ON (LOW)
> +		 * SW5.9 (GPMC_WPN) = OFF (HIGH)
> +		 */
> +		reg = <0 0 4>;		/* device IO registers */
> +		ti,nand-ecc-opt = "bch8";
> +		ti,elm-id = <&elm>;
> +		nand-bus-width = <16>;
> +		gpmc,device-width = <2>;
> +		gpmc,sync-clk-ps = <0>;
> +		gpmc,cs-on-ns = <0>;
> +		gpmc,cs-rd-off-ns = <80>;
> +		gpmc,cs-wr-off-ns = <80>;
> +		gpmc,adv-on-ns = <0>;
> +		gpmc,adv-rd-off-ns = <60>;
> +		gpmc,adv-wr-off-ns = <60>;
> +		gpmc,we-on-ns = <10>;
> +		gpmc,we-off-ns = <50>;
> +		gpmc,oe-on-ns = <4>;
> +		gpmc,oe-off-ns = <40>;
> +		gpmc,access-ns = <40>;
> +		gpmc,wr-access-ns = <80>;
> +		gpmc,rd-cycle-ns = <80>;
> +		gpmc,wr-cycle-ns = <80>;
> +		gpmc,bus-turnaround-ns = <0>;
> +		gpmc,cycle2cycle-delay-ns = <0>;
> +		gpmc,clk-activation-ns = <0>;
> +		gpmc,wait-monitoring-ns = <0>;
> +		gpmc,wr-data-mux-bus-ns = <0>;
> +		/* MTD partition table */
> +		/* All SPL-* partitions are sized to minimal length
> +		 * which can be independently programmable. For
> +		 * NAND flash this is equal to size of erase-block */
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		partition@0 {
> +			label = "NAND.SPL";
> +			reg = <0x00000000 0x000020000>;
> +		};
> +		partition@1 {
> +			label = "NAND.SPL.backup1";
> +			reg = <0x00020000 0x00020000>;
> +		};
> +		partition@2 {
> +			label = "NAND.SPL.backup2";
> +			reg = <0x00040000 0x00020000>;
> +		};
> +		partition@3 {
> +			label = "NAND.SPL.backup3";
> +			reg = <0x00060000 0x00020000>;
> +		};
> +		partition@4 {
> +			label = "NAND.u-boot-spl-os";
> +			reg = <0x00080000 0x00040000>;
> +		};
> +		partition@5 {
> +			label = "NAND.u-boot";
> +			reg = <0x000c0000 0x00100000>;
> +		};
> +		partition@6 {
> +			label = "NAND.u-boot-env";
> +			reg = <0x001c0000 0x00020000>;
> +		};
> +		partition@7 {
> +			label = "NAND.u-boot-env.backup1";
> +			reg = <0x001e0000 0x00020000>;
> +		};
> +		partition@8 {
> +			label = "NAND.kernel";
> +			reg = <0x00200000 0x00800000>;
> +		};
> +		partition@9 {
> +			label = "NAND.file-system";
> +			reg = <0x00a00000 0x0f600000>;
> +		};
> +	};
> +};
> 


-- 
Regards,
Nishanth Menon
