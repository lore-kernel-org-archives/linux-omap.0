From: Blazej Kot <bjk45@cornell.edu>
Subject: Re: Gumstix Overo Low Power Standby?
Date: Tue, 26 May 2009 16:44:58 -0400
Message-ID: <249CF2F5-CA30-49BE-8524-B81AEC4D42A5@cornell.edu>
References: <E7CF933B-CAC8-4F9E-AA3F-C64F36063C8F@cornell.edu> <87ws8bog2c.fsf@deeprootsystems.com> <87iqjvoe0q.fsf@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from granite1.mail.cornell.edu ([128.253.83.141]:52951 "EHLO
	authusersmtp.mail.cornell.edu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758449AbZEZUo7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 May 2009 16:44:59 -0400
In-Reply-To: <87iqjvoe0q.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>


On May 20, 2009, at 1:55 PM, Kevin Hilman wrote:

> Kevin Hilman <khilman@deeprootsystems.com> writes:
>
>> Blazej Kot <bjk45@cornell.edu> writes:
>>
>>> I have been working with the linux-pm kernel on the Gumstix Overo,
>>> seeing how low it's power consumption can go, both during the cpu  
>>> "on"
>>> and especially while the CPU is suspended. Thus far, I've had some
>>> disappointing results, the best I could get is about 500mW while on,
>>> and 250mW while suspended (ie by running "echo mem > /sys/power/
>>> state"). I am led to believe that the OMAP processor is capable of
>>> much lower power consumption during standby.
>>>
>>> I am wondering if anybody in the gumstix community is looking into  
>>> the
>>> software support for very-low-power modes on the overo. If so, I am
>>> wondering what the lowest power levels are which you have reached
>>> during standby are.
>>>
>>> I have seen this:
>>>
>>> http://markmail.org/message/ge5hec5f5asp7a67#query:omap%20linux
>>> %2080%20ma+page:1+mid:t2erlwweknakm767+state:results
>>>
>>> Which seems to indicate the lowest power reached is 80mA at 3.3V ->
>>> 0.264 W, which is about what I'm seeing. Is it really true that the
>>> overo draws a quarter of a watt when doing absolutely nothing?
>>
>> There are lots of factors involved.
>>
>> The current OMAP PM branch is focused on minimizing power consumed by
>> the OMAP SoC itself.  However, there are lots of other things on- 
>> board
>> (audio codecs, regulators, WiFi chipsets etc.) that can consume power
>> that we may not be currently managing in the omap kernel.
>>
>> I don't have an Overo so am not familiar with all the on board
>> peripherals, but you should probably do some experiments where you
>> can put all the on-board devices into low-power/off states and
>> run some experiments as well.
>>
>> In the case of the Beagle results you referenced, I'm pretty sure it
>> is something on board that is drawing the ~80mA and not on-chip.  I
>> assume this because setting the OMAP to use OFF-mode in suspend or
>> idle results in the drop of a few mA reflecting an expected drop in
>> power consumed by OMAP itself, but still leaving lots of power
>> consumed.
>>
>> For example, testing today's PM branch on Beagle gives me roughly the
>> same numbers as the post you referenced, but slightly better:
>>
>> - boot idle: 323 mA
>>
>> - screen blank: 216 mA
>>  # echo 3 > /sys/class/graphics/fb0/blank
>>
>> - suspend (OMAP retention): 75 mA
>>  # echo mem > /sys/power/state
>>
>> - sleep-while-idle: 75 mA - this same power state as suspend,
>>  but happens in idle
>>  # echo 1 > /sys/power/sleep_while_idle
>>
>> - suspend (OMAP off): 72 mA
>>  # echo 1 > /sys/power/enable_off_mode
>>  # echo 1 > /sys/power/voltage_off_while_idle
>>
>> Ultimitately the answer is that more work needs to be done with the
>> using the regulator framework and/or the drivers for the on-chip
>> peripherals to be sure they can be powered off when needed.
>>
>
> After digging a little more in the beagle forums, someone has already
> done the work to confirm that it is indeed board level design and
> issues that are drawing the rest of the power on Beagle.
>
> There's a thread[1] in the beagleboard list about how to get down to
> 8mW power on Beagle, but it does require hardware changes.  This
> should shed some light on the types of things you'd probably have
> to do for Overo.
>
> Kevin
>
> [1] http://groups.google.com/group/beagleboard/browse_thread/thread/197a8ef6b46cc828/6e98db4cbe2cebaa?#


Thanks for that, it is an interesting link. I have now reached the new  
low of around 170mW (at 3.28V), but this is high. I basically used the  
TWL (PMC) scripts in the linked post, and also turned off the U6 chip  
on the gumstix, which is the USB PHY layer driver.

Also,  I noticed that my systems becomes unusable after suspending for  
more than abut a minute, and it will not wake from sleep. I will try  
to troubleshot and narrow this down.

I am wondering, is there anyone out there working on PM issues on the  
Gumstix? Perhaps if there are some gumstix company people here they  
can answer what their status is. I will ask around on the gumstix  
emailing list also.

thanks,
Blazej
