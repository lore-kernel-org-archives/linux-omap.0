From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 05/12] arm: dts: am4372: Add dcan nodes
Date: Wed, 10 Sep 2014 11:08:01 +0300
Message-ID: <541006E1.1030809@ti.com>
References: <1410274534-22826-1-git-send-email-rogerq@ti.com> <1410274534-22826-6-git-send-email-rogerq@ti.com> <540F182A.9010702@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55002 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318AbaIJIIZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Sep 2014 04:08:25 -0400
In-Reply-To: <540F182A.9010702@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, tony@atomide.com
Cc: wg@grandegger.com, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, Afzal Mohammed <afzal@ti.com>

On 09/09/2014 06:09 PM, Marc Kleine-Budde wrote:
> On 09/09/2014 04:55 PM, Roger Quadros wrote:
>> From: Afzal Mohammed <afzal@ti.com>
>>
>> Add dcan nodes.
>>
>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
>> Signed-off-by: George Cherian <george.cherian@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm/boot/dts/am4372.dtsi | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>> index 8689949..3514d0a 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -885,6 +885,28 @@
>>  				clock-names = "fck";
>>  			};
>>  		};
>> +
>> +		dcan0: can@481cc000 {
>> +			compatible = "bosch,d_can";
>> +			ti,hwmods = "d_can0";
>> +			clocks = <&dcan0_fck>;
>> +			clock-names = "fck";
>> +			reg = <0x481cc000 0x2000
>> +				0x44e10644 0x4>;
>> +			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> 
> Where are the syscon phandles?

They are added in patch 10. As that doesn't look nice, I'll squash it to this patch.

> 
>> +			status = "disabled";
>> +		};
>> +
>> +		dcan1: can@481d0000 {
>> +			compatible = "bosch,d_can";
>> +			ti,hwmods = "d_can1";
>> +			clocks = <&dcan1_fck>;
>> +			clock-names = "fck";
>> +			reg = <0x481d0000 0x2000
>> +				0x44e10644 0x4>;
>> +			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>> +			status = "disabled";
>> +		};
>>  	};
>>  };
>>  
>>

cheers,
-roger

