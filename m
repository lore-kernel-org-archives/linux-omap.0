From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Wed, 12 Mar 2014 16:53:38 -0500
Message-ID: <20140312215337.GA5735@kahuna>
References: <1394621360-2457-1-git-send-email-pekon@ti.com>
 <1394621360-2457-2-git-send-email-pekon@ti.com>
 <532070C8.1030903@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EAB2CF1@DBDE04.ent.ti.com>
 <CAGo_u6rvUqa-7afTFzBahDJuyVkXAj5J2LL8tQRjZuf8_xWXWA@mail.gmail.com>
 <CAOCHtYhqZoCF13e1YjBiWPufDEmVotL3chO9ZUtivWbVTWVfiQ@mail.gmail.com>
 <20140312192850.GF1996@atomide.com>
 <5320C8B5.601@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EAB2E95@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57943 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752243AbaCLVyO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Mar 2014 17:54:14 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAB2E95@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Robert Nelson <robertcnelson@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>

On 16:13-20140312, Gupta, Pekon wrote:
> I think this is different discussion from previous one ..
> "common DTS file" v/s "replicated DTS entries in individual board files"
> because 'uncomment' issue will remain in both scenarios. (please read below)

see below patch to highlight what I was mentioning: The build generates the dtb that can be used with
nand cape without any hand modification. the "easy" part I mentioned is
just knowing to select the right dtb corresponding to the cape. There is
no replication, just overriding the default board behavior.

>From b573d557aa09e34b1b587943dfea73bac480286d Mon Sep 17 00:00:00 2001
From: DUMMY AUTHOR <dummy@somewhere.com>
Date: Wed, 12 Mar 2014 16:47:15 -0500
Subject: [REFERENCE PATCH] ARM: dts: am335x-bone: add support for beaglebone NAND cape

Beaglebone Board can be connected to expansion boards to add devices to them.
These expansion boards are called 'capes'. This patch adds support for
following versions of Beaglebone(AM335x) NAND capes
(a) NAND Device with bus-width=16, block-size=128k, page-size=2k, oob-size=64
(b) NAND Device with bus-width=16, block-size=256k, page-size=4k, oob-size=224
Further information and datasheets can be found at [1] and [2]

* How to boot from NAND using Memory Expander + NAND Cape ? *
 - Important: As BOOTSEL values are sampled only at POR, so after changing any
   setting on SW2 (DIP switch), disconnect and reconnect all board power supply
   (including mini-USB console port) to POR the beaglebone.

 - Selection of ECC scheme
  for NAND cape(a), ROM code expects BCH8_HW ecc-scheme
  for NAND cape(b), ROM code expects BCH16_HW ecc-scheme

 - Selction of boot modes can be controlled via  DIP switch(SW2) present on
   Memory Expander cape.
   SW2[SWITCH_BOOT] == OFF  follow default boot order  MMC-> SPI -> UART -> USB
   SW2[SWITCH_BOOT] == ON   boot mode selected via DIP switch(SW2)
   So to flash NAND, first boot via MMC or other sources and then switch to
   SW2[SWITCH_BOOT]=ON to boot from NAND Cape.

 - For NAND boot following switch settings need to be followed
   SW2[ 0] = ON   (SYSBOOT[ 0]==0: NAND boot mode selected )
   SW2[ 1] = ON   (SYSBOOT[ 1]==0:       -- do --          )
   SW2[ 2] = OFF  (SYSBOOT[ 2]==1:       -- do --          )
   SW2[ 3] = OFF  (SYSBOOT[ 3]==1:       -- do --          )
   SW2[ 4] = ON   (SYSBOOT[ 4]==0:       -- do --          )
   SW2[ 8] = OFF  (SYSBOOT[ 8]==1: 0:x8 device, 1:x16 device )
   SW2[ 9] = ON   (SYSBOOT[ 9]==0: ECC done by ROM  )
   SW2[10] = ON   (SYSBOOT[10]==0: Non Muxed device )
   SW2[11] = ON   (SYSBOOT[11]==0:    -- do --      )

[1] http://beagleboardtoys.info/index.php?title=BeagleBone_Memory_Expansion
[2] http://beagleboardtoys.info/index.php?title=BeagleBone_4Gb_16-Bit_NAND_Module
---
 arch/arm/boot/dts/Makefile                    |    1 +
 arch/arm/boot/dts/am335x-bone-memory-cape.dts |  123 +++++++++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-bone-memory-cape.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0320303..c5e9bfa 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -226,6 +226,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	am335x-evmsk.dtb \
 	am335x-bone.dtb \
 	am335x-boneblack.dtb \
+	am335x-bone-memory-cape.dtb\
 	am335x-nano.dtb \
 	am335x-base0033.dtb \
 	am3517-evm.dtb \
