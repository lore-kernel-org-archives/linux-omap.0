From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: AM33XX: Add support for IGEP COM AQUILA
Date: Thu, 20 Jun 2013 09:16:36 -0500
Message-ID: <51C30EC4.4090302@ti.com>
References: <1371630423-2481-1-git-send-email-eballetbo@iseebcn.com> <1371630423-2481-2-git-send-email-eballetbo@iseebcn.com> <51C18BEE.4020405@ti.com> <CAAwP0s3BaCte1qWM0mgK+VyXmOPy5WLmgYJfAhRtmANcwwfn_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44634 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935359Ab3FTOQi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jun 2013 10:16:38 -0400
In-Reply-To: <CAAwP0s3BaCte1qWM0mgK+VyXmOPy5WLmgYJfAhRtmANcwwfn_A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi Javier,

On 6/19/2013 8:32 AM, Javier Martinez Canillas wrote:
> Hi,
>
> On Wed, Jun 19, 2013 at 12:46 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>> Hi Enric,
>>
>>
>> On 06/19/2013 03:27 AM, Enric Balletbo i Serra wrote:
>>>
>>> The IGEP COM AQUILA is industrial processors SODIMM module with
>>> following highlights:
>>>
>>>      o AM3352/AM3354/AM3358/AM3359 Texas Instruments processor
>>>      o Cortex-A8 ARM CPU
>>>      o 3.3 volts Inputs / Outputs use industrial
>>>      o 256 MB DDR3 SDRAM / 128 Megabytes FLASH
>>>      o MicroSD card reader on-board
>>>      o Ethernet controller on-board
>>>      o JTAG debug connector available
>>>      o Designed for industrial range purposes
>>>
>>> Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
>>> ---
>>>    arch/arm/boot/dts/am335x-igep0033.dtsi | 269
>>> +++++++++++++++++++++++++++++++++
>>>    1 file changed, 269 insertions(+)
>>>    create mode 100644 arch/arm/boot/dts/am335x-igep0033.dtsi
>>>
>>> diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi
>>> b/arch/arm/boot/dts/am335x-igep0033.dtsi
>>> new file mode 100644
>>> index 0000000..1d70141
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
>>> @@ -0,0 +1,269 @@
>>> +/*
>>> + * Copyright (C) 2013 ISEE 2007 SL - http://www.isee.biz/
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "am33xx.dtsi"
>>> +
>>> +/ {
>>> +       cpus {
>>> +               cpu@0 {
>>> +                       cpu0-supply = <&vdd1_reg>;
>>> +               };
>>> +       };
>>> +
>>> +       memory {
>>> +               device_type = "memory";
>>> +               reg = <0x80000000 0x10000000>; /* 256 MB */
>>> +       };
>>> +
>>> +       am33xx_pinmux: pinmux@44e10800 {
>>
>>
>> That node should be inside the ocp one since the control module is a regular
>> IP connected to the OCP interconnect.
>>
>>
>>
>
> In fact, I don't think that there should be a definition of the On
> Chip Peripherals interconnect or any child node of the ocp in a DTS
> file.
> These should be defined in the included dtsi file since it will be
> common to all boards based on this SoC.

Well there is nothing wrong with that in the DTS theory, but I do agree 
that keeping these internal SoC details outside the board file is indeed 
much better.

> DTS files that describe a board can reference these nodes defined in
> the dtsi and add their custom peripherals as childs of them.
>
> So, instead defining in the DTS:
>
> am33xx_pinmux: pinmux@44e10800 {
> ...
> };
>
> gpmc: gpmc@50000000 {
> ...
> };
>
> i2c0: i2c@44e0b000 {
> ...
> };
>
> uart0: serial@44e09000 {
> ..
> };
>
> It has to be defined as:
>
> &am33xx_pinmux {
> ...
> };
>
> &gpmc {
> ...
> };
>
> &i2c0 {
> ...
> }
>
> I'm looking at other am33xx dts such as am335x-bone.dts and
> am335x-evm.dts and I see that these define device nodes already
> defined in the included .dtsi which is wrong in my opinion.
>
> The OMAP{3,4,5} dtsi and dts do correctly and can be used as a
> reference on how the device nodes have to be defined and referenced.

Good point, we should potentially clean the am33xx files to make then 
consistent with other OMAP stuff.

Thanks,
Benoit



