From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: RFD: OMAP PRCM register access holding up PM branch submissions
Date: Thu, 12 Mar 2009 10:55:01 -0700
Message-ID: <87mybq62yy.fsf@deeprootsystems.com>
References: <87hc1y930c.fsf@deeprootsystems.com>
	<20090312162804.GA7179@n2100.arm.linux.org.uk>
	<87bps67kby.fsf@deeprootsystems.com>
	<20090312170151.GB7854@n2100.arm.linux.org.uk>
	<20090312172646.GL19229@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.244]:50252 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbZCLRzI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 13:55:08 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1080379agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 10:55:05 -0700 (PDT)
In-Reply-To: <20090312172646.GL19229@atomide.com> (Tony Lindgren's message of "Thu\, 12 Mar 2009 10\:26\:46 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Tony Lindgren <tony@atomide.com> writes:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090312 10:03]:
>> On Thu, Mar 12, 2009 at 09:54:41AM -0700, Kevin Hilman wrote:
>> > If you can share your opinions on the two register access approaches I
>> > described, I will work on coordinating development in that direction.
>> 
>> If I had a path forwards, then I would say so.  At the moment, I have
>> a vague idea about what I'd like to see, but it isn't in a workable
>> state at the present time.
>> 
>> I need to put further thought and time into coming up with a solution.
>> For the time being, I am not going to apply the outstanding patches to
>> put in place a solution which is totally confused about iomem and u32
>> types with lots of casts to make it work.  Even one which passes u32
>> types to the IO accessors (which don't produce a warning but shouldn't
>> be allowed in any case.)
>
> Well let's get the current omap clock patches in omap-clks3 merged.
> It is already way closer to what we need than the current mainline code.
>
> Paul, maybe you can post that series to linux-omap for final review
> and testing because of the mail/OOM issues Russell is having?

I will post this series to linux-omap for final review.

I don't think there are any major objections that should prevent this
from going into this merge window.  

> Then we'll come up with a proper solution for the remaining patches
> after this merge window.

Agreed, this PRCM issue does not need to be resolved for this merge window.

Kevin