diff --git a/arch/arm/boot/dts/am335x-bone-memory-cape.dts b/arch/arm/boot/dts/am335x-bone-memory-cape.dts
new file mode 100644
index 0000000..7ab088d
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-bone-memory-cape.dts
@@ -0,0 +1,123 @@
+#include "am335x-bone.dts"
+
+&am33xx_pinmux {
+	nand_flash_x16: nand_flash_x16 {
+		pinctrl-single,pins = <
+			0x00 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad0.gpmc_ad0 */
+			0x04 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad1.gpmc_ad1 */
+			0x08 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad2.gpmc_ad2 */
+			0x0c (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad3.gpmc_ad3 */
+			0x10 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad4.gpmc_ad4 */
+			0x14 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad5.gpmc_ad5 */
+			0x18 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad6.gpmc_ad6 */
+			0x1c (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad7.gpmc_ad7 */
+			0x20 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad8.gpmc_ad8 */
+			0x24 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad9.gpmc_ad9 */
+			0x28 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad10.gpmc_ad10 */
+			0x2c (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad11.gpmc_ad11 */
+			0x30 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad12.gpmc_ad12 */
+			0x34 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad13.gpmc_ad13 */
+			0x38 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad14.gpmc_ad14 */
+			0x3c (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad15.gpmc_ad15 */
+			0x70 (MUX_MODE0 | PIN_INPUT_PULLUP )	/* gpmc_wait0.gpmc_wait0 */
+			0x74 (MUX_MODE7 | PIN_OUTPUT_PULLUP)	/* gpmc_wpn.gpio0_30 */
+			0x7c (MUX_MODE0 | PIN_OUTPUT_PULLUP)	/* gpmc_csn0.gpmc_csn0  */
+			0x90 (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_advn_ale.gpmc_advn_ale */
+			0x94 (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_oen_ren.gpmc_oen_ren */
+			0x98 (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_wen.gpmc_wen */
+			0x9c (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+		>;
+	};
+};
+
+
+/* NAND cape cannot work with MMC2 */
+&mmc2 {
+	status = "disabled";
+};
+
+&elm {
+	status = "okay";
+};
+
+&gpmc {
+	pinctrl-names = "default";
+	status = "okay";
+	pinctrl-0 = <&nand_flash_x16>;
+	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	nand@0,0 {
+		reg = <0 0 0>; /* CS0, offset 0 */
+		ti,nand-ecc-opt = "bch8";
+		ti,elm-id = <&elm>;
+		nand-bus-width = <16>;
+		gpmc,device-width = <2>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <80>;
+		gpmc,cs-wr-off-ns = <80>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <80>;
+		gpmc,adv-wr-off-ns = <80>;
+		gpmc,we-on-ns = <20>;
+		gpmc,we-off-ns = <60>;
+		gpmc,oe-on-ns = <20>;
+		gpmc,oe-off-ns = <60>;
+		gpmc,access-ns = <40>;
+		gpmc,rd-cycle-ns = <80>;
+		gpmc,wr-cycle-ns = <80>;
+		gpmc,wait-on-read = "true";
+		gpmc,wait-on-write = "true";
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+		/* MTD partition table */
+		/* All SPL-* partitions are sized to minimal length
+		 * which can be independently programmable. For
+		 * NAND flash this is equal to size of erase-block */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition@0 {
+			label = "NAND.SPL";
+			reg = <0x00000000 0x00040000>;
+		};
+		partition@1 {
+			label = "NAND.SPL.backup1";
+			reg = <0x00040000 0x00040000>;
+		};
+		partition@2 {
+			label = "NAND.SPL.backup2";
+			reg = <0x00080000 0x00040000>;
+		};
+		partition@3 {
+			label = "NAND.SPL.backup3";
+			reg = <0x000C0000 0x00040000>;
+		};
+		partition@4 {
+			label = "NAND.u-boot-spl-os";
+			reg = <0x00100000 0x00080000>;
+		};
+		partition@5 {
+			label = "NAND.u-boot";
+			reg = <0x00180000 0x00100000>;
+		};
+		partition@6 {
+			label = "NAND.u-boot-env";
+			reg = <0x00280000 0x00040000>;
+		};
+		partition@7 {
+			label = "NAND.u-boot-env.backup1";
+			reg = <0x002C0000 0x00040000>;
+		};
+		partition@8 {
+			label = "NAND.kernel";
+			reg = <0x00300000 0x00700000>;
+		};
+		partition@9 {
+			label = "NAND.file-system";
+			reg = <0x00A00000 0x1F600000>;
+		};
+	};
+};
-- 
1.7.9.5


-- 
Regards,
Nishanth Menon
