From: mathias nyman <mathias.nyman@nokia.com>
Subject: Re: [PATCH 3/3] lp5521: move to drivers/leds
Date: Mon, 06 Oct 2008 16:32:13 +0300
Message-ID: <48EA135D.3070104@nokia.com>
References: <1223284291-7675-4-git-send-email-felipe.balbi@nokia.com> <20081006110851.GA8580@kos.to> <20081006111721.GE2806@atomide.com> <20081006115103.GN7437@gandalf.research.nokia.com> <20081006125457.GA16255@kos.to> <20081006125809.GR7437@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46675 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbYJFNd2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 09:33:28 -0400
In-Reply-To: <20081006125809.GR7437@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Riku Voipio <riku.voipio@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, rpurdie@rpsys.net

Felipe Balbi wrote:
> On Mon, Oct 06, 2008 at 03:54:57PM +0300, ext Riku Voipio wrote:
>   
>> On Mon, Oct 06, 2008 at 02:51:03PM +0300, Felipe Balbi wrote:
>>     
>>> On Mon, Oct 06, 2008 at 02:17:23PM +0300, Tony Lindgren wrote:
>>>       
>>>> * Riku Voipio <riku.voipio@iki.fi> [081006 14:09]:
>>>>         
>>>>> On Mon, Oct 06, 2008 at 12:11:31PM +0300, Felipe Balbi wrote:
>>>>>           
>>>>>> This driver should be sitting together with the other
>>>>>> led drivers.
>>>>>>             
>>>>> But this driver actually doesn't implement the led sysfs interface.
>>>>> If the driver is changed to implement the led framework interface,
>>>>> we break the existing n810 userland and expose only limited subset
>>>>> of lp5521 features for userland..
>>>>>           
>>>> Maybe this feature should be a distro specific hack on top of
>>>> the mainline tree?
>>>>         
>>> the problem is that led api (afaict) doesn't really have abstraction for
>>> rgb leds like the one we use. It can only handle blinky leds and on/off
>>> transitions and we need more functionality.
>>>       
>> RGB can somewhat be handled, by creating three led devices:
>>
>> n810:red:foo
>> n810:gree:foo
>> n810:blue:foo
>>     
>
> If that's the case I'd expect the driver author to do it since I have no
> time left for that. A few fixes here and there to the driver is fine and
> preparing the driver for mainline integration is also fine since it's a
> simple cp iteration.
>
>   
The driver and chip supports lots of functionality that is not yet in 
the led framework.
Even if there is now support for some "Hardware accelerated blink of 
LEDs" it is not enough.

The lp5521 chip can be programmed with blinking patterns including 
fades, triggers between R, G and B channels and other nice features
Chip has three modes: direct,(set brightness of leds directly through 
sysfs) load (load a pattern to channel) and run.

RGB direct mode could be handled with three led devices but the rest of 
the functionality is a bit trickier.

Patterns are mainly used in n810 as it doesn't require any CPU interaction

At the time of writing this driver led-class.txt stated that:
"Some leds can be programmed to flash in hardware. As this isn't a generic
LED device property, this should be exported as a device specific sysfs
attribute rather than part of the class if this functionality is required."

The driver for the next version of the lp552x chip uses the led class 
for the direct mode

-Mathias

