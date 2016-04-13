From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/30] ARM: OMAP2+: hwmod module clock type support
Date: Wed, 13 Apr 2016 08:49:29 -0700
Message-ID: <20160413154928.GS5995@atomide.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
 <20160412145819.GA25032@rob-hp-laptop>
 <20160412155829.GM5995@atomide.com>
 <570DEE66.8030706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <570DEE66.8030706@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Rob Herring <robh@kernel.org>, linux-omap@vger.kernel.org, paul@pwsan.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [160413 00:00]:
> On 04/12/2016 06:58 PM, Tony Lindgren wrote:
> >
> >Yes Tero please check those, we need to support the old behavior too.
> >Sounds like you figured that out how to do that alreadey by generating
> >the clock name for the built-in data.
> 
> Some of the old clock nodes are being dropped by this series, namely the
> timer ones, and they are getting merged to the new timerX_mod_ck nodes.
> 
> The reason for this is the behavior of the clock driver itself; it assumes
> it gets a clock handle for which it can do clk_set_parent (for setting
> proper source clock to get correct time-base), but normal _mod_ck nodes do
> not support this. So, what happens for example for omap4 is following:

OK

> These clocks are then directly referenced by hwmod. The reason for having
> two registers under the new timer node is that in some hardwares (like
> AM33xx), the register address for the gate and mux component are different.
> 
> Anyway, compatibility will be broken once the hwmod_data changes go in for
> individual SoCs, as the clkctrl portion is going to be dropped, and the
> hwmod has no chance to work with old DT data. If this is not acceptable,
> then the whole exercise becomes moot as we need to move the data someplace
> else within the kernel, and forget about the transition to DT.

Yeah if have hwmod lookup the clkctrl clock based on the generated
clock name, it can still find the clock. But naturally if the clocks
are not defined, hwmod won't find them for an old dtb.

If we want to avoid that, the clkctrl data would have be built in
for each SoC in the clock driver, and we'd still need to provide the
DT bindings for them. We do have the TI clock bindings tagged as
unstable and defining clocks for SoCs is the dts files is pretty much
the standard.. Probably the best we can do is to things in phases where
we drop the hwmod data only later on.

Regards,

Tony
