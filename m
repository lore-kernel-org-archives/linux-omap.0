From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] OMAP2: gptimer min_delta_ns should be rounded up
Date: Mon, 29 Dec 2008 11:38:02 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D3BCB12@dlee02.ent.ti.com>
References: <> <1230570868-25078-1-git-send-email-Aaro.Koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41862 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbYL2RiP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Dec 2008 12:38:15 -0500
In-Reply-To: <1230570868-25078-1-git-send-email-Aaro.Koskinen@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <Aaro.Koskinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> clockevent_delta2ns() used to initialize min_delta_ns rounds the value
> down, so the result can be too small. When clockevents_program_event()
> is using too small value it will try to program the timer with zero
> ticks stalling the timer queue.

> +             clockevent_delta2ns(1, &clockevent_gpt) + 1;

That value is still not correct.  The base perhaps should be '3'.  The additional +1 is needed if you use a base value of 1 which can cause the error your patch addresses.

        clockevent_delta2ns(3, &clockevent_gpt);

min_delta_ns stops the frame work from trying to program an expiry time which may not be achievable due to timer costs.

A write to the timer when it has a 32KHz F-Clock can take ~3 32Khz clock cycles to complete.  Hence the cost of '3' not '1'.

If your lucky the write will be posted and not stall the CPU.  But just because the IP block has captured the change doesn't mean it will take effect immediately.  The write will still have to resynchronization internally with f-clk.

Regards,
Richard W.
