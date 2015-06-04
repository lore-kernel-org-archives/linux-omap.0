From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/2] clk: change clk_ops' ->round_rate() prototype
Date: Thu, 4 Jun 2015 23:02:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1506042258530.12316@utopia.booyaka.com>
References: <1430407809-31147-1-git-send-email-boris.brezillon@free-electrons.com> <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-media-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawn.guo@linaro.org>, ascha Hauer <kernel@pengutronix.de>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Max Filippov <jcmvbkbc@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Barry Song <baohua@kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, =?ISO-8859-15?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>, Peter
List-Id: linux-omap@vger.kernel.org

Hi folks

just a brief comment on this one:

On Thu, 30 Apr 2015, Boris Brezillon wrote:

> Clock rates are stored in an unsigned long field, but ->round_rate()
> (which returns a rounded rate from a requested one) returns a long
> value (errors are reported using negative error codes), which can lead
> to long overflow if the clock rate exceed 2Ghz.
> 
> Change ->round_rate() prototype to return 0 or an error code, and pass the
> requested rate as a pointer so that it can be adjusted depending on
> hardware capabilities.

...

> diff --git a/Documentation/clk.txt b/Documentation/clk.txt
> index 0e4f90a..fca8b7a 100644
> --- a/Documentation/clk.txt
> +++ b/Documentation/clk.txt
> @@ -68,8 +68,8 @@ the operations defined in clk.h:
>  		int		(*is_enabled)(struct clk_hw *hw);
>  		unsigned long	(*recalc_rate)(struct clk_hw *hw,
>  						unsigned long parent_rate);
> -		long		(*round_rate)(struct clk_hw *hw,
> -						unsigned long rate,
> +		int		(*round_rate)(struct clk_hw *hw,
> +						unsigned long *rate,
>  						unsigned long *parent_rate);
>  		long		(*determine_rate)(struct clk_hw *hw,
>  						unsigned long rate,

I'd suggest that we should probably go straight to 64-bit rates.  There 
are already plenty of clock sources that can generate rates higher than 
4GiHz.


- Paul
