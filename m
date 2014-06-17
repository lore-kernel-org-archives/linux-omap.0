From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [RFC PATCH] clk: ti: set CLK_SET_RATE_NO_REPARENT for ti,mux-clock
Date: Tue, 17 Jun 2014 14:34:04 -0700
Message-ID: <20140617213404.32686.34311@quantum>
References: <1402992272-21413-1-git-send-email-tomi.valkeinen@ti.com>
 <1402992272-21413-2-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1406170814220.31106@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33919 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964856AbaFQVeL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 17:34:11 -0400
Received: by mail-pa0-f44.google.com with SMTP id rd3so4867657pab.31
        for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2014 14:34:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1406170814220.31106@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>

Quoting Paul Walmsley (2014-06-17 01:15:09)
> On Tue, 17 Jun 2014, Tomi Valkeinen wrote:
> 
> > When setting the rate of a clock, by default the clock framework will
> > change the parent of the clock to the most suitable one in
> > __clk_mux_determine_rate() (most suitable by looking at the clock rate).
> 
> That is just insane.

The patch description is insane. The framework has nothing to do with
this dynamic re-parenting behavior and certainly the framework does not
force this behavior on clock providers. This behavior is specific to
users of __clk_mux_determine_rate. Those are:

1) drivers/clk/clk-mux.c
2) drivers/clk/qcom/mmcc-msm8960.c
3) drivers/clk/samsung/clk-s3c2410-dclk.c
4) drivers/clk/ti/mux.c

If dynamic re-parenting by default doesn't work for your platform then
you have two choices:

1) use the CLK_SET_RATE_NO_REPARENT flag (as this patch does)
2) don't use the basic divider type and write your own

If you choose #2 then all you have to do when implementing
.determine_rate is ignore the best_parent_rate argument.

Finally when the .determine_rate callback was introduced (allowing
dynamic re-parenting from a call to clk_set_rate) the
CLK_SET_RATE_NO_REPARENT flag was applied to all affected users to
maintain prior behavior and prevent regressions.

I have some local patches to improve documentation around these areas
for 3.17.

Regards,
Mike

> 
> > This is a rather dangerous default, and causes problems on AM43x when
> > using display and ethernet. There are multiple ways to select the clock
> > muxes on AM43x, and some of those clock paths have the same source
> > clocks for display and ethernet. When changing the clock rate for the
> > display subsystem, the clock framework decides to change the display mux
> > from the dedicated display PLL to a shared PLL which is used by the
> > ethernet, and then changes the rate of the shared PLL, breaking the
> > ethernet.
> > 
> > As I don't think there ever is a case where we want the clock framework
> > to automatically change the parent clock of a clock mux, this patch sets
> > the CLK_SET_RATE_NO_REPARENT for all ti,mux-clocks.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Reviewed-by: Paul Walmsley <paul@pwsan.com>
> 
> 
> - Paul
