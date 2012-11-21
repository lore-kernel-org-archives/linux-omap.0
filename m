From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 00/16] OMAP USB Host cleanup
Date: Wed, 21 Nov 2012 12:05:12 +0200
Message-ID: <50ACA758.9070600@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <87fw49cnvh.fsf@deeprootsystems.com> <50AA05C3.7010003@ti.com> <876251b2kq.fsf@deeprootsystems.com> <20121120231312.GP18567@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43533 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051Ab2KUKFQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 05:05:16 -0500
In-Reply-To: <20121120231312.GP18567@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, balbi@ti.com
Cc: Kevin Hilman <khilman@deeprootsystems.com>, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi Tony,

On 11/21/2012 01:13 AM, Tony Lindgren wrote:
> Hi Roger,
> 
> * Kevin Hilman <khilman@deeprootsystems.com> [121119 15:24]:
>> Roger Quadros <rogerq@ti.com> writes:
>>
>>> Kevin,
>>>
>>> On 11/16/2012 10:08 PM, Kevin Hilman wrote:
>>>> Roger Quadros <rogerq@ti.com> writes:
>>>>
>>>>> Hi,
>>>>>
>>>>> This patchset addresses the following
>>>>>
>>>>> - Avoid addressing clocks one by one by name and use a for loop + bunch
>>>>>   of cleanups.
>>>>> - Get number of channels/ports dynamically either from revision register
>>>>>   or from platform data. Avoids getting clocks that are not present.
>>>>> - Add OMAP5 and HSIC mode (Not tested)
>>>>> - Save power on Panda when EHCI driver is not loaded.
>>>>>
>>>>
>>>> Seeing the clock changes/cleanups, I gave this a spin on OMAP3
>>>> (3530/Beagle, 3530/Overo, 3730/Beagle-xM, 3730/OveroSTORM) to see if it
>>>> fixed up the problem where CORE does not hit retention in idle when USB
>>>> host is enabled, even with no devices attached.
>>>>
>>>> Unfortunately, it didn't help. :(
>>>
>>> oh that's bad. But this series wasn't meant to fix that ;).
>>
>> Oh, sorry.  Yeah, I didn't mean this as a nak.  Just an opportunity to
>> complain to the maintainers that a long-standing issue needs to be
>> addressed.
> 
> It seems that drivers/mfd/omap-usb-host.c is one of the last users
> of cpu_is_omap macros blocking enabling ARM multiplatform support for
> omap2+.
> 
> Please fix that ASAP as early as possible in this patch series to
> remove the dependencies between core omap code development and driver
> development.
> 
> Basically you need to remove #include <plat/cpu.h> and pass the
> revision information in platform data (and device tree compatible
> flag when that is supported).
> 

Okay I'll send a patch to fix that ASAP.

Felipe, any comments on the patches in this series?

regards,
-roger
