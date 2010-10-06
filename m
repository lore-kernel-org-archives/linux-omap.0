From: David Anders <x0132446@ti.com>
Subject: Re: [PATCH 0/4] omap4: pandaboard: machine cleanups
Date: Wed, 06 Oct 2010 16:01:32 -0500
Message-ID: <4CACE3AC.2000308@ti.com>
References: <1285104244-32274-1-git-send-email-x0132446@ti.com> <20100927223054.GG16721@atomide.com> <20101006205638.GA4859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55820 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933107Ab0JFVBe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 17:01:34 -0400
In-Reply-To: <20101006205638.GA4859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Goluguri, Jayabharath" <jayabharath@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "Pasam, Vijay" <vpasam@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,

must have missed this request, i'll repost now

thanks
Dave

On 10/06/2010 03:56 PM, Tony Lindgren wrote:
> * Tony Lindgren<tony@atomide.com>  [100927 15:22]:
>    
>> * David Anders<x0132446@ti.com>  [100921 14:15]:
>>      
>>> PandaBoard machine file related cleanups.
>>>
>>> David Anders (4):
>>>    omap4: pandaboard: remove unused hsmmc definition
>>>    omap4: pandaboard: Fix the init if CONFIG_MMC_OMAP_HS is not set
>>>    omap4: pandaboard: Adding card detect support for MMC1
>>>    omap4: pandaboard: enable the ehci port on pandaboard
>>>
>>>   arch/arm/mach-omap2/board-omap4panda.c |   76 +++++++++++++++++++++++++++++---
>>>   1 files changed, 69 insertions(+), 7 deletions(-)
>>>        
>> David, please repost this series one more time with linux-arm-kernel
>> list also Cc'd in addition to the linux-omap list.
>>      
> Ping, we're starting to run out of time!
>
> Tony
>    

