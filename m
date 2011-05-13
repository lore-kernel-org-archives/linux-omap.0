From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] [RFC] OMAP4: clock: shrink clock data utilizing preprocessor.
Date: Fri, 13 May 2011 14:21:52 +0200
Message-ID: <4DCD2260.4090806@ti.com>
References: <1305247077-15927-1-git-send-email-vzapolskiy@gmail.com>	<20110513113013.GP31483@atomide.com> <BANLkTinNVbViwjAcrOqfR+-ZJ+i1DF9Hdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57659 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932345Ab1EMMV7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 08:21:59 -0400
In-Reply-To: <BANLkTinNVbViwjAcrOqfR+-ZJ+i1DF9Hdw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Vladimir,

Could you please re-send your original patch?

For some reason I cannot find it in any mailing list so far.
Maybe it is due to its size.

On 5/13/2011 2:08 PM, Vladimir Zapolskiy wrote:
> On Fri, May 13, 2011 at 2:30 PM, Tony Lindgren<tony@atomide.com>  wrote:
>> * Vladimir Zapolskiy<vzapolskiy@gmail.com>  [110512 17:35]:
>>> This mass change reduces homogeneous data chunks along clock
>>> definitions. No semantical difference is added to the change,
>>> and still it could be introduced easily.
>>>
>>> Signed-off-by: Vladimir Zapolskiy<vzapolskiy@gmail.com>
>>> ---
>>>   arch/arm/mach-omap2/clock44xx_data.c | 3313 +++++++++-------------------------
>>>   1 files changed, 848 insertions(+), 2465 deletions(-)
>>
>> Hehehe, the diffstat certainly looks good :)
>>
>> This would be best done for all of them using some
>> perl/sed/python script. And could be done for the hwmod data
>> too. Do you already have something like that available?
>>
> Unfortunately I don't have an automated tool, but that would be great
> to have such a script. For this time I've checked the correctness of the
> change comparing the preprocessed output.

In fact these files are already generated automatically, as written in 
the header file. So changing the output format should straightforward. 
At least for OMAP4... OMAP2 and OMAP3 were done manually some time ago.

Regards,
Benoit
