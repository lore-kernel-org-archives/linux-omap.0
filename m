From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] per board prm timings
Date: Fri, 13 Feb 2009 11:08:08 -0800
Message-ID: <87skmijgtj.fsf@deeprootsystems.com>
References: <1234281875-19768-1-git-send-email-peter.de-schrijver@nokia.com>
	<1234281875-19768-2-git-send-email-peter.de-schrijver@nokia.com>
	<87d4dnpmxq.fsf@deeprootsystems.com>
	<20090213102430.GA4582@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:22675 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbZBMTIN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 14:08:13 -0500
Received: by yx-out-2324.google.com with SMTP id 8so679137yxm.1
        for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2009 11:08:12 -0800 (PST)
In-Reply-To: <20090213102430.GA4582@codecarver.research.nokia.com> (Peter De Schrijver's message of "Fri\, 13 Feb 2009 12\:24\:30 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> Hi Kevin,
>
>> Peter,
>> 
>> I like this approach much better than what we currently have.  Pushing
>> to PM branch.
>> 
>> The next thing I would like to see is all the register value defines
>> removed from prm-regbits-34xx.h.  That header is supposed to be for
>> the bitfield definitions, not for values.
>> 
>
> True. If this patch goes in, there is no need for the register value
> defines in prm-regbits-34xx.h any more.
>

OK, I pushed a patch which removes them from regbits.h and moved some of the
other value defines into pm34xx.c until a better place is found.

Kevin
