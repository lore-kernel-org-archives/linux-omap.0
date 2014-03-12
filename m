From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Wed, 12 Mar 2014 09:35:52 -0500
Message-ID: <532070C8.1030903@ti.com>
References: <1394621360-2457-1-git-send-email-pekon@ti.com> <1394621360-2457-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33116 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754189AbaCLOgR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Mar 2014 10:36:17 -0400
In-Reply-To: <1394621360-2457-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>, Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>

On 03/12/2014 05:49 AM, Pekon Gupta wrote:
> Beaglebone Board can be connected to expansion boards to add devices to them.
> These expansion boards are called 'capes'. This patch adds support for
> following versions of Beaglebone(AM335x) NAND capes
> (a) NAND Device with bus-width=16, block-size=128k, page-size=2k, oob-size=64
> (b) NAND Device with bus-width=16, block-size=256k, page-size=4k, oob-size=224
> Further information and datasheets can be found at [1] and [2]
> 
> * How to boot from NAND using Memory Expander + NAND Cape ? *
>  - Important: As BOOTSEL values are sampled only at POR, so after changing any
>    setting on SW2 (DIP switch), disconnect and reconnect all board power supply
>    (including mini-USB console port) to POR the beaglebone.
> 
>  - Selection of ECC scheme
>   for NAND cape(a), ROM code expects BCH8_HW ecc-scheme
>   for NAND cape(b), ROM code expects BCH16_HW ecc-scheme
> 
>  - Selction of boot modes can be controlled via  DIP switch(SW2) present on
>    Memory Expander cape.
>    SW2[SWITCH_BOOT] == OFF  follow default boot order  MMC-> SPI -> UART -> USB
>    SW2[SWITCH_BOOT] == ON   boot mode selected via DIP switch(SW2)
>    So to flash NAND, first boot via MMC or other sources and then switch to
>    SW2[SWITCH_BOOT]=ON to boot from NAND Cape.
> 
>  - For NAND boot following switch settings need to be followed
>    SW2[ 0] = ON   (SYSBOOT[ 0]==0: NAND boot mode selected )
>    SW2[ 1] = ON   (SYSBOOT[ 1]==0:       -- do --          )
>    SW2[ 2] = OFF  (SYSBOOT[ 2]==1:       -- do --          )
>    SW2[ 3] = OFF  (SYSBOOT[ 3]==1:       -- do --          )
>    SW2[ 4] = ON   (SYSBOOT[ 4]==0:       -- do --          )
>    SW2[ 8] = OFF  (SYSBOOT[ 8]==1: 0:x8 device, 1:x16 device )
>    SW2[ 9] = ON   (SYSBOOT[ 9]==0: ECC done by ROM  )
>    SW2[10] = ON   (SYSBOOT[10]==0: Non Muxed device )
>    SW2[11] = ON   (SYSBOOT[11]==0:    -- do --      )
> 
> [1] http://beagleboardtoys.info/index.php?title=BeagleBone_Memory_Expansion
> [2] http://beagleboardtoys.info/index.php?title=BeagleBone_4Gb_16-Bit_NAND_Module
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone.dts | 123 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 123 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index 94ee427..be2c572 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts

better to make a nand_cape dts which includes the am335x-bone.dts?

> @@ -10,6 +10,36 @@
>  #include "am33xx.dtsi"
>  #include "am335x-bone-common.dtsi"
>  
> +&am33xx_pinmux {
> +	nand_flash_x16: nand_flash_x16 {
> +		pinctrl-single,pins = <
> +			0x00 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad0.gpmc_ad0 */
> +			0x04 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad1.gpmc_ad1 */
> +			0x08 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad2.gpmc_ad2 */
> +			0x0c (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad3.gpmc_ad3 */
> +			0x10 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad4.gpmc_ad4 */
> +			0x14 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad5.gpmc_ad5 */
> +			0x18 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad6.gpmc_ad6 */
> +			0x1c (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad7.gpmc_ad7 */
> +			0x20 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad8.gpmc_ad8 */
> +			0x24 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad9.gpmc_ad9 */
> +			0x28 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad10.gpmc_ad10 */
> +			0x2c (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad11.gpmc_ad11 */
> +			0x30 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad12.gpmc_ad12 */
> +			0x34 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad13.gpmc_ad13 */
> +			0x38 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad14.gpmc_ad14 */
> +			0x3c (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad15.gpmc_ad15 */
> +			0x70 (MUX_MODE0 | PIN_INPUT_PULLUP )	/* gpmc_wait0.gpmc_wait0 */
> +			0x74 (MUX_MODE7 | PIN_OUTPUT_PULLUP)	/* gpmc_wpn.gpio0_30 */
> +			0x7c (MUX_MODE0 | PIN_OUTPUT_PULLUP)	/* gpmc_csn0.gpmc_csn0  */
> +			0x90 (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_advn_ale.gpmc_advn_ale */
> +			0x94 (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_oen_ren.gpmc_oen_ren */
> +			0x98 (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_wen.gpmc_wen */
> +			0x9c (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_be0n_cle.gpmc_be0n_cle */
> +		>;
> +	};
> +};
> +
>  &ldo3_reg {
>  	regulator-min-microvolt = <1800000>;
>  	regulator-max-microvolt = <3300000>;
> @@ -27,3 +57,96 @@
>  &aes {
>  	status = "okay";
>  };
> +
> +/*
> + * uncomment following to enable NAND cape support
> + * &mmc2 {
> + *      status = "disabled";
> + * };
> + * &elm {
> + *	status = "okay";
> + * };
> + * &gpmc {
> + *	status = "okay";
> + * };
> + */
> +&gpmc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nand_flash_x16>;
> +	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
> +	nand@0,0 {
> +		reg = <0 0 0>; /* CS0, offset 0 */
> +		ti,nand-ecc-opt = "bch8";
> +		ti,elm-id = <&elm>;
> +		nand-bus-width = <16>;
> +		gpmc,device-width = <2>;
> +		gpmc,sync-clk-ps = <0>;
> +		gpmc,cs-on-ns = <0>;
> +		gpmc,cs-rd-off-ns = <80>;
> +		gpmc,cs-wr-off-ns = <80>;
> +		gpmc,adv-on-ns = <0>;
> +		gpmc,adv-rd-off-ns = <80>;
> +		gpmc,adv-wr-off-ns = <80>;
> +		gpmc,we-on-ns = <20>;
> +		gpmc,we-off-ns = <60>;
> +		gpmc,oe-on-ns = <20>;
> +		gpmc,oe-off-ns = <60>;
> +		gpmc,access-ns = <40>;
> +		gpmc,rd-cycle-ns = <80>;
> +		gpmc,wr-cycle-ns = <80>;
> +		gpmc,wait-on-read = "true";
> +		gpmc,wait-on-write = "true";
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
> +			reg = <0x000C0000 0x00040000>;
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
> +			reg = <0x002C0000 0x00040000>;
> +		};
> +		partition@8 {
> +			label = "NAND.kernel";
> +			reg = <0x00300000 0x00700000>;
> +		};
> +		partition@9 {
> +			label = "NAND.file-system";
> +			reg = <0x00A00000 0x1F600000>;
> +		};
> +	};
> +};
> 


-- 
Regards,
Nishanth Menon
