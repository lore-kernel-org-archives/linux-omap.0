From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] OMAP2: gptimer min_delta_ns should be rounded up
Date: Wed, 31 Dec 2008 09:47:59 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D3BCF0A@dlee02.ent.ti.com>
References: <> <1230570868-25078-1-git-send-email-Aaro.Koskinen@nokia.com>
 <13B9B4C6EF24D648824FF11BE8967162036D3BCB12@dlee02.ent.ti.com>
 <495A5165.1040105@nokia.com>
 <13B9B4C6EF24D648824FF11BE8967162036D3BCD0B@dlee02.ent.ti.com>
 <495B8E1B.9050302@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42668 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755422AbYLaPsK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Dec 2008 10:48:10 -0500
In-Reply-To: <495B8E1B.9050302@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> > If 5 users call into this api and try and set wake ups at an rate the
> hardware can't support,  you end up wasting time writing wake ups which can't
> be met.
>
> Yes, I actually made a test case with hrtimers too see the difference
> (though I think I'm also seeing hrtimer/oneshot code still doing some
> unnecessary programming...)

Cool. A quantitative test.

Actually, the functional spec for timer says max re-sync time is:
        3 OCP clock + 2.5 TIMER clock
        3(1/83MHz) + 76uS = ~76uS

When I've measured the stall portion I usually don't see more then ~65uS stall.  There is still a bit of time once the block has taken in the command before its issued.

* There is posting at the timer-ip-block which means the first write doesn't stall the MPU but it will take time to see the external effect (ie your interrupt/signal while internal resync happens).  The 2nd write (to same register) starts to be really costly as the MPU stalls till the 1st one completes.  This write is caused by the frame work trying to reprogram for timer events it can't meet. So if you don't set the delta_ns correctly it allows programming at a rate which the hardware can't support and you end up stalling mpu and missing deadline which wasn't realistic to start off with.

** Your original patch WAS good.  It fixed a real bug.  My comment was mainly that the patch could go one further, fix the bug, and setup the time interface so it didn't suck mpu time and break user expectations about timer delivery.

When the code is set to MHz time base a (1,)+1 is the right value.  When it uses 32KHz the right value is (2.5,).  I don't think interface can take 2.5 so I rounded to 3.  An optimization would be to use 2.5's effective value.

Thanks for taking the time to understand.

Regards,
Richard W.

