From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM
	MDK (Re: LDP support)
Date: Fri, 8 May 2009 08:22:45 -0700
Message-ID: <20090508152245.GK5593@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030555A7D9@dbde02.ent.ti.com> <4A03F8DD.4070307@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64381 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138AbZEHPWz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 11:22:55 -0400
Content-Disposition: inline
In-Reply-To: <4A03F8DD.4070307@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

* stanley.miao <stanley.miao@windriver.com> [090508 02:15]:
> Gadiyar, Anand wrote:
>> Stanley.miao wrote:
>>   
>>> Russell King - ARM Linux wrote:
>>>     
>>>> On Thu, May 07, 2009 at 11:01:35PM +0800, stanley.miao wrote:
>>>>         
>>>>> Hi, Tony,
>>>>>
>>>>> Now the kernel can't boot on LDP. The attached file is the boot log.
>>>>>             
>>>> No boot log found.
>>>>
>>>>
>>>>         
>>> Sorry, forgot to attach the boot log.
>>>
>>> It is linux-omap master branch.
>>>
>>> Stanley.
>>>     
>>
>> Looks like you used the CodeSourcery 2007q3 toolchain. This had been
>> reported earlier. Switching to 2008q3 works.
>>
>> - Anand
>>
>>
>>
>>   
> Yeah, Now the kernel booted. it's compiler's problem.
>
> Linux version 2.6.30-rc4-omap1-05873-g2489dcb (stanley@stanley-desktop)  
> (gcc version 4.3.2 (Sourcery G++ Lite 2008q3-72) ) #2 Fri May 8 17:06:34  
> CST 2009
> CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c5387f
> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> Machine: OMAP LDP board
>
>
> Hi, Tony,
>
> LCD still works.
> The code I tested is the master branch of linux-omap. Is it right ?

Well the goal here is to get the mainline code to work for the LCD.

I'll post few patches for you to test after trying them out on 3430sdp.

Regards,

Tony
