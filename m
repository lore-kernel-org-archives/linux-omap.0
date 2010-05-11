From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/6] OMAP3: GPIO: Only enable WAKEUPEN for edge detection GPIOs
Date: Tue, 11 May 2010 16:27:06 -0700
Message-ID: <87fx1yrpdh.fsf@deeprootsystems.com>
References: <1272929177-22685-1-git-send-email-khilman@deeprootsystems.com>
	<1272929177-22685-3-git-send-email-khilman@deeprootsystems.com>
	<20100510211105.GI16460@atomide.com>
	<87vdaufr92.fsf@deeprootsystems.com>
	<20100511225734.GK13931@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46566 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab0EKX1K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:27:10 -0400
Received: by pvh11 with SMTP id 11so98199pvh.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 16:27:09 -0700 (PDT)
In-Reply-To: <20100511225734.GK13931@atomide.com> (Tony Lindgren's message of "Tue\, 11 May 2010 15\:57\:34 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

-cqwang address which is bouncing

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [100511 07:22]:
>> Tony Lindgren <tony@atomide.com> writes:
>> 
>> > * Kevin Hilman <khilman@deeprootsystems.com> [100503 16:28]:
>> >> From: Chunqiu Wang <cqwang@motorola.com>
>> >> 
>> >> According to the GPIO 'Wakeup and Interrupt' section of the TRM[1],
>> >> wake-up requests can only be generated on edge transitions.
>> >> 
>> >> Also for OMAP3, only edge GPIOs may lose interrupts when PER enters
>> >> RET/OFF state, this is addressed by gpio prepare|resume idle functions
>> >
>> > There's a generic solution to this problem. The solution is to temporarily
>> > set the level GPIO pins into edge for the duration of idle. Then
>> > they need to be set back to level after the system is woken up.
>> 
>> Sure, but that doesn't change the need for this patch which is
>> a correctness fix.
>> 
>> Adding wakeup support for level GPIOs would be a separate fix.
>
> OK, let's plan on merging these then. Want me to pick these,
> or pull from some branch?

You can pull from the gpio-2.6.35 branch in my tree.

> Looks like they also need to be posted to LAKML too, and we
> should get them into linux-omap master for some testing.

Oops, meant to cc l-a-k.  Will repost with l-a-k in Cc.

Kevin

> Looks like these should not cause much of merge issues with
> the gpio platform init patches. It would be nice to get those
> merged too if possible.
>
> Regards,
>
> Tony
