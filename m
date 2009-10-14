From: Tony Lindgren <tony@atomide.com>
Subject: Re: stable kernel version
Date: Wed, 14 Oct 2009 12:33:24 -0700
Message-ID: <20091014193324.GK12700@atomide.com>
References: <4AD58D69.2080303@tzi.de> <20091014172656.GJ12700@atomide.com> <4AD60CEE.8000204@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61642 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbZJNTeL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 15:34:11 -0400
Content-Disposition: inline
In-Reply-To: <4AD60CEE.8000204@tzi.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janosch Machowinski <scotch@tzi.de>
Cc: linux-omap@vger.kernel.org

* Janosch Machowinski <scotch@tzi.de> [091014 10:40]:
> Tony Lindgren schrieb:
>> * Janosch Machowinski <scotch@tzi.de> [091014 01:48]:
>>   
>>> Hi,
>>> I'm looking for an stable omap kernel,
>>> for an gumstix board. I tried the 2.6.30
>>> and 2.6.31 git heads, but they both
>>> resulted in an unbootable system.
>>> Any advices, on which version to take ?
>>>     
>>
>> Starting with 2.6.31, the stable omap kernel latest released
>> kernel from Linus. So 2.6.31 in this case.
>>
>> Of course you may still need to patch in some things you need,
>> like PM, EHCI and dspbridge.
>>
>> What do you get when booting? Overo boots just fine for me.
>
> Hi Tony,
>
> the 2.6.30 head booted fine until the point where it
> waited for the SD-Card to get ready. There it just hung
> forever.

Hmm, 2.6.30 may not have all the core stuff in it yet.

> the 2.6.31 head crashed instantly after the uncompression
> of the kernel image.

There are few patches still pending to get to mainline
via other mailing lists, you can see them in omap-testing
branch.

> I will try out the 2.6.31 mainline kernel tommorw.

OK, also I just pushed updated omap-debug branch that
I forgot to rebase on top of current linux-omap master
branch (Thanks Paul for letting me know!).

Tony
