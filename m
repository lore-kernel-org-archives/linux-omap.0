From: George Cherian <george.cherian@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: am335x-bone*: add DT for BeagleBone Black
Date: Fri, 6 Sep 2013 13:19:26 +0530
Message-ID: <52298906.6040800@ti.com>
References: <1378449204-8601-1-git-send-email-koen@dominion.thruhere.net>
 <52297CCF.3090200@ti.com>
 <50E637BB-5A62-477C-B943-9687BC3488BC@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50E637BB-5A62-477C-B943-9687BC3488BC@dominion.thruhere.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, swarren@wwwdotorg.org, tony@atomide.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, bcousson@baylibre.com, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 9/6/2013 12:40 PM, Koen Kooi wrote:
> Op 6 sep. 2013, om 08:57 heeft George Cherian <george.cherian@ti.com> het volgende geschreven:
>
>> On 9/6/2013 12:03 PM, Koen Kooi wrote:
>>> The BeagleBone Black is basically a regular BeagleBone with eMMC and HDMI added,
>>> so create a common dtsi both can use. MMC support for AM335x still isn't in, so
>>> only the LDO change has been added.
>>>
>>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>>> ---
>>>   .../{am335x-bone.dts => am335x-bone-common.dtsi}   |   3 -
>>>   arch/arm/boot/dts/am335x-bone.dts                  | 256 +--------------------
>>>   arch/arm/boot/dts/am335x-boneblack.dts             |  18 ++
>>>   3 files changed, 19 insertions(+), 258 deletions(-)
>>>   copy arch/arm/boot/dts/{am335x-bone.dts => am335x-bone-common.dtsi} (99%)
>>>   create mode 100644 arch/arm/boot/dts/am335x-boneblack.dts
>> How did you test am335x-boneblack.dtb? where are the Makefile changes for boneblack?
> Ah, I missed the makefile in my commit. I have a bunch of other patches on top to make more stuff work.
>
> [..]
>
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
>>> @@ -0,0 +1,18 @@
>>> +/*
>>> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +/dts-v1/;
>>> +
>>> +#include "am33xx.dtsi"
>> Why cant we add am33xx.dtsi  in am335x-bone-common.dtsi ?
> That didn't work when I tried it. It did work before the preprocessor changes when using /include/

It will work......
>
>>> +#include "am335x-bone-common.dtsi"
>>> +
>>> +&ldo3_reg {
>>> +	regulator-min-microvolt = <1800000>;
>>> +	regulator-max-microvolt = <1800000>;
>>> +	regulator-always-on;
>>> +};
>>> +
>> With this ldo values mmc was not working for me on Boneblack.
>> got it working with
>>
>> &ldo3_reg {
>> 	regulator-min-microvolt = <1800000>;
>> 	regulator-max-microvolt = <3300000>;
>> 	regulator-always-on;
>> };
> That LDO is shared, the other consumer will get fried if you use 3.3V. I forget if it's DDR3 or HDMI.


-- 
-George
