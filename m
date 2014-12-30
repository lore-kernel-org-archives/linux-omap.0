From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: Re: [PATCH v2] ARM: dts: cm-t3x: add NAND support
Date: Tue, 30 Dec 2014 09:39:02 +0200
Message-ID: <54A25696.80608@compulab.co.il>
References: <54A00BD6.8010507@compulab.co.il> <1419777049-25271-1-git-send-email-lifshitz@compulab.co.il> <54A151F2.9010904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:48373 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbaL3Hj3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Dec 2014 02:39:29 -0500
In-Reply-To: <54A151F2.9010904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il

Hi Roger,

On 12/29/2014 03:06 PM, Roger Quadros wrote:
> Hi Dmitry,
>
> On 28/12/14 16:30, Dmitry Lifshitz wrote:
>> CM-T3517, CM-T3530 and CM-T3730 features NAND storage chip connected to
>> GPMC bus.
>>
>> Add GPMC DT entry into the root DT file omap3-cm-t3x.dtsi, common for
>> all three modules.
>>
>> NAND timings are calculated to be safe for CM-T3x devices as it works
>> now in non DT boot (in this case the timings are updated by U-Boot).
>
> I didn't get this part. You provide the GPMC timings in the DT now so they will override
> u-boot configured timings.
>

In the board files for CM-T3x modules we did not override NAND timings 
configured in U-Boot. Now, with DT boot, we do not want to rely on boot 
loader settings wherever is possible. So, we specify the timings 
explicitly.

In order to avoid regression, the timings setup is the same as we do in 
U-Boot.

>>
>> Update GPMC ranges in boards DT files to include all connected devices.
>>
>> Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
>> ---
>>
>> v2 * Update GPMC ranges with NAND values in omap3-cm-t3x30.dtsi.
>>     * Add commit message details
>>
>>   arch/arm/boot/dts/omap3-cm-t3x.dtsi   |   58 +++++++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/omap3-cm-t3x30.dtsi |    3 +-
>>   arch/arm/boot/dts/omap3-sbc-t3517.dts |    4 ++
>>   arch/arm/boot/dts/omap3-sbc-t3530.dts |   10 ++----
>>   arch/arm/boot/dts/omap3-sbc-t3730.dts |    5 ++-
>>   5 files changed, 70 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
>> index 6ea6d46..4d091ca 100644
>> --- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
>> +++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
>> @@ -259,3 +259,61 @@
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&mcbsp2_pins>;
>>   };
>> +
>> +&gpmc {
>> +	ranges = <0 0 0x00000000 0x01000000>;
>
> Isn't this ranges property redundant as it will be overridden by the board specific dts?
>
>> +
>> +	nand@0,0 {
>> +		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
>> +		nand-bus-width = <8>;
>> +		gpmc,device-width = <1>;
>> +		ti,nand-ecc-opt = "sw";
>
> any particular reason for sticking with "sw"? Isn't it better to use at least "ham1"
> or migrate to stronger schemes like "bch4" or "bch8"?
>
> "ham1" scheme is compatible with ROM loader so the boot partition could be flashed from Linux.
> For bch4/8 you will have to keep boot partition/s locked from Linux access as we don't yet
> support mixed ECC schemes among partitions.
>

The regression issue should be considered here. Our customers have 
thousands of boards running rootfs with "sw" ecc. Updating the kernel is 
not a reason for reformatting the NAND.

>> +
>> +		gpmc,cs-on-ns = <0>;
>> +		gpmc,cs-rd-off-ns = <120>;
>> +		gpmc,cs-wr-off-ns = <120>;
>> +
>> +		gpmc,adv-on-ns = <0>;
>> +		gpmc,adv-rd-off-ns = <120>;
>> +		gpmc,adv-wr-off-ns = <120>;
>> +
>> +		gpmc,we-on-ns = <6>;
>> +		gpmc,we-off-ns = <90>;
>> +
>> +		gpmc,oe-on-ns = <6>;
>> +		gpmc,oe-off-ns = <90>;
>> +
>> +		gpmc,page-burst-access-ns = <6>;
>> +		gpmc,access-ns = <72>;
>> +		gpmc,cycle2cycle-delay-ns = <60>;
>> +
>> +		gpmc,rd-cycle-ns = <120>;
>> +		gpmc,wr-cycle-ns = <120>;
>> +		gpmc,wr-access-ns = <186>;
>> +		gpmc,wr-data-mux-bus-ns = <90>;
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +		partition@0 {
>> +			label = "xloader";
>> +			reg = <0 0x80000>;
>> +		};
>> +		partition@0x80000 {
>> +			label = "uboot";
>> +			reg = <0x80000 0x1e0000>;
>> +		};
>> +		partition@0x260000 {
>> +			label = "uboot environment";
>> +			reg = <0x260000 0x40000>;
>> +		};
>> +		partition@0x2a0000 {
>> +			label = "linux";
>> +			reg = <0x2a0000 0x400000>;
>> +		};
>> +		partition@0x6a0000 {
>> +			label = "rootfs";
>> +			reg = <0x6a0000 0x1f880000>;
>> +		};
>> +	};
>> +};
>> diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
>> index 9a4a3ab..d9e92b6 100644
>> --- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
>> +++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
>> @@ -50,7 +50,8 @@
>>   #include "omap-gpmc-smsc911x.dtsi"
>>
>>   &gpmc {
>> -	ranges = <5 0 0x2c000000 0x01000000>;
>> +	ranges = <5 0 0x2c000000 0x01000000>, /* CM-T3x30 SMSC9x Eth */
>> +		 <0 0 0x00000000 0x01000000>; /* CM-T3x NAND */
>
> Isn't this ranges property redundant as it will anyways be overridden by the board specific dts?
>

The ranges are specified here (and other files below) by design.

We built a tree like structure to organize DT files -
d234e4239 "ARM: dts: sbc-t3x: refactor DT support"

It allows to inherit/override properties common for different boards.

Our customers do not have to deal with a correct GPMC ranges settings, 
once they base on omap3-cm-t3x.dts core module DT file (in case they do 
not connect additional device to the bus).

This is the point of Igor's comment to the previous patch version.

>>
>>   	smsc1: ethernet@gpmc {
>>   		compatible = "smsc,lan9221", "smsc,lan9115";
>> diff --git a/arch/arm/boot/dts/omap3-sbc-t3517.dts b/arch/arm/boot/dts/omap3-sbc-t3517.dts
>> index 1798653..c2d5c28 100644
>> --- a/arch/arm/boot/dts/omap3-sbc-t3517.dts
>> +++ b/arch/arm/boot/dts/omap3-sbc-t3517.dts
>> @@ -69,3 +69,7 @@
>>   	};
>>   };
>>
>> +&gpmc {
>> +	ranges = <4 0 0x2d000000 0x01000000>,	/* SB-T35 SMSC9x Eth */
>> +		 <0 0 0x00000000 0x01000000>;	/* CM-T3x NAND */
>> +};
>> diff --git a/arch/arm/boot/dts/omap3-sbc-t3530.dts b/arch/arm/boot/dts/omap3-sbc-t3530.dts
>> index c994f0f..834bc78 100644
>> --- a/arch/arm/boot/dts/omap3-sbc-t3530.dts
>> +++ b/arch/arm/boot/dts/omap3-sbc-t3530.dts
>> @@ -26,14 +26,10 @@
>>   	};
>>   };
>>
>> -/*
>> - * The following ranges correspond to SMSC9x eth chips on CM-T3530 CoM and
>> - * SB-T35 baseboard respectively.
>> - * This setting includes both chips in SBC-T3530 board device tree.
>> - */
>>   &gpmc {
>> -	ranges = <5 0 0x2c000000 0x01000000>,
>> -		 <4 0 0x2d000000 0x01000000>;
>> +	ranges = <5 0 0x2c000000 0x01000000>,	/* CM-T3x30 SMSC9x Eth */
>> +		 <4 0 0x2d000000 0x01000000>,	/* SB-T35 SMSC9x Eth */
>> +		 <0 0 0x00000000 0x01000000>;	/* CM-T3x NAND */
>>   };
>>
>>   &mmc1 {
>> diff --git a/arch/arm/boot/dts/omap3-sbc-t3730.dts b/arch/arm/boot/dts/omap3-sbc-t3730.dts
>> index 5bdddf2..73c7bf4 100644
>> --- a/arch/arm/boot/dts/omap3-sbc-t3730.dts
>> +++ b/arch/arm/boot/dts/omap3-sbc-t3730.dts
>> @@ -27,8 +27,9 @@
>>   };
>>
>>   &gpmc {
>> -	ranges = <5 0 0x2c000000 0x01000000>,
>> -		 <4 0 0x2d000000 0x01000000>;
>> +	ranges = <5 0 0x2c000000 0x01000000>,	/* CM-T3x30 SMSC9x Eth */
>> +		 <4 0 0x2d000000 0x01000000>,	/* SB-T35 SMSC9x Eth */
>> +		 <0 0 0x00000000 0x01000000>;	/* CM-T3x NAND */
>>   };
>>
>>   &dss {
>>
>
> cheers,
> -roger
>
>
>


Thanks,

Dmitry

