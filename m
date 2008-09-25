From: Tony Lindgren <tony@atomide.com>
Subject: Re: MMC broken on beagleboard with current git
Date: Thu, 25 Sep 2008 12:47:19 +0300
Message-ID: <20080925094718.GE5222@atomide.com>
References: <FDAFB709-68B8-478D-8321-1322449B9A7F@student.utwente.nl> <20080925085142.GC5222@atomide.com> <77EE6A0D-895B-4E0B-B9C4-18D333BFF85C@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52270 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbYIYJrZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 05:47:25 -0400
Content-Disposition: inline
In-Reply-To: <77EE6A0D-895B-4E0B-B9C4-18D333BFF85C@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, beagleboard Board <beagleboard@googlegroups.com>

* Koen Kooi <k.kooi@student.utwente.nl> [080925 12:23]:
>
> Op 25 sep 2008, om 10:51 heeft Tony Lindgren het volgende geschreven:
>
>> * Koen Kooi <k.kooi@student.utwente.nl> [080925 11:42]:
>>> Hi,
>>>
>>> I just built a kernel from current git[1] and the mmc controller  
>>> doesn't
>>> get detected on boot on my beagleboards. The omap mmc system has  
>>> seen a
>>> lot of changes lately, does anyone have a hint where to start looking
>>> before attemping a bisect?
>>
>> Sounds like the recent mmc init changes we've done:
>>
>> 535e1808d1c77a580815f7d7daacc6c030e29cb1 -  12 september 2008
>
>> 8e6e06c71b9d21d85a3ae652868e2802c054a08a - 12 september 2008
>
>> c434c15d28c82d92e55897bd265c423e9ab69362 - 24 september 2008
>
>
>> I've verified that it works on omap3430sdp. But mach-omap2/hsmmc.c  
>> needs
>> some more work done to support other mmc controllers besides the first 
>> one.
>> I don't think other controllers ever worked before these patches
>> either though..
>>
>> Let me know if you can narrow it down to some commit and I may be able
>> to help further from there.
>
> The previous working version I built was based of  
> de1121fdb899f762b9e717f44eaf3fae7c00cd3e which was commited at 13  
> september 2008, so 535e18.. and 8e6e06c.. don't break it.

OK, good to know. Can you try to git-bisect it?

Tony

>>
>>> [1] http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=c434c15d28c82d92e55897bd265c423e9ab69362
>>
>>
>>
>


