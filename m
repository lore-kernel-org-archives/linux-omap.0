From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 1/2] clk: change clk_ops' ->round_rate() prototype
Date: Tue, 19 May 2015 18:01:44 -0700
Message-ID: <20150520010144.GA31054@codeaurora.org>
References: <1430407809-31147-1-git-send-email-boris.brezillon@free-electrons.com>
 <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com>
 <20150507063953.GC32399@codeaurora.org>
 <20150507093702.0b58753d@bbrezillon>
 <20150515174048.4a31af49@bbrezillon>
 <5557267D.7080209@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5557267D.7080209@kapsi.fi>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Mike Turquette <mturquette@linaro.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawn.guo@linaro.org>, ascha Hauer <kernel@pengutronix.de>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Max Filippov <jcmvbkbc@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Barry Song <baohua@kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, Emilio L?pez <emilio@elopez.com.ar>, Maxime Ripard <maxime.rip>
List-Id: linux-omap@vger.kernel.org

On 05/16, Mikko Perttunen wrote:
> On 05/15/2015 06:40 PM, Boris Brezillon wrote:
> >Hi Stephen,
> >
> >Adding Mikko in the loop (after all, he was the one complaining about
> >this signed long limitation in the first place, and I forgot to add
> >him in the Cc list :-/).
> 
> I think I got it through linux-tegra anyway, but thanks :)
> 
> >
> >Mikko, are you okay with the approach proposed by Stephen (adding a
> >new method) ?
> 
> Yes, sounds good to me. If a driver uses the existing methods with
> too large frequencies, the issue is pretty discoverable anyway. I
> think "adjust_rate" sounds a bit too much like it sets the clock's
> rate, though; perhaps "adjust_rate_request" or something like that?
> 

Well I'm also OK with changing the determine_rate API one more
time, but we'll have to be careful. Invariably someone will push
a new clock driver through some non-clk tree path and we'll get
build breakage. They shouldn't be doing that, so either we do the
change now and push it to -next and see what breaks, or we do
this after -rc1 comes out and make sure everyone has lots of
warning.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
