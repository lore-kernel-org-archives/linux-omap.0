From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH v3 3/4] arm/dts: AM33XX: Configure pinmuxs for D_CAN1
 on AM335x-EVM
Date: Tue, 28 Aug 2012 11:51:32 +0530
Message-ID: <503C636C.6080708@ti.com>
References: <1345119610-5247-1-git-send-email-anilkumar@ti.com> <1345119610-5247-4-git-send-email-anilkumar@ti.com> <20120824201447.GY11011@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58821 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713Ab2H1GVy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Aug 2012 02:21:54 -0400
In-Reply-To: <20120824201447.GY11011@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: AnilKumar Ch <anilkumar@ti.com>, devicetree-discuss@lists.ozlabs.org, mkl@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 8/25/2012 1:44 AM, Tony Lindgren wrote:
> * AnilKumar Ch <anilkumar@ti.com> [120816 05:20]:
>> Add D_CAN1 pinctrl node to am3358_pinmux master node to export
>> D_CAN functionality on AM335x EVM according to pinctrl-single
>> driver.
>>
>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>> ---
>> Changes from v2:
>> 	- Incorporated Vaibhav H's comments on v2
>> 	  * Added dcan0 instances to am33xx.dtsi file
>>
>> Changes from v1:
>> 	- These two patches separated from c_can DT support
>> 	  patch series.
>>
>>  arch/arm/boot/dts/am335x-evm.dts |   12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
>> index 5dd8a6b..a64c30a 100644
>> --- a/arch/arm/boot/dts/am335x-evm.dts
>> +++ b/arch/arm/boot/dts/am335x-evm.dts
>> @@ -18,6 +18,18 @@
>>  		reg = <0x80000000 0x10000000>; /* 256 MB */
>>  	};
>>  
>> +	am3358_pinmux: pinmux@44E10800 {
> 
> This should be just &am3358_pinmux as you already include it.
> 

I think it won't work this way, it will result into syntax error.
The reason being is, unlike OMAP (and like other platforms, like, imx)
here we are again representing device hierarchy starting from root,

am335x-evm.dts:
/ {

	ocp {
		...
	};

};

Although I am not too familiar with DTS compiler, but below code results
in syntax error:

am335x-evm.dts:
/ {

	ocp {
		...
		&am3358_pinmux {
			...
		};
	};

};


Thanks,
Vaibhav

>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&d_can1_pins>;
>> +
>> +		d_can1_pins: pinmux_d_can_pins {
>> +			pinctrl-single,pins = <
>> +				0x168 0x2	/* uart0_ctsn.d_can1_tx, OUTPUT | MODE2 */
>> +				0x16C 0x32	/* uart0_rtsn.d_can1_rx, INPUT_PULLUP | MODE2 */
>> +			>;
>> +		};
>> +	};
>> +
> 
> It would better to claim these pins in the dcan driver entry
> rather than set them as pins enabled by the pinctrl driver.
> The reason is that in case you want to enable runtime PM related
> stuff, like some more advanced wake-up features, for the rx pin
> you can do it in the driver.
> 
> Then one nit.. Please lowercase all hex number in this series as that's the style
> here.
> 
> Regards,
> 
> Tony
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
