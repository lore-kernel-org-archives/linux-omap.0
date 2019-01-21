From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/3] mach-omap2: handle autoidle denial
Date: Mon, 21 Jan 2019 11:58:03 -0800
Message-ID: <20190121195803.GH5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116220429.9136-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190116 14:04]:
> On the gta04 with a dm3730 omap_hdq does not work properly when the
> device enters lower power states. Idling uart1 and 2 is enough
> to show up that problem, if there are no other things enabled.
> Further research reveals that hdq iclk must not be turned off during
> transfers, also according to the TRM. That fact is also correctly described
> in the flags but the code to handle that is incomplete.
> 
> To handle multiple users of a single ick, autoidle is disabled
> when a user of that ick requires that (has the OCPIF_SWSUP_IDLE))
> 
> Changes v3:
> - replace CLK_IS_BASIC
> 
> Changes v2:
> - uses spinlocks instead of mutexes
> - invert counter logic
> - check whether clock type is basic

For this series it's best to merge it all via the
clock tree along with the related clock patches:

Acked-by: Tony Lindgren <tony@atomide.com>
