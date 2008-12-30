From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] OMAP2: gptimer min_delta_ns should be rounded up
Date: Tue, 30 Dec 2008 11:01:21 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D3BCD0B@dlee02.ent.ti.com>
References: <> <1230570868-25078-1-git-send-email-Aaro.Koskinen@nokia.com>
 <13B9B4C6EF24D648824FF11BE8967162036D3BCB12@dlee02.ent.ti.com>
 <495A5165.1040105@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36687 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbYL3RBb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Dec 2008 12:01:31 -0500
In-Reply-To: <495A5165.1040105@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> >         clockevent_delta2ns(3, &clockevent_gpt);
> >
> > min_delta_ns stops the frame work from trying to program an expiry time
> which may not be achievable due to timer costs.
> >
> > A write to the timer when it has a 32KHz F-Clock can take ~3 32Khz clock
> cycles to complete.  Hence the cost of '3' not '1'.
>
> I'm not sure if I see any problem. If the timer programming cost is
> bigger than min_delta_ns, the framework should adapt to it.

By setting this value to the cost of the timer operation you allow the frame work to adapt.

If 5 users call into this api and try and set wake ups at an rate the hardware can't support, you end up wasting time writing wake ups which can't be met.

Worse to stall the processor.  If you look at the ETM trace output of programming the timer you will see the whole call path to writing to the timer takes some few uS.  By you can be stuck at the writing of the timer registers up to 90uS (if f-clk is set to 32khz).

By allowing frequent accesses you:
        - don't meet the deadline anyway
                - program a wake for 20uS it won't signal till 90uS anyway.
                - you can at least query and round to get what the hardware supports if the interface is set properly.
        - you stall the processor and waste cycles.

> I guess you would want to make min_delta_ns bigger to avoid excessive
> scheduling/wakeups, but I think there is no any single "correct" value
> for every system/board.

The correct value for the chip timer IP is 3 if the functional clock is at 32MHz.  If you use a faster time base like 12Mhz use 1.   Next, If you want to try and factor in the software cost you can try.  This software cost (what DPLL rate am I at, how much code is executed on path, ...) will be very board and port specific.

Regards,
Richard W.

