From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH V2 2/2] ARM: dts: DRA7: Add node for RTC
Date: Wed, 9 Jul 2014 16:05:36 +0530
Message-ID: <53BD1AF8.2060609@ti.com>
References: <alpine.DEB.2.02.1407060031120.23762@utopia.booyaka.com> <1404894932-26677-1-git-send-email-lokeshvutla@ti.com> <1404894932-26677-3-git-send-email-lokeshvutla@ti.com> <20140709091232.GJ28884@atomide.com> <53BD0C43.1090002@ti.com> <20140709100914.GL28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48614 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754667AbaGIKhu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jul 2014 06:37:50 -0400
In-Reply-To: <20140709100914.GL28884@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, devicetree@vger.kernel.org, nm@ti.com, j-keerthy@ti.com, nsekhar@ti.com

On Wednesday 09 July 2014 03:39 PM, Tony Lindgren wrote:
> * Keerthy <a0393675@ti.com> [140709 02:36]:
>> On Wednesday 09 July 2014 02:42 PM, Tony Lindgren wrote:
>>> * Lokesh Vutla <lokeshvutla@ti.com> [140709 01:37]:
>>>> --- a/arch/arm/boot/dts/dra7-evm.dts
>>>> +++ b/arch/arm/boot/dts/dra7-evm.dts
>>>> @@ -249,6 +249,7 @@
>>>>   					regulator-min-microvolt = <1050000>;
>>>>   					regulator-max-microvolt = <1050000>;
>>>>   					regulator-boot-on;
>>>> +					regulator-always-on;
>>>>   				};
>>> Is this regulator really always on?
>> This feeds on to RTC which is a free running clock. So i guess always on is
>> justified no?
> Well the dts entries should describe the hardware. If the
> regulator can be enabled and disabled, we should not claim it's
> always on.

 From the PMIC perspective every regulator can be enabled and
disabled. From a Board perspective there are some which need
to be always on. For Ex: SMPS123 which feeds on to the MPU.

I guess RTC also needs the supply to be on as long as we want
the clock to be ticking.

> Also adding temporary dts entries just causes more churn on the
> dts files which is a PITA for everybody.
>
> Regards,
>
> Tony

Regards,
Keerthy
