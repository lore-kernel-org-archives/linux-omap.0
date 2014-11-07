From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 0/3] ARM: dts: AM43x: Fix DCDC3 regulator voltage
Date: Fri, 7 Nov 2014 14:08:53 +0530
Message-ID: <545C851D.3070905@ti.com>
References: <1415271004-10935-1-git-send-email-j-keerthy@ti.com> <20141106182526.GC31454@atomide.com> <545C4EA1.5000802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41379 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbaKGIlw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Nov 2014 03:41:52 -0500
In-Reply-To: <545C4EA1.5000802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, galak@codeaurora.org, mark.rutland@arm.com, pawel.moll@arm.com

On Friday 07 November 2014 10:16 AM, Keerthy wrote:
> On Thursday 06 November 2014 11:55 PM, Tony Lindgren wrote:
>> * Keerthy <j-keerthy@ti.com> [141106 02:55]:
>>> Fix DCDC3 volatge to 1.5V which is the right value to be supplied by
>>> DCDC3 for all the boards.
>> Hmm so what about the comments for similar beaglebone changes
>> in thread "[PATCH] ARM: dts: am335x-boneblack: set dcdc1 regulator
>> for 1.35v ddr3"?
> Hi Tony,
>
> am335x uses TPS65917 PMIC and am43x* use TPS65218 PMIC.

Typo TPS65917--->TPS65217

> The latest TPS65218 defaults to 1.5V. We see boot hangs when
> there is a voltage change from 1.5V to 1.35V in case of AM43x
> boards. Hence keeping it at 1.5V.
>
> Regards,
> Keerthy
>>
>> Regards,
>>
>> Tony
>>> Keerthy (3):
>>>    ARM: dts: AM43x-EPOS-EVM: Fix DCDC3 voltage
>>>    ARM: dts: AM437x-GP-EVM: Fix DCDC3 voltage
>>>    ARM: dts: AM437x-SK-EVM: Fix DCDC3 voltage
>>>
>>>   arch/arm/boot/dts/am437x-gp-evm.dts  |    4 ++--
>>>   arch/arm/boot/dts/am437x-sk-evm.dts  |    4 ++--
>>>   arch/arm/boot/dts/am43x-epos-evm.dts |    4 ++--
>>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> -- 
>>> 1.7.9.5
>>>
>

