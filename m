From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: MMC3 Overo
Date: Thu, 06 Aug 2009 08:16:03 -0700
Message-ID: <873a856ki4.fsf@deeprootsystems.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
	<bb2708720908050901lbc67b1cx5a75a7667fa36fd1@mail.gmail.com>
	<bb2708720908050902o39c67430pbdcd12e9b835ab70@mail.gmail.com>
	<873a866xdo.fsf@deeprootsystems.com>
	<bb2708720908050935s6602d76dq2dbaa00195008132@mail.gmail.com>
	<5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com>
	<4A79C83E.9040603@deeprootsystems.com>
	<5e088bd90908051121h38678c9fha73b7beb88752156@mail.gmail.com>
	<4A79D104.60607@deeprootsystems.com>
	<bb2708720908051229x49f10094w9b19b468d4bfaec8@mail.gmail.com>
	<bb2708720908051902p4b369784s8fc5056be9ba047d@mail.gmail.com>
	<871vnp8170.fsf@deeprootsystems.com> <4A7AEC54.107@nt.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:34303 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756004AbZHFPQN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 11:16:13 -0400
Received: by wf-out-1314.google.com with SMTP id 26so376557wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 06 Aug 2009 08:16:14 -0700 (PDT)
In-Reply-To: <4A7AEC54.107@nt.tu-darmstadt.de> (Vladimir Pantelic's message of "Thu\, 06 Aug 2009 16\:44\:36 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vladimir Pantelic <pan@nt.tu-darmstadt.de>
Cc: linux-omap@vger.kernel.org

Vladimir Pantelic <pan@nt.tu-darmstadt.de> writes:

> Kevin Hilman wrote:
>
>>>         AB1_35XXCBB_MMC3_CLK
>>>         AF10_35XXCBB_MMC3_CLK
>>>         R9_35XXCBC_MMC3_CLK
>>>         AB2_35XXCBC_MMC3_CLK
>>>         AC1_35XXCUS_MMC3_CLK
>>>  We would then have to update mux.c making sure the position matches
>>>  and add the proper settings.
>>>
>>>  So this is obviously a maintenance nightmare.
>>
>> So why don't we drop the ball (pun intended.) ;)
>>
>> This is what I proposed to Phillip Ballister for his SPI changes for Beagle.
>>
>> Though I haven't looked at the details for each package, I have a hard
>> time imagining that the reg offsets and functionality for each package
>> is different.  In fact, I'm pretty sure they're even the same between
>> 34xx and 35xx.
>>
>> IOW, why not just name it OMAP3_MMC3_CLK and have a single entry.
>>
>> Then each board file that cares simply has to call omap_cfg_reg() on
>> that name and not care about the package.
>
> even for 1 package, how will you know whether OMAP3_MMC3_CLK is connected
> to ball AB1 or AF10 as both is possible...

doh! good point.  I was thinking of functions that are only availble
on a single ball.  

/me resolves to finish waking up before thinking more about mux issues

Kevin
