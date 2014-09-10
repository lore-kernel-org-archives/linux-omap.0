From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 02/12] ARM: dts: DRA7: Add DCAN nodes
Date: Wed, 10 Sep 2014 11:06:05 +0300
Message-ID: <5410066D.1060402@ti.com>
References: <1410274534-22826-1-git-send-email-rogerq@ti.com> <1410274534-22826-3-git-send-email-rogerq@ti.com> <540F1702.2000007@pengutronix.de> <540F1768.8090901@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <540F1768.8090901@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, tony@atomide.com
Cc: wg@grandegger.com, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/09/2014 06:06 PM, Marc Kleine-Budde wrote:
> On 09/09/2014 05:04 PM, Marc Kleine-Budde wrote:
>> On 09/09/2014 04:55 PM, Roger Quadros wrote:
>>> The SoC supports 2 DCAN nodes. Add them.
>>
>> I think you should put the device-tree ml for DT related patches on Cc.

OK.

>>
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>  arch/arm/boot/dts/dra7.dtsi | 30 ++++++++++++++++++++++++++++++
>>>  1 file changed, 30 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>>> index 370009e..09d5739 100644
>>> --- a/arch/arm/boot/dts/dra7.dtsi
>>> +++ b/arch/arm/boot/dts/dra7.dtsi
>>> @@ -34,6 +34,8 @@
>>>  		serial3 = &uart4;
>>>  		serial4 = &uart5;
>>>  		serial5 = &uart6;
>>> +		d_can0 = &dcan1;
>>> +		d_can1 = &dcan2;
>>>  	};
>>>  
>>>  	timer {
>>> @@ -1267,6 +1269,34 @@
>>>  			ti,irqs-skip = <10 133 139 140>;
>>>  			ti,irqs-safe-map = <0>;
>>>  		};
>>> +
>>> +		dcan1: can@481cc000 {
>>> +			compatible = "bosch,d_can";
>>> +			ti,hwmods = "dcan1";
>>> +			reg = <0x4ae3c000 0x2000>,
>>> +			      <0x558 0x4>; /* index to RAMINIT reg within syscon */
>>
>> Putting the offset within the syscon here doesn't look good.
>>
>>> +			ti,raminit-syscon = <&dra7_ctrl_core>;
>>
>> Why not add it as a second parameter to the ti,raminit-syscon instead?

Yes, that would be better.

> 
> ./drivers/power/reset/keystone-reset.c does this.

Thanks for the hint. I'll fix this in v3.

cheers,
-rogre
