From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: am335x: system doesn't reboot after flashing NAND
Date: Wed, 4 Jun 2014 14:32:01 +0200
Message-ID: <CAGm1_ks-oAtTzOaaV9WTk13tibK20uKigGCJ22H=0qz7edHeRw@mail.gmail.com>
References: <CAGm1_kstgCEQRuaz836v7xg=DHVxpQ6VQPBzkORz1D=18fxp8w@mail.gmail.com>
 <CAGm1_kv7EmQ1MaXL0nhQcPZp53DjBLfdnTqFit9e0FT1J8zzug@mail.gmail.com>
 <538EBF54.7080709@ti.com> <CAGm1_ktWxQFQ0jWjn7A2NO8nPayY9S2McPrKHWbGRtkw1751ig@mail.gmail.com>
 <538EDD77.8070807@ti.com> <CAGm1_kt7BZ7RcbPd51QXhXxQV4SRzeXLzKW43wqK5UnPbYoHBw@mail.gmail.com>
 <538EF2EF.4050709@ti.com> <CAGm1_ksofkCNB1R9kg6L9FBFFPoE=62AZ1Vid4_n7DEu1oi4GQ@mail.gmail.com>
 <538EFA70.4040102@ti.com> <20980858CB6D3A4BAE95CA194937D5E73EAF2B9B@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:43092 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbaFDMcW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jun 2014 08:32:22 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp16so6949509pbb.34
        for <linux-omap@vger.kernel.org>; Wed, 04 Jun 2014 05:32:21 -0700 (PDT)
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAF2B9B@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "Nori, Sekhar" <nsekhar@ti.com>, "Quadros, Roger" <rogerq@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jun 4, 2014 at 1:49 PM, Gupta, Pekon <pekon@ti.com> wrote:
>>On Wednesday 04 June 2014 04:00 PM, Yegor Yefremov wrote:
> [...]
>
>>>> The way ROM works for XIP boot is:
>>>>
>>>> 1) Set chip select 0 base address to 0x0800'0000
>>>> 2) Read memory at 0x0800'0000
>>>> 3) If something else other than 0x0 or ~0x0 is found, jump to
>>>> 0x0800'0000 and start executing.
>>>>
>>>> Can you check to see the contents of 0x0800'0000 before and after nand
>>>> write using mtdblock?
>>>
>>> Before writing:
>>>
>>> # devmem 0x08000000 32
>>> 0xFFFFFFFF
>>>
>>> After writing:
>>>
>>> # devmem 0x08000000 32
>>> 0xE0E0E0E0
>>
>>Okay, so this is the cause of failure to boot. I am not sure what
>>operation by NAND driver causes this value to change. Perhaps you could
>>bisect a bit by dumping this address at various points during the write
>>operation?
>>
>>If you have a debugger it will become easy to do this.
>>
> I'm not sure, if a NAND device is connected as CS0 how is ROM code
> detecting it as NOR and proceeding for an XIP read.
> As its mentioned in XIP boot process in AM335x TRM that if an invalid
> boot image is found then ROM code falls back to next boot device
> which is in this case MMC boot. A hung code here mean
> - XIP boot is not failing OR
> - ROM code is waiting on GPMC_WAIT0 pin a part of XIP read access.
> So please check if the GPMC:
>
> (1) This may happen because GPMC pins are shared for both NOR and
>    NAND so plz check conflicting pins as given in
>   AM335x TRM: Table 26-9. Pins Used for Non-Muxed NOR Boot
> (Please see that GPMC_WAIT0 and GPMC_WAIT1 are pulled high on the board)

