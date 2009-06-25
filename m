From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH][RFC] OMAP3: PM: Prevent hang in prcm_interrupt_handler
Date: Thu, 25 Jun 2009 13:56:31 -0500
Message-ID: <4A43C85F.50703@ti.com>
References: <1245452921-24142-1-git-send-email-jon-hunter@ti.com> <87prcv25ro.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53653 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754600AbZFYS4h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Jun 2009 14:56:37 -0400
In-Reply-To: <87prcv25ro.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Kevin Hilman wrote:
> Jon Hunter <jon-hunter@ti.com> writes:
> 
>> From: Jon Hunter <jon-hunter@ti.com>
>>
>> There are two scenarios where a race condition could result in a hang in the
>> prcm_interrupt handler. These are:
> 
> IIRC, the RX51 tree has a workaround for some hangs seen in this
> interrupt handler as well, so this has definitely been seen.  The fix
> there though was just to no loop, I think your fix is more thorough 
> and fixes the root cause.  Thanks.
> 
> No comments on the funtional changes, but a couple
> cosmetic/documentation changes.
> 
> 1) Would it be possible to summarize the requirements in the function
> itself as part of this patch.

Absolutely. I will add some comments.

> 2) With the extra indentation, this function is getting too indented.
> Looking closer, an abstraction of the 'enable clocks, poll PM_WKST,
> disable clocks loop' could be done an called with the various modules
> and offsets.  I've attached a hack/patch below to show what I mean.
> You could just fold this into your patch.

Yes that makes a lot of sense. I did not like the fact it was becoming 
difficult to read with the extra indentation. I will re-work this and 
get you something in the next couple days.

Thanks for the feedback.

Cheers
Jon

