From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2] ARM: dts: cm-t3x: add NAND support
Date: Thu, 8 Jan 2015 12:30:23 +0200
Message-ID: <54AE5C3F.7010306@ti.com>
References: <54A00BD6.8010507@compulab.co.il> <1419777049-25271-1-git-send-email-lifshitz@compulab.co.il> <54A151F2.9010904@ti.com> <54A25696.80608@compulab.co.il> <20150108001648.GQ13010@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41898 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612AbbAHKaz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jan 2015 05:30:55 -0500
In-Reply-To: <20150108001648.GQ13010@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il

On 08/01/15 02:16, Tony Lindgren wrote:
> * Dmitry Lifshitz <lifshitz@compulab.co.il> [141229 23:42]:
>> On 12/29/2014 03:06 PM, Roger Quadros wrote:
>>> On 28/12/14 16:30, Dmitry Lifshitz wrote:
>>>> --- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
>>>> +++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
>>>> @@ -50,7 +50,8 @@
>>>>  #include "omap-gpmc-smsc911x.dtsi"
>>>>
>>>>  &gpmc {
>>>> -	ranges = <5 0 0x2c000000 0x01000000>;
>>>> +	ranges = <5 0 0x2c000000 0x01000000>, /* CM-T3x30 SMSC9x Eth */
>>>> +		 <0 0 0x00000000 0x01000000>; /* CM-T3x NAND */
>>>
>>> Isn't this ranges property redundant as it will anyways be overridden by the board specific dts?
>>>
>>
>> The ranges are specified here (and other files below) by design.
>>
>> We built a tree like structure to organize DT files -
>> d234e4239 "ARM: dts: sbc-t3x: refactor DT support"
>>
>> It allows to inherit/override properties common for different boards.
>>
>> Our customers do not have to deal with a correct GPMC ranges settings, once
>> they base on omap3-cm-t3x.dts core module DT file (in case they do not
>> connect additional device to the bus).
>>
>> This is the point of Igor's comment to the previous patch version.
> 
> Roger, do you still have pending issues with this patch?

Sorry missed this one. Thanks for the explanations Dmitry.

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger
