From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM
 MDK (Re: LDP support)
Date: Fri, 08 May 2009 17:18:21 +0800
Message-ID: <4A03F8DD.4070307@windriver.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030555A7D9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:62406 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753229AbZEHJQA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 May 2009 05:16:00 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030555A7D9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Gadiyar, Anand wrote:
> Stanley.miao wrote:
>   
>> Russell King - ARM Linux wrote:
>>     
>>> On Thu, May 07, 2009 at 11:01:35PM +0800, stanley.miao wrote:
>>>   
>>>       
>>>> Hi, Tony,
>>>>
>>>> Now the kernel can't boot on LDP. The attached file is the boot log.
>>>>     
>>>>         
>>> No boot log found.
>>>
>>>
>>>   
>>>       
>> Sorry, forgot to attach the boot log.
>>
>> It is linux-omap master branch.
>>
>> Stanley.
>>     
>
> Looks like you used the CodeSourcery 2007q3 toolchain. This had been
> reported earlier. Switching to 2008q3 works.
>
> - Anand
>
>
>
>   
Yeah, Now the kernel booted. it's compiler's problem.

Linux version 2.6.30-rc4-omap1-05873-g2489dcb (stanley@stanley-desktop) 
(gcc version 4.3.2 (Sourcery G++ Lite 2008q3-72) ) #2 Fri May 8 17:06:34 
CST 2009
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP LDP board


Hi, Tony,

LCD still works.
The code I tested is the master branch of linux-omap. Is it right ?

Stanley.

