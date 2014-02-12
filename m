From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: [PATCH] ARM: dts: OMAP5: add pmu node
Date: Wed, 12 Feb 2014 09:02:25 -0600
Message-ID: <52FB8D01.7030609@mentor.com>
References: <1391014601-31663-1-git-send-email-nathan_lynch@mentor.com> <52FA8498.5050507@mentor.com> <52FB7072.5000005@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:33898 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbaBLPC3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Feb 2014 10:02:29 -0500
In-Reply-To: <52FB7072.5000005@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org
Cc: tony@atomide.com

On 02/12/2014 07:00 AM, Benoit Cousson wrote:
>> On 01/29/2014 10:56 AM, Nathan Lynch wrote:
>>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>>> index a72813a9663e..fbf4661436e2 100644
>>> --- a/arch/arm/boot/dts/omap5.dtsi
>>> +++ b/arch/arm/boot/dts/omap5.dtsi
>>> @@ -76,6 +76,12 @@
>>>                    <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) |
>>> IRQ_TYPE_LEVEL_LOW)>;
>>>       };
>>>
>>> +    pmu {
>>> +        compatible = "arm,cortex-a15-pmu";
>>> +        interrupts = <0 131 4>,
>>> +                 <0 132 4>;
> 
> Could you use the macros instead of hard coded value? You have the
> example just before your modification in the patch itself.

Thanks Benoit.  Sorry for missing that, will fix.

