From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP5: Enable arch timer support
Date: Thu, 13 Sep 2012 14:30:28 +0530
Message-ID: <CAMQu2gzA6ZAh+u-TDSESNmmfzT1t4e1PnqjNT=cMm16uNfehqQ@mail.gmail.com>
References: <1344856045-15134-1-git-send-email-santosh.shilimkar@ti.com>
 <1344856045-15134-3-git-send-email-santosh.shilimkar@ti.com>
 <504DE165.4000208@ti.com> <CAMQu2gxE8e9RBykLDyukZwV7dPKv3nG1vCynO1pijUBXBnyq8Q@mail.gmail.com>
 <504DE79B.3090302@ti.com> <CAMQu2gwT=XHcZtdKfYacGyt21Mo0of8MmSMNE+0PP9wemKSyxw@mail.gmail.com>
 <CAMQu2gzKDLBJmVdm0SUr0ec=LueT0mqBUYmHyGMsav5k=ggKQg@mail.gmail.com> <50519FB9.9060208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:42026 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753151Ab2IMJA5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 05:00:57 -0400
Received: by vcbfo13 with SMTP id fo13so2195813vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Sep 2012 02:00:49 -0700 (PDT)
In-Reply-To: <50519FB9.9060208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.orig

On Thu, Sep 13, 2012 at 2:26 PM, Benoit Cousson <b-cousson@ti.com> wrote:
> Hi Santosh,
>
> On 09/11/2012 11:29 AM, Shilimkar, Santosh wrote:
>> Benoit,
>>
>> On Mon, Sep 10, 2012 at 7:09 PM, Shilimkar, Santosh
>> <santosh.shilimkar@ti.com> wrote:
>>> On Mon, Sep 10, 2012 at 6:44 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>>>>
>>
>> [...]
>>
>>>>>> Silly question: Don't we have one arch-timer per CPU?
>>>>>>
>>>>> It is per CPU just like A9 TWD
>>>>
>>>> Shouldn't we have two nodes then?
>>>>
>>> I need to check this but arch timer DT node should be same
>>> as the twd DT node. May be one node with reference to
>>> each CPU node should do but am not too sure about the DT
>>> nodes and how all that work.
>>>
>> Here is an updated patch based on our discussion. Thanks for comments.
>> Let me know if you are ok with this version.
>
> Cool, thanks for the update.
>
>> From 98f6a3b4b52ef7c76ed8b19bf9257c51ee5d7323 Mon Sep 17 00:00:00 2001
>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Date: Mon, 13 Aug 2012 14:39:03 +0530
>> Subject: [PATCH] ARM: OMAP5: Enable arch timer support
>>
>> Enable Cortex A15 generic timer support for OMAP5 based SOCs.
>> The CPU local timers run on the free running real time counter clock.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Acked-by: Benoit Cousson <b-cousson@ti.com>
>
Thanks Benoit.

> Tony,
>
> I can potentially add it along with the timer changes in the dts part2
> series if you ack the timer patch. We don't have tons of OMAP5 content
> in the dts branch so it should not conflict.
>
Yep. let me know what works. if needed I can put these two patches
on a branch and send a pull request.

Regards
santosh
