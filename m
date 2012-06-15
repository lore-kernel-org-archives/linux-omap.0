From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V4 12/12] ARM: OMAP2+: Simplify dmtimer clock aliases
Date: Fri, 15 Jun 2012 10:27:10 -0500
Message-ID: <4FDB544E.1010906@ti.com>
References: <1338917700-29174-1-git-send-email-jon-hunter@ti.com> <1338917700-29174-13-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1206141417560.18430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42855 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932205Ab2FOP1N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jun 2012 11:27:13 -0400
In-Reply-To: <alpine.DEB.2.00.1206141417560.18430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Hi Paul,

On 06/14/2012 03:31 PM, Paul Walmsley wrote:
> Hi Jon
> 
> On Tue, 5 Jun 2012, Jon Hunter wrote:
> 
>> The OMAP dmtimer driver allows you to dynamically configure the functional
>> clock that drives the timer logic. The dmtimer driver uses the device name and
>> a "con-id" string to search for the appropriate functional clock.
>>
>> Currently, we define a clock alias for each functional clock source each timer
>> supports. Some functional clock sources are common to all of the timers on a
>> device and so for these clock sources we can use a single alias with a unique
>> con-id string.
>>
>> The possible functional clock sources for an OMAP device are a 32kHz clock,
>> a system (MHz range) clock and (for OMAP2 only) an external clock. By defining
>> a unique con-id name for each of these (timer_32k_ck, timer_sys_ck and
>> timer_ext_ck) we can eliminate a lot of the clock aliases for timers. This
>> reduces code, speeds-up searches and clock initialisation time.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> Sorry to make you change this, but how about adding the optional clock 
> aliases to the hwmod data instead?

Yes, we can do. However, technically these are not optional clocks but
parents clocks. So if you are ok with that we can.

> So rather than:
> 
>> +	CLK(NULL,	"timer_32k_ck",	&func_32k_ck,	CK_243X),
>> +	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_243X),
>> +	CLK(NULL,	"timer_ext_ck",	&alt_ck,	CK_243X),
> 
> add something like (rough example):
> 
> static struct omap_hwmod_opt_clk timer_opt_clks[] = {
> 	{ .role = "32k", .clk = "func_32k_ck" },
> 	{ .role = "sys", .clk = "sys_ck" },
> 	{ .role = "alt", .clk = "alt_ck" },
> };
> 
> and then add the .opt_clks and .opt_clks_cnt fields to the struct 
> omap_hwmod records; see for example omap44xx_dss_hwmod.
> 
> Doing it this way will remove the clkdev entries, which we're trying to 
> get rid of.  I hope also that these should be auto-generatable from the 
> hardware data at some point.  And adding the opt_clk data should result in 
> a faster search time for these aliases, since only the omap_hwmod_opt_clk 
> records would need to be iterated over, rather than the clkdev data which 
> is quite a bit larger.

Ok, but what it not clear to me is how I retrieve the clock handle from
the driver. Is there an API I can use to retrieve the optional clocks
using the device structure? In other words, similar to clk_get()?

Cheers
Jon
