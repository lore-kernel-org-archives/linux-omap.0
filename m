From: Tony Lindgren <tony@atomide.com>
Subject: Re: Tracking N770 breakage
Date: Wed, 20 May 2009 08:19:07 -0700
Message-ID: <20090520151907.GC8308@atomide.com>
References: <20090516140653.10104565olvxrwjk@lidskialf.net> <20090517031715.92503qopn0joudhc@lidskialf.net> <20090519231500.GM19742@atomide.com> <20090520061544.560957looc5zgav4@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57044 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935AbZETPTJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 11:19:09 -0400
Content-Disposition: inline
In-Reply-To: <20090520061544.560957looc5zgav4@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew de Quincey <adq_dvb@lidskialf.net>, ladis@linux-mips.org
Cc: linux-omap@vger.kernel.org

* Andrew de Quincey <adq_dvb@lidskialf.net> [090519 22:15]:
> Quoting Tony Lindgren <tony@atomide.com>:
>
>> * Andrew de Quincey <adq_dvb@lidskialf.net> [090516 19:17]:
>>> Argh, my N770 seems to have just died; it has been behaving slightly
>>> oddly and now it simply won't turn on (black screen and no sign of life
>>> whatsoever).
>>>
>>> It is well out of warranty and frankly I don't see myself buying another
>>> one, so this effectively ends my hacking on it :(
>>
>> Bummer :(
>>
>> After a quick try, CONFIG_OMAP_RESET_CLOCKS was the first stopper, then
>> it could not mount the MMC root.
>
> Ahh excellent, that was why I posted my progress, in case it rang a bell 
> with anyone! I think the touchpad driver may be broken as well BTW.
>
>> I think there was a patch posted for the omap1 MMC by Ladislav few months
>> ago that probably fixes it.
>
> Cool - I hope I may be back in the running soon (I was rather annoyed  
> when I posted that message!); I've ordered a new battery in case its  
> just that. A kind person has also offered me one thats broken in a  
> different way that I can probably cobble together with the remains of  
> mine if its something more critical that has died.

Good to hear, let's hope it just needs a new battery.

See also the n8x0 thread. If we get drivers/cbus to mainline, we
pretty much have everything we need for 770 in mainline too.

It would be nice to get the drivers/mmc/host/omap.c patch integrated
for 2.6.30 to make omap1 MMC work again. Ladislav, any news on that?

Regards,

Tony
