From: Tony Lindgren <tony@atomide.com>
Subject: Re: MMC broken on beagleboard with current git
Date: Thu, 25 Sep 2008 13:39:53 +0300
Message-ID: <20080925103952.GJ5222@atomide.com>
References: <FDAFB709-68B8-478D-8321-1322449B9A7F@student.utwente.nl> <20080925085142.GC5222@atomide.com> <77EE6A0D-895B-4E0B-B9C4-18D333BFF85C@student.utwente.nl> <20080925094718.GE5222@atomide.com> <4D346DA2-6C57-48A7-AC4E-2191C44497CF@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59824 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbYIYKj4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 06:39:56 -0400
Content-Disposition: inline
In-Reply-To: <4D346DA2-6C57-48A7-AC4E-2191C44497CF@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

* Koen Kooi <k.kooi@student.utwente.nl> [080925 13:25]:
>
> Op 25 sep 2008, om 11:47 heeft Tony Lindgren het volgende geschreven:
>
>> * Koen Kooi <k.kooi@student.utwente.nl> [080925 12:23]:
>>>
>>> Op 25 sep 2008, om 10:51 heeft Tony Lindgren het volgende geschreven:
>>>
>>>> * Koen Kooi <k.kooi@student.utwente.nl> [080925 11:42]:
>>>>> Hi,
>>>>>
>>>>> I just built a kernel from current git[1] and the mmc controller
>>>>> doesn't
>>>>> get detected on boot on my beagleboards. The omap mmc system has
>>>>> seen a
>>>>> lot of changes lately, does anyone have a hint where to start  
>>>>> looking
>>>>> before attemping a bisect?
>>>>
>>>> Sounds like the recent mmc init changes we've done:
>>>>
>>>> 535e1808d1c77a580815f7d7daacc6c030e29cb1 -  12 september 2008
>>>
>>>> 8e6e06c71b9d21d85a3ae652868e2802c054a08a - 12 september 2008
>>>
>>>> c434c15d28c82d92e55897bd265c423e9ab69362 - 24 september 2008
>>>
>>>
>>>> I've verified that it works on omap3430sdp. But mach-omap2/hsmmc.c
>>>> needs
>>>> some more work done to support other mmc controllers besides the  
>>>> first
>>>> one.
>>>> I don't think other controllers ever worked before these patches
>>>> either though..
>>>>
>>>> Let me know if you can narrow it down to some commit and I may be  
>>>> able
>>>> to help further from there.
>>>
>>> The previous working version I built was based of
>>> de1121fdb899f762b9e717f44eaf3fae7c00cd3e which was commited at 13
>>> september 2008, so 535e18.. and 8e6e06c.. don't break it.
>>
>> OK, good to know. Can you try to git-bisect it?
>
> That proved to be a lot less work than expected :)
>
> Last good: 9d1dff8638c9e96a401e1885f9948662e9ff9636
> First bad: c434c15d28c82d92e55897bd265c423e9ab69362
>
> So 
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=c434c15d28c82d92e55897bd265c423e9ab69362 
>  breaks MMC on beagle.

Hmm, I don't understand how it could work on 3430sdp...

Looks like board-omap3beagle.c calls hsmmc_init() just like
board-3430sdp.c. Maybe timings have changed and you need
a longer delay somewhere during the init?

Maybe sprinkle some printks to hsmmc.c and see if that
makes it to work?

Also make sure omap_hsmmc.c probe finishes OK.

Tony

>>>>> [1] http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=c434c15d28c82d92e55897bd265c423e9ab69362



