From: Janosch Machowinski <scotch@tzi.de>
Subject: Re: stable kernel version
Date: Wed, 14 Oct 2009 19:39:58 +0200
Message-ID: <4AD60CEE.8000204@tzi.de>
References: <4AD58D69.2080303@tzi.de> <20091014172656.GJ12700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-bremen.de ([134.102.201.18]:43453 "EHLO
	informatik.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752308AbZJNRko (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Oct 2009 13:40:44 -0400
In-Reply-To: <20091014172656.GJ12700@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tony Lindgren schrieb:
> * Janosch Machowinski <scotch@tzi.de> [091014 01:48]:
>   
>> Hi,
>> I'm looking for an stable omap kernel,
>> for an gumstix board. I tried the 2.6.30
>> and 2.6.31 git heads, but they both
>> resulted in an unbootable system.
>> Any advices, on which version to take ?
>>     
>
> Starting with 2.6.31, the stable omap kernel latest released
> kernel from Linus. So 2.6.31 in this case.
>
> Of course you may still need to patch in some things you need,
> like PM, EHCI and dspbridge.
>
> What do you get when booting? Overo boots just fine for me.

Hi Tony,

the 2.6.30 head booted fine until the point where it
waited for the SD-Card to get ready. There it just hung
forever.

the 2.6.31 head crashed instantly after the uncompression
of the kernel image.

I will try out the 2.6.31 mainline kernel tommorw.

Regards,
    Janosch
