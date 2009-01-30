From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Beagle PM hangs
Date: Sat, 31 Jan 2009 01:11:42 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702DE7B7679@dbde02.ent.ti.com>
References: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com>
	<87zlhbqtrv.fsf@deeprootsystems.com>	<87skn3qq6x.fsf@deeprootsystems.com>
	<8bf247760901300616k53722fb0if55e2d07c71df10c@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE89671620376DEC131@dlee02.ent.ti.com>
 <87hc3gk9au.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44049 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882AbZA3TmA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 14:42:00 -0500
In-Reply-To: <87hc3gk9au.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Sriram V <vshrirama@gmail.com>, Peter Reid <ppeter.reid@gmail.com>, Koen Kooi <koen@beagleboard.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>
>Richard,
>
>"Woodruff, Richard" <r-woodruff2@ti.com> writes:
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
>>                 - hooking ddr-chip-CKE wrongly or a way OMAP doesn't support like sharing between
>dies.
>
>Another possibility is that the the memory timings for the custom
>board are not set correctly.
>
>Richard, Do you have pointers to CDP/zoom code that has a workaround
>for the 3430 > es3 errata as well as the 'ctrl sequence issue' you
>mentioned?

Richard, 
All the fixes should be available on [1] Time to Market Branch: ti-2.6.24-omap3
You could point patches from there if required.

[1] http://git.omapzoom.com/?p=omapkernel.git;a=shortlog;h=refs/heads/ti-2.6.24-omap3


>
>Kevin
>
>
>
