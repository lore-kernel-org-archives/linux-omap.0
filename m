From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 06/10] omap2+: Remove gptimer_wakeup for now
Date: Mon, 27 Jun 2011 14:16:02 -0700
Message-ID: <87boxjasbx.fsf@ti.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092341.357.14183.stgit@kaulin> <8762nrch91.fsf@ti.com>
	<20110627191907.GW23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:57392 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754676Ab1F0VQF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 17:16:05 -0400
Received: by mail-pw0-f51.google.com with SMTP id 18so3934829pwi.24
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2011 14:16:04 -0700 (PDT)
In-Reply-To: <20110627191907.GW23145@atomide.com> (Tony Lindgren's message of
	"Mon, 27 Jun 2011 12:19:07 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [110627 10:27]:
>> Tony Lindgren <tony@atomide.com> writes:
>> 
>> > This removes the support for setting the wake-up timer for debugging.
>> >
>> > Later on we can reserve gptimer1 for PM code only and have similar
>> > functionality.
>> >
>> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>> > Reviewed-by: Kevin Hilman <khilman@ti.com>
>> 
>> Another minor change to fold into patch: gptimer_wakeup doesn't exist
>> anymore, so should probably be removed from dmtimer.h
>
> Thanks, updated patch below. Still with your Reviewed-by

Thanks.

> despite causing you more work with the removal of the
> interface :)

Well, part of me wants to keep it because I use it all the time, but I
know it's an ugly hack so I won't fight for it.  Also the timer cleanups
are nice and more important.  So for now I'll just keep a patch in the
PM branch for the wakeup timer.

I'm talking with tglx offline if we can make a generic interface for
this in the clockevents layer.  The clockevents already have a
notification on suspend that we could use for this.

Kevin
