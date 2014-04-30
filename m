From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC 08/11] ARM: dts: am33xx: Add prcm_resets node
Date: Wed, 30 Apr 2014 13:13:27 -0500
Message-ID: <53613D47.4000905@ti.com>
References: <1398802790-29287-1-git-send-email-dmurphy@ti.com> <1398802790-29287-9-git-send-email-dmurphy@ti.com> <6286135.g77D4pMffU@wuerfel> <20140430002211.GC27571@atomide.com> <53613A29.8080803@ti.com> <20140430181042.GC12362@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37442 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759218AbaD3SOF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Apr 2014 14:14:05 -0400
In-Reply-To: <20140430181042.GC12362@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, t-kristo@ti.com, s-anna@ti.com, p.zabel@pengutronix.de

Tony

On 04/30/2014 01:10 PM, Tony Lindgren wrote:
> * Dan Murphy <dmurphy@ti.com> [140430 11:00]:
>> Tony and Arnd
>>
>> Thanks for the comments
>>
>> On 04/29/2014 07:22 PM, Tony Lindgren wrote:
>>> * Arnd Bergmann <arnd@arndb.de> [140429 13:35]:
>>>> On Tuesday 29 April 2014 15:19:47 Dan Murphy wrote:
>>>>> + * AM33xx reset index for PRCM Module
>>>>> + *
>>>>> + * Copyright 2014 Texas Instruments Inc.
>>>>> + *
>>>>> + * This program is free software; you can redistribute it and/or modify
>>>>> + * it under the terms of the GNU General Public License version 2 as
>>>>> + * published by the Free Software Foundation.
>>>>> + */
>>>>> +
>>>>> +#ifndef _DT_BINDINGS_RESET_TI_AM33XX_H
>>>>> +#define _DT_BINDINGS_RESET_TI_AM33XX_H
>>>>> +
>>>>> +#define RESET_DEVICE_RESET                     0
>>>>> +#define RESET_GFX_RESET                                1
>>>>> +#define RESET_PER_RESET                                2
>>>>> +
>>>>> +#endif
>>>> Interfaces like this should only be used if you can't use hardware
>>>> numbers, in general. If these numbers are in the data sheet, just
>>>> put them directly into the dts file, as we do for interrupt numbers,
>>>> gpio numbers, register offsets etc.
>>>>
>>>> If you have made them up to define an interface between the driver
>>>> and DT because there is no usable hardare ID, I'd suggest just using
>>>> a single file across all SoCs that have this driver, and have
>>>> a unified name space.
>>> Also, it's a bit unclear how the reset controller phandle is used
>>> referenced and used by the consumer device.. Maybe setting that up
>>> first in a Linux generic way is a good point starting point.
>>>
>>> Maybe something like this along the same way as clocks are set up
>>> (completely untested):
>>>
>>> &reset1 {
>>> 	iva_reset: reset1 {
>>> 		reg = /bits/ 8 <0>;
>>> 	};
>>> 	gfx_reset: reset1 {
>>> 		reg = /bits/ 8 <1>;
>>> 	};
>>> 	...
>>> };
>>>
>>> &iva {
>>> 	compatible = "ti,ivahd";
>>> 	resets = <&reset1 1>;
>>> 	...
>>> };
>> I had something very similar to this when I was developing this driver but moved away from this.
>>
>> Following the clocks implementation I had a separate dtsi for resets for each device and had the data defined like so
>> for each SoC.
>>
>> &prcm_resets {
>>        device_reset: device_reset {
>>                rstctrl_offs = <0x1104>;
>>                ctrl_bit-shift = <0>;
>>                rstst_offs      = <0x1114>;
>>                sts_bit-shift   = <0>;
>>        };
>>
>>        gpu_reset: gpu_reset {
>>                rstctrl_offs = <0x0D00>;
>>                ctrl_bit-shift = <3>;
>>                rstst_offs      = <0x0D0C>;
>>                sts_bit-shift = <5>;
>>        };
>> };
>>
>> And then any client interested in a specific reset driver would include this
>>
>> resets = <&prcm_resets &gpu_reset>;
>> reset-names = "gpu_reset";
>>
>> Our reset code would then retrieve the register data through the phandle instead of an index.
>>
>> Thoughts?
> Using phandles makes sense here because it avoids the indexing. Indexing
> has a problem of needing to be in sync with the .dts files and the
> device driver(s). Using an index also easily causes misuse of virtual
> indexes being added that no longer describe the hardware at all.

Thanks.  What about placing register data in the dts files?  Is there any issue with this concept?

Dan

> Regards,
>
> Tony


-- 
------------------
Dan Murphy

