From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 8/8] ARM: DRA7: dts: Add the dts files for dra7 SoC
 and dra7-evm board
Date: Tue, 30 Jul 2013 18:11:27 +0530
Message-ID: <51F7B477.9010701@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <1375183546-12758-9-git-send-email-rnayak@ti.com> <51F7B1E0.4060800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F7B1E0.4060800@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: paul@pwsan.com, khilman@linaro.org, tony@atomide.com, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 30 July 2013 06:00 PM, Nishanth Menon wrote:
> On 07/30/2013 06:25 AM, Rajendra Nayak wrote:
>> From: R Sricharan <r.sricharan@ti.com>
>>
>> Add minimal device tree source needed for DRA7 based SoCs.
>> Also add a board dts file for the dra7-evm (based on dra752)
>> which contains 1.5G of memory with 1G interleaved and 512MB
>> non-interleaved. Also added in the board file are pin configuration
>> details for i2c, mcspi and uart devices on board.
>>
>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> ---
>>   arch/arm/boot/dts/Makefile     |    3 +-
>>   arch/arm/boot/dts/dra7-evm.dts |  163 ++++++++++++++
>>   arch/arm/boot/dts/dra7.dtsi    |  488 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 653 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm/boot/dts/dra7-evm.dts
>>   create mode 100644 arch/arm/boot/dts/dra7.dtsi
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 641b3c9..e2f8566 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -173,7 +173,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>>       am335x-bone.dtb \
>>       am3517-evm.dtb \
>>       am3517_mt_ventoux.dtb \
>> -    am43x-epos-evm.dtb
>> +    am43x-epos-evm.dtb \
>> +    dra7-evm.dtb
>>   dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
>>   dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
>>   dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
>> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
>> new file mode 100644
>> index 0000000..7b0b563
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/dra7-evm.dts
>> @@ -0,0 +1,163 @@
>> +/*
>> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +/dts-v1/;
>> +
>> +/include/ "dra7.dtsi"
>> +
>> +/ {
>> +    model = "TI DRA7";
>> +    compatible = "ti,dra7-evm", "ti,dra7";
>> +
>> +    memory {
>> +        device_type = "memory";
>> +        reg = <0x80000000 0x60000000>; /* 1536 MB */
>> +    };
>> +};
>> +
>> +&dra7_pmx_core {
>> +    i2c1_pins: pinmux_i2c1_pins {
>> +        pinctrl-single,pins = <
>> +            0x400 0x60000    /* i2c1_sda */
>> +            0x404 0x60000    /* i2c1_scl */
>> +        >;
>> +    };
>> +
>> +    i2c2_pins: pinmux_i2c2_pins {
>> +        pinctrl-single,pins = <
>> +            0x408 0x60000    /* i2c2_sda */
>> +            0x40c 0x60000    /* i2c2_scl */
>> +        >;
>> +    };
>> +
>> +    i2c3_pins: pinmux_i2c3_pins {
>> +        pinctrl-single,pins = <
>> +            0x410 0x60000    /* i2c3_sda */
>> +            0x414 0x60000    /* i2c3_scl */
>> +        >;
>> +    };
>> +
>> +    mcspi1_pins: pinmux_mcspi1_pins {
>> +        pinctrl-single,pins = <
>> +            0x3a4 0x40000    /* spi2_clk */
>> +            0x3a8 0x40000    /* spi2_d1 */
>> +            0x3ac 0x40000    /* spi2_d0 */
>> +            0x3b0 0xc0000    /* spi2_cs0 */
>> +            0x3b4 0xc0000    /* spi2_cs1 */
>> +            0x3b8 0xe0006    /* spi2_cs2 */
>> +            0x3bc 0xe0006    /* spi2_cs3 */
>> +        >;
>> +    };
>> +
>> +    mcspi2_pins: pinmux_mcspi2_pins {
>> +        pinctrl-single,pins = <
>> +            0x3c0 0x40000    /* spi2_sclk */
>> +            0x3c4 0xc0000    /* spi2_d1 */
>> +            0x3c8 0xc0000    /* spi2_d1 */
>> +            0x3cc 0xe0000    /* spi2_cs0 */
>> +        >;
>> +    };
>> +
>> +    uart1_pins: pinmux_uart1_pins {
>> +        pinctrl-single,pins = <
>> +            0x3e0 0xe0000    /* uart1_rxd */
>> +            0x3e4 0xe0000    /* uart1_txd */
>> +            0x3e8 0x60003    /* uart1_ctsn */
>> +            0x3ec 0x60003    /* uart1_rtsn */
>> +        >;
>> +    };
>> +
>> +    uart2_pins: pinmux_uart2_pins {
>> +        pinctrl-single,pins = <
>> +            0x3f0 0x60000 /* uart2_rxd */
>> +            0x3f4 0x60000 /* uart2_txd */
>> +            0x3f8 0x60000 /* uart2_ctsn */
>> +            0x3fc 0x60000 /* uart2_rtsn */
>> +        >;
>> +    };
>> +
>> +    uart3_pins: pinmux_uart3_pins {
>> +        pinctrl-single,pins = <
>> +            0x248 0xc0000 /* uart3_rxd */
>> +            0x24c 0xc0000 /* uart3_txd */
>> +        >;
>> +    };
>> +};
>> +
>> +&i2c1 {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&i2c1_pins>;
>> +
>> +    clock-frequency = <400000>;
>> +};
>> +
>> +&i2c2 {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&i2c2_pins>;
>> +
>> +    clock-frequency = <400000>;
>> +};
>> +
>> +&i2c3 {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&i2c3_pins>;
>> +
>> +    clock-frequency = <3400000>;
>> +};
>> +
>> +&i2c4 {
>> +    status = "disabled";
>> +};
>> +
>> +&i2c5 {
>> +    status = "disabled";
>> +};
>> +
>> +&mcspi1 {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&mcspi1_pins>;
>> +};
>> +
>> +&mcspi2 {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&mcspi2_pins>;
>> +};
>> +
>> +&mcspi3 {
>> +    status = "disabled";
>> +};
>> +
>> +&mcspi4 {
>> +    status = "disabled";
>> +};
>> +
>> +&uart1 {
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&uart1_pins>;
>> +};
>> +
>> +&uart2 {
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&uart2_pins>;
>> +};
>> +
>> +&uart3 {
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&uart3_pins>;
>> +};
>> +
>> +&uart4 {
>> +    status = "disabled";
>> +};
>> +
>> +&uart5 {
>> +    status = "disabled";
>> +};
>> +
>> +&uart6 {
>> +    status = "disabled";
>> +};
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> new file mode 100644
>> index 0000000..8a0c08e
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -0,0 +1,488 @@
>> +/*
>> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + * Based on "omap4.dtsi"
>> + */
>> +
>> +/include/ "skeleton.dtsi"
>> +
>> +/ {
>> +    compatible = "ti,dra7xx";
>> +    interrupt-parent = <&gic>;
>> +
>> +    aliases {
>> +        serial0 = &uart1;
>> +        serial1 = &uart2;
>> +        serial2 = &uart3;
>> +        serial3 = &uart4;
>> +        serial4 = &uart5;
>> +        serial5 = &uart6;
>> +    };
>> +
>> +    cpus {
>> +        cpu@0 {
>> +            compatible = "arm,cortex-a15";
>> +            timer {
>> +                compatible = "arm,armv7-timer";
>> +                /*
>> +                 * PPI secure/nonsecure IRQ,
>> +                 * active low level-sensitive
>> +                 */
>> +                interrupts = <1 13 0x308>,
>> +                         <1 14 0x308>;
>> +                clock-frequency = <6144000>;
>> +            };
>> +        };
>> +        cpu@1 {
>> +            compatible = "arm,cortex-a15";
>> +            timer {
>> +                compatible = "arm,armv7-timer";
>> +                /*
>> +                 * PPI secure/nonsecure IRQ,
>> +                 * active low level-sensitive
>> +                 */
>> +                interrupts = <1 13 0x308>,
>> +                         <1 14 0x308>;
>> +                clock-frequency = <6144000>;
>> +            };
>> +        };
>> +    };
>> +
>> +    gic: interrupt-controller@48211000 {
>> +        compatible = "arm,cortex-a15-gic";
>> +        interrupt-controller;
>> +        #interrupt-cells = <3>;
>> +        reg = <0x48211000 0x1000>,
>> +              <0x48212000 0x1000>;
>> +    };
>> +
>> +    /*
>> +     * The soc node represents the soc top level view. It is uses for IPs
>> +     * that are not memory mapped in the MPU view or for the MPU itself.
>> +     */
>> +    soc {
>> +        compatible = "ti,omap-infra";
>> +        mpu {
>> +            compatible = "ti,omap5-mpu";
>> +            ti,hwmods = "mpu";
>> +        };
>> +    };
>> +
>> +    /*
>> +     * XXX: Use a flat representation of the SOC interconnect.
>> +     * The real OMAP interconnect network is quite complex.
>> +     * Since that will not bring real advantage to represent that in DT for
>> +     * the moment, just use a fake OCP bus entry to represent the whole bus
>> +     * hierarchy.
>> +     */
>> +    ocp {
>> +        compatible = "ti,omap4-l3-noc", "simple-bus";
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges;
>> +        ti,hwmods = "l3_main_1", "l3_main_2";
>> +
>> +        counter32k: counter@4ae04000 {
>> +            compatible = "ti,omap-counter32k";
>> +            reg = <0x4ae04000 0x40>;
>> +            ti,hwmods = "counter_32k";
>> +        };
>> +
>> +        dra7_pmx_core: pinmux@4a003400 {
>> +            compatible = "pinctrl-single";
>> +            reg = <0x4a003400 0x0464>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            pinctrl-single,register-width = <32>;
>> +            pinctrl-single,function-mask = <0x3fffffff>;
>> +        };
>> +
>> +        sdma: dma-controller@4a056000 {
>> +            compatible = "ti,omap4430-sdma";
>> +            reg = <0x4a056000 0x1000>;
>> +            interrupts = <0 12 0x4>,
>> +                     <0 13 0x4>,
>> +                     <0 14 0x4>,
>> +                     <0 15 0x4>;
>> +            #dma-cells = <1>;
>> +            #dma-channels = <32>;
>> +            #dma-requests = <127>;
>> +        };
>> +
>> +        gpio1: gpio@4ae10000 {
>> +            compatible = "ti,omap4-gpio";
>> +            reg = <0x4ae10000 0x200>;
>> +            interrupts = <0 29 0x4>;
>> +            ti,hwmods = "gpio1";
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <1>;
>> +        };
>> +
>> +        gpio2: gpio@48055000 {
>> +            compatible = "ti,omap4-gpio";
>> +            reg = <0x48055000 0x200>;
>> +            interrupts = <0 30 0x4>;
>> +            ti,hwmods = "gpio2";
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <1>;
>> +        };
>> +
>> +        gpio3: gpio@48057000 {
>> +            compatible = "ti,omap4-gpio";
>> +            reg = <0x48057000 0x200>;
>> +            interrupts = <0 31 0x4>;
>> +            ti,hwmods = "gpio3";
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <1>;
>> +        };
>> +
>> +        gpio4: gpio@48059000 {
>> +            compatible = "ti,omap4-gpio";
>> +            reg = <0x48059000 0x200>;
>> +            interrupts = <0 32 0x4>;
>> +            ti,hwmods = "gpio4";
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <1>;
>> +        };
>> +
>> +        gpio5: gpio@4805b000 {
>> +            compatible = "ti,omap4-gpio";
>> +            reg = <0x4805b000 0x200>;
>> +            interrupts = <0 33 0x4>;
>> +            ti,hwmods = "gpio5";
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <1>;
>> +        };
>> +
>> +        gpio6: gpio@4805d000 {
>> +            compatible = "ti,omap4-gpio";
>> +            reg = <0x4805d000 0x200>;
>> +            interrupts = <0 34 0x4>;
>> +            ti,hwmods = "gpio6";
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <1>;
>> +        };
>> +
>> +        gpio7: gpio@48051000 {
>> +            compatible = "ti,omap4-gpio";
>> +            reg = <0x48051000 0x200>;
>> +            interrupts = <0 35 0x4>;
>> +            ti,hwmods = "gpio7";
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <1>;
>> +        };
>> +
>> +        gpio8: gpio@48053000 {
>> +            compatible = "ti,omap4-gpio";
>> +            reg = <0x48053000 0x200>;
>> +            interrupts = <0 121 0x4>;
>> +            ti,hwmods = "gpio8";
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <1>;
>> +        };
>> +
>> +        uart1: serial@4806a000 {
>> +            compatible = "ti,omap4-uart";
>> +            reg = <0x4806a000 0x100>;
>> +            interrupts = <0 72 0x4>;
>> +            ti,hwmods = "uart1";
>> +            clock-frequency = <48000000>;
>> +        };
>> +
>> +        uart2: serial@4806c000 {
>> +            compatible = "ti,omap4-uart";
>> +            reg = <0x4806c000 0x100>;
>> +            interrupts = <0 73 0x4>;
>> +            ti,hwmods = "uart2";
>> +            clock-frequency = <48000000>;
>> +        };
>> +
>> +        uart3: serial@48020000 {
>> +            compatible = "ti,omap4-uart";
>> +            reg = <0x48020000 0x100>;
>> +            interrupts = <0 74 0x4>;
>> +            ti,hwmods = "uart3";
>> +            clock-frequency = <48000000>;
>> +        };
>> +
>> +        uart4: serial@4806e000 {
>> +            compatible = "ti,omap4-uart";
>> +            reg = <0x4806e000 0x100>;
>> +            interrupts = <0 70 0x4>;
>> +            ti,hwmods = "uart4";
>> +            clock-frequency = <48000000>;
>> +        };
>> +
>> +        uart5: serial@48066000 {
>> +            compatible = "ti,omap4-uart";
>> +            reg = <0x48066000 0x100>;
>> +            interrupts = <0 105 0x4>;
>> +            ti,hwmods = "uart5";
>> +            clock-frequency = <48000000>;
>> +        };
>> +
>> +        uart6: serial@48068000 {
>> +            compatible = "ti,omap4-uart";
>> +            reg = <0x48068000 0x100>;
>> +            interrupts = <0 106 0x4>;
>> +            ti,hwmods = "uart6";
>> +            clock-frequency = <48000000>;
>> +        };
>> +
>> +        timer1: timer@4ae18000 {
>> +            compatible = "ti,omap5430-timer";
>> +            reg = <0x4ae18000 0x80>;
>> +            interrupts = <0 37 0x4>;
>> +            ti,hwmods = "timer1";
>> +            ti,timer-alwon;
>> +        };
>> +
>> +        timer2: timer@48032000 {
>> +            compatible = "ti,omap5430-timer";
>> +            reg = <0x48032000 0x80>;
>> +            interrupts = <0 38 0x4>;
>> +            ti,hwmods = "timer2";
>> +        };
>> +
>> +        timer3: timer@48034000 {
>> +            compatible = "ti,omap5430-timer";
>> +            reg = <0x48034000 0x80>;
>> +            interrupts = <0 39 0x4>;
>> +            ti,hwmods = "timer3";
>> +        };
>> +
>> +        timer4: timer@48036000 {
>> +            compatible = "ti,omap5430-timer";
>> +            reg = <0x48036000 0x80>;
>> +            interrupts = <0 40 0x4>;
>> +            ti,hwmods = "timer4";
>> +        };
>> +
>> +        timer5: timer@48820000 {
>> +            compatible = "ti,omap5430-timer";
>> +            reg = <0x48820000 0x80>;
>> +            interrupts = <0 41 0x4>;
>> +            ti,hwmods = "timer5";
>> +            ti,timer-dsp;
>> +        };
>> +
>> +        timer6: timer@48822000 {
>> +            compatible = "ti,omap5430-timer";
>> +            reg = <0x48822000 0x80>;
>> +            interrupts = <0 42 0x4>;
>> +            ti,hwmods = "timer6";
>> +            ti,timer-dsp;
>> +            ti,timer-pwm;
>> +        };
>> +
>> +        timer7: timer@48824000 {
>> +            compatible = "ti,omap5430-timer";
>> +            reg = <0x48824000 0x80>;
>> +            interrupts = <0 43 0x4>;
>> +            ti,hwmods = "timer7";
>> +            ti,timer-dsp;
>> +        };
>> +
>> +        timer8: timer@48826000 {
>> +            compatible = "ti,omap5430-timer";
>> +            reg = <0x48826000 0x80>;
>> +            interrupts = <0 44 0x4>;
>> +            ti,hwmods = "timer8";
>> +            ti,timer-dsp;
>> +            ti,timer-pwm;
>> +        };
>> +
>> +        timer9: timer@4803e000 {
>> +            compatible = "ti,omap5430-timer";
>> +            reg = <0x4803e000 0x80>;
>> +            interrupts = <0 45 0x4>;
>> +            ti,hwmods = "timer9";
>> +        };
>> +
>> +        timer10: timer@48086000 {
>> +            compatible = "ti,omap5430-timer";
>> +            reg = <0x48086000 0x80>;
>> +            interrupts = <0 46 0x4>;
>> +            ti,hwmods = "timer10";
>> +        };
>> +
>> +        timer11: timer@48088000 {
>> +            compatible = "ti,omap5430-timer";
>> +            reg = <0x48088000 0x80>;
>> +            interrupts = <0 47 0x4>;
>> +            ti,hwmods = "timer11";
>> +            ti,timer-pwm;
>> +        };
>> +
>> +        wdt2: wdt@4ae14000 {
>> +            compatible = "ti,omap4-wdt";
>> +            reg = <0x4ae14000 0x80>;
>> +            interrupts = <0 80 0x4>;
>> +            ti,hwmods = "wd_timer2";
>> +        };
>> +
>> +        i2c1: i2c@48070000 {
>> +            compatible = "ti,omap4-i2c";
>> +            reg = <0x48070000 0x100>;
>> +            interrupts = <0 56 0x4>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            ti,hwmods = "i2c1";
>> +        };
>> +
>> +        i2c2: i2c@48072000 {
>> +            compatible = "ti,omap4-i2c";
>> +            reg = <0x48072000 0x100>;
>> +            interrupts = <0 57 0x4>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            ti,hwmods = "i2c2";
>> +        };
>> +
>> +        i2c3: i2c@48060000 {
>> +            compatible = "ti,omap4-i2c";
>> +            reg = <0x48060000 0x100>;
>> +            interrupts = <0 61 0x4>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            ti,hwmods = "i2c3";
>> +        };
>> +
>> +        i2c4: i2c@4807a000 {
>> +            compatible = "ti,omap4-i2c";
>> +            reg = <0x4807a000 0x100>;
>> +            interrupts = <0 62 0x4>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            ti,hwmods = "i2c4";
>> +        };
>> +
>> +        i2c5: i2c@4807c000 {
>> +            compatible = "ti,omap4-i2c";
>> +            reg = <0x4807c000 0x100>;
>> +            interrupts = <0 60 0x4>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            ti,hwmods = "i2c5";
>> +        };
>> +
>> +        mmc1: mmc@4809c000 {
>> +            compatible = "ti,omap4-hsmmc";
>> +            reg = <0x4809c000 0x400>;
>> +            interrupts = <0 83 0x4>;
>> +            ti,hwmods = "mmc1";
>> +            ti,dual-volt;
>> +            ti,needs-special-reset;
>> +            dmas = <&sdma 61>, <&sdma 62>;
>> +            dma-names = "tx", "rx";
>> +        };
>> +
>> +        mmc2: mmc@480b4000 {
>> +            compatible = "ti,omap4-hsmmc";
>> +            reg = <0x480b4000 0x400>;
>> +            interrupts = <0 86 0x4>;
>> +            ti,hwmods = "mmc2";
>> +            ti,needs-special-reset;
>> +            dmas = <&sdma 47>, <&sdma 48>;
>> +            dma-names = "tx", "rx";
>> +        };
>> +
>> +        mmc3: mmc@480ad000 {
>> +            compatible = "ti,omap4-hsmmc";
>> +            reg = <0x480ad000 0x400>;
>> +            interrupts = <0 94 0x4>;
>> +            ti,hwmods = "mmc3";
>> +            ti,needs-special-reset;
>> +            dmas = <&sdma 77>, <&sdma 78>;
>> +            dma-names = "tx", "rx";
>> +        };
>> +
>> +        mmc4: mmc@480d1000 {
>> +            compatible = "ti,omap4-hsmmc";
>> +            reg = <0x480d1000 0x400>;
>> +            interrupts = <0 96 0x4>;
>> +            ti,hwmods = "mmc4";
>> +            ti,needs-special-reset;
>> +            dmas = <&sdma 57>, <&sdma 58>;
>> +            dma-names = "tx", "rx";
>> +        };
>> +
>> +        mcspi1: spi@48098000 {
>> +            compatible = "ti,omap4-mcspi";
>> +            reg = <0x48098000 0x200>;
>> +            interrupts = <0 65 0x4>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            ti,hwmods = "mcspi1";
>> +            ti,spi-num-cs = <4>;
>> +            dmas = <&sdma 35>,
>> +                   <&sdma 36>,
>> +                   <&sdma 37>,
>> +                   <&sdma 38>,
>> +                   <&sdma 39>,
>> +                   <&sdma 40>,
>> +                   <&sdma 41>,
>> +                   <&sdma 42>;
>> +            dma-names = "tx0", "rx0", "tx1", "rx1",
>> +                    "tx2", "rx2", "tx3", "rx3";
>> +        };
>> +
>> +        mcspi2: spi@4809a000 {
>> +            compatible = "ti,omap4-mcspi";
>> +            reg = <0x4809a000 0x200>;
>> +            interrupts = <0 66 0x4>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            ti,hwmods = "mcspi2";
>> +            ti,spi-num-cs = <2>;
>> +            dmas = <&sdma 43>,
>> +                   <&sdma 44>,
>> +                   <&sdma 45>,
>> +                   <&sdma 46>;
>> +            dma-names = "tx0", "rx0", "tx1", "rx1";
>> +        };
>> +
>> +        mcspi3: spi@480b8000 {
>> +            compatible = "ti,omap4-mcspi";
>> +            reg = <0x480b8000 0x200>;
>> +            interrupts = <0 91 0x4>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            ti,hwmods = "mcspi3";
>> +            ti,spi-num-cs = <2>;
>> +            dmas = <&sdma 15>, <&sdma 16>;
>> +            dma-names = "tx0", "rx0";
>> +        };
>> +
>> +        mcspi4: spi@480ba000 {
>> +            compatible = "ti,omap4-mcspi";
>> +            reg = <0x480ba000 0x200>;
>> +            interrupts = <0 48 0x4>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            ti,hwmods = "mcspi4";
>> +            ti,spi-num-cs = <1>;
>> +            dmas = <&sdma 70>, <&sdma 71>;
>> +            dma-names = "tx0", "rx0";
>> +        };
>> +    };
>> +};
>>
> ref: [1], we discussed that we should now be able to introduce all instances of h/w blocks into the dra7.dts. Further, considering [2]

hmm, thats a long discussion on crossbar driver that [1] points to. Do you want to summarize what you mean by 'introduce all instances of h/w blocks'

> would you not want to follow "status = disabled" for all modules by default and enable required modules in board file, so that we dont have to respin this yet again?

Well, I was just following the convention of whats already followed on existing OMAPs. See [3] for some views on these.

> 
> 
> [1] http://marc.info/?t=137416599400001&r=1&w=2
> [2] http://marc.info/?l=linux-omap&m=137510358229479&w=2
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/086297.html