The system has only 8-bit NAND

        nandflash_pins_s0: nandflash_pins_s0 {
                pinctrl-single,pins = <
                        0x0 (PIN_INPUT_PULLUP | MUX_MODE0)      /*
gpmc_ad0.gpmc_ad0 */
                        0x4 (PIN_INPUT_PULLUP | MUX_MODE0)      /*
gpmc_ad1.gpmc_ad1 */
                        0x8 (PIN_INPUT_PULLUP | MUX_MODE0)      /*
gpmc_ad2.gpmc_ad2 */
                        0xc (PIN_INPUT_PULLUP | MUX_MODE0)      /*
gpmc_ad3.gpmc_ad3 */
                        0x10 (PIN_INPUT_PULLUP | MUX_MODE0)     /*
gpmc_ad4.gpmc_ad4 */
                        0x14 (PIN_INPUT_PULLUP | MUX_MODE0)     /*
gpmc_ad5.gpmc_ad5 */
                        0x18 (PIN_INPUT_PULLUP | MUX_MODE0)     /*
gpmc_ad6.gpmc_ad6 */
                        0x1c (PIN_INPUT_PULLUP | MUX_MODE0)     /*
gpmc_ad7.gpmc_ad7 */
                        0x70 (PIN_INPUT_PULLUP | MUX_MODE0)     /*
gpmc_wait0.gpmc_wait0 */
                        0x74 (PIN_INPUT_PULLUP | MUX_MODE0)     /*
gpmc_wpn.gpmc_wpn */
                        0x7c (PIN_OUTPUT | MUX_MODE0)           /*
gpmc_csn0.gpmc_csn0  */
                        0x90 (PIN_OUTPUT | MUX_MODE0)           /*
gpmc_advn_ale.gpmc_advn_ale */
                        0x94 (PIN_OUTPUT | MUX_MODE0)           /*
gpmc_oen_ren.gpmc_oen_ren */
                        0x98 (PIN_OUTPUT | MUX_MODE0)           /*
gpmc_wen.gpmc_wen */
                        0x9c (PIN_OUTPUT | MUX_MODE0)           /*
gpmc_be0n_cle.gpmc_be0n_cle */
                >;
&elm {
        status = "okay";
};

&gpmc {
        pinctrl-names = "default";
        pinctrl-0 = <&nandflash_pins_s0>;
        ranges = <0 0 0x08000000 0x10000000>;   /* CS0: NAND */
        status = "okay";

        nand@0,0 {
                reg = <0 0 0>; /* CS0, offset 0 */
                nand-bus-width = <8>;
                ti,nand-ecc-opt = "bch8";
                ti,nand-xfer-type = "polled";

                gpmc,device-nand = "true";
                gpmc,device-width = <1>;
                gpmc,sync-clk-ps = <0>;
                gpmc,cs-on-ns = <0>;
                gpmc,cs-rd-off-ns = <44>;
                gpmc,cs-wr-off-ns = <44>;
                gpmc,adv-on-ns = <6>;
                gpmc,adv-rd-off-ns = <34>;
                gpmc,adv-wr-off-ns = <44>;
                gpmc,we-on-ns = <0>;
                gpmc,we-off-ns = <40>;
                gpmc,oe-on-ns = <0>;
                gpmc,oe-off-ns = <54>;
                gpmc,access-ns = <64>;
                gpmc,rd-cycle-ns = <82>;
                gpmc,wr-cycle-ns = <82>;
                gpmc,wait-on-read = "true";
                gpmc,wait-on-write = "true";
                gpmc,bus-turnaround-ns = <0>;
                gpmc,cycle2cycle-delay-ns = <0>;
                gpmc,clk-activation-ns = <0>;
                gpmc,wait-monitoring-ns = <0>;
                gpmc,wr-access-ns = <40>;
                gpmc,wr-data-mux-bus-ns = <0>;

                #address-cells = <1>;
                #size-cells = <1>;
                elm_id = <&elm>;

                /* MTD partition table */
                partition@0 {
                       label = "MLO";
                        reg = <0x00000000 0x000020000>;
                };

                partition@1 {
                        label = "U-boot";
                        reg = <0x00020000 0x001e0000>;
                };

                partition@2 {
                        label = "DTB";
                        reg = <0x00200000 0x000020000>;
                };

                partition@3 {
                        label = "environment";
                        reg = <0x00220000 0x000020000>;
                };

                partition@4 {
                        label = "Kernel";
                        reg = <0x00240000 0x00600000>;
                };

                partition@5 {
                        label = "File-System";
                        reg = <0x00840000 0x0C360000>;
                };
        };
};

GPMC_WAIT0 has a pull-up and when I measured it, the signal was high i.e. ready.

> (2) Some SYSBOOT configuration might also be confusing ROM code.
>  If you are using x8 NAND device, then please try with setting
>  SYSBOOT[8] = 1
>  SYSBOOT[11: 10] == 01 or 11 (reserved values)
>  This should fail XIP boot and make the ROM code fall back
>  to next boot device which is MMC in this case.

The stuff is soldered. I'll see, what I can do.

Yegor
