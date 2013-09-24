From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] arm: dts: omap5-uevm: Add status parameter for i2c/spi/uart.
Date: Tue, 24 Sep 2013 11:57:49 +0530
Message-ID: <524130E5.8050704@ti.com>
References: <1380001165-19078-1-git-send-email-sourav.poddar@ti.com> <524126CC.3020300@ti.com> <52412792.1050105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39846 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714Ab3IXG1f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Sep 2013 02:27:35 -0400
In-Reply-To: <52412792.1050105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: bcousson@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, balbi@ti.com

On Tuesday 24 September 2013 11:18 AM, Sourav Poddar wrote:
> On Tuesday 24 September 2013 11:14 AM, Sekhar Nori wrote:
>> On Tuesday 24 September 2013 11:09 AM, Sourav Poddar wrote:
>>> omap5 has all devices enable by default.
>>> Disable thosw not required in omap5 uevm board.
>> s/thosw/those
>>
>>> Fix the following:
>>> Added status parameter
>>> Simulataneously, fix some tab formatting.
>> s/Simulataneously/Simultaneously
>>
>>> Signed-off-by: Sourav Poddar<sourav.poddar@ti.com>
>>> ---
>>>   arch/arm/boot/dts/omap5-uevm.dts |   38
>>> +++++++++++++++++++++++++++++++-------
>>>   1 files changed, 31 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts
>>> b/arch/arm/boot/dts/omap5-uevm.dts
>>> index 65d7b60..78cf0f2 100644
>>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>>> @@ -450,6 +450,18 @@
>>>       };
>>>   };
>>>
>>> +&i2c2 {
>>> +    status = "disabled";
>>> +};
>>> +
>>> +&i2c3 {
>>> +    status = "disabled";
>>> +};
>>> +
>>> +&i2c4 {
>>> +    status = "disabled";
>>> +};
>> The right thing to do would be to mark these as disabled in omap5.dtsi
>> so boards can enable only what they need instead of disable what they
>> don't need (which is potentially a very long list)
> Yes, initially I thought so. But saw these varies from soc to soc.
> On DRA, it is done the way you suggested. For omap5, I saw mmc
> getting disabled in board dts.
> 
> I can change these though. Then, other modules like keypad/mmc should
> also be disable in
> dtsi file to have some uniformity. ?

Yes, that would be nice. This is usually the norm. One exception that is
made is that internal modules like RTC, cryptos can be left enabled in
the <soc>.dtsi so each board doesn't have to enable it. Just make sure
that the module is such that it can really function on *all* boards.
Typically that would mean IOs are not present or optional without loss
of complete functionality.

Thanks,
Sekhar
