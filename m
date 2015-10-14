From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH v3 20/27] ARM: dts: dra7: Fix NAND device nodes.
Date: Wed, 14 Oct 2015 09:37:18 -0500
Message-ID: <561E689E.70104@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <1442588029-13769-21-git-send-email-rogerq@ti.com> <561E59F0.8080906@ti.com>
 <561E6413.2060607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561E6413.2060607@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org



On 10/14/2015 09:17 AM, Roger Quadros wrote:
> On 14/10/15 16:34, Franklin S Cooper Jr. wrote:
>>
>> On 09/18/2015 09:53 AM, Roger Quadros wrote:
>>> Add compatible id, GPMC register resource and interrupt
>>> resource to NAND controller nodes.
>>>
>>> The GPMC driver now implements gpiochip and irqchip so
>>> enable gpio-controller and interrupt-controller properties.
>>>
>>> With this the interrupt parent of NAND node changes so fix it
>>> accordingly.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>  arch/arm/boot/dts/dra7-evm.dts  | 5 ++++-
>>>  arch/arm/boot/dts/dra7.dtsi     | 4 ++++
>>>  arch/arm/boot/dts/dra72-evm.dts | 5 ++++-
>>>  3 files changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
>>> index a6c82e5..8a31161 100644
>>> --- a/arch/arm/boot/dts/dra7-evm.dts
>>> +++ b/arch/arm/boot/dts/dra7-evm.dts
>>> @@ -585,9 +585,12 @@
>>>  	status = "okay";
>>>  	pinctrl-names = "default";
>>>  	pinctrl-0 = <&nand_flash_x16>;
>>> -	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
>>> +	ranges = <0 0 0x08000000 0x01000000>;	/* minimum GPMC partition = 16MB */
>>>  	nand@0,0 {
>>> +		compatible = "ti,omap2-nand";
>>>  		reg = <0 0 4>;		/* device IO registers */
>>> +		interrupt-parent = <&crossbar_mpu>;
>>> +		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
>>>  		ti,nand-ecc-opt = "bch8";
>>>  		ti,elm-id = <&elm>;
>>>  		nand-bus-width = <16>;
>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>>> index 5d65db9..f0a3616 100644
>>> --- a/arch/arm/boot/dts/dra7.dtsi
>>> +++ b/arch/arm/boot/dts/dra7.dtsi
>>> @@ -1389,6 +1389,10 @@
>>>  			gpmc,num-waitpins = <2>;
>>>  			#address-cells = <2>;
>>>  			#size-cells = <1>;
>>> +			gpio-controller;
>>> +			#gpio-cells = <2>;
>>> +			interrupt-controller;
>>> +			#interrupt-cells = <2>;
>>>  			status = "disabled";
>>>  		};
>> Based on the discussion on my patchset I noticed that the nand node defines the
>> interrupt but it is also defined in the parent node. Similar to the dma channel we
>> should conclude where the best place for it to be defined.  But to me it seems at
>> least it should only be defined once.
> The interrupt is defined at both places because it is used at both places.
> It is used as a shared interrupt. Wait_pin interrupts are managed by the
> gpmc driver and NAND specific interrupts are managed by the NAND driver.
>
> If GPMC dma channel is going to be used only by the NAND driver then
> we should define the channel in the NAND node.
>
>> This is true for your other patches making similar changes to the dt.
> Yes, GPMC IRQ is defined in both GPMC and NAND nodes.
Ok. I would still think you would just reuse the entry from the
parent since you know it will always be the same. But we can
go with what Tony thinks is best.
>
> --
> cheers,
> -roger
