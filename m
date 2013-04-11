From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: gpio/omap v2: map irq_enable/disable to mask/unmask.
Date: Thu, 11 Apr 2013 12:52:14 -0500
Message-ID: <5166F84E.9050502@ti.com>
References: <20130411131842.GA9331@blumentopf> <5166DCAD.1030409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49064 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964931Ab3DKRwZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Apr 2013 13:52:25 -0400
In-Reply-To: <5166DCAD.1030409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Andreas Fenkart <andreas.fenkart@streamunlimited.com>, khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org, daniel@zonque.org


On 04/11/2013 10:54 AM, Santosh Shilimkar wrote:
> On Thursday 11 April 2013 06:48 PM, Andreas Fenkart wrote:
>> Hi Santosh,
>>
>> I submitted the following patch a while back.
>> https://patchwork.kernel.org/patch/1886421/
>>
>> As already said, the patch is straight forward, but without it,
>> we probably will not see decent SDIO performance on am335x chips.
>>
>> [why it is needed]
>>
> Why part is clear for me.
> 
>> There are still open questions to gpio patch itself, see here
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg87217.html
>>
>> So could we pls reopen that thread? It might be on the other side
>> of your mailbox
>>
> Your idea is reasonable and probably patch make lot of sense for
> edge triggered interrupt.
> 
> Can you please repost the patch with the more comprehensive change-log
> as discussed in the thread.

Originally, I had a question on enable/disable versus mask/unmask, but
looking at the way we have implemented mask/unmask for omap, I don't
think that my question is really applicable. Yes so please re-post.

Jon
