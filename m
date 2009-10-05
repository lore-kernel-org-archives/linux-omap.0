From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: [PATCH] OMAP3: RX51: support sleep indicator LEDs
Date: Mon, 05 Oct 2009 14:31:46 +0300
Message-ID: <4AC9D922.6090409@nokia.com>
References: <1254497755-1822-1-git-send-email-khilman@deeprootsystems.com>	<20091002155944.GV1133@earth.li> <87tyyh7orh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21737 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbZJELeU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 07:34:20 -0400
In-Reply-To: <87tyyh7orh.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jonathan McDowell <noodles@earth.li>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Kevin Hilman wrote:
> Jonathan McDowell <noodles@earth.li> writes:
> 
>> On Fri, Oct 02, 2009 at 08:35:55AM -0700, Kevin Hilman wrote:
>>> The sleep indicator LEDs can be enabled/disabled by toggling GPIO162.
>>> Request this GPIO in RX51 board init, disable by default and expose
>>> GPIO162 to userspace so LEDs can be toggled from userspace:
>> Wouldn't this be better done using the LED class subsystem?
> 
> No, these are HW controlled LEDs which blink based on whether the OMAP
> is hitting retention or OFF mode etc.  The software has no control
> over the blinking of LEDs themselves.  The GPIO simply enables them.
> 
> Kevin
> 

Actually, i think it would make sense to use LED class subsystem, even if the 
GPIO does not directly control LEDs because

1) it does indirectly control a group of LEDs. enable/disable

2) it solves our GPIO numbering problem. user-space does not need to care about 
or track which GPIO to set/reset

3) Makes better sense from architecture point of view

	User-space will write to /sys/class/leds/debug_leds/brightness

-roger

> 
>>> To enable:
>>>
>>>   # echo 1 > /sys/class/gpio/gpio162/value
>>>
>>> To disable:
>>>
>>>   # echo 0 > /sys/class/gpio/gpio162/value
>>>
>>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>> ---
>> J.
>>
>> -- 
>> 101 things you can't have too much of : 16 - Time.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

