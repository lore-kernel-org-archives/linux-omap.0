From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 5/5] [RFC] ARM: timer-sp: Use of_clk_get_parent_count()
 instead of open coding
Date: Thu, 4 Jun 2015 11:14:04 -0700
Message-ID: <20150604181404.GF490@codeaurora.org>
References: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
 <1432891549-23295-6-git-send-email-geert+renesas@glider.be>
 <20150603234426.GB490@codeaurora.org>
 <CAMuHMdXRQbBJWLCiDgx=vRcj=MS5BAQ6gskfcMGZzW1gKa6J8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48034 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbbFDSOI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2015 14:14:08 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdXRQbBJWLCiDgx=vRcj=MS5BAQ6gskfcMGZzW1gKa6J8g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-clk@vger.kernel.org, kernel@stlinux.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 06/04, Geert Uytterhoeven wrote:
> Hi Stephen,
> 
> On Thu, Jun 4, 2015 at 1:44 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 05/29, Geert Uytterhoeven wrote:
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>  #include <linux/err.h>
> >>  #include <linux/interrupt.h>
> >>  #include <linux/irq.h>
> >> @@ -234,7 +235,7 @@ static void __init sp804_of_init(struct device_node *np)
> >>               clk1 = NULL;
> >>
> >>       /* Get the 2nd clock if the timer has 3 timer clocks */
> >> -     if (of_count_phandle_with_args(np, "clocks", "#clock-cells") == 3) {
> >> +     if (of_clk_get_parent_count(np) == 3) {
> >
> > So maybe it means if we want to expose of_clk_get_parent_count()
> > we should move it to some other header file (of_clk.h?). And then
> > maybe we should always compile said helpers if OF=y and
> > HAVE_CLK=y.
> 
> That makes sense.
> 
> Currently we have lots of of_clk_*() in <linux/clk-provider.h>, and a few
> of_clk_get*() in <inux/clk.h>.
> And the mysterious of_clk_set_defaults() in <linux/clk/clk-conf.h>.
> 
> All of_clk_get*() could be moved to a new <linux/of_clk.h>.
> 
> Alternatively, of_clk_get_parent_count() could just move to <linux/clk.h>?

Hmm... of_clk_*() functions that return a struct clk * or work
with a struct clk * should stay within clk.h. But these ones in
clk-provider.h should probably move to a new of_clk.h file:

	of_clk_get_parent_count
	of_clk_get_parent_name
	of_clk_init

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
