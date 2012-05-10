From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM address
 space.
Date: Thu, 10 May 2012 12:41:35 +0530
Message-ID: <4FAB6A27.3050509@ti.com>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com> <20120508124116.GE17798@arm.com> <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com> <20120508215554.GA18980@n2100.arm.linux.org.uk> <CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com> <20120509122348.GA30632@n2100.arm.linux.org.uk> <CAMQu2gzdwXwzhhFLtLXTj5e0a9cFeq5ReUcMT-tGUxTPUcV_4Q@mail.gmail.com> <20120509154849.GA10375@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:53406 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756660Ab2EJHLn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 03:11:43 -0400
Received: by obceq6 with SMTP id eq6so1672660obc.9
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 00:11:41 -0700 (PDT)
In-Reply-To: <20120509154849.GA10375@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, R Sricharan <r.sricharan@ti.com>

On Wednesday 09 May 2012 09:18 PM, Russell King - ARM Linux wrote:
> On Wed, May 09, 2012 at 06:00:10PM +0530, Shilimkar, Santosh wrote:
>> On Wed, May 9, 2012 at 5:53 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Wed, May 09, 2012 at 02:20:28PM +0530, Shilimkar, Santosh wrote:
>>>> The only change done common code is  clearing 'XN' bit for DRAM
>>>> region in page table entries. The other change of setting the DACR
>>>> register is done in ARMv7 specific code.
>>>
>>> Yes, XN is an ARMv6+ thing.  Before ARMv5, it was implementation defined.
>>>
>>> Some implementations used the bit to mean "allow writes to update the
>>> cache".  Other implementations labelled this bit as "should be zero"
>>> while others labelled it as "should be one".
>>>
>> Good to know.
>>
>>> The upshot of this is, we know that having this bit as '1' means that
>>> all the CPUs we support today work.  I would be _very_ concerned to
>>> change this bit to zero as we _really_ don't know how the pre-ARMv6
>>> CPUs would react.
>>>
>> I agree.
>>
>>> The solution to this is pretty simple - if ARMv6+ needs a different
>>> base section mapping value, then we need to extract that from the code
>>> and pass in the base section mapping value.
>>>
>>> I'll sort out a patch later today for this.
>> Great.
> 
> This works for my 4430SDP board.  I haven't booted it on anything else yet.
> Please can you check that this solves the issue for you?  Thanks.
> 
Yes it does.
Are you planning to merge below patch as is or split
the patch like 1) Refactoring 2) ARMv7 fix

Either is fine with me.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
