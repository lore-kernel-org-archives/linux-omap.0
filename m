From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Beagle PM hangs
Date: Fri, 30 Jan 2009 11:53:29 -0800
Message-ID: <87skn0in9i.fsf@deeprootsystems.com>
References: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com>
	<87zlhbqtrv.fsf@deeprootsystems.com>
	<87skn3qq6x.fsf@deeprootsystems.com>
	<8bf247760901300616k53722fb0if55e2d07c71df10c@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE89671620376DEC131@dlee02.ent.ti.com>
	<87hc3gk9au.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:18792 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbZA3Txd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 14:53:33 -0500
Received: by rv-out-0506.google.com with SMTP id k40so588252rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2009 11:53:32 -0800 (PST)
In-Reply-To: <87hc3gk9au.fsf@deeprootsystems.com> (Kevin Hilman's message of "Fri\, 30 Jan 2009 09\:12\:09 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Sriram V <vshrirama@gmail.com>, Peter Reid <ppeter.reid@gmail.com>, Koen Kooi <koen@beagleboard.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Richard,
>
> "Woodruff, Richard" <r-woodruff2@ti.com> writes:
>
>>>   I wait for a min and try to wakeup - It works.
>>>
>>>   If i wait a little longer before waking it up say, 3 or 4 minutes.
>>> It does not wakeup.
>>
>> That is consistent with your memory not being placed into self refresh properly.
>>
>> 5 general bugs I've seen over time:
>>         sw bug:
>>                 - ctrl sequence issue before sleep
>>                 - CKE balls not muxed correctly
>>                 - crash on unexpected wake path
>>         chip bug:
>>                 - (3430 >= es3 requires a errata sequence to work)
>>         board bug:
>>                 - hooking ddr-chip-CKE wrongly or a way OMAP doesn't support like sharing between dies.
>
> Another possibility is that the the memory timings for the custom
> board are not set correctly.
>

Also, as another reference point:

I do not see this behavior on some other custom ES3-based hardware
using the PM branch.  So that suggests some board-specific issues are
involved.

Kevin
