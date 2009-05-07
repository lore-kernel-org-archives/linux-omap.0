From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM
 MDK	(Re: LDP support)
Date: Thu, 07 May 2009 23:01:35 +0800
Message-ID: <4A02F7CF.1050803@windriver.com>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090505195231.GB8004@n2100.arm.linux.org.uk> <20090506040015.GM5593@atomide.com> <20090506224917.GS5593@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:55097 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbZEGO7Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 May 2009 10:59:24 -0400
In-Reply-To: <20090506224917.GS5593@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [090505 21:00]:
>   
>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090505 12:52]:
>>     
>>> On Tue, Apr 28, 2009 at 03:42:37PM -0700, Tony Lindgren wrote:
>>>       
>>>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090428 15:07]:
>>>>         
>>>>> Tony, et.al.,
>>>>>
>>>>> Any ideas when more LDP support will be pushed into mainline (such as
>>>>> the framebuffer support)?
>>>>>           
>>>> I'll be looking at the board-*.c patches for the next merge window
>>>> hopefully this week or next week.
>>>>
>>>> Looks like LDP keyboard, touchscreen & RTC are pretty much ready
>>>> to go. Then the MMC has some regulator updates, but AFAIK the MMC
>>>> should work OK already.
>>>>
>>>> For the framebuffer, Imre and Tomi know the status the best, so
>>>> I've added them to Cc.
>>>>
>>>> Imre has been meaning to send a bunch of drivers/video/omap changes
>>>> to the fbdev list for a while now and LDP framebuffer may depend on
>>>> those. Imre, any news on the status of sending the fb patches
>>>> upstream?
>>>>
>>>> Then there are the upcoming DSS patches from Tomi, but those still
>>>> need some work before they're ready to go.
>>>>         
>>> Is there any news on this?  Will we see more functional OMAP3 / LDP
>>> support queued for the next merge window?
>>>       
>> Yes fro the stuff listed above, but still no news on the framebuffer
>> patches. Imre?
>>     
>
> Added Stanley Miao to Cc. Here's an updated version of Stanley's patch to
> add fb support for LDP.
>
> I don't have an LDP, maybe you guys can give it a try against the mainline
> kernel and see if it works! There might be some changes needed to 
> drivers/video/omap/dispc.c too.. And those should be handled by Imre.
>
> But if this works, at least we can then add support for few more boards
> easily while waiting for Imre to send his updates.
>   
Hi, Tony,

Now the kernel can't boot on LDP. The attached file is the boot log.

I will check it when I have  time.

Stanley.

> Cheers,
>
> Tony 
>   

