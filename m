From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Gumstix Overo Low Power Standby?
Date: Wed, 27 May 2009 20:59:26 +0200
Message-ID: <4A1D8D8E.9070501@googlemail.com>
References: <E7CF933B-CAC8-4F9E-AA3F-C64F36063C8F@cornell.edu> <87ws8bog2c.fsf@deeprootsystems.com> <87iqjvoe0q.fsf@deeprootsystems.com> <249CF2F5-CA30-49BE-8524-B81AEC4D42A5@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:51198 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758840AbZE0S7i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2009 14:59:38 -0400
Received: by bwz22 with SMTP id 22so4900338bwz.37
        for <linux-omap@vger.kernel.org>; Wed, 27 May 2009 11:59:39 -0700 (PDT)
In-Reply-To: <249CF2F5-CA30-49BE-8524-B81AEC4D42A5@cornell.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Blazej Kot <bjk45@cornell.edu>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

Blazej Kot wrote:
> 
> On May 20, 2009, at 1:55 PM, Kevin Hilman wrote:
> 
>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>>
>>> Blazej Kot <bjk45@cornell.edu> writes:
>>>
>>>> I have been working with the linux-pm kernel on the Gumstix Overo,
>>>> seeing how low it's power consumption can go, both during the cpu "on"
>>>> and especially while the CPU is suspended. Thus far, I've had some
>>>> disappointing results, the best I could get is about 500mW while on,
>>>> and 250mW while suspended (ie by running "echo mem > /sys/power/
>>>> state"). I am led to believe that the OMAP processor is capable of
>>>> much lower power consumption during standby.
>>>>
>>>> I am wondering if anybody in the gumstix community is looking into the
>>>> software support for very-low-power modes on the overo. If so, I am
>>>> wondering what the lowest power levels are which you have reached
>>>> during standby are.
>>>>
>>>> I have seen this:
>>>>
>>>> http://markmail.org/message/ge5hec5f5asp7a67#query:omap%20linux
>>>> %2080%20ma+page:1+mid:t2erlwweknakm767+state:results
>>>>
>>>> Which seems to indicate the lowest power reached is 80mA at 3.3V ->
>>>> 0.264 W, which is about what I'm seeing. Is it really true that the
>>>> overo draws a quarter of a watt when doing absolutely nothing?
>>>
>>> There are lots of factors involved.
>>>
>>> The current OMAP PM branch is focused on minimizing power consumed by
>>> the OMAP SoC itself.  However, there are lots of other things on-board
>>> (audio codecs, regulators, WiFi chipsets etc.) that can consume power
>>> that we may not be currently managing in the omap kernel.
>>>
>>> I don't have an Overo so am not familiar with all the on board
>>> peripherals, but you should probably do some experiments where you
>>> can put all the on-board devices into low-power/off states and
>>> run some experiments as well.
>>>
>>> In the case of the Beagle results you referenced, I'm pretty sure it
>>> is something on board that is drawing the ~80mA and not on-chip.  I
>>> assume this because setting the OMAP to use OFF-mode in suspend or
>>> idle results in the drop of a few mA reflecting an expected drop in
>>> power consumed by OMAP itself, but still leaving lots of power
>>> consumed.
>>>
>>> For example, testing today's PM branch on Beagle gives me roughly the
>>> same numbers as the post you referenced, but slightly better:
>>>
>>> - boot idle: 323 mA
>>>
>>> - screen blank: 216 mA
>>>  # echo 3 > /sys/class/graphics/fb0/blank
>>>
>>> - suspend (OMAP retention): 75 mA
>>>  # echo mem > /sys/power/state
>>>
>>> - sleep-while-idle: 75 mA - this same power state as suspend,
>>>  but happens in idle
>>>  # echo 1 > /sys/power/sleep_while_idle
>>>
>>> - suspend (OMAP off): 72 mA
>>>  # echo 1 > /sys/power/enable_off_mode
>>>  # echo 1 > /sys/power/voltage_off_while_idle
>>>
>>> Ultimitately the answer is that more work needs to be done with the
>>> using the regulator framework and/or the drivers for the on-chip
>>> peripherals to be sure they can be powered off when needed.
>>>
>>
>> After digging a little more in the beagle forums, someone has already
>> done the work to confirm that it is indeed board level design and
>> issues that are drawing the rest of the power on Beagle.
>>
>> There's a thread[1] in the beagleboard list about how to get down to
>> 8mW power on Beagle, but it does require hardware changes.  This
>> should shed some light on the types of things you'd probably have
>> to do for Overo.
>>
>> Kevin
>>
>> [1] 
>> http://groups.google.com/group/beagleboard/browse_thread/thread/197a8ef6b46cc828/6e98db4cbe2cebaa?# 
>>
> 
> 
> Thanks for that, it is an interesting link. I have now reached the new 
> low of around 170mW (at 3.28V), but this is high. I basically used the 
> TWL (PMC) scripts in the linked post, and also turned off the U6 chip on 
> the gumstix, which is the USB PHY layer driver.
> 
> Also,  I noticed that my systems becomes unusable after suspending for 
> more than abut a minute, and it will not wake from sleep. I will try to 
> troubleshot and narrow this down.

I think to remember there was some discussion about SDRAM self 
refresh. Look for thread "OMAP3: PM: SDRC: ensure mux of SDRC clock 
enable pins for self-refresh" and

http://www.sakoman.net/cgi-bin/gitweb.cgi?p=u-boot-omap3.git;a=commit;h=4025cfbde3611b14c0d4831a5524e5e061128e30

Just guessing, though.

Dirk

> I am wondering, is there anyone out there working on PM issues on the 
> Gumstix? Perhaps if there are some gumstix company people here they can 
> answer what their status is. I will ask around on the gumstix emailing 
> list also.
> 
> thanks,
> Blazej
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

