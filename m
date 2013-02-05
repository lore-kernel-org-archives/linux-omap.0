From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: DT GPMC SRAM and NOR flash support ?
Date: Tue, 05 Feb 2013 16:48:15 +0000
Message-ID: <511137CF.1090706@mimc.co.uk>
References: <510BF3D3.3000304@mimc.co.uk> <510BF766.5090608@ti.com> <510C19FC.8090906@mimc.co.uk> <5111304C.7090706@mimc.co.uk> <511134C8.8000008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:37307 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754083Ab3BEQsR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 11:48:17 -0500
In-Reply-To: <511134C8.8000008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Afzal Mohammed <afzal@ti.com>

On 05/02/13 16:35, Jon Hunter wrote:
> 
> On 02/05/2013 10:16 AM, Mark Jackson wrote:
>> On 01/02/13 19:39, Mark Jackson wrote:
>>> On 01/02/13 17:12, Jon Hunter wrote:
>>>> Hi Mark,
>>>>
>>>> On 02/01/2013 10:56 AM, Mark Jackson wrote:
>>>>> There's plenty of DT support going in for NAND flash, but is there any work going on to support NOR
>>>>> flash ?
>>>>
>>>> What board and device are you working that is using NOR? I have a
>>>> OMAP2420 H4 with NOR that I have been doing a bit of maintenance for but
>>>> I don't spend much time on it. Eventually it will have to be done but it
>>>> is always good to know if there is a pressing need.
>>>
>>> We have a custom AM335x CPU board (arriving on my desk within the next few weeks) that has both NAND
>>> and NOR Flash.
>>>
>>>>> And how about SRAM chips or other memory mapped devices ?
>>>>
>>>> Not sure about SRAM (trying to think if I have a board with SRAM even),
>>>> but definitely, boards using the GPMC to interface to ethernet chips
>>>> need to be added.
>>>
>>> The board also contains an FRAM chip (which is just treated as SRAM).
>>>
>>> If you'd anything in the pipeline, I'm glad to help in any testing. I've created a custom cape board
>>> for the BeagleBone which contains the NOR flash and FRAM chips, so I'm not waiting for the new
>>> hardware to arrive.
> 
> Sorry for the delay. I personally don't have anything in the pipe.
> 
> Afzal, do you know of anyone looking at this?
> 
>> I've experimented with trying to add a mtd-physmap device, but no joy.
>>
>> I'm guessing that the current mtd-physmap code is (in some way) currently incompatible with the GPMC
>> device ?
> 
> I am not familiar with mtd-physmap to comment. Is that DT specific?

Well, it's documented in Documentation/devicetree/bindings/mtd/mtd-physmap.txt, showing you can
specify "cfi-flash" or "mtd-ram" devices, eg (taken from mtd-physmap.txt):-

	flash@ff000000 {
		compatible = "amd,am29lv128ml", "cfi-flash";
		reg = <ff000000 01000000>;
		bank-width = <4>;
		device-width = <1>;
		#address-cells = <1>;
		#size-cells = <1>;
		fs@0 {
			label = "fs";
			reg = <0 f80000>;
		};
		firmware@f80000 {
			label ="firmware";
			reg = <f80000 80000>;
			read-only;
		};
	};

	sram@2,0 {
		compatible = "samsung,k6f1616u6a", "mtd-ram";
		reg = <2 0 0x00200000>;
		bank-width = <2>;
	};

But I guess the GPMC needs to be configured to enable chip selects, data widths, etc.

I did get *something* on the address / data bus by adding the patches below, but I'm getting bus
contention, so something else needs setting up in the GPMC.

I'm no great device driver writer, but if anyone can give me some pointers, I'm happy to keep digging.

Cheers
Mark J.

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index a37e1c9..8f45d18 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1265,10 +1265,13 @@ static int gpmc_probe_dt(struct platform_device *pdev)
        struct device_node *child;
        const struct of_device_id *of_id =
                of_match_device(gpmc_dt_ids, &pdev->dev);
+       unsigned long base;

        if (!of_id)
                return 0;

