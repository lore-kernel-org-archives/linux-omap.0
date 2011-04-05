From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: RX-51: Platform support for lp5523
Date: Tue, 5 Apr 2011 15:34:08 +0300
Message-ID: <4D9B0C40.8080705@nokia.com>
References: <20110329172922.GA19494@earth.universe> <20110329173647.GK4016@atomide.com> <20110329181615.GA20371@earth.universe> <20110329193301.GP4016@atomide.com> <4D9B06C1.1080306@nokia.com> <20110405121911.GJ30505@legolas.emea.dhcp.ti.com> <4D9B09B0.9020806@nokia.com> <20110405123015.GM30505@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:41215 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278Ab1DEMe3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Apr 2011 08:34:29 -0400
In-Reply-To: <20110405123015.GM30505@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: ext Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>, linux-omap@vger.kernel.org

On 04/05/2011 03:30 PM, ext Felipe Balbi wrote:
> On Tue, Apr 05, 2011 at 03:23:12PM +0300, Ameya Palande wrote:
>> On 04/05/2011 03:19 PM, ext Felipe Balbi wrote:
>>> On Tue, Apr 05, 2011 at 03:10:41PM +0300, Ameya Palande wrote:
>>>> Hi Tony,
>>>>
>>>> On 03/29/2011 10:33 PM, ext Tony Lindgren wrote:
>>>>> * Sebastian Reichel<sre@debian.org>    [110329 11:13]:
>>>>>> On Tue, Mar 29, 2011 at 10:36:47AM -0700, Tony Lindgren wrote:
>>>>>>> * Sebastian Reichel<sre@debian.org>    [110329 10:26]:
>>>>>>>> Is there any reason, that the rx51 platform code does not support
>>>>>>>> the lp5523 chip? The chip driver itself is in the mainline kernel
>>>>>>>> since 2.6.37-rc2.
>>>>>>>
>>>>>>> Got a patch for that? As always, patches related to blinking leds
>>>>>>> have a special high priority here! :)
>>>>>>
>>>>>> Ameya Palande has written one, which is available at [0]. I added
>>>>>> him to CC, so that he can comment on mainline inclusion.
>>>>>
>>>>> OK. Ameya, can you please post it for review for this list with
>>>>> linux-arm-kernel list Cc'd?
>>>>>
>>>>> Regards,
>>>>>
>>>>> Tony
>>>>>
>>>>>> [0] http://gitorious.org/nokia-n900-kernel/nokia-n900-kernel/commit/54caed7bdc7e9f5aa84fe50f3bc321fc1ef600ad?format=patch
>>>>
>>>> Can we get following patch in for 2.6.39-rc2?
>>>> http://marc.info/?l=linux-omap&m=130200500812156&w=2
>>>
>>> Tony will say for sure, but I don't consider that a bugfix, so you need
>>> to wait next merge window for that to reach mainline :-
>>
>> It is not a new feature/driver for sure. We are just enabling support
>> for a driver (lp5523) on N900 which is already present in mainline.
>
> Exactly, adding a new feature. Let me put it this way: which bug or
> regression are you fixing with this patch ?

I never claimed that it is fixing a bug/regression ;)
IMHO driver for lp5523 chip is a "new feature" which is already in 
mainline. This patch just enables use of this feature on N900.

Cheers,
Ameya.
