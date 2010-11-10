From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/6] [v2] omap:mailbox-enhancements and fixes
Date: Wed, 10 Nov 2010 19:58:36 +0100
Message-ID: <4CDAEB5C.6000703@ti.com>
References: <1289393121-7911-1-git-send-email-h-kanigeri2@ti.com>	<4CDACB0E.3050403@ti.com> <AANLkTi=jL-aV0Xn3rcnZwaYLz9nY5QwXbGPHsdq1R2Gz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35508 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753608Ab0KJS52 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Nov 2010 13:57:28 -0500
In-Reply-To: <AANLkTi=jL-aV0Xn3rcnZwaYLz9nY5QwXbGPHsdq1R2Gz@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <hari.kanigeri@gmail.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 11/10/2010 5:56 PM, Hari Kanigeri wrote:
> Benoit,
>
> Thanks for your comments.
>
> On Wed, Nov 10, 2010 at 10:40 AM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> Hi Hari,
>>
>> On 11/10/2010 1:45 PM, Hari Kanigeri wrote:
>>>
>>> Thanks to Rene Sapiens and Omar Ramirez for their inputs on initial patch
>>> set.
>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37278.html
>>>
>>> The patch set addresses the following review comments from Rene and Omar.
>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37626.html
>>> https://patchwork.kernel.org/patch/255091/
>>> https://patchwork.kernel.org/patch/255081/
>>>
>>> Following patches are changed because of above review comments:
>>> omap:mailbox-send message in process context
>>> omap:mailbox-add notification support for multiple readers
>>>
>>> Following patch is dropped from initial patch set
>>> omap:mailbox-resolve multiple receiver problem
>>>
>>> The patch set is tested on omap4 SDP board.
>>>
>>> Fernando Guzman Lugo (1):
>>>    mailbox: change full flag per mailbox queue instead of global
>>>
>>> Hari Kanigeri (5):
>>>    omap:mailbox: fix rx interrupt disable in omap4
>>>    omap:mailbox-fix checkpatch warnings
>>
>> That one is weird? How can you submit a patch that fix checkpatch?
>
> Why weird if the patch is fixing the checkpatch warnings that were
> already present in the code ?

OK, so you meant that this is fixing some already existing warnings in 
mainline code?
My point was that checkpatch is supposed to check patch... but it's true 
that is can check the code as well. I was assuming that all the code in 
mainline is supposed to be already checkpatch proof :-)
It seems that this is not the case.

It might be interesting to run it on every plat-omap / mach-omap files...

Thanks,
Benoit

> The other option is to leave the checkpatch warnings in the code :)
>
>> In theory you should not send any patch that generate checkpatch error or
>> warning.
>>
>>>    omap:mailbox-send message in process context
>>>    omap:mailbox-add notification support for multiple readers
>>>    omap:clocks44x-add dummy clock for mailbox
>>
>> We are trying to enforce some consistency in the subjects name so you should
>> name your patches like that:
>
> Good point, thanks for pointing about consistency. I wasn't aware
> about the rule to use OMAP in caps.
> I will fix it.
>
> Thank you,
> Best regards,
> Hari

