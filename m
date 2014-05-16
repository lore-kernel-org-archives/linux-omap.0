From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 2/4] ARM: dts: am437x-gp-evm: add support for parallel
 NAND flash
Date: Fri, 16 May 2014 15:22:22 +0300
Message-ID: <537602FE.4020108@ti.com>
References: <1400238230-26357-1-git-send-email-pekon@ti.com> <1400238230-26357-3-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57462 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932571AbaEPMW2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 08:22:28 -0400
In-Reply-To: <1400238230-26357-3-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Hi Pekon,

On 05/16/2014 02:03 PM, Pekon Gupta wrote:
> Adds pinmux and DT node for Micron (MT29F4G08AB) x8 NAND device present on
> am437x-gp-evm board.
> (1) As NAND Flash data lines are muxed with eMMC, Thus at a given time either
>     eMMC or NAND can be enabled. Selection between eMMC and NAND is controlled:
>     (a) By dynamically driving following GPIO pin from software
>         SPI2_CS0(GPIO) == 0 NAND is selected (default)
>         SPI2_CS0(GPIO) == 1 eMMC is selected
>     (b) By statically using Jumper (J89) on the board
> 
> (2) As NAND device connnected to this board has page-size=4K and oob-size=224,
>     So ROM code expects boot-loaders to be flashed in BCH16 ECC scheme for
>     NAND boot.
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
>  arch/arm/boot/dts/am437x-gp-evm.dts | 108 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
> index 30ace1b..97b71e6 100644
> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> @@ -150,6 +150,27 @@
>  			0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
>  		>;
>  	};
> +
> +	nand_flash_x8: nand_flash_x8 {
> +		pinctrl-single,pins = <
> +			0x26c(PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* spi2_cs0.gpio/eMMCorNANDsel */
> +			0x0  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
> +			0x4  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
> +			0x8  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
> +			0xc  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
> +			0x10 (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
> +			0x14 (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
> +			0x18 (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
> +			0x1c (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
> +			0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
> +			0x74 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpmc_wpn */
> +			0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
> +			0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
> +			0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
> +			0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
> +			0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
> +		>;
> +	};
>  };
>  
>  &i2c0 {
> @@ -246,3 +267,90 @@
>  	phy_id = <&davinci_mdio>, <0>;
>  	phy-mode = "rgmii";
>  };
> +
> +&elm {
> +	status = "okay";
> +};
> +
> +&gpmc {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nand_flash_x8>;
> +	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
> +	nand@0,0 {
> +		reg = <0 0 0x37c>;	/* device IO registers */

This register space is used by the parent GPMC node as well as the NAND controller. So doing a request_and_ioremap() on this space will fail as it is already taken by the GPMC driver. 

Further, the GPMC register space doesn't map to the GPMC memory map created by this Chip select but it is mapped to L3_IO space. i.e. (physical address 0x6e00 0000)

We could have split the GPMC register space into GPMC part and NAND part but to add to the complexity, the register spaces for GPMC vs NAND are interleaved so it can't be easily split up. The way the NAND driver is currently written is that it expects the register addresses to come via platform data, primarily to get around this address interleaving issue. 

Apart from the GPMC register space, the NAND controller uses 4 bytes of GPMC memory map for I/O, and that is something that could be reflected here.

e.g.
		reg = <0 0 4>;		/* NAND I/O space */

But still, the start address can't be 0 and has to be assigned when this CS region is mapped. It is still unclear to me how that can be done.

cheers,
-roger

> +		ti,nand-ecc-opt = "bch8";
> +		ti,elm-id = <&elm>;
> +		nand-bus-width = <8>;
> +		gpmc,device-width = <1>;
> +		gpmc,sync-clk-ps = <0>;
> +		gpmc,cs-on-ns = <0>;
> +		gpmc,cs-rd-off-ns = <40>;
> +		gpmc,cs-wr-off-ns = <40>;
> +		gpmc,adv-on-ns = <0>;
> +		gpmc,adv-rd-off-ns = <25>;
> +		gpmc,adv-wr-off-ns = <25>;
> +		gpmc,we-on-ns = <0>;
> +		gpmc,we-off-ns = <20>;
> +		gpmc,oe-on-ns = <3>;
> +		gpmc,oe-off-ns = <30>;
> +		gpmc,access-ns = <30>;
> +		gpmc,rd-cycle-ns = <40>;
> +		gpmc,wr-cycle-ns = <40>;
> +		gpmc,wait-pin = <0>;
> +		gpmc,wait-on-read;
> +		gpmc,wait-on-write;
> +		gpmc,bus-turnaround-ns = <0>;
> +		gpmc,cycle2cycle-delay-ns = <0>;
> +		gpmc,clk-activation-ns = <0>;
> +		gpmc,wait-monitoring-ns = <0>;
> +		gpmc,wr-access-ns = <40>;
> +		gpmc,wr-data-mux-bus-ns = <0>;
> +		/* MTD partition table */
> +		/* All SPL-* partitions are sized to minimal length
> +		 * which can be independently programmable. For
> +		 * NAND flash this is equal to size of erase-block */
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		partition@0 {
> +			label = "NAND.SPL";
> +			reg = <0x00000000 0x00040000>;
> +		};
> +		partition@1 {
> +			label = "NAND.SPL.backup1";
> +			reg = <0x00040000 0x00040000>;
> +		};
> +		partition@2 {
> +			label = "NAND.SPL.backup2";
> +			reg = <0x00080000 0x00040000>;
> +		};
> +		partition@3 {
> +			label = "NAND.SPL.backup3";
> +			reg = <0x000c0000 0x00040000>;
> +		};
> +		partition@4 {
> +			label = "NAND.u-boot-spl-os";
> +			reg = <0x00100000 0x00080000>;
> +		};
> +		partition@5 {
> +			label = "NAND.u-boot";
> +			reg = <0x00180000 0x00100000>;
> +		};
> +		partition@6 {
> +			label = "NAND.u-boot-env";
> +			reg = <0x00280000 0x00040000>;
> +		};
> +		partition@7 {
> +			label = "NAND.u-boot-env.backup1";
> +			reg = <0x002c0000 0x00040000>;
> +		};
> +		partition@8 {
> +			label = "NAND.kernel";
> +			reg = <0x00300000 0x00700000>;
> +		};
> +		partition@9 {
> +			label = "NAND.file-system";
> +			reg = <0x00a00000 0x1f600000>;
> +		};
> +	};
> +};
> 

