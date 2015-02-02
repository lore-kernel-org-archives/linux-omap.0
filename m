From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk instances
Date: Mon, 02 Feb 2015 14:50:36 -0800
Message-ID: <20150202225036.421.43421@quantum>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
 <20150201212432.22722.70917@quantum> <54CFE1FE.7040404@codeaurora.org>
 <alpine.DEB.2.02.1502022230110.2045@localhost6.localdomain6>
 <54CFFBCF.90706@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54CFFBCF.90706@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, t-kristo@ti.com, cocci@systeme.lip6.fr
List-Id: linux-omap@vger.kernel.org

Quoting Stephen Boyd (2015-02-02 14:35:59)
> On 02/02/15 13:31, Julia Lawall wrote:
> >
> > On Mon, 2 Feb 2015, Stephen Boyd wrote:
> >
> >> Julia,
> >>
> >> Is there a way we can write a coccinelle script to check for this? The
> >> goal being to find all drivers that are comparing struct clk pointers or
> >> attempting to dereference them. There are probably other frameworks that
> >> could use the same type of check (regulator, gpiod, reset, pwm, etc.).
> >> Probably anything that has a get/put API.
> > Comparing or dereferencing pointers of a particular type should be 
> > straightforward to check for.  Is there an example of how to use the 
> > parent_index value to fix the problem?
> >
> 
> I'm not sure how to fix this case with parent_index values generically.
> I imagine it would be highly specific to the surrounding code to the
> point where we couldn't fix it automatically. For example, if it's a clk
> consumer (not provider like in this case) using an index wouldn't be the
> right fix. We would need some sort of clk API that we don't currently
> have and I would wonder why clock consumers even care to compare such
> pointers in the first place.

Ack. Is there precedent for a "Don't do that" kind of response?

Regards,
Mike

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
