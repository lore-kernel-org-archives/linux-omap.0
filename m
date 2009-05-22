From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: Tracking N770 breakage
Date: Fri, 22 May 2009 18:47:20 +0100
Message-ID: <20090522184720.10616mt8vpjglk3k@lidskialf.net>
References: <20090516140653.10104565olvxrwjk@lidskialf.net>
	<20090517031715.92503qopn0joudhc@lidskialf.net>
	<20090519231500.GM19742@atomide.com>
	<20090520061544.560957looc5zgav4@lidskialf.net>
	<20090520151907.GC8308@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:49424 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757180AbZEVRrU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 13:47:20 -0400
In-Reply-To: <20090520151907.GC8308@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: ladis@linux-mips.org, linux-omap@vger.kernel.org

Quoting Tony Lindgren <tony@atomide.com>:

> * Andrew de Quincey <adq_dvb@lidskialf.net> [090519 22:15]:
>> Quoting Tony Lindgren <tony@atomide.com>:
>>
>>> * Andrew de Quincey <adq_dvb@lidskialf.net> [090516 19:17]:
>>>> Argh, my N770 seems to have just died; it has been behaving slightly
>>>> oddly and now it simply won't turn on (black screen and no sign of life
>>>> whatsoever).
>>>>
>>>> It is well out of warranty and frankly I don't see myself buying another
>>>> one, so this effectively ends my hacking on it :(
>>>
>>> Bummer :(
>>>
>>> After a quick try, CONFIG_OMAP_RESET_CLOCKS was the first stopper, then
>>> it could not mount the MMC root.
>>
>> Ahh excellent, that was why I posted my progress, in case it rang a bell
>> with anyone! I think the touchpad driver may be broken as well BTW.
>>
>>> I think there was a patch posted for the omap1 MMC by Ladislav few months
>>> ago that probably fixes it.
>>
>> Cool - I hope I may be back in the running soon (I was rather annoyed
>> when I posted that message!); I've ordered a new battery in case its
>> just that. A kind person has also offered me one thats broken in a
>> different way that I can probably cobble together with the remains of
>> mine if its something more critical that has died.
>
> Good to hear, let's hope it just needs a new battery.
>
> See also the n8x0 thread. If we get drivers/cbus to mainline, we
> pretty much have everything we need for 770 in mainline too.
>
> It would be nice to get the drivers/mmc/host/omap.c patch integrated
> for 2.6.30 to make omap1 MMC work again. Ladislav, any news on that?

OK! My friend has lent me his N770 in the meantime so I can get going  
again. It seems the board is fried on mine as my battery works  
perfectly fine in his. gah!

Anyway, I have just tried disabling RESET_CLOCKS, but it still doesn't  
work for me with the very latest linux-omap-2.6.

With my HWA patch applied, at least the screen goes black, but I don't  
see any console output, and the thing doesn't appear as a USB gadget  
(I'm mounting NFS as root over USB with cdc_ether).

I wish the thing had an LED I could turn on! Hmm, I wonder if I could  
turn off the backlight easily..

