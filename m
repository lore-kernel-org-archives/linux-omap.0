From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH] clk: ti: set CLK_SET_RATE_NO_REPARENT for
 ti,mux-clock
Date: Tue, 17 Jun 2014 08:15:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406170814220.31106@utopia.booyaka.com>
References: <1402992272-21413-1-git-send-email-tomi.valkeinen@ti.com> <1402992272-21413-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47484 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbaFQIPK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 04:15:10 -0400
In-Reply-To: <1402992272-21413-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>

On Tue, 17 Jun 2014, Tomi Valkeinen wrote:

> When setting the rate of a clock, by default the clock framework will
> change the parent of the clock to the most suitable one in
> __clk_mux_determine_rate() (most suitable by looking at the clock rate).

That is just insane.

> This is a rather dangerous default, and causes problems on AM43x when
> using display and ethernet. There are multiple ways to select the clock
> muxes on AM43x, and some of those clock paths have the same source
> clocks for display and ethernet. When changing the clock rate for the
> display subsystem, the clock framework decides to change the display mux
> from the dedicated display PLL to a shared PLL which is used by the
> ethernet, and then changes the rate of the shared PLL, breaking the
> ethernet.
> 
> As I don't think there ever is a case where we want the clock framework
> to automatically change the parent clock of a clock mux, this patch sets
> the CLK_SET_RATE_NO_REPARENT for all ti,mux-clocks.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>


- Paul
