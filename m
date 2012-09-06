From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC RESEND 1/4] arm/dts: OMAP: Add timer nodes
Date: Thu, 06 Sep 2012 08:45:26 -0500
Message-ID: <5048A8F6.6080108@gmail.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com> <1342218413-30116-2-git-send-email-jon-hunter@ti.com> <5000D647.4090200@gmail.com> <500439A8.1050705@ti.com> <500D6CAB.4030504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56887 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555Ab2IFNpa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 09:45:30 -0400
Received: by obbuo13 with SMTP id uo13so2474152obb.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 06:45:29 -0700 (PDT)
In-Reply-To: <500D6CAB.4030504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 07/23/2012 10:24 AM, Jon Hunter wrote:
> Hi Rob,
> 
> On 07/16/2012 10:56 AM, Jon Hunter wrote:
>> Hi Rob,
>>
>> On 07/13/2012 09:15 PM, Rob Herring wrote:
>>> On 07/13/2012 05:26 PM, Jon Hunter wrote:
>>>> Add the 12 GP timers nodes present in OMAP3.
>>>> Add the 11 GP timers nodes present in OMAP4.
>>>>
>>>> Add documentation for timer properties specific to OMAP.
>>>>
>>>> For each timer an alias is being added. The purpose for doing this is because
>>>> the OMAP dmtimer driver uses an ID to distinguish between the different timer
>>>> instances. For example, a timer can be requested by its ID. By adding an alias
>>>> for each timer we can then use the function of_alias_get_id() to extract the
>>>> ID for each timer from the alias name. The same method is used for the TTY
>>>> serial devices. If it is preferred that such an alias is not added and there
>>>> is a better way to pass an ID from device-tree let me know.
>>>
>>> I'm not sure this is really a good use of aliases. UARTs use aliases
>>> because it is important that the UART number to tty number is known and
>>> fixed. IIUC, as an example you are picking timer1 because it has
>>> properties X, Y and Z. If so, then you should describe those h/w
>>> properties within the timer nodes so you can pick which timer to use
>>> based on it's h/w properties.
>>
>> Thanks for the feedback. What you suggest could definitely work for most
>> timers. The only item that I would need to resolve here is the handling
>> of system timers (ie. those used for clockevents and clocksource). These
>> system timers (for OMAP) are reserved during early boot based upon the
>> timer ID today and so this is before the actual main timer driver has
>> been probed and all the attributes of the timers has been read for
>> device-tree.
>>
>> One thought would be to move the reservation of the system timers out of
>> the kernel and into device-tree itself. Then we query device tree on
>> start-up to see which we should use. I am wondering if this could be a
>> better use of alias? For example, say I want to use timer1 as my
>> clockevent timer and so I could have an alias of ...
>>
>> alias {
>> 	clockevent_timer = &timer1;
>> }
>>
>> However, I am not sure if this is even correct, because there does not
>> appear to be an API to search the aliases by name and return the
>> phandle, just of_alias_get_id(). Alternatively, I could add another
>> property called "ti,timer-clockevent" that is populated for the timer
>> used as the clockevent timer.
> 
> Do you have any inputs on the above? Does it make sense to reserve timer
> resources for kernel system timers in device-tree?

This issue is not unique to omap. So if we do specify clockevent and
clocksource in dts, then it should be in a common way. I think using
"linux,clockevent" either as an alias name or property within the timer
node would work. I don't have a strong preference, but I tend to lean
toward an alias. Primarily this is because we are already using aliases
for similar purposes.

However, I still think this could be done by looking at properties.
There's not really any reason you can't check properties at timer init
stage. The FDT has already been un-flattened. What are the features or
lack of features you care about to determine which timer to use?

Rob

