From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
Date: Fri, 09 Mar 2012 07:23:16 -0800
Message-ID: <87haxx6bob.fsf@ti.com>
References: <20120202093600.12509.35052.stgit@dusk> <87ty39cc7s.fsf@ti.com>
	<alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021328450.586@utopia.booyaka.com>
	<CAKd1q9rq67gUyXn+rOL348YwaYQiqHR8UQCSd68fpxhZHHsYGA@mail.gmail.com>
	<87sjhjaqyi.fsf@ti.com> <1331232433.18015.69.camel@cumari>
	<alpine.DEB.2.00.1203081153540.9551@utopia.booyaka.com>
	<1331233547.18015.74.camel@cumari> <87d38mbxfu.fsf@ti.com>
	<1331273702.18015.92.camel@cumari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50840 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757350Ab2CIPXP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 10:23:15 -0500
Received: by mail-iy0-f172.google.com with SMTP id z13so2634380iaz.31
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 07:23:14 -0800 (PST)
In-Reply-To: <1331273702.18015.92.camel@cumari> (Luciano Coelho's message of
	"Fri, 09 Mar 2012 08:15:02 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, ido@wizery.com

Luciano Coelho <coelho@ti.com> writes:

> Hi Kevin,
>
> On Thu, 2012-03-08 at 13:21 -0800, Kevin Hilman wrote: 
>> Luciano Coelho <coelho@ti.com> writes:
>> 
>> [...]
>> 
>> > Thanks, Paul! I was just chatting with Kevin about this on IRC.  With
>> > your patch and no_console_suspend, it works. :)
>> 
>> Just FYI... I've queued this patch from Paul and it's now queued by Tony
>> for v3.4 in his cleanup-pm branch.
>
> Great, thanks for the info!
>
> BTW, you and Paul said that it was not recommended to use
> no_console_suspend, but Ido (on CC) said that it can be useful for us,
> because we need to see if our own (wireless) stuff goes into suspend
> correctly.

no_console_suspend should not be needed there.  It is really only
intended as a *temporary* debug feature when suspend fails.

Since the console is disabled during suspend, if suspend fails, you
might not see the reason for failure.  So in this case, you enable
no_console_suspend just to see the suspend output, and why it's failing.

If suspend/resume succeed, you will see all the console output after
resume because even though the console is disabled, the printks are
buffered, so you will see them eventually.

So with a working suspend/resume, you will eventually see all the
console output.

So basically, any usage of no_console_suspend should be temporary, until
you figure out why suspend if failing. 

> Are there any real problems with no_console_suspend besides power
> consumption? Is it safe for us to simply apply Paul's patch when we need
> it?

There are important side effects of leaving the console enabled.
Namely, the console UART will stay clocked, and thus prevent it's
surrounding powerdomain from reaching a low power state.  UARTs can be
in either the PER or CORE powerdomains, so preventing them from reaching
the low powerstate will affect other drivers in those powerdomains.

For example, if your device is in the same powerdomain as the UART, it
will not be clock gated (or power gated) so the context save/restore
paths of those devices will not be exercised.


Kevin
