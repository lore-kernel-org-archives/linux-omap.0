From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 06/10] ARM: dts: am4372: Add DCAN nodes
Date: Thu, 13 Nov 2014 16:40:04 +0200
Message-ID: <5464C2C4.2070907@ti.com>
References: <1415881371-4982-1-git-send-email-rogerq@ti.com> <1415881371-4982-7-git-send-email-rogerq@ti.com> <5464BB38.7020402@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51833 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbaKMOkW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2014 09:40:22 -0500
In-Reply-To: <5464BB38.7020402@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, tony@atomide.com
Cc: wg@grandegger.com, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org

On 11/13/2014 04:07 PM, Marc Kleine-Budde wrote:
> On 11/13/2014 01:22 PM, Roger Quadros wrote:
>> The SoC contains 2 DCAN modules. Add them.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm/boot/dts/am4372.dtsi | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>> index 899c57c..12fb1db 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -901,6 +901,28 @@
>>  			compatible = "mmio-sram";
>>  			reg = <0x40300000 0x40000>; /* 256k */
>>  		};
>> +
>> +		dcan0: can@481cc000 {
>> +			compatible = "ti,am3352-d_can";
> 
> You should add "ti,am4372-d_can" as first compatible here.
> 
We don't have a separate compatible id for am4372-d_can
as it the IP exactly same as am3352-d_can.

cheers,
-roger

>> +			ti,hwmods = "d_can0";
>> +			clocks = <&dcan0_fck>;
>> +			clock-names = "fck";
>> +			reg = <0x481cc000 0x2000>;
>> +			syscon-raminit = <&am43xx_control_module 0x644 0>;
>> +			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
>> +			status = "disabled";
>> +		};
>> +
>> +		dcan1: can@481d0000 {
>> +			compatible = "ti,am3352-d_can";
> 
> Same here.
> 
>> +			ti,hwmods = "d_can1";
>> +			clocks = <&dcan1_fck>;
>> +			clock-names = "fck";
>> +			reg = <0x481d0000 0x2000>;
>> +			syscon-raminit = <&am43xx_control_module 0x644 1>;
>> +			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>> +			status = "disabled";
>> +		};
>>  	};
>>  };
>>  
>>
> 
> Marc
> 

