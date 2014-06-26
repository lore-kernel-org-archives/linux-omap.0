From: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Subject: Re: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Thu, 26 Jun 2014 16:48:24 -0300
Message-ID: <20140626194824.GA18814@fox>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
 <1403612666-31197-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:38983 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaFZTqP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2014 15:46:15 -0400
Received: by mail-yk0-f178.google.com with SMTP id q9so2292408ykb.37
        for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2014 12:46:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403612666-31197-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>

Hi Pekon,

On Tue, Jun 24, 2014 at 05:54:24PM +0530, Pekon Gupta wrote:
> Beaglebone Board can be connected to expansion boards to add devices =
to them.
> These expansion boards are called 'capes'. This patch adds support fo=
r
> following versions of Beaglebone(AM335x) NAND capes
> (a) NAND Device with bus-width=3D16, block-size=3D128k, page-size=3D2=
k, oob-size=3D64
> (b) NAND Device with bus-width=3D16, block-size=3D256k, page-size=3D4=
k, oob-size=3D224
> Further information and datasheets can be found at [1] and [2]
>=20
> * How to boot from NAND using Memory Expander + NAND Cape ? *
>  - Important: As BOOTSEL values are sampled only at POR, so after cha=
nging any
>    setting on SW2 (DIP switch), disconnect and reconnect all board po=
wer supply
>    (including mini-USB console port) to POR the beaglebone.
>=20
>  - Selection of ECC scheme
>   for NAND cape(a), ROM code expects BCH8_HW ecc-scheme
>   for NAND cape(b), ROM code expects BCH16_HW ecc-scheme
>=20
>  - Selection of boot modes can be controlled via  DIP switch(SW2) pre=
sent on
>    Memory Expander cape, so first boot via MMC or other sources to fl=
ash NAND
>    device and then switch to SW2[SWITCH_BOOT]=3DON to boot from NAND =
Cape.
>    SW2[SWITCH_BOOT] =3D=3D OFF  follow default boot order  MMC-> SPI =
-> UART -> USB
>    SW2[SWITCH_BOOT] =3D=3D ON   boot mode selected via DIP switch(SW2=
)
>=20
>  - For NAND boot following switch settings need to be followed
>    SW2[ 1] =3D ON   (SYSBOOT[ 0]=3D=3D0: NAND boot mode selected )
>    SW2[ 2] =3D ON   (SYSBOOT[ 1]=3D=3D0:       -- do --          )
>    SW2[ 3] =3D OFF  (SYSBOOT[ 2]=3D=3D1:       -- do --          )
>    SW2[ 4] =3D OFF  (SYSBOOT[ 3]=3D=3D1:       -- do --          )
>    SW2[ 5] =3D ON   (SYSBOOT[ 4]=3D=3D0:       -- do --          )
>    SW2[ 6] =3D OFF  (SYSBOOT[ 8]=3D=3D1: 0:x8 device, 1:x16 device )
>    SW2[ 7] =3D ON   (SYSBOOT[ 9]=3D=3D0: ECC done by ROM  )
>    SW2[ 8] =3D ON   (SYSBOOT[10]=3D=3D0: Non Muxed device )
>    SW2[ 9] =3D ON   (SYSBOOT[11]=3D=3D0:    -- do --      )
>=20
> [1] http://beagleboardtoys.info/index.php?title=3DBeagleBone_Memory_E=
xpansion
> [2] http://beagleboardtoys.info/index.php?title=3DBeagleBone_4Gb_16-B=
it_NAND_Module
>=20
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
>  arch/arm/boot/dts/am335x-bone-memory-cape.dts | 127 ++++++++++++++++=
++++++++++
>  arch/arm/boot/dts/am335x-bone.dts             |   1 +
>  arch/arm/boot/dts/am335x-boneblack.dts        |   1 +
>  3 files changed, 129 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am335x-bone-memory-cape.dts
>=20
> diff --git a/arch/arm/boot/dts/am335x-bone-memory-cape.dts b/arch/arm=
/boot/dts/am335x-bone-memory-cape.dts
> new file mode 100644
> index 0000000..6d8ebd8
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-bone-memory-cape.dts
> @@ -0,0 +1,127 @@
> +/*
> + * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This DTS adds supports for capes using GPMC interface to connect =
external
> + * memory like NAND, NOR Flash to Beaglebone-White and Beaglebone-Bl=
ack.
> + */
> +
> +
> +&am33xx_pinmux {
> +	bbcape_nand_flash_pins: bbcape_nand_flash_pins {
> +		pinctrl-single,pins =3D <
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
> +			0x74 (MUX_MODE0 | PIN_OUTPUT_PULLUP)	/* gpmc_wpn.gpmc_wpn */
> +			0x7c (MUX_MODE0 | PIN_OUTPUT_PULLUP)	/* gpmc_csn0.gpmc_csn0  */
> +			0x90 (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_advn_ale.gpmc_advn_ale */
> +			0x94 (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_oen_ren.gpmc_oen_ren */
> +			0x98 (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_wen.gpmc_wen */
> +			0x9c (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_be0n_cle.gpmc_be0n_cle */
> +		>;
> +	};
> +};
> +
> +
> +&gpmc {
> +	ranges =3D <0 0 0 0x01000000>;	/* address range =3D 16MB (minimum G=
PMC partition) */
> +	nand@0,0 {
> +		status =3D "disabled";
> +		reg =3D <0 0 4>;		/* device IO registers */
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&bbcape_nand_flash_pins>;
This doesn't seem to work as pinctrl properties are not parsed for
childs of the gpmc node. Did this work for you?

Putting this in the gpmc node makes it work, but how will we control
pins for the nand and nor independently? I believe there is currently n=
o
support for muxing individual gpmc devices. If we want to add both
devices to the DT and enable them as needed we'd need to add support fo=
r
this, right?

> +		ti,nand-ecc-opt =3D "bch8";
> +		ti,elm-id =3D <&elm>;
> +		/* generic bindings */
> +		nand-bus-width =3D <16>;
> +		/* vendor specific bindings */
> +		gpmc,device-width =3D <2>;
> +		gpmc,sync-clk-ps =3D <0>;
> +		gpmc,cs-on-ns =3D <0>;
> +		gpmc,cs-rd-off-ns =3D <80>;
> +		gpmc,cs-wr-off-ns =3D <80>;
> +		gpmc,adv-on-ns =3D <0>;
> +		gpmc,adv-rd-off-ns =3D <80>;
> +		gpmc,adv-wr-off-ns =3D <80>;
> +		gpmc,we-on-ns =3D <20>;
> +		gpmc,we-off-ns =3D <60>;
> +		gpmc,oe-on-ns =3D <20>;
> +		gpmc,oe-off-ns =3D <60>;
> +		gpmc,access-ns =3D <40>;
> +		gpmc,rd-cycle-ns =3D <80>;
> +		gpmc,wr-cycle-ns =3D <80>;
> +		gpmc,wait-pin =3D <0>;
> +		gpmc,wait-on-read;
> +		gpmc,wait-on-write;
> +		gpmc,bus-turnaround-ns =3D <0>;
> +		gpmc,cycle2cycle-delay-ns =3D <0>;
> +		gpmc,clk-activation-ns =3D <0>;
> +		gpmc,wait-monitoring-ns =3D <0>;
> +		gpmc,wr-access-ns =3D <40>;
> +		gpmc,wr-data-mux-bus-ns =3D <0>;
> +		/* MTD partition table */
> +		/* All SPL-* partitions are sized to minimal length
> +		 * which can be independently programmable. For
> +		 * NAND flash this is equal to size of erase-block */
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		partition@0 {
> +			label =3D "NAND.SPL";
> +			reg =3D <0x00000000 0x00040000>;
> +		};
> +		partition@1 {
> +			label =3D "NAND.SPL.backup1";
> +			reg =3D <0x00040000 0x00040000>;
> +		};
> +		partition@2 {
> +			label =3D "NAND.SPL.backup2";
> +			reg =3D <0x00080000 0x00040000>;
> +		};
> +		partition@3 {
> +			label =3D "NAND.SPL.backup3";
> +			reg =3D <0x000c0000 0x00040000>;
> +		};
> +		partition@4 {
> +			label =3D "NAND.u-boot-spl-os";
> +			reg =3D <0x00100000 0x00080000>;
> +		};
> +		partition@5 {
> +			label =3D "NAND.u-boot";
> +			reg =3D <0x00180000 0x00100000>;
> +		};
> +		partition@6 {
> +			label =3D "NAND.u-boot-env";
> +			reg =3D <0x00280000 0x00040000>;
> +		};
> +		partition@7 {
> +			label =3D "NAND.u-boot-env.backup1";
> +			reg =3D <0x002c0000 0x00040000>;
> +		};
> +		partition@8 {
> +			label =3D "NAND.kernel";
> +			reg =3D <0x00300000 0x00700000>;
> +		};
> +		partition@9 {
> +			label =3D "NAND.file-system";
> +			reg =3D <0x00a00000 0x1f600000>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am=
335x-bone.dts
> index 94ee427..f16bfcf 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -9,6 +9,7 @@
> =20
>  #include "am33xx.dtsi"
>  #include "am335x-bone-common.dtsi"
> +#include "am335x-bone-memory-cape.dts"
> =20
>  &ldo3_reg {
>  	regulator-min-microvolt =3D <1800000>;
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/d=
ts/am335x-boneblack.dts
> index 305975d..e6d7e54 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -9,6 +9,7 @@
> =20
>  #include "am33xx.dtsi"
>  #include "am335x-bone-common.dtsi"
> +#include "am335x-bone-memory-cape.dts"
> =20
>  &ldo3_reg {
>  	regulator-min-microvolt =3D <1800000>;
> --=20
> 1.8.5.1.163.gd7aced9
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Guido Mart=EDnez, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
