From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH 05/10] ARM: OMAP1: Make 770 LCD work
Date: Thu, 28 May 2009 19:44:42 +0100
Message-ID: <20090528194442.39896ichvj5e3dzs@lidskialf.net>
References: <20090519232905.12760.15490.stgit@localhost>
	<20090519233732.12760.34595.stgit@localhost>
	<20090525092911.GC28195@n2100.arm.linux.org.uk>
	<20090525142128.17675cl0tvdr0y1k@lidskialf.net>
	<20090525174055.127744136qxu9vk0@lidskialf.net>
	<20090528182047.GF32453@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:37427 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbZE1Sol convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 14:44:41 -0400
In-Reply-To: <20090528182047.GF32453@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Imre Deak <imre.deak@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Quoting Tony Lindgren <tony@atomide.com>:

> * Andrew de Quincey <adq_dvb@lidskialf.net> [090525 09:41]:
>> Quoting Andrew de Quincey <adq_dvb@lidskialf.net>:
>>
>>> Quoting Russell King - ARM Linux <linux@arm.linux.org.uk>:
>>>
>>>> On Tue, May 19, 2009 at 04:37:32PM -0700, Tony Lindgren wrote:
>>>>> Make 770 LCD work by passing the clock from platform data.
>>>>> Also remove the old unused functions.
>>>>
>>>> I don't like this - because its passing struct clk's through platform
>>>> data.  That's not how things are supposed to work.
>>>>
>>>> The way PXA solves this problem is to have clock aliases - see
>>>> clk_add_alias().
>>>
>>> Interesting idea - I now have a prototype patch implementing this,
>>> which I'll send when I get home (otherwise it would be an "it
>>> compiles" "test" :)
>>>
>>> There isn't a common definition of clk_add_alias() though - that
>>> symbol is defined in arch/arm/mach-pxa/clock.c, so I had to copy it
>>> into arch/arm/plat-omap/clock.c
>>
>> Attached is a patch implementing this method. I don't like the
>> duplication of the clk_alias code, but I imagine that could be resolved
>> if this method was chosen....
>
> Andrew, can you please reply with your Signed-off-by?

Sure - sorry I was holding off in case there were any comments on the  
method...

Signed-off-by: Andrew de Quincey <adq@lidskialf.net>

