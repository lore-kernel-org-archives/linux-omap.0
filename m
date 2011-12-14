From: Paul Walmsley <paul@pwsan.com>
Subject: Re: sys_clkout2
Date: Tue, 13 Dec 2011 18:34:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112131819510.12046@utopia.booyaka.com>
References: <4EE7C38D.8020501@mlbassoc.com> <alpine.DEB.2.00.1112131447230.12046@utopia.booyaka.com> <4EE7DF0A.50706@mlbassoc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48209 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755652Ab1LNBec (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 20:34:32 -0500
In-Reply-To: <4EE7DF0A.50706@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: linux-omap@vger.kernel.org

On Tue, 13 Dec 2011, Gary Thomas wrote:

> On 2011-12-13 14:56, Paul Walmsley wrote:
>
> > I presume you have some external device that relies on sys_clkout2 for 
> > its clock input?
>
> Precisely.

Okay, so the "clean" way to do this is to write a short driver for that 
device, if there isn't one already, that takes care of configuring the 
clock settings that you need.

> Do I need to do anything special to control how the clock is configured, 
> e.g. div & src settings?

You can change the divider immediately upstream from the sys_clkout2 
output by calling clk_set_rate() on the sys_clkout2 struct clk that you 
got back from clk_get() in the example that I sent.  

You can change the source for sys_clkout2 by calling clk_set_parent() on 
clkout2_src_ck.  This is a separate clock, so you'd need to add a new 
clkdev entry for this for your driver, and you'd need to clk_get() it and 
also clk_get() the new parent source clock that you'd want to use.  Looks 
like these are your choices for parents:

static const struct clksel clkout2_src_clksel[] = {
	{ .parent = &core_ck,		.rates = clkout2_src_core_rates },
	{ .parent = &sys_ck,		.rates = clkout2_src_sys_rates },
	{ .parent = &cm_96m_fck,	.rates = clkout2_src_96m_rates },
	{ .parent = &omap_54m_fck,	.rates = clkout2_src_54m_rates },
	{ .parent = NULL }
};

> > Or if you just want a dirty hack, you can probably get away with just
> > adding the ENABLE_ON_INIT flag to the sys_clkout2 .flags field in
> > mach-omap2/clock3xxx_data.c.
> 
> Thanks, I'll give this a try when I have eyes on the hardware (Wednesday)

N.B., the kernel clock framework init code won't change clock parents or 
divisors, except when doing so is needed to disable or enable the clock.  

So if you are programming those from U-boot, you probably won't need to 
change the parent or divisors from kernel code.


- Paul
