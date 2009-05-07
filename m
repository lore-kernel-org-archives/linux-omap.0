From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM
	MDK (Re: LDP support)
Date: Thu, 7 May 2009 10:18:58 -0700
Message-ID: <20090507171857.GC5593@atomide.com>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090505195231.GB8004@n2100.arm.linux.org.uk> <20090506040015.GM5593@atomide.com> <20090506224917.GS5593@atomide.com> <4A02F7CF.1050803@windriver.com> <20090507161936.GA26106@n2100.arm.linux.org.uk> <20090507162833.GZ5593@atomide.com> <DE514120-BF18-4DB7-9B0F-D17F495B75B2@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51605 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbZEGRS7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 13:18:59 -0400
Content-Disposition: inline
In-Reply-To: <DE514120-BF18-4DB7-9B0F-D17F495B75B2@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: linux-omap List <linux-omap@vger.kernel.org>

* Koen Kooi <koen@dominion.thruhere.net> [090507 09:57]:
>
> Op 7 mei 2009, om 18:28 heeft Tony Lindgren het volgende geschreven:
>
>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090507 09:19]:
>>> On Thu, May 07, 2009 at 11:01:35PM +0800, stanley.miao wrote:
>>>> Hi, Tony,
>>>>
>>>> Now the kernel can't boot on LDP. The attached file is the boot log.
>>>
>>> No boot log found.
>>>
>>> My master branch, based upon 2.6.29-rc3 boots fine on the LDP.
>>>
>>> Uncompressing  
>>> Linux.............................................................
>>> ............................................ done, booting the  
>>> kernel.
>>> Linux version 2.6.29-rc3 (rmk@dyn-67.arm.linux.org.uk) (gcc version  
>>> 4.3.2 (GCC)) #125 Mon Feb 2 22:22:54 GMT 2009
>>
>> <snip snip>
>>
>>> omapfb: configured for panel ldp
>>> omapfb: DISPC version 3.0 initialized
>>> omapfb: Framebuffer initialized. Total vram 614400 planes 1
>>> omapfb: Pixclock 32000 kHz hfreq 60.3 kHz vfreq 93.7 Hz
>>
>> Can you see the penguin?
>
> 2.6.29 does this on my zoom:
>
> http://www.flickr.com/photos/koenkooi/3406819626/
>
> Boots into X and all :) That's with DSS1, not Tomi's DSS2. As I said  
> earlier, the touchscreen is unusable.

Good to hear. What patches do you have applied?

What exactly is wrong with the touchscreen? Got any patches for that?

Regards,

Tony
