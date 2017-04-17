From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: dra7: Add power hold and power controller
 properties to palmas
Date: Mon, 17 Apr 2017 11:45:39 +0530
Message-ID: <5745adc5-1296-a489-4895-b18463b3f346@ti.com>
References: <1492059081-20124-1-git-send-email-j-keerthy@ti.com>
 <20170414142142.GT5339@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170414142142.GT5339-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Friday 14 April 2017 07:51 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [170412 21:55]:
>> Add power hold and power controller properties to palmas node.
>> This is needed to shutdown pmic correctly on boards with
>> powerhold set.
> 
> Is this OK to wait for v4.12 or is this needed as a fix for
> the -rc series?

Can wait for v4.12.

> 
> Regards,
> 
> Tony
> 
>> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/dra7-evm.dts | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
>> index 4bc4b57..31a9e06 100644
>> --- a/arch/arm/boot/dts/dra7-evm.dts
>> +++ b/arch/arm/boot/dts/dra7-evm.dts
>> @@ -204,6 +204,8 @@
>>  	tps659038: tps659038@58 {
>>  		compatible = "ti,tps659038";
>>  		reg = <0x58>;
>> +		ti,palmas-override-powerhold;
>> +		ti,system-power-controller;
>>  
>>  		tps659038_pmic {
>>  			compatible = "ti,tps659038-pmic";
>> -- 
>> 1.9.1
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
