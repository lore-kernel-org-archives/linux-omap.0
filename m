From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
Date: Thu, 05 Feb 2015 21:06:48 +0100
Message-ID: <54D3CD58.4030902@samsung.com>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
 <54D3C803.30706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <54D3C803.30706@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 05/02/15 20:44, Sylwester Nawrocki wrote:
>> +void __clk_put(struct clk *clk)
>> > +{
>> > +	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>> > +		return;
>> > +
>> > +	clk_core_put(clk->core);
>> > +	kfree(clk);
>
> Why do we have kfree() here? clk_get() doesn't allocate the data structure 
> being freed here. What happens if we do clk_get(), clk_put(), clk_get() 
> on same clock?
> 
> I suspect __clk_free_clk() should be called in __clk_release() callback
> instead, but then there is an issue of safely getting reference to
> struct clk from struct clk_core pointer.

Please ignore this comment, I missed __clk_create_clk() calls in clkdev.c
Anyway, in current -next I'm seeing random pointer dereferences while
booting Odroid U3, I'll get back to debugging this tomorrow morning.

-- 
Regards,
Sylwester
