From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC 0/2] mach-omap2: handle autoidle denial
Date: Thu, 4 Oct 2018 07:25:58 -0700
Message-ID: <20181004142558.GB5662@atomide.com>
References: <20181004055147.23048-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181004055147.23048-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, paul@pwsan.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [181004 05:56]:
> On the gta04 with a dm3730 omap_hdq does not work properly when the
> device enters lower power states. Idling uart1 and 2 is enough
> to show up that problem, if there are no other things enabled.
> Further research reveals that hdq iclk must not be turned off during
> transfers, also according to the TRM. That fact is also correctly described
> in the flags but the code to handle that is incomplete.
> 
> Since the order is first disable all autoidles, then disable selected
> and then enable all, we need to either change that order or add
> a usecount. Since it is done only in init, we could think about changing
> order.

These patches look OK to me, assuming Tero will review them more
closely.

It seems we should just provide a generic interface for
clk_allow_autoidle() and clk_deny_autoidle()? Otherwise we'll
be forever stuck with pdata callbacks it seems.

Regards,

Tony
