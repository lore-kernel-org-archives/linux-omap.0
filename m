From: George Cherian <george.cherian@ti.com>
Subject: Re: Gadget regression with enabling of MUSB babble interrupt handling
Date: Fri, 20 Jun 2014 09:11:53 +0530
Message-ID: <53A3AD81.10109@ti.com>
References: <20140619095655.GA29055@atomide.com> <53A2B6B0.2040804@zonque.org> <20140619103100.GB29055@atomide.com> <53A2BD34.1060409@zonque.org> <20140619104324.GC29055@atomide.com> <53A2C06D.1000705@zonque.org> <20140619112455.GE29055@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39011 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933593AbaFTDl5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jun 2014 23:41:57 -0400
In-Reply-To: <20140619112455.GE29055@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Daniel Mack <daniel@zonque.org>
Cc: linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

On 6/19/2014 4:54 PM, Tony Lindgren wrote:
> * Daniel Mack <daniel@zonque.org> [140619 03:51]:
>> On 06/19/2014 12:43 PM, Tony Lindgren wrote:
>>> * Daniel Mack <daniel@zonque.org> [140619 03:38]:
>>>> On 06/19/2014 12:31 PM, Tony Lindgren wrote:
>>>>> * Daniel Mack <daniel@zonque.org> [140619 03:10]:
>>>>>> On 06/19/2014 11:56 AM, Tony Lindgren wrote:
>>>>> But that also raises a question: Were these patches merged for
>>>>> v3.16 ever even tested in peripheral mode?
>>>> At the time, I had no such hardware to test this on, so I was hoping for
>>>> more testers to give them a try in different environments, which
>>>> apparently didn't happen. It fixed a dead USB port condition on
>>>> host-mode enabled hardware, though.
>>> Well we probably should not merge patches without proper acks and
>>> tested-by:s in general as things just seem to keep breaking
>>> constantly otherwise. And things not working will keep people from
>>> using linux next which will lead into even less testing..
>> I'm fairly sure the patch causing your trouble has been in linux-next
>> for a while before they hit the merge window, so people with gadget
>> enabled musb could have noticed the breakage early enough. The feedback
>> rate for patches to this driver posted to linux-usb is also usually low,
>> unfortunately.
I blame myself for not explicitly pointing out the fix.
Instead I clubbed it with this series.

http://marc.info/?l=linux-usb&m=140109627505065&w=4

Sorry for that.

> Right but the problem is that people are not touching linux next
> because it's constantly broken :)
>   
>> Anyway, breaking things is certainly not good, and I'm sorry for that.
>> I'm just uncertain what detail in the procedure should be tweaked in
>> order to prevent that from happening in the future.
> Well I guess somebody should run basic tests on this driver in
> linux next, that would probably solve the issues.

I am doing it.
> Regards,
>
> Tony


-- 
-George

