From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK to speed-up
 boot
Date: Thu, 20 Jan 2011 10:34:38 -0600
Message-ID: <4D38641E.2000301@gmail.com>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com> <4D385155.4050301@gmail.com> <43c027bd53818ab19bdc1c823aa21ea4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40803 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab1ATQem (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 11:34:42 -0500
Received: by gwj20 with SMTP id 20so221787gwj.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 08:34:41 -0800 (PST)
In-Reply-To: <43c027bd53818ab19bdc1c823aa21ea4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>

On 01/20/2011 09:36 AM, Santosh Shilimkar wrote:
>> -----Original Message-----
>> From: Rob Herring [mailto:robherring2@gmail.com]
>> Sent: Thursday, January 20, 2011 8:44 PM
>> To: Santosh Shilimkar
>> Cc: linux-arm-kernel@lists.infradead.org; Russell King; linux-
>> omap@vger.kernel.org; Linus Walleij
>> Subject: Re: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK
>> to speed-up boot
>>
>> On 01/20/2011 03:42 AM, Santosh Shilimkar wrote:
>>> On some architectures, secondary cores shares clock with primiary
>>> core and hence scale together. Hence secondary core lpj
>> calibration
>>> is not necessary and can be skipped to save considerable time.
>>>
>>> This can speed up the secondary cpu boot and hotplug cpu online
>>> paths.
>>>
>>> Discussion thread:
>>> 	http://www.spinics.net/lists/arm-kernel/msg111124.html
>>>
>>
>> There's already one way to do this with pre-calculated lpj.
>>
> How about the hot-plug path? This is not for just boot.

The path is the same for hotplug and secondary boot, so yes for both. 
Plus you get the added benefit of speeding up the primary core boot as well.

>
>> Also, this isn't multi-platform friendly. You could accomplish the
>> same
>> thing using the clock api to get the core frequency of each core and
>> only calculate lpj if the frequency is different.
> May be but what's wrong with the obvious approach which is
> completely non-intrusive.
> Why is not multi-platform friendly ?
> Archs can choose not to select this option.

I meant you can't have single kernel binary with a platform with single 
core freq and a platform with independent core freq.

Looking at this some more, the only reason to call calibrate_delay is to 
get a more accurate value. If you have different frequencies per core, 
you've got bigger problems as loops_per_jiffy value is not per core. So 
your kconfig option name is misleading. Something like 
ARCH_WANT_UDELAY_RECALC would be more accurate. To get a more accurate 
calculation, calibrate_delay only needs to be called by 1 secondary 
core. Perhaps it could be called from somewhere that is not in the 
boot/hotplug path or only done once.

Rob

>
> Regards,
> Santosh

