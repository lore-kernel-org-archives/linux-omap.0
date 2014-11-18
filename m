From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] ARM: dts: DRA7: Add node for RTC
Date: Tue, 18 Nov 2014 10:31:04 +0530
Message-ID: <546AD290.8080303@ti.com>
References: <1416199509-3977-1-git-send-email-lokeshvutla@ti.com> <5469E76A.7020105@cogentembedded.com> <5469F271.9080102@ti.com> <546A1E5E.1040909@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50173 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbaKRFCo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2014 00:02:44 -0500
In-Reply-To: <546A1E5E.1040909@cogentembedded.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, t-kristo@ti.com, linux-arm-kernel@lists.infradead.org

Hi,
On Monday 17 November 2014 09:42 PM, Sergei Shtylyov wrote:
> On 11/17/2014 4:04 PM, Lokesh Vutla wrote:
> 
>>> On 11/17/2014 7:45 AM, Lokesh Vutla wrote:
> 
>>>> Add node for RTC.
> 
>>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>>> [nm@ti.com: update with rtc crossbar number]
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>> ---
>>>>    arch/arm/boot/dts/dra7.dtsi | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
> 
>>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>>>> index 9cc9843..f98f9f0 100644
>>>> --- a/arch/arm/boot/dts/dra7.dtsi
>>>> +++ b/arch/arm/boot/dts/dra7.dtsi
>>>> @@ -1075,6 +1075,15 @@
>>>>                status = "disabled";
>>>>            };
>>>>
>>>> +        rtc: rtcss@48838000 {
> 
>>>     Please just name the node "rtc@48838000", in accordance with ePAPR.
> 
>> Okay. will update it.
> 
>>>> +            compatible = "ti,am3352-rtc";
>>>> +            reg = <0x48838000 0x100>;
>>>> +            interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
> 
>>>     2 similar interrupts?
> 
>> both rtc timer and rtc alarm uses same interrupt on DRA7 Soc.
>> Driver handles it accordingly.
>> So passing the same interrupt.
> 
>    I think it would have been better if the driver just handled a single interrupt.
There are certain SoCs with RTC IP where timer and alarm uses different interrupts.
Driver has to take care of that scenario also. So it expects two interrupts from dt. 

Thanks and regards,
Lokesh 
> 
>> Thanks and regards,
>> Lokesh
> 
>>> [...]
> 
> WBR, Sergei
> 

