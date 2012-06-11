From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 05/11] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Mon, 11 Jun 2012 11:12:42 +0200
Message-ID: <4FD5B68A.40908@ti.com>
References: <20120607060901.25532.68354.stgit@dusk> <20120607061309.25532.13430.stgit@dusk> <79CD15C6BA57404B839C016229A409A83EA43E0F@DBDE01.ent.ti.com> <alpine.DEB.2.00.1206070107530.6684@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA44DD9@DBDE01.ent.ti.com> <alpine.DEB.2.00.1206071355090.14977@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA46071@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34435 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab2FKJMv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 05:12:51 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA46071@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>

On 6/8/2012 9:10 PM, Hiremath, Vaibhav wrote:
> On Fri, Jun 08, 2012 at 01:33:46, Paul Walmsley wrote:
>> Hi
>>
>> On Thu, 7 Jun 2012, Hiremath, Vaibhav wrote:
>>
>>> I couldn't finish my testing today, got into continuous meetings.
>>
>> No worries, I understand.
>>
>>> Tomorrow, I will test it and update you on this.
>>
>> That would be great.
>>
>> I took a look at SPRUH73F and sure enough, at least one module (CONTROL)
>> doesn't support smart-idle -- per Table 14-217 "CONTROL Register Field
>> Descriptions".  I'd guess that the PRCM won't idle-req this IP block until
>> the kernel is not running, so we might be able to get away with the
>> existing approach; but the TRM also says:
>>
>> "By definition, initiator may generate read/write transaction as long as
>> it is out of IDLE state."
>>
>> Which pretty much matches my understanding too of the implicit interface
>> contract here.
>>
>> So I think we'd better go back to the flag approach as implemented in this
>> patch:
>>
>> http://www.spinics.net/lists/arm-kernel/msg176836.html
>>
>> The WBU 32k sync timer's behavior is what relies on quirks of the
>> integration that are hard to identify via other means, so it seems to be
>> safest to tag it explicitly.
>>
>
> Paul,
>
> I tested it on AM335x platform just now, it booted up to the Linux prompt,
> but I am sure it is going to impact low power state usecases on AM33xx.

Why are you sure about that? As explained to Paul, using the force-idle 
will do the same as smart-idle most of the time.

So what power impact are you expecting?

> So, I also feel that, flag based approach should be used here.

Why? Why adding a new flag to detect a condition that is already 
captured somewhere else?

Regards,
Benoit
