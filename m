From: Michael Jones <michael.jones@matrix-vision.de>
Subject: Re: timing in driver function
Date: Fri, 05 Aug 2011 14:06:36 +0200
Message-ID: <4E3BDCCC.3090009@matrix-vision.de>
References: <4E36C30E.9060809@matrix-vision.de> <alpine.DEB.2.00.1108011931151.28427@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.matrix-vision.com ([85.214.244.251]:34943 "EHLO
	mail2.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755569Ab1HEMMS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 08:12:18 -0400
In-Reply-To: <alpine.DEB.2.00.1108011931151.28427@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Hi Paul,

On 08/02/2011 03:41 AM, Paul Walmsley wrote:
> 
> Hi,
> 
> On Mon, 1 Aug 2011, Michael Jones wrote:
> 
>> I have a function in a driver which takes ~50ms to execute, which I've
>> measured by reading jiffies at the beginning and end. But jiffies only
>> counts at 128Hz on my system, so this was a very coarse measurement. Now
>> I would like to find out more exactly where the time is going inside
>> this function. So my basic question is, what is the best way to measure
>> lapsed time with reasonable resolution on an OMAP?
>>
>> As I had done with the jiffies measurement, what I imagined was
>> inserting lines into my function, sampling the value of some counter at
>> various points within it. This approach is crude but simple and would
>> suffice for my case.
>>
>> Since it must be a very common task, I thought I'd ask here what the
>> recommended approach is. I see a few directions...
>>
>> 1. Using the OMAP's 32kHz timer, which is provided as a "struct
>> clocksource". It seems like what I would want is to call
>> clocksource_32k.read(), but I don't know how to retrieve clocksource_32k.
> 
> Consider getnstimeofday().  It's not OMAP-specific; there are several 
> examples in the Linux codebase[1]; and if you use a higher-resolution 
> clocksource, the resolution should also increase (try disabling 
> CONFIG_OMAP_32K_TIMER).
> 
> 
> 1. http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Ftorvalds%2Flinux-2.6.git&a=search&h=HEAD&st=grep&s=getnstimeofday
> 
> 
> - Paul

Thanks, I took your suggestion and it served my purpose just fine.

-Michael

MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Erhard Meier
