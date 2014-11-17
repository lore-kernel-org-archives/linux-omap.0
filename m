From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] ARM: dts: DRA7: Add node for RTC
Date: Mon, 17 Nov 2014 18:34:49 +0530
Message-ID: <5469F271.9080102@ti.com>
References: <1416199509-3977-1-git-send-email-lokeshvutla@ti.com> <5469E76A.7020105@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49261 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbaKQNGZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Nov 2014 08:06:25 -0500
In-Reply-To: <5469E76A.7020105@cogentembedded.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, t-kristo@ti.com, linux-arm-kernel@lists.infradead.org

Hi,
On Monday 17 November 2014 05:47 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/17/2014 7:45 AM, Lokesh Vutla wrote:
> 
>> Add node for RTC.
> 
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> [nm@ti.com: update with rtc crossbar number]
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>   arch/arm/boot/dts/dra7.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
> 
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 9cc9843..f98f9f0 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -1075,6 +1075,15 @@
>>               status = "disabled";
>>           };
>>
>> +        rtc: rtcss@48838000 {
> 
>    Please just name the node "rtc@48838000", in accordance with ePAPR.
Okay. will update it.
> 
>> +            compatible = "ti,am3352-rtc";
>> +            reg = <0x48838000 0x100>;
>> +            interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
> 
>    2 similar interrupts?
both rtc timer and rtc alarm uses same interrupt on DRA7 Soc.
Driver handles it accordingly.
So passing the same interrupt.

Thanks and regards,
Lokesh
> 
> [...]
> 
> WBR, Sergei
> 