+       gpmc_cs_request(0, SZ_16M, &base);
+
        for_each_node_by_name(child, "nand") {
                ret = gpmc_probe_nand_child(pdev, child);
                of_node_put(child);
diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 11b240c..ad89446 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -26,7 +26,7 @@

        am33xx_pinmux: pinmux@44e10800 {
                pinctrl-names = "default";
-               pinctrl-0 = <&user_leds_s0>;
+               pinctrl-0 = <&user_leds_s0 &gpmc_pins_s0>;

                user_leds_s0: user_leds_s0 {
                        pinctrl-single,pins = <
@@ -36,6 +36,49 @@
                                0x60 0x17       /* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
                        >;
                };
+
+               gpmc_pins_s0: gpmc_pins_s0 {
+                       pinctrl-single,pins = <
+                               0x0 0x30        /* gpmc_ad0.gpmc_ad0, INPUT | PULLUP | MODE0 */
+                               0x4 0x30        /* gpmc_ad1.gpmc_ad1, INPUT | PULLUP | MODE0 */
+                               0x8 0x30        /* gpmc_ad2.gpmc_ad2, INPUT | PULLUP | MODE0 */
+                               0xc 0x30        /* gpmc_ad3.gpmc_ad3, INPUT | PULLUP | MODE0 */
+                               0x10 0x30       /* gpmc_ad4.gpmc_ad4, INPUT | PULLUP | MODE0 */
+                               0x14 0x30       /* gpmc_ad5.gpmc_ad5, INPUT | PULLUP | MODE0 */
+                               0x18 0x30       /* gpmc_ad6.gpmc_ad6, INPUT | PULLUP | MODE0 */
+                               0x1c 0x30       /* gpmc_ad7.gpmc_ad7, INPUT | PULLUP | MODE0 */
+                               0x20 0x30       /* gpmc_ad8.gpmc_ad8, INPUT | PULLUP | MODE0 */
+                               0x24 0x30       /* gpmc_ad9.gpmc_ad9, INPUT | PULLUP | MODE0 */
+                               0x28 0x30       /* gpmc_ad10.gpmc_ad10, INPUT | PULLUP | MODE0 */
+                               0x2c 0x30       /* gpmc_ad11.gpmc_ad11, INPUT | PULLUP | MODE0 */
+                               0x30 0x30       /* gpmc_ad12.gpmc_ad12, INPUT | PULLUP | MODE0 */
+                               0x34 0x30       /* gpmc_ad13.gpmc_ad13, INPUT | PULLUP | MODE0 */
+                               0x38 0x30       /* gpmc_ad14.gpmc_ad14, INPUT | PULLUP | MODE0 */
+                               0x3c 0x30       /* gpmc_ad15.gpmc_ad15, INPUT | PULLUP | MODE0 */
+
+                               0x7c 0x10       /* gpmc_csn0.gpmc_csn0, OUTPUT_PULLUP | MODE0 */
+                               0x80 0x10       /* gpmc_csn1.gpmc_csn1, OUTPUT_PULLUP | MODE0 */
+                               0x84 0x10       /* gpmc_csn2.gpmc_csn2, OUTPUT_PULLUP | MODE0 */
+                               0x88 0x10       /* gpmc_csn3.gpmc_csn3, OUTPUT_PULLUP | MODE0 */
+
+                               0x90 0x10       /* gpmc_advn_ale.gpmc_advn_ale, OUTPUT_PULLUP | MODE0 */
+                               0x94 0x10       /* gpmc_oen_ren.gpmc_oen_ren, OUTPUT_PULLUP | MODE0 */
+                               0x98 0x10       /* gpmc_wen.gpmc_wen, OUTPUT_PULLUP | MODE0 */
+                               0x9c 0x10       /* gpmc_ben0_cle.gpmc_ben0_cle, OUTPUT_PULLUP | MODE0 */
+
+                               0xa4 0x11       /* lcd_data1.gpmc_a1, OUTPUT_PULLUP | MODE1 */
+                               0xa8 0x11       /* lcd_data2.gpmc_a2, OUTPUT_PULLUP | MODE1 */
+                               0xac 0x11       /* lcd_data3.gpmc_a3, OUTPUT_PULLUP | MODE1 */
+                               0xb0 0x11       /* lcd_data4.gpmc_a4, OUTPUT_PULLUP | MODE1 */
+                               0xb4 0x11       /* lcd_data5.gpmc_a5, OUTPUT_PULLUP | MODE1 */
+                               0xb8 0x11       /* lcd_data6.gpmc_a6, OUTPUT_PULLUP | MODE1 */
+                               0xbc 0x11       /* lcd_data7.gpmc_a7, OUTPUT_PULLUP | MODE1 */
+
+                               0xe0 0x11       /* lcd_vsync.gpmc_a8, OUTPUT_PULLUP | MODE1 */
+                               0xe4 0x11       /* lcd_hsync.gpmc_a9, OUTPUT_PULLUP | MODE1 */
+                               0xe8 0x11       /* lcd_pclk.gpmc_a10, OUTPUT_PULLUP | MODE1 */
+                       >;
+               };
        };

        ocp {
@@ -50,7 +93,15 @@
                        tps: tps@24 {
                                reg = <0x24>;
                        };
+               };

+               elm: elm@48080000 {
+                       status = "okay";
+               };
+
+               gpmc: gpmc@50000000 {
+                       status = "okay";
+                       ranges = <0 0 0x08000000 0x08000000>;   /* CS0: NOR 16M */
                };
        };

