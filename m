From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 1/2] clk: change clk_ops' ->round_rate() prototype
Date: Wed, 6 May 2015 23:39:53 -0700
Message-ID: <20150507063953.GC32399@codeaurora.org>
References: <1430407809-31147-1-git-send-email-boris.brezillon@free-electrons.com>
 <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawn.guo@linaro.org>, ascha Hauer <kernel@pengutronix.de>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Max Filippov <jcmvbkbc@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Barry Song <baohua@kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>, Peter
List-Id: linux-omap@vger.kernel.org

On 04/30, Boris Brezillon wrote:
> Clock rates are stored in an unsigned long field, but ->round_rate()
> (which returns a rounded rate from a requested one) returns a long
> value (errors are reported using negative error codes), which can lead
> to long overflow if the clock rate exceed 2Ghz.
> 
> Change ->round_rate() prototype to return 0 or an error code, and pass the
> requested rate as a pointer so that it can be adjusted depending on
> hardware capabilities.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

This patch is fairly invasive, and it probably doesn't even
matter for most of these clock providers to be able to round a
rate above 2GHz. I've been trying to remove the .round_rate op
from the framework by encouraging new features via the
.determine_rate op. Sadly, we still have to do a flag day and
change all the .determine_rate ops when we want to add things.

What if we changed determine_rate ops to take a struct
clk_determine_info (or some better named structure) instead of
the current list of arguments that it currently takes? Then when
we want to make these sorts of framework wide changes we can just
throw a new member into that structure and be done.

It doesn't solve the unsigned long to int return value problem
though. We can solve that by gradually introducing a new op and
handling another case in the rounding path. If we can come up
with some good name for that new op like .decide_rate or
something then it makes things nicer in the long run. I like the
name .determine_rate though :/

The benefit of all this is that we don't have to worry about
finding the random clk providers that get added into other
subsystems and fixing them up. If drivers actually care about
this problem then they'll be fixed to use the proper op. FYI,
last time we updated the function signature of .determine_rate we
broke a couple drivers along the way.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
