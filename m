From: Mark Jackson <mpfj-list-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>
Subject: [PATCH v3] Add support for Newflow NanoBone board
Date: Fri, 04 Oct 2013 09:15:01 +0100
Message-ID: <524E7905.4060907@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <martinez.javier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

NanoBone Specification:
-----------------------
CPU:
  TI AM335x

Memory:
  256MB DDR3
  128MB NOR flash
  128KB FRAM

Ethernet:
  2 x 10/100 connected to SMSC LAN8710 PHY

USB:
  1 x USB2.0 Type A

I2C:
  2Kbit EEPROM (Microchip 24AA02)
  RTC (Maxim DS1338)
  GPIO Expander (Microchip MCP23017)

Expansion connector:
  6 x UART
  1 x MMC/SD
  1 x USB2.0

Signed-off-by: Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>
Reviewed-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---
Changes in v3:
- Added MMC support
- Fixed regulator limits

Changes in v2:
- Reworked to use existing device nodes as suggested by Javier

 MAINTAINERS                       |    6 +
 arch/arm/boot/dts/Makefile        |    1 +
 arch/arm/boot/dts/am335x-nano.dts |  431 +++++++++++++++++++++++++++++=
++++++++
 3 files changed, 438 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-nano.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index e61c2e8..8a4c9d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6062,6 +6062,12 @@ L:	linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 F:	drivers/gpio/gpio-omap.c
=20
+OMAP/NEWFLOW NANOBONE MACHINE SUPPORT
+M:	Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>
+L:	linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	arch/arm/boot/dts/am335x-nano.dts
+
 OMFS FILESYSTEM
 M:	Bob Copeland <me-aXfl/3sk2vNUbtYUoyoikg@public.gmane.org>
 L:	linux-karma-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e95af3f..543e837 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -184,6 +184,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) +=3D omap2420-h4.dtb \
 	am335x-evmsk.dtb \
 	am335x-bone.dtb \
 	am335x-boneblack.dtb \
+	am335x-nano.dtb \
 	am3517-evm.dtb \
 	am3517_mt_ventoux.dtb \
 	am43x-epos-evm.dtb
diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am33=
5x-nano.dts
new file mode 100644
index 0000000..9907b49
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -0,0 +1,431 @@
+/*
+ * Copyright (C) 2013 Newflow Ltd - http://www.newflow.co.uk/
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "am33xx.dtsi"
+
+/ {
+	model =3D "Newflow AM335x NanoBone";
+	compatible =3D "ti,am33xx";
+
+	cpus {
+		cpu@0 {
+			cpu0-supply =3D <&dcdc2_reg>;
+		};
+	};
+
+	memory {
+		device_type =3D "memory";
+		reg =3D <0x80000000 0x10000000>; /* 256 MB */
+	};
+
+	leds {
+		compatible =3D "gpio-leds";
+
+		led@0 {
+			label =3D "nanobone:green:usr1";
+			gpios =3D <&gpio1 5 0>;
+			default-state =3D "off";
+		};
+	};
+};
+
+&am33xx_pinmux {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&misc_pins>;
+
+	misc_pins: misc_pins {
+		pinctrl-single,pins =3D <
+			0x15c (PIN_OUTPUT | MUX_MODE7)	/* spi0_cs0.gpio0_5 */
+		>;
+	};
+
+	gpmc_pins: gpmc_pins {
+		pinctrl-single,pins =3D <
+			0x0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			0x4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			0x8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			0xc (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			0x10 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			0x14 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			0x18 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			0x1c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			0x20 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad8.gpmc_ad8 */
+			0x24 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad9.gpmc_ad9 */
+			0x28 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad10.gpmc_ad10 */
+			0x2c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad11.gpmc_ad11 */
+			0x30 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad12.gpmc_ad12 */
+			0x34 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad13.gpmc_ad13 */
+			0x38 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad14.gpmc_ad14 */
+			0x3c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad15.gpmc_ad15 */
+
+			0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0 */
+			0x80 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn1.gpmc_csn1 */
+			0x84 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn2.gpmc_csn2 */
+			0x88 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn3.gpmc_csn3 */
+
+			0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+			0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+			0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+			0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_ben0_cle.gpmc_ben0_cle */
+
+			0xa4 (PIN_OUTPUT | MUX_MODE1)		/* lcd_data1.gpmc_a1 */
+			0xa8 (PIN_OUTPUT | MUX_MODE1)		/* lcd_data2.gpmc_a2 */
+			0xac (PIN_OUTPUT | MUX_MODE1)		/* lcd_data3.gpmc_a3 */
+			0xb0 (PIN_OUTPUT | MUX_MODE1)		/* lcd_data4.gpmc_a4 */
+			0xb4 (PIN_OUTPUT | MUX_MODE1)		/* lcd_data5.gpmc_a5 */
+			0xb8 (PIN_OUTPUT | MUX_MODE1)		/* lcd_data6.gpmc_a6 */
+			0xbc (PIN_OUTPUT | MUX_MODE1)		/* lcd_data7.gpmc_a7 */
+
+			0xe0 (PIN_OUTPUT | MUX_MODE1)		/* lcd_vsync.gpmc_a8 */
+			0xe4 (PIN_OUTPUT | MUX_MODE1)		/* lcd_hsync.gpmc_a9 */
+			0xe8 (PIN_OUTPUT | MUX_MODE1)		/* lcd_pclk.gpmc_a10 */
+		>;
+	};
+
+	i2c0_pins: i2c0_pins {
+		pinctrl-single,pins =3D <
+			0x188 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			0x18c (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+		>;
+	};
+
+	uart0_pins: uart0_pins {
+		pinctrl-single,pins =3D <
+			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			0x174 (PIN_OUTPUT | MUX_MODE0)		/* uart0_txd.uart0_txd */
+		>;
+	};
+
+	uart1_pins: uart1_pins {
+		pinctrl-single,pins =3D <
+			0x178 (PIN_OUTPUT | MUX_MODE7)		/* uart1_ctsn.uart1_ctsn */
+			0x17c (PIN_OUTPUT | MUX_MODE7)		/* uart1_rtsn.uart1_rtsn */
+			0x180 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			0x184 (PIN_OUTPUT | MUX_MODE0)		/* uart1_txd.uart1_txd */
+		>;
+	};
+
+	uart2_pins: uart2_pins {
+		pinctrl-single,pins =3D <
+			0xc0 (PIN_INPUT_PULLUP | MUX_MODE7)	/* lcd_data8.gpio2[14] */
+			0xc4 (PIN_OUTPUT | MUX_MODE7)		/* lcd_data9.gpio2[15] */
+			0x150 (PIN_INPUT | MUX_MODE1)		/* spi0_sclk.uart2_rxd */
+			0x154 (PIN_OUTPUT | MUX_MODE1)		/* spi0_d0.uart2_txd */
+		>;
+	};
+
+	uart3_pins: uart3_pins {
+		pinctrl-single,pins =3D <
+			0xc8 (PIN_INPUT_PULLUP | MUX_MODE6)	/* lcd_data10.uart3_ctsn */
+			0xcc (PIN_OUTPUT | MUX_MODE6)		/* lcd_data11.uart3_rtsn */
+			0x160 (PIN_INPUT | MUX_MODE1)		/* spi0_cs1.uart3_rxd */
+			0x164 (PIN_OUTPUT | MUX_MODE1)		/* ecap0_in_pwm0_out.uart3_txd */
+		>;
+	};
+
+	uart4_pins: uart4_pins {
+		pinctrl-single,pins =3D <
+			0xd0 (PIN_INPUT_PULLUP | MUX_MODE6)	/* lcd_data12.uart4_ctsn */
+			0xd4 (PIN_OUTPUT | MUX_MODE6)		/* lcd_data13.uart4_rtsn */
+			0x168 (PIN_INPUT | MUX_MODE1)		/* uart0_ctsn.uart4_rxd */
+			0x16c (PIN_OUTPUT | MUX_MODE1)		/* uart0_rtsn.uart4_txd */
+		>;
+	};
+
+	uart5_pins: uart5_pins {
+		pinctrl-single,pins =3D <
+			0xd8 (PIN_INPUT | MUX_MODE4)		/* lcd_data14.uart5_rxd */
+			0x144 (PIN_OUTPUT | MUX_MODE3)		/* rmiii1_refclk.uart5_txd */
+		>;
+	};
+
+	mmc1_pins: mmc1_pins {
+		pinctrl-single,pins =3D <
+			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			0xf4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			0xf8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			0xfc (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			0x104 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			0x1e8 (PIN_INPUT_PULLUP | MUX_MODE7)	/* emu1.gpio3[8] */
+			0x1a0 (PIN_INPUT_PULLUP | MUX_MODE7)	/* mcasp0_aclkr.gpio3[18] */
+		>;
+	};
+};
+
+&uart0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart0_pins>;
+	status =3D "okay";
+};
+
+&uart1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart1_pins>;
+	status =3D "okay";
+	rts-gpio =3D <&gpio0 13 GPIO_ACTIVE_HIGH>;
+	rs485-rts-active-high;
+	rs485-rx-during-tx;
+	rs485-rts-delay =3D <1 1>;
+	linux,rs485-enabled-at-boot-time;
+};
+
+&uart2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart2_pins>;
+	status =3D "okay";
+	rts-gpio =3D <&gpio2 15 GPIO_ACTIVE_HIGH>;
+	rs485-rts-active-high;
+	rs485-rts-delay =3D <1 1>;
+	linux,rs485-enabled-at-boot-time;
+};
+
+&uart3 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart3_pins>;
+	status =3D "okay";
+};
+
+&uart4 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart4_pins>;
+	status =3D "okay";
+};
+
+&uart5 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart5_pins>;
+	status =3D "okay";
+};
+
+&i2c0 {
+	status =3D "okay";
+	pinctrl-names =3D "default";
+	clock-frequency =3D <400000>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&i2c0_pins>;
+
+	gpio@20 {
+		compatible =3D "mcp,mcp23017";
+		reg =3D <0x20>;
+	};
+
+	tps: tps@24 {
+		reg =3D <0x24>;
+	};
+
+	eeprom@53 {
+		compatible =3D "mcp,24c02";
+		reg =3D <0x53>;
+		pagesize =3D <8>;
+	};
+
+	rtc@68 {
+		compatible =3D "dallas,ds1307";
+		reg =3D <0x68>;
+	};
+};
+
+&elm {
+	status =3D "okay";
+};
+
+&gpmc {
+	compatible =3D "ti,am3352-gpmc";
+	ti,hwmods =3D "gpmc";
+	status =3D "okay";
+	gpmc,num-waitpins =3D <2>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&gpmc_pins>;
+
+	#address-cells =3D <2>;
+	#size-cells =3D <1>;
+	ranges =3D <0 0 0x08000000 0x08000000>;	/* CS0: NOR 128M */
+
+	nor@0,0 {
+		reg =3D <0 0x00000000 0x08000000>;
+		compatible =3D "cfi-flash";
+		linux,mtd-name =3D "spansion,s29gl010p11t";
+		bank-width =3D <2>;
+
+		gpmc,mux-add-data =3D <2>;
+
+		gpmc,sync-clk-ps =3D <0>;
+		gpmc,cs-on-ns =3D <0>;
+		gpmc,cs-rd-off-ns =3D <160>;
+		gpmc,cs-wr-off-ns =3D <160>;
+		gpmc,adv-on-ns =3D <10>;
+		gpmc,adv-rd-off-ns =3D <30>;
+		gpmc,adv-wr-off-ns =3D <30>;
+		gpmc,oe-on-ns =3D <40>;
+		gpmc,oe-off-ns =3D <160>;
+		gpmc,we-on-ns =3D <40>;
+		gpmc,we-off-ns =3D <160>;
+		gpmc,rd-cycle-ns =3D <160>;
+		gpmc,wr-cycle-ns =3D <160>;
+		gpmc,access-ns =3D <150>;
+		gpmc,page-burst-access-ns =3D <10>;
+		gpmc,cycle2cycle-samecsen;
+		gpmc,cycle2cycle-delay-ns =3D <20>;
+		gpmc,wr-data-mux-bus-ns =3D <70>;
+		gpmc,wr-access-ns =3D <80>;
+
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+
+		/*
+		MTD partition table
+		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+		+------------+-->0x00000000-> U-Boot start
+		|            |
+		|            |-->0x000BFFFF-> U-Boot end
+		|            |-->0x000C0000-> ENV1 start
+		|            |
+		|            |-->0x000DFFFF-> ENV1 end
+		|            |-->0x000E0000-> ENV2 start
+		|            |
+		|            |-->0x000FFFFF-> ENV2 end
+		|            |-->0x00100000-> Kernel start
+		|            |
+		|            |-->0x004FFFFF-> Kernel end
+		|            |-->0x00500000-> File system start
+		|            |
+		|            |-->0x014FFFFF-> File system end
+		|            |-->0x01500000-> User data start
+		|            |
+		|            |-->0x03FFFFFF-> User data end
+		|            |-->0x04000000-> Data storage start
+		|            |
+		+------------+-->0x08000000-> NOR end (Free end)
+		*/
+		partition@0 {
+			label =3D "boot";
+			reg =3D <0x00000000 0x000c0000>; /* 768KB */
+		};
+
+		partition@1 {
+			label =3D "env1";
+			reg =3D <0x000c0000 0x00020000>; /* 128KB */
+		};
+
+		partition@2 {
+			label =3D "env2";
+			reg =3D <0x000e0000 0x00020000>; /* 128KB */
+		};
+
+		partition@3 {
+			label =3D "kernel";
+			reg =3D <0x00100000 0x00400000>; /* 4MB */
+		};
+
+		partition@4 {
+			label =3D "rootfs";
+			reg =3D <0x00500000 0x01000000>; /* 16MB */
+		};
+
+		partition@5 {
+			label =3D "user";
+			reg =3D <0x01500000 0x02b00000>; /* 43MB */
+		};
+
+		partition@6 {
+			label =3D "data";
+			reg =3D <0x04000000 0x04000000>; /* 64MB */
+		};
+	};
+};
+
+&mac {
+	dual_emac =3D <1>;
+};
+
+&cpsw_emac0 {
+	phy_id =3D <&davinci_mdio>, <0>;
+	dual_emac_res_vlan =3D <1>;
+};
+
+&cpsw_emac1 {
+	phy_id =3D <&davinci_mdio>, <1>;
+	dual_emac_res_vlan =3D <2>;
+};
+
+&mmc1 {
+	status =3D "okay";
+	vmmc-supply =3D <&ldo4_reg>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&mmc1_pins>;
+	bus-width =3D <4>;
+	cd-gpios =3D <&gpio3 8 0>;
+	wp-gpios =3D <&gpio3 18 0>;
+};
+
+#include "tps65217.dtsi"
+
+&tps {
+	regulators {
+		dcdc1_reg: regulator@0 {
+			/* +1.5V voltage with =C2=B14% tolerance */
+			regulator-min-microvolt =3D <1450000>;
+			regulator-max-microvolt =3D <1550000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		dcdc2_reg: regulator@1 {
+			/* VDD_MPU voltage limits 0.95V - 1.1V with =C2=B14% tolerance */
+			regulator-name =3D "vdd_mpu";
+			regulator-min-microvolt =3D <915000>;
+			regulator-max-microvolt =3D <1140000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		dcdc3_reg: regulator@2 {
+			/* VDD_CORE voltage limits 0.95V - 1.1V with =C2=B14% tolerance */
+			regulator-name =3D "vdd_core";
+			regulator-min-microvolt =3D <915000>;
+			regulator-max-microvolt =3D <1140000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo1_reg: regulator@3 {
+			/* +1.8V voltage with =C2=B14% tolerance */
+			regulator-min-microvolt =3D <1750000>;
+			regulator-max-microvolt =3D <1870000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo2_reg: regulator@4 {
+			/* +3.3V voltage with =C2=B14% tolerance */
+			regulator-min-microvolt =3D <3175000>;
+			regulator-max-microvolt =3D <3430000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo3_reg: regulator@5 {
+			/* +1.8V voltage with =C2=B14% tolerance */
+			regulator-min-microvolt =3D <1750000>;
+			regulator-max-microvolt =3D <1870000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo4_reg: regulator@6 {
+			/* +3.3V voltage with =C2=B14% tolerance */
+			regulator-min-microvolt =3D <3175000>;
+			regulator-max-microvolt =3D <3430000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+	};
+};
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
