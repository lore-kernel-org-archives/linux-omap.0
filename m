From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: Tracking N770 breakage
Date: Wed, 20 May 2009 06:15:44 +0100
Message-ID: <20090520061544.560957looc5zgav4@lidskialf.net>
References: <20090516140653.10104565olvxrwjk@lidskialf.net>
	<20090517031715.92503qopn0joudhc@lidskialf.net>
	<20090519231500.GM19742@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:33367 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbZETFPo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 01:15:44 -0400
In-Reply-To: <20090519231500.GM19742@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Quoting Tony Lindgren <tony@atomide.com>:

> * Andrew de Quincey <adq_dvb@lidskialf.net> [090516 19:17]:
>> Argh, my N770 seems to have just died; it has been behaving slightly
>> oddly and now it simply won't turn on (black screen and no sign of life
>> whatsoever).
>>
>> It is well out of warranty and frankly I don't see myself buying another
>> one, so this effectively ends my hacking on it :(
>
> Bummer :(
>
> After a quick try, CONFIG_OMAP_RESET_CLOCKS was the first stopper, then
> it could not mount the MMC root.

Ahh excellent, that was why I posted my progress, in case it rang a  
bell with anyone! I think the touchpad driver may be broken as well BTW.

> I think there was a patch posted for the omap1 MMC by Ladislav few months
> ago that probably fixes it.

Cool - I hope I may be back in the running soon (I was rather annoyed  
when I posted that message!); I've ordered a new battery in case its  
just that. A kind person has also offered me one thats broken in a  
different way that I can probably cobble together with the remains of  
mine if its something more critical that has died.

